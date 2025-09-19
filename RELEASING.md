# Releasing

Steps to publish `go_responsive`, `go_responsive_annotation` and `go_responsive_generator` to pub.dev.

## Manual Version

> of all packages to spesific version for easy to match

```sh
version="0.4.3" &&
melos version -V go_responsive:$version -V go_responsive_annotation:$version -V go_responsive_generator:$version
```

## Manual Changelog enty message

> If any package not update its actual content and not new commited detect then use message

```txt
Update dependencies
```

## Pusg Git Tags to Github

```sh
git push --follow-tags
```

## Verify chnages with dry run

```sh
melos publish --dry-run
```

## Publisht to pub.dev

```sh
melos publish --no-dry-run --git-tag-version
```