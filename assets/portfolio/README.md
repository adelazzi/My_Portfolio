# Editing your portfolio content

Everything on the site about your career, projects and skills comes from
[`career.json`](career.json). Add or change an entry there and the page updates
itself: the git tree, the projects list and the skills columns. No Dart code
to touch.

Button and menu text lives separately in `assets/translations/language_<code>.json`.

## Before you push

```bash
dart run tool/validate_career.dart
```

It reports anything the site would skip (bad date, unknown track, missing file)
and exits with an error so the GitHub deploy stops instead of publishing a
broken page. Missing translations show up as notes; English is used for them.

## Text in several languages

Any text field can be one string (English only):

```json
"title": "Flutter developer"
```

or one string per language. Leave a language out and English is shown:

```json
"title": { "en": "Flutter developer", "ru": "Flutter-разработчик" }
```

Languages: `en`, `ar`, `fr`, `ru`.

## `photo`

Path to your portrait, shown next to the About text. Leave it `null` to show
the text alone.

```json
"photo": "assets/images/me.jpg"
```

## `path`: the career git tree

One entry per study, job or community role. The order in the file doesn't
matter; entries are sorted by date.

| Field | Required | What it does |
|---|---|---|
| `id` | yes | Unique name, letters and dashes: `"hiske-dev"` |
| `track` | yes | Which line it sits on. One of the `tracks` ids: `studies`, `work`, `community` |
| `start` | yes | `"2024-06"` (year and month) or `"2024"` |
| `end` | yes | `"2025-08"`, or `null` if it's still going on. Ongoing entries are drawn in gold |
| `label` | no | Short name written next to the dot: `"Hiske Dev"`. Defaults to the English `place` |
| `title` | yes | `"Flutter developer"` |
| `place` | yes | Company, school or club |
| `details` | no | A short paragraph |
| `highlights` | no | List of bullet points (`{ "en": ["...", "..."] }`) |
| `logo` | no | `"assets/images/hoskadev.png"` |
| `link` | no | Website, shown as "Visit website" |
| `links` | no | Extra links: `[{ "label": { "en": "View certificate" }, "url": "https://..." }]` |

How the tree is drawn:

- The track marked `"main": true` (studies) is the main line.
- Other tracks branch off the main line when their first entry starts and merge
  back when the last one ends. Gaps shorter than four months stay one branch.
- The newest ongoing entry on the main line gets the pulsing "now" marker and
  is selected when the page opens.

### Template

```json
{
  "id": "new-job",
  "track": "work",
  "start": "2027-02",
  "end": null,
  "label": "Company",
  "logo": "assets/images/company.png",
  "title": { "en": "Software engineer", "ru": "Инженер-программист" },
  "place": { "en": "Company name" },
  "details": { "en": "What you do there in one or two sentences." },
  "highlights": { "en": ["A result you're proud of", "Another one"] }
}
```

### Adding a new track

Add it to `tracks` and use its `id` in entries. Tracks are drawn top to bottom
in the order listed:

```json
{ "id": "freelance", "title": { "en": "Freelance", "ru": "Фриланс" } }
```

## `projects`

| Field | Required | What it does |
|---|---|---|
| `id` | yes | Unique name |
| `date` | yes | `"2025-05"`. Newest projects are shown first |
| `title` | yes | Project name |
| `summary` | yes | Description. Long ones get a "Read more" toggle |
| `image` | no | `"assets/images/projects/name.jpg"`, about 1600 px wide |
| `tech` | no | `["Flutter", "Firebase"]` |
| `award` | no | Prize or recognition, shown in gold |
| `links` | no | Same shape as in `path` |

New images go in `assets/images/projects/`. Keep them under about 300 KB.

## `skills`

```json
{ "name": "Flutter", "area": "Frontend", "level": "daily" }
```

`level` is `daily` (first column, larger) or `familiar` (second column).

## `roles`: the lines in the hero

```json
{ "since": "2021", "title": { "en": "Flutter developer" } }
```

Each role is drawn from its `since` year to today. The most recent one is gold.
