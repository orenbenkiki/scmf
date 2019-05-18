# SCMF: Simpler Cargo Make Flows

A simpler set of flows for [cargo
make](https://github.com/sagiegurari/cargo-make). This set of flows was designed
for my personal use. Feel free to use it if it also works for you.

## Installation:

In the first few lines of your `Makefile.toml`, write:

```toml
extend = "Makefile.scmf.toml"

[config]
load_script = ["wget https://raw.githubusercontent.com/orenbenkiki/scmf/master/Makefile.scmf.toml Makefile.scmf.toml"]
```

Alternatively you can write:

You would also want to add `.common.toml` to your `.gitignore` file.

## Usage:

You can always run `cargo make --list-all-steps` for the up-to-date list of tasks and flows.

The set of flows should be as follows:

### Top level flows.

* `cargo make pc`

  This flow should be invoked before committing a new version. It is a good
  candidate for adding to a `git` pre-commit hook. It invokes the following
  sub-flows:

  * `cleanup` to ensure a clean rebuild.
  * `prepare` to correct the source files (in particular, their formatting).
  * `ci` to invoke all the verifications the CI server will perform.

* `cargo make ci`

  This flow should be invoked by a continuous integration server. Its goal is to
  find any possible reason to reject the new version. It invokes the following
  sub-flows:

  * `verify` to ensure the code doesn't have blatant bugs.
  * `audit` to ensure the code satisfies basic code style and guidelines.
  * `doc` to ensure the code contains reasonable amount of documentation.

### Basic flows.

* `cleanup` just invokes `cargo clean`.

* `prepare` just invokes `format` to enforce the Rust standard formatting style.

* `verify` invokes `build` to compile the code, `test` to run the unit tests,
  and `coverage` to collect their coverage.

* `audit` invokes `check-format` to verify the formatting, `clippy` to ensure
  general Rust best practices, `todox` to ensure there are no leftover tasks
  to be done before the new version is complete, `coverage-annotations` to
  ensure the code coverage comments reflect the actual coverage status of each
  line, and `outdated` to ensure the crate's dependencies are up-to-date.

## Configuration

Since this builds on the `Makefile.stable.toml` provided by `cargo make`, some
of the configuration variables provided there. Most notable is
`CARGO_MAKE_COVERAGE_PROVIDER` to control how coverage is collected (by default,
using `kcov`).

In addition, the following environment variables are specific to `SCMF`:

* Setting `SCMF_DISABLE_FORMAT` disables reformatting the code using `rustfmt`.

* Setting `SCMF_DISABLE_CHECK_FORMAT` disables verifying the code format using
  `rustfmt --check`.

* Setting `SCMF_DISABLE_CLIPPY` disables verifying the code using `clippy`.

* Setting `SCMF_DISABLE_OUTDATED` disables verifying that the crate dependencies
  are up-to-date.

* Setting `SCMF_DISABLE_TODOX` disables scanning the sources for pending
  `todox` issues.

* Setting `SCMF_DISABLE_COVERAGE_ANNOTATIONS` disables verifying that the
  code coverage comments match the actual code coverage.

## License

`SCMF` is licensed under the [MIT License](LICENSE.txt).
