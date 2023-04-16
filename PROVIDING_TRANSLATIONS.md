# Providing translations

Just to keep things sensible and maintainable, a few ground rules.

1. Please keep the translation as direct to the _U.S. English_ translation as possible.

1. Keep the first part of the filename the same as the _U.S. English_ translation. For example:

    ```plain
    installing-garlicos-single-card
    ```

1. After the first part of the filename, use a period (`.`) to delimit the _locale code_ of the translation. A _complete_ locale code is comprised of a 2-character [ISO 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) language identifer, then an underscore (`_`), then a 2-character [ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1#Current_codes) country identifier.

    For example:

    | Code    | Country Dialect         |
    |---------|-------------------------|
    | `en_us` | English, U.S.           |
    | `en_gb` | English, Britain        |
    | `fr_fr` | French, France          |
    | `fr_ca` | French, Canada          |
    | `es_us` | Spanish, U.S.           |
    | `es_mx` | Spanish, Mexico         |
    | `es_es` | Spanish, Spain          |
    | `zh_cn` | Chinese, Mainland China |
    | `zh_tw` | Chinese, Taiwan         |
    | `zh_hk` | Chinese, Hong Kong      |

1. File extension is `.md`. The final filename would look like `installing-garlicos-single-card.es_mx.md` for the _Mexican Spanish_ translation of _Installing Garlic OS on your Anbernic RG35XX using macOS (single-card setup)_.
