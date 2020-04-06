.PHONY: build
# '.ONESHELL' configures Make to spawn a single shell for all commands in a
# given make recipe, which means env settings can be reused.
.ONESHELL:

build:
	# '@' suppresses command to stdout, only prints output to stdout.
	@ $(if $(AWS_PROFILE),$(call assume_role))
	packer build packer.json

# Dynamically assumes role and injects credentials into document
define assume_role
	export AWS_DEFAULT_REGION=$$(aws configure get region)
	eval $$(aws sts assume-role --role-arn=$$(aws configure get role_arn) \
		--role-session-name=$$(aws configure get role_session_name) \
		--query "Credentials.[ \
				[join('=',['export AWS_ACCESS_KEY_ID',AccessKeyId])], \
				[join('=',['export AWS_SECRET_ACCESS_KEY',SecretAccessKey])], \
				[join('=',['export AWS_SESSION_TOKEN',SessionToken])] \
			]" \
		--output text)
endef
