<!-- $size: 16:9 -->
<!--
$theme: gaia
template: invert
page_number: true
-->

<!-- footer: Refactoring Elixir for Maintainability -->


REFACTORING ELIXIR FOR MAINTAINABILITY
===
##### By Dave Lucia
##### `@davydog187`

---
# ~~REFACTORING ELIXIR FOR MAINTAINABILITY~~
# Leveraging Protocols and Behaviours to write better designed Elixir programs
---

# The Problem

Elixir is a very expressive language that offers syntactic features that are new and exciting when coming from other languages. Beginners tend to overuse features such as pattern matching and multiple function heads because of their novelty, while missing opportunities to make their code more generic and workable. Additionally, powerful language features such as protocols and behaviours are often overlooked due to their relative complexity.

---
1. Beginners love pattern match, and overuse it
2. Protocols are a higher level concept with unclear applications
3. Behaviours don't seem useful when first starting out, and its unclear when to use them

---
# What will we do for the next 20 minutes?
1. Write some bad code in Phoenix
2. Make it better with Protocols
3. Learn a bit about how Protocols work
4. Make the code EVEN BETTER with behaviours
---

# Who is this guy?


## Dave Lucia

Currently
* Platform Software Architect @ SimpleBet (Elixir + Rust)


Formerly
* Founding team member of The Outline (Elixir + Javascript)
* Bloomberg.com
---
# What got me excited about Elixir?
# Pattern matching is :cool:
```elixir
def foo(%{} = map) do
  # map stuff
end

def foo(atom) when is_atom(atom) do
  # atom stuff
end

def foo("" <> binary) do
  # binary stuff
end
```
---

# TODO write an example of excessive pattern matching
---
# Let's build a blog :newspaper:
---


```elixir
defmodule Blog.Post do
  use Blog.Web, :model

  schema "posts" do
    field :title, :string
    field :author, :string
    field :body, :string
  end
end
```

```eex
<article>
  <header>
    <h1><%= @post.title %></h1>
    <address><%= @post.author %></address>
  </header>
  <section>
    <%= @post.body %>
  </section>
</article>
```
---
# Let's :hot_pepper: it up with some Markdown
---
```elixir
defmodule Blog.Web.PostView do
  use Blog.Web, :view

  def render_markdown(binary) do
    Blog.Markdown.to_html(binary)
  end
end
```

```elixir
defmodule Blog.Markdown do

  def to_html(binary) when is_binary(binary) do
    Cmark.to_html(binary)
  end
end
```
---
# Render the body as Markdown

```eex
<section>
  <%# Convert the markdown -> HTML %>
  <%= render_markdown @post.body %>
</section>
```

---
# Our HTML is being escaped :cry:

![](assets/escaped_html.png)

---
## `Phoenix.render/3` returns a safe tuple? :hushed:

```
iex(2)> Phoenix.View.render(Blog.Web.PostView, "show.html", post: post)
{:safe,
 [[[[[[["" | "<article>\n  <header>\n    <h1>"] | "First post"] |
      "</h1>\n    <address>"] | "Dave"] |
    "</address>\n  </header>\n  <section>\n"] |
   "&lt;p&gt;&lt;em&gt;Hello&lt;/em&gt; &lt;strong&gt;World&lt;/strong&gt;!&lt;/p&gt;\n"] |
  "  </section>\n</article>\n"]}
```

#### We can see our escaped HTML

```
"&lt;p&gt;&lt;em&gt;Hello&lt;/em&gt; &lt;strong&gt;World&lt;"
```
---
> The safe tuple annotates that our template is safe and that we don't need to escape its contents because all data has already been encoded.

# Thanks for keeping us safe, Phoenix :wink:
---
#### We need our Markdown rendered HTML to go from
#### `iodata` :point_right: `{:safe, iodata}`
---
## `render_markdown/1` now marks the HTML as safe
```elixir
def render_markdown(binary) do
  binary
  |> Markdown.to_html()
  |> Phoenix.HTML.raw() # Convert to {:safe, iodata} tuple
end
```

![](assets/safe_html.png)

---
## :white_check_mark:  The Good

we can render Markdown in templates

## :x: The Bad

We need have to remember to use the `render_markdown/1` function

---
# We're here to Refactor for Maintainability :tm:

## Let's refactor by leveraging Protocols
---
## Protocols help you acheive the Open/Closed Principle  in Elixir

:white_check_mark: Open for extension
:x: Closed for modification

> Protocols are a mechanism to achieve polymorphism in Elixir. Dispatching on a protocol is available to any data type as long as it implements the protocol.
---
## We can extend the rendering power of Phoenix by leveraging its `Phoenix.HTML.Safe` Protocol
---
```elixir
defmodule Blog.Markdown do
  defstruct text: ""

  def to_html(%__MODULE__{text: text}) when is_binary(text) do
    Cmark.to_html(binary)
  end

  defimpl Phoenix.HTML.Safe do
    # Implement the protocol
    def to_iodata(%Blog.Markdown{} = markdown) do
      Blog.Markdown.to_html(markdown)
    end
  end
end
```
---
```elixir
post = put_in(post.body, Markdown.new(post.body))

Phoenix.View.render(
  Blog.Web.PostView,
  "show.html",
  post: post
)
```

```eex
<article>
  <header>
    <h1><%= @post.title %></h1>
    <address><%= @post.author %></address>
  </header>
  <section>
    <%# render_markdown(@post.body) %>
    <%= @post.body %>
  </section>
</article>
```
---
# But wait, we can do better
---
## We still need to remember to wrap in a `Markdown` struct
```elixir
post = put_in(post.body, Markdown.new(post.body))
```

### How can we refactor further? :thinking:
---
# Behaviours :sunglasses:
---
#
