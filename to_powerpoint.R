pagedown::chrome_print("slides.html", output = "slides.pdf")
pages <- pdftools::pdf_info("slides.pdf")$pages
filenames <- sprintf("pdf_slides/slides_%02d.png", 1:pages)
dir.create("pdf_slides")
pdftools::pdf_convert("slides.pdf", filenames = filenames)
slide_images <- glue::glue(
  "
---
![]({filenames}){{width=100%, height=100%}}
")
slide_images <- paste(slide_images, collapse = "\n")
md <- glue::glue(
  "
  ---
  output: powerpoint_presentation
  ---
  {slide_images}
  "
)
cat(md, file = "slides_powerpoint.Rmd")
rmarkdown::render("slides_powerpoint.Rmd")  ## powerpoint!
