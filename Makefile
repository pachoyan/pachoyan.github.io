# Makefile

.PHONY: install
install:
	bundle install

.PHONY: dev
dev:
	bundle exec jekyll serve
