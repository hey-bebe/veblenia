# Veblenia Site Design

## Goal

Configure this repository as a working Hugo notes site for **Veblenia** with the tagline **"Notes and Fragments on Institutions"**. The result should replace the stock scaffold with a source-driven site that builds cleanly on GitHub Pages and uses the existing `archie` theme with minimal local overrides.

## Scope

This design covers:

- Real site metadata and navigation
- A post-first homepage
- Source content structure for posts and static pages
- Tags and archive browsing
- Minimal template overrides needed to fix incorrect theme behavior
- Repository hygiene for local and miscellaneous files via `.gitignore`

This design does not include:

- A theme migration
- Custom visual redesign beyond small structural fixes
- Search, comments, analytics, or other optional features

## Current State

The repository is an almost-empty Hugo scaffold:

- [`hugo.toml`](/home/cody/Projects/veblenia/hugo.toml) still contains placeholder metadata
- There is no source content under `content/`
- The homepage renders as an empty default site
- The bundled theme has taxonomy labeling and HTML metadata issues that should be fixed locally instead of forking the theme

## Approach

Keep the existing `archie` theme, but configure the site as an actual publication and override only the templates that are wrong for this use case. This preserves the current stack and avoids unnecessary theme churn while still making the site coherent and deployable.

## Information Architecture

### Primary Sections

- `posts`
  The main publishing section and the only section shown on the homepage.
- `about`
  A standalone page describing the project.
- `contact`
  A standalone page with contact details or instructions.

### Navigation

The top navigation should contain:

- Home
- Contact
- Tags
- Archive
- About

### Browsing Model

- The homepage shows posts only
- Tags provide taxonomy-based browsing
- Archive provides a chronological list of posts
- About and Contact are static pages outside the post stream

## Content Model

### Post Content

Posts will live under `content/posts/` and use Hugo front matter appropriate for a notes site:

- `title`
- `date`
- `description` optional
- `tags` optional
- `draft` optional

### Static Pages

Create:

- `content/about.md`
- `content/contact.md`
- `content/archive.md`

`archive.md` should use a dedicated archive layout so it appears as a normal page in navigation but renders as a chronological post listing.

## Site Configuration

Update [`hugo.toml`](/home/cody/Projects/veblenia/hugo.toml) to define:

- Real `baseURL`
- Real title and language code
- Active theme
- Main menu entries
- Main content section as `posts`
- Tags taxonomy
- Site description/tagline metadata
- Any minimal params required by `archie` for correct title/subtitle rendering

The final configuration should avoid stock placeholder values and should support clean generation of canonical URLs and feed metadata.

## Template Overrides

Add local templates under `layouts/` only where site behavior must differ from the upstream theme.

### Required Overrides

- Home template
  Ensure the homepage renders only the posts list and does not depend on placeholder intro content.
- Archive page template
  Render posts chronologically from a dedicated archive page.
- Taxonomy terms template
  Replace hardcoded `All tags` behavior with labels derived from the active taxonomy.
- Taxonomy term template
  Replace hardcoded `Entries tagged` wording with neutral taxonomy-aware headings.
- Base layout and head partial behavior
  Ensure the HTML `lang` attribute is attached to the `<html>` element instead of `<head>`.

### Non-Goals for Overrides

- Do not fork the whole theme
- Do not redesign the visual system unless required for clarity
- Do not add optional features that the user did not request

## Deployment

Keep the existing GitHub Pages workflow. The repo should remain buildable with Hugo, and the output should reflect the real site configuration rather than placeholder scaffold values.

This design does not change the deployment architecture. It only ensures the source configuration and templates produce correct output.

## Repository Hygiene

Add or update [`.gitignore`](/home/cody/Projects/veblenia/.gitignore) so local tooling and miscellaneous files are not tracked accidentally.

The ignore rules should include the categories the user explicitly requested, including:

- `superpowers`
- `docs`
- `.emacs`
- `codex`
- other similar local or miscellaneous helper files that should not be committed

The implementation should preserve normal source files required to build and deploy the site while excluding clearly local, editor-specific, or workflow-specific artifacts.

## Testing and Verification

Verification should confirm:

- `hugo build --gc --minify --cacheDir /tmp/veblenia-hugo-cache` succeeds
- The homepage shows posts only
- The top navigation contains the requested entries
- About, Contact, Tags, and Archive pages render successfully
- Taxonomy headings are correct for both tags and any future taxonomy pages
- Generated HTML uses a valid `lang` attribute placement
- Requested local and miscellaneous files are ignored by git

## Risks and Constraints

- The current repo tracks generated `public/` output, so local verification builds may rewrite generated files
- The `archie` theme may have additional assumptions, but local overrides should be sufficient for the agreed scope
- Final `baseURL` depends on the intended production URL; if it is not yet known, a provisional GitHub Pages URL can be used and updated later

## Implementation Summary

Implement the site by:

1. Replacing placeholder Hugo configuration with real site metadata and menus
2. Creating the initial source content structure
3. Adding minimal local template overrides for homepage, archive, taxonomy labels, and valid HTML metadata
4. Updating `.gitignore` to exclude the requested local and miscellaneous files
5. Running a Hugo build to verify the configured site renders correctly
