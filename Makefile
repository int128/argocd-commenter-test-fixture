all:

setup:
	git config user.name 'github-actions[bot]'
	git config user.email '41898282+github-actions[bot]@users.noreply.github.com'
	git checkout -B "$(FIXTURE_BRANCH)/main"
	git add .
	git commit -a -m "Initial commit"
	git push origin -f "$(FIXTURE_BRANCH)/main"

test1:
	git checkout "$(FIXTURE_BRANCH)/main"
	git checkout -b "$(FIXTURE_BRANCH)/test1"
	sed -i -e 's/name: echoserver/name: echoserver-test1/g' app1/deployment/echoserver.yaml
	git commit -a -m 'e2e-test: app1'
	git push origin -f "$(FIXTURE_BRANCH)/test1"
	gh pr create --base "$(FIXTURE_BRANCH)/main" --fill --body "$(PULL_REQUEST_BODY)"
	gh pr merge --squash
	git checkout "$(FIXTURE_BRANCH)/main"
	git pull origin "$(FIXTURE_BRANCH)/main" --ff-only

test2:
	git checkout "$(FIXTURE_BRANCH)/main"
	git checkout -b "$(FIXTURE_BRANCH)/test2"
	sed -i -e 's/app: echoserver/app: echoserver-test2/g' app2/deployment/echoserver.yaml
	git commit -a -m 'e2e-test: app2'
	git push origin -f "$(FIXTURE_BRANCH)/test2"
	gh pr create --base "$(FIXTURE_BRANCH)/main" --fill --body "$(PULL_REQUEST_BODY)"
	gh pr merge --squash
	git checkout "$(FIXTURE_BRANCH)/main"
	git pull origin "$(FIXTURE_BRANCH)/main" --ff-only
