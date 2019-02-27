# Code BEAM Presentation

## REFACTORING ELIXIR FOR MAINTAINABILITY

Elixir is a very expressive language that offers syntactic features that are new and exciting when coming from other languages. Beginners tend to overuse features such as pattern matching and multiple function heads because of their novelty, while missing opportunities to make their code more generic and workable. Additionally, powerful language features such as protocols and behaviours are often overlooked due to their relative complexity.

This talk will highlight many of the common beginner mistakes, and often alternative patterns to writing code that tend to be more maintainable over time.

### OBJECTIVES

This talk aims to identify common beginner mistakes when coming from other languages such as Javascript, Ruby or Go, that do not have the ergonomic features of Elixir, and offers insight into how to fix these mistakes to make your code more maintainable over time.

### TARGET AUDIENCE
This talk appeals to beginners and intermediate developers who are newer to Elixir and haven't written enough code to identify structural patterns that can lead to future headaches.


### Development

To build the presentation as a PDF, run

```bash
marp presentation.md --allow-local-files --pdf --theme gaia
```

To build the website, run

```bash
marp presentation.md --allow-local-files --html --theme gaia
```
