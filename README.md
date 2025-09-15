This README is a work in progress.

Papers can be reproducible. You can (and should) have everything necessary in one place.

## Write a paper with Quarto

The best way to write an automated and reproducible paper is by using [Quarto](https://quarto.org/). Quarto files end with `.qmd` and are an extension of Markdown (the simple markup language used to write this `README.md`). You will write the paper itself in the file `index.qmd`. Keep in mind:

- This is a text file. Everything is stored as text and is easily readable.
- Because of the simple original format, Quarto allows you to output this not only in a common PDF, but also dozens of other formats.
- You can customize a PDF format by defining the template used by the journals you want to publish in.
- You can include code chunks in Quarto files and they will be executed and their output automatically included in the final document.
- You can easily include references by defining them in `references.bib` and using their name in Quarto files.

## Ensure reproducibility with renv

If your output results depend on R code, e.g. you use custom functions and create plots from them with ggplot2, anyone could reproduce your results thanks to [renv](https://pkgs.rstudio.com/renv/). They only need to follow these steps:

1. The first time, they open an R session in this folder.
2. They run `renv::restore()` and install all packages.
3. They run `quarto render` in the command line or render the `index.qmd` file accordingly from RStudio.

## Allow collaborator editing with trackdown

If you need some help to write the content of the paper or just some feedback from collaborators and they know nothing about coding, they don't need to use git or R. They can suggest changes from a Google Docs file!

You will be responsible for syncing both places, but luckily it's quite easy with the [trackdown](https://claudiozandonella.github.io/trackdown/) R package.

## (Optional) Don't die configuring trackdown

If you want collaborators to suggest changes in a Google Docs, you will need a few one time configuration steps so that trackdown can read/write your files. Of course, this is only if you trust it! The trackdown package is open-source, so you could check that [nothing fishy is going on](https://github.com/ClaudioZandonella/trackdown).

1. TODO: add previous steps from creating Google Cloud Platform project
2. Create credentials for trackdown:
  - Go to APIs & Services -> Credentials -> Create credentials -> OAuth client ID
  - Fill credential info:
    - Application type: Desktop app
    - Name: whatever, e.g. Trackdown
  - Click create
  - Download JSON with credentials. The name should be something like `client_secret_some_long_code.apps.googleusercontent.com.json`.
3. Use credentials. Put this JSON file in this main folder and rename as `trackdown_access.json`. This is read from `.Rprofile` every time you open an R session here. When using trackdown update/download functions, the first time you will be asked to grant access.
4. Use trackdown! There are three functions you most likely need. Be careful! They overwrite everything, but ask you before just to confirm.
  - `trackdown::upload_file("index.qmd")`: Only the first time, when the file still doesn't exist in Google Docs.
  - `trackdown::update_file("index.qmd")`: Every time you make a change in this project and you want to update the Google doc.
  - `trackdown::download_file("index.qmd")`: Every time changes were made in the Google doc and *all* of the suggestions were resolved (accepted/rejected), if you want to update this project with its content.

## Sync workflow and automatic previews

TODO: explain how to work with both changes in this project and changes in Google doc, use separate branches, see automatic preview in PRs...

