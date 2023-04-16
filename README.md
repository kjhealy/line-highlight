# Line-highlight Extension For Quarto

Quarto Extension to enable source code line highlighting and output line highlighting for HTML documents (`format: html`) similar to how [`code-line-numbers`](https://quarto.org/docs/reference/formats/html.html#code) works for RevealJs output.

## Installing

```bash
quarto add shafayetShafee/line-highlight
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Once installed, using this filter is easy. Simply add the following in your document yaml,

```
---
title: "Code Line Number(s) Highlight in html"
format: html
filters:
  - line-highlight
---
```
**Please Note that, this filter extension requires Quarto v1.2 at least to work.**

### Highlighting Source Line Numbers

#### Example 01

Suppose we want to highlight the second line of a code chunk, to do that, we simply need to use the chunk option, `source-line-numbers: "2"` for that chunk.

~~~
---
title: "line highlighting"
format: html
filters:
  - line-highlight
---

```{r}
#| source-line-numbers: "2"

iris |> 
  head(5)
```
~~~

<img src="example-images/line-highlight01.png" alt="Example-01" width="600" />

#### Example 02 (with source code line number)

Also, having the source code line numbered in such case would be helpful. We can do that by using source class `numberLines` (i.e. `#| class-source: "numberLines"`).

Here we have highlighted line number 2 and 6 to 7 and have also enabled source code line numbering using `numberLines` source-class.

~~~
---
title: "line highlighting"
format: html
filters:
  - line-highlight
---

```{r}
#| message: false
#| class-source: "numberLines"
#| source-line-numbers: "2,6-7"

# library call
library(dplyr)

# code
iris |> 
  group_by(Species) |> 
  summarize(mean(Sepal.Length))
```
~~~

<img src="example-images/line-highlight02.png" alt="Example-02" width="600" />


## Highlighting on markdown formatted codeblocks

Highlighting will also works on syntactically formatted markdown code blocks (non-executable)(e.g. `{.r}`, `{.python}`, `{.julia}` etc)

Use `source-line-numbers` as code-block attributes (i.e. \<attribute-name\>=\<value\>),


```{.r source-line-numbers="1,4"}
library(dplyr)

iris |> 
  group_by(Species) |> 
  summarize(mean(Sepal.Length))
```

To get line numbers, use the `.numberLines` class additionally on the code-block,


```{.python .numberLines source-line-numbers="3-4"}
print("Hello world")

for name in ["Sam", "Jake"]:
    print(f"Hello {name}!")
```

<img src="example-images/line-highlight04.png" alt="Highlighting on markdown formatted codeblocks" width="600" />

For details, [see here](https://shafayetshafee.github.io/line-highlight/example.html#highlighting-on-markdown-formatted-codeblocks).


### Highlighting Output Line Numbers

Highlighting output line numbers a bit tricky. To enable output line number highlighting, we need to use both output class `highlight` and `numberLines` along with `output-line-numbers`.


#### Example

So to highlight second line of output, we use `output-line-numbers: "2"` and `class-output: "highlight numberLines"` (Sorry couldn't make it any more easier :D :p).

~~~
---
title: "line highlighting"
format: html
filters:
  - line-highlight
---

```{r}
#| message: false
#| source-line-numbers: "1,4"
#| class-output: "highlight numberLines"
#| output-line-numbers: "2"

library(dplyr)

mtcars |> 
  summarize(
    avg_mpg = mean(mpg)
  )
```
~~~

<img src="example-images/line-highlight03.png" alt="Example" width="600" />


For a complete compilable `qmd` file with these example,

- The source code: [example.qmd](example.qmd) 
- The rendered HTML document [example.html](https://shafayetshafee.github.io/line-highlight/example.html)


## Acknowledgement

The javascript code and css for implementing ling highlighting is taken (modified and reduced) from the [Quarto Github Repo](https://github.com/quarto-dev/quarto-cli/tree/main/src/resources/formats/revealjs/plugins/line-highlight).