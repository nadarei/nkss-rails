LIDOC := lidoc

LIDOC_OPTS  ?= --github $(GITHUB_REPO) --git-branch master
GITHUB_REPO ?= nadarei/nkss-rails

FILES := \
	README.md \
	app/helpers/*.rb \
	app/views/*/*.haml \
	app/assets/stylesheets/*.sass

docs: $(FILES)
	rm -rf $@
	$(LIDOC) $(LIDOC_OPTS) $^ --output $@

# Sends the documentation to gh-pages.
docs.deploy: docs
	cd docs && \
	git init . && \
	git add . && \
	git commit -m "Update documentation."; \
	git push "git@github.com:$(GITHUB_REPO).git" master:gh-pages --force && \
	rm -rf .git

.PHONY: docs docs.deploy
