# Quarto Reporting Template

This repository provides a starter Quarto project for building program reports. It includes recommended structure, layout patterns, styling conventions, and reusable components that support both narrative reports and data‑driven briefs.

The template is designed to be program‑agnostic. Users can adapt it to any reporting workflow, including those that load cleaned data from the ETL pipeline.

---

## What This Template Includes

- **Recommended project structure** for parent reporting repos  
- **Project‑level SCSS** for consistent typography, spacing, and layout  
- **Unified icon system** (Font Awesome + Bootstrap Icons)  
- **Reusable layout components**, including a dashboard‑style panel header  
- **Example narrative and visual sections**  
- **Placeholders for ETL integration**, including:
  - a `params:` block in `_quarto.yml`
  - a placeholder `R/load_data.R` script
  - a `data/` folder for ETL outputs

The template renders successfully without any external data. Analysts can plug in their program’s ETL outputs when available.

---

## Folder Structure

```{md}
reporting-template/
  _quarto.yml
  index.qmd
  README.md
  styles/
    report-html.scss
    fontawesome/
      css/
      webfonts/
  R/
    load_data.R        # placeholder for program-specific data loading
  data/
    .gitkeep           # ETL outputs go here
  images/
    .gitkeep
```

---

## How to Use This Template

1. Click **Use this template** to create a new repository.  
2. Update `_quarto.yml` with your program name and parameters.  
3. Replace the placeholder content in `index.qmd` with your report’s narrative and visuals.
4. Replace the content of this `README.md` to explain your report project. 
5. When your program has an ETL pipeline:
   - place cleaned data files in `data/`
   - update `R/load_data.R` to read them
   - reference the loaded data in your `.qmd` files  
6. Add additional `.qmd` files, images, or R scripts as needed.

---

## ETL Integration

This template includes placeholders for connecting to the ETL pipeline. The
intention is to allow {targets} to execute the ETL pipeline in
`famcare-etl-governed`, so the goal is to read the relevant program-specific.
target. One should also read targets for additional data bundles as needed. This
includes but is not necessarily limited to the cartography bundle.

A typical pattern might look like:

```{r}
#| label: load-<program>-data

# Set default fallback parameters for running code interactively during
# development since Quarto params are only passed when rendering the document
# if (
#   !exists(
#     "params"
#   )
# ) {
#   params <- list(
#     start_date = "2026-01-01",
#     end_date = "2026-03-31"
#     fiscal_system = "state"
#   )
# }

# Load ETL output
# source(
#   "R/load_data.R"
# )

# Run the function to load <program> data
# <program>_data <- load_epicc_data()
# Build subsets
# <program>_subsets <- build_subsets(
#  full_data = <program>_data$<program>_full_data,
#  start_date = params$start_date,
#  end_date   = params$end_date,
#  fiscal_system = params$fiscal_system
# )
#
# <program>_initiated  <- <program>_subsets$initiated_within_period
# <program>_dismissed  <- <program>_subsets$dismissed_within_period
```

These examples are commented out so the template renders without dependencies.

---

## Using Rendering Profiles in This Quarto Project

This project supports **two different rendering modes**, depending on the type of report you are producing:

- **Infographic‑style briefs** (HTML → PDF using pagedjs-cli)
- **Narrative LaTeX reports** (PDF via LaTeX engine)

These modes are implemented using **Quarto profiles**, allowing both formats to coexist cleanly in the same repository without duplicating configuration.

---

### Default Profile - Infographic Briefs (HTML + pagedjs-cli PDF)

The **default** rendering mode is optimized for *infographic briefs* and other layout‑heavy reports that rely on:

- SCSS theming  
- FontAwesome icons  
- HTML/CSS layout  
- Full‑page designs  
- Web fonts  
- Paged media CSS  

This profile uses **pagedjs-cli** to generate PDFs from HTML.

#### Render to HTML (Default)

```{md}
quarto render index.qmd
```

### LaTeX Profile - Narrative Reports (Annual Reports, Long-Form Text)

The `latex` profile is designed for **narrative, text‑heavy reports** that require:

- LaTeX typography  
- Traditional pagination  
- Section numbering  
- Academic‑style layout  
- Custom LaTeX preambles

This profile uses a LaTeX engine (e.g., `xelatex`) instead of `pagedjs`.

#### Render to PDF (LaTeX Profile)

```{md}
quarto render index.qmd --profile latex
```

---

## Notes

- The template is intentionally minimal.  
- You can safely delete any sections you don’t need.  
- The SCSS file (`styles/report.scss`) is where you customize colors, spacing, and layout.  
- The icon system works offline because the icon files are included directly in the project.

---

## Contributing

If you discover a pattern that would help others, feel free to propose an update. This template is meant to evolve as our reporting workflows evolve.
