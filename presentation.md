<!-- $size: 16:9 -->
<!-- $theme: gaia -->


# REFACTORING ELIXIR FOR MAINTAINABILITY

---
# ~~REFACTORING ELIXIR FOR MAINTAINABILITY~~
# Leveraging Protocols and Behaviours to write better designed Elixir programs
---

# The Problem

Elixir is a very expressive language that offers syntactic features that are new and exciting when coming from other languages. Beginners tend to overuse features such as pattern matching and multiple function heads because of their novelty, while missing opportunities to make their code more generic and workable. Additionally, powerful language features such as protocols and behaviours are often overlooked due to their relative complexity.


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
# 
