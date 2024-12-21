All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## [2.0.0] – 2024-12-21

- Modernize the gem setup [#5](https://github.com/liveh2o/strong_routes/pull/5)
- Make Allow middleware thread-safe without duping (85x faster!) [#6](https://github.com/liveh2o/strong_routes/pull/6)
- Return 404 HEAD response by default (if `public/404.html` is present in Rails apps, it is rendered instead) [#7](https://github.com/liveh2o/strong_routes/pull/7)
- Automatically reload allowed routes in Rails apps when routes change (in development mode)
- Use Standard styles

### Added

- Add config options for `:content`, `:content_type`, and `:status`. If `:content` is nil (the default), no headers will be returned. Otherwise, a `content-type` header will be added. If `:content_type` is nil (the default), `"text/plain"` will be used.

### Changed

- Allowed routes now require a leading slash (i.e., "/") [#9](https://github.com/liveh2o/strong_routes/pull/9)

### Removed

- Drop support for the `:message` config option (use `:content` instead)
- Drop support for allowing routes as symbols
- Require Ruby 2.7

## [1.0.2] - 2016-02-09

- Make allow middleware thread-safe ([61a3b50](https://github.com/liveh2o/strong_routes/commit/61a3b507e83f6a582d1cee9f36b70306b0fc0eae))

## [1.0.1] - 2014-06-05

- Recognize root paths [#3](https://github.com/liveh2o/strong_routes/pull/3)

## [1.0.0] - 2014-06-04

## [0.9.5] - 2014-03-31

## [0.9.4] - 2014-02-18

## [0.9.3] - 2014-02-17

## [0.9.2] - 2014-02-17

## [0.9.1] - 2014-02-17

## [0.9.0] - 2014-02-17

- Initial release
