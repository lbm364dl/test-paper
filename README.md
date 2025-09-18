This README is a work in progress.

Papers can be reproducible. You can (and should) have everything necessary to generate your paper in one place. This is the place.

## TLDR: How to use this

1. [Install Quarto](https://quarto.org/docs/get-started/).
2. Open a command line and run `quarto install tinytex`. Quarto first converts your file to [LaTeX](https://en.wikipedia.org/wiki/LaTeX) and then uses that to generate your PDF. This command installs a minimal LaTeX.
3. If you use RStudio, you can open this as an RStudio project. Otherwise you probably know what you're doing.
4. You write your paper in `index.qmd`. This is a [Quarto](https://quarto.org/) file. Just go and take a look. Make some edits. You'll figure out the details.
5. You get your PDF by running `quarto render` in your command line or clicking [some render button in your RStudio](https://quarto.org/docs/get-started/hello/rstudio.html#rendering).
6. If you got problems with the previous step because of some missing R package, we got you covered. Just run `renv::restore()` in R to install all necessary packages!
7. You check the output PDF in `_manuscript/index.pdf`. If you're not satisfied, go back to step 4. Make more changes to your `index.qmd`.
8. (Optional) Your collaborators don't know anything about git or coding but want to make suggestions. Just send them a Google Docs link and then you [take care of syncing both places](#sync-workflow-and-automatic-previews). OK, this one needs a bit of configuration to set up. If you need it, go read about [collaborator editing with trackdown](#allow-collaborator-editing-with-trackdown).
9. (Optional) Some researcher wants to reproduce your work. Just send them a link to your GitHub repository. Seriously, that's all. OK, for this to be bullet-proof, you need to be careful on how you set up package dependencies if you write R code in your project. See [reproducibility with renv](#ensure-reproducibility-with-renv).

## Write a paper with Quarto

The best way to write an automated and reproducible paper is by using [Quarto](https://quarto.org/). Quarto files end with `.qmd` and are an extension of Markdown (the simple markup language used to write this `README.md`). You will write the paper itself in the file `index.qmd`. Keep in mind:

- This is a text file. Everything is stored as text and is easily readable.
- Because of the simple original format, Quarto allows you to output this not only in a common PDF, but also dozens of other formats.
- You can customize a PDF format by defining the template used by the journals you want to publish in.
- You can include code chunks in Quarto files and they will be executed and their output automatically included in the final document.
- You can easily include citations by defining them in `references.bib` and using their name in Quarto files.

## Integrate your citations (e.g. Zotero) seamlessly

If you know what [BibTeX](https://www.bibtex.org/) is, go ahead, see how the file `references.bib` is used. See the `[@knuth84]` usage in the sample `index.qmd`. You can manually add BibTeX references in there.

If you use RStudio, adding citations is incredibly easy:

- Open a Quarto file (`index.qmd` here)
- From the two options _Source_ and _Visual_, choose _Visual_
- Put your cursor where you want your citation
- Click _Insert_ -> _Citation_
- Search your citation. There are different ways to get it. Your Zotero library will also appear if you have the Zotero app installed

If you know what you're looking for, there's an easier way by writing a `@` in _Visual_ mode where you want the citation, and RStudio will automatically open a search menu for you to choose.

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

If you want collaborators to suggest changes in a Google Docs, you will need a few one time configuration steps so that trackdown can read/write your files. Of course, this is only if you trust it! The trackdown package is open-source, so you could check that [nothing fishy is going on](https://github.com/ClaudioZandonella/trackdown). If you feel safer, you could also create a new Google account just for this usage.

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
8. Restart your R session. Your credentials are read automatically from `.Rprofile` every time you open an R session here. If you already had an open session while setting the credentials file, it won't be read until you restart the session.
9. Actually use trackdown! Check the [previous section](#allow-collaborator-editing-with-trackdown) for the important functions. When using trackdown update/download functions, the first time you will be asked to grant access in your browser. **Toggle the _allow read/write access_ button before continuing**. Otherwise it won't work.

## Sync workflow and automatic previews

1. The `main` branch must contain the most up to date reviewed version of the paper.
2. The `sync-google-doc` branch will be up to date with the Google Docs version of your paper.
3. When a certain review stage finishes, you download the content into `sync-google-doc` with trackdown and create a Pull Request from `sync-google-doc` to `main`.
4. You will see a preview of the PDF result in the Pull Request after a while.
5. If you're satisfied with the result, you merge into `main`.
6. If you want to add new content yourself right here, you create your own branch. When you're done, you merge to `main`.
7. If there are local changes not in the Google doc, you do `git pull origin main` from the `sync-google-doc` branch to update it. You then update the Google doc using trackdown. **Please have a clean Google doc stage (no pending reviews) before, otherwise you may lose changes when overwriting.**
8. Ask for a new review. Go back to step 3.
