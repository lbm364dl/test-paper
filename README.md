This README is a work in progress.

Papers can be reproducible. You can (and should) have everything necessary to generate your paper in one place. This is the place.

## TLDR: How to use this

1. You write your paper in `index.qmd`. This is a [Quarto](https://quarto.org/) file. Just go and take a look. Make some edits. You'll figure out the details.
2. You get your PDF by running `quarto render` in your terminal or clicking [some render button in your RStudio](https://quarto.org/docs/get-started/hello/rstudio.html#rendering). You might need to first [install Quarto](https://quarto.org/docs/get-started/).
3. You check the output PDF in `_manuscript/index.pdf`. If you're not satisfied, go back to step 1.
4. (Optional) Your collaborators don't know anything about git or coding but want to make suggestions. Just send them a Google Docs link and then you [take care of syncing both places](#sync-workflow-and-automatic-previews). OK, this one needs a bit of configuration to set up. If you need it, go read about [collaborator editing with trackdown](#allow-collaborator-editing-with-trackdown).
5. (Optional) Some researcher wants to reproduce your work. Just send them a link to your GitHub repository. Seriously, that's all. OK, for this to be bullet-proof, you need to be careful on how you set up package dependencies if you write R code project. See [reproducibility with renv](#ensure-reproducibility-with-renv).

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

There are three functions you most likely need. Be careful! They overwrite everything, but ask you before just to confirm.
  - `trackdown::upload_file("index.qmd")`: Only the first time, when the file still doesn't exist in Google Docs.
  - `trackdown::update_file("index.qmd")`: Every time you make a change in this project and you want to update the Google doc.
  - `trackdown::download_file("index.qmd")`: Every time changes were made in the Google doc and *all* of the suggestions were resolved (accepted/rejected), if you want to update this project with its content.

## (Optional) Don't die configuring trackdown

If you want collaborators to suggest changes in a Google Docs, you will need a few one time configuration steps so that trackdown can read/write your files. Of course, this is only if you trust it! The trackdown package is open-source, so you could check that [nothing fishy is going on](https://github.com/ClaudioZandonella/trackdown).

1. Open [your Google Cloud Platform project](https://console.cloud.google.com/), signed in with your desired Google account.
2. Open [this link](https://console.cloud.google.com/auth/overview/create) to create an _app_ (whatever that means). Fill things:
  - App Information:
    - App name: whatever, e.g., Trackdown
    - User support email: your own email
  - Audience: external
  - Contact Information: your own email
  - Finish: agree
  - Finally, create
3. Open [this link](https://console.cloud.google.com/auth/audience) to add yourself as test user (whatever that means).
  - In _Test users_, click _Add users_
  - Add your own email
  - Click _Save_ (twice if necessary)
4. Open [this link](https://console.cloud.google.com/apis/library/drive.googleapis.com) and click _Enable_ to allow programmatic access to Google Drive.
5. Open [this link](https://console.cloud.google.com/apis/library/docs.googleapis.com) and click _Enable_ to allow programmatic access to Google Docs.
6. Open [this link](https://console.cloud.google.com/auth/clients/create) to create an OAuth client ID (whatever that means). Fill things:
  - Application type: Desktop app
  - Name: whatever, e.g. Trackdown
  - Click create
  - Click  _Download JSON_. The name of the downloaded file should be something like `client_secret_some_long_code.apps.googleusercontent.com.json`.
7. Actually use these credentials:
  - Put that JSON file in this main folder (the same folder where this `README.md` file is).
  - Rename it as `trackdown_access.json`. The `.json` is the extension, and you might not need to write it if you use e.g. Windows file explorer. If something goes wrong, make sure you didn't name it `trackdown_access.json.json` by mistake.
  - Your credentials will be read automatically from `.Rprofile` every time you open an R session here. When using trackdown update/download functions, the first time you will be asked to grant access in your browser. **Toggle the _allow access_ button before continuing**. Otherwise it won't work.
8. Actually use trackdown! Check the [previous section](#allow-collaborator-editing-with-trackdown) for the important functions.

## Sync workflow and automatic previews

TODO: explain how to work with both changes in this project and changes in Google doc, use separate branches, see automatic preview in PRs...
