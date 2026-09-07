<!-- Thank you for contributing to the kit! Playbook conventions live in CONTRIBUTING.md. -->

## What does this PR change?

<!-- Kit playbook (references/), SKILL.md, templates, tooling, docs, examples? -->

## Why

<!-- What does a teardown run gain? Link the issue if there is one. -->

## Checklist

- [ ] `bash scripts/validate-skill.sh` exits 0
- [ ] CI green (markdownlint + link check run automatically)
- [ ] **Playbook change?** Re-ran a smoke teardown with the change applied
      (per CONTRIBUTING — methodology edits that were never executed tend to
      read well and run badly)
- [ ] **New/changed sweep?** Keeps the house shape: role / one exact
      question / required sourcing / output shape; revenue estimates stay
      separate per source
- [ ] **Versioning** matches CONTRIBUTING (patch = wording, minor =
      sweeps/methodology/examples, major = output contract)
- [ ] `examples/` untouched (regenerated only on minor milestones)
