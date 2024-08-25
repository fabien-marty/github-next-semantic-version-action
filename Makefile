default: help

.PHONY: docker
docker: Dockerfile ## Build the docker image
	docker build -t github-next-semantic-version-action:latest .

.PHONY: clean
clean: ## Clean tmp files
	rm -f github-next-semantic-version Dockerfile

.PHONY: no-dirty
no-dirty: ## Check for git dirty files
	@git diff --exit-code >/dev/null 2>&1 || (echo "ERROR: There are dirty files"; git diff; exit 1)
	@N=`git status --porcelain 2>/dev/null| grep "^??" |wc -l`; if test $${N} -gt 0; then echo "ERROR: There are untracked files"; git status; exit 1; fi

Dockerfile: Dockerfile.template
	TMP=`./latest-version.sh` && \
	export VERSION=`echo $${TMP} | cut -d' ' -f1` && \
	export URL=`echo $${TMP} | cut -d' ' -f2` && \
	docker run -t -v $$(pwd):/workdir --user=$$(id -u) -e VERSION -e URL ghcr.io/fabien-marty/jinja-tree:latest /workdir
	
.PHONY: help
help::
	@# See https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
