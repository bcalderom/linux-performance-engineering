---
trigger: always_on
---

# Update CHANGELOG.md

After comple successfully a modification, add the details to the CHANGELOG.md file in the docs directory.

The format should be:
  

    ## [Version Number] - YYYY-MM-DD


    ### Added

    - Brief description of new feature
    - Link to relevant documentation or issue


    ### Changed

    - Description of modifications to existing functionality
    - Impact on user experience


    ### Fixed

    - Bug fixes with issue reference (#123)
    - Description of the resolution


    ### Deprecated

    - Features marked for removal in future versions
    - Migration guidance


    ### Removed

    - Features or functionality removed in this version
    - Alternative approaches


    ### Security

    - Security-related changes or patches
    - CVE references if applicable


    ### Performance

    - Performance improvements
    - Metrics or benchmarks if available


    ### Technical Debt

    - Code refactoring without functional changes
    - Test coverage improvements

* Only include sections that have at least one real bullet.
* Do not add sections with - N/A. If there is nothing relevant for a category in a given version, simply omit that subsection.

# Commit Message Generation

When generating commit messages:

- Always follow the conventional commit framework (type(scope): description)
- Keep the first line under 72 characters
- Use present tense for the action
- Be specific about what changed, not how it changed
- Add a brief joke or pun in the extended description when appropriate