# default target does nothing
.DEFAULT_GOAL: default
default: ;

# add truffle and testrpc to $PATH
export PATH := ./node_modules/.bin:$(PATH)

test:
	xcodebuild test -project KinSDK/KinSDK.xcodeproj \
	-scheme KinTestHost \
	-sdk iphonesimulator \
	-destination 'platform=iOS Simulator,name=iPhone 6'

prepare-tests: truffle
	truffle/scripts/prepare-tests.sh
.PHONY: test

truffle: testrpc truffle-clean
	truffle/scripts/truffle.sh
.PHONY: truffle

truffle-clean:
	rm -f truffle/token-contract-address

testrpc: testrpc-run  # alias for testrpc-run
.PHONY: testrpc
testrpc-run: testrpc-kill
	truffle/scripts/testrpc-run.sh
.PHONY: testrpc-run

testrpc-kill:
	truffle/scripts/testrpc-kill.sh
.PHONY: testrpc-kill

clean: truffle-clean testrpc-kill
	rm -f truffle/truffle.log
	rm -f truffle/testrpc.log

get-geth:
	scripts/get_geth.sh
