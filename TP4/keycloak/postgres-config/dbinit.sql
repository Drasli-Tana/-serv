CREATE USER keycloak WITH ENCRYPTED PASSWORD 'keycloak';
CREATE DATABASE keycloak;
GRANT ALL PRIVILEGES ON DATABASE keycloak TO keycloak;

\connect "keycloak" keycloak;

-- Adminer 4.8.1 PostgreSQL 13.0 dump

CREATE TABLE "public"."admin_event_entity" (
    "id" character varying(36) NOT NULL,
    "admin_event_time" bigint,
    "realm_id" character varying(255),
    "operation_type" character varying(255),
    "auth_realm_id" character varying(255),
    "auth_client_id" character varying(255),
    "auth_user_id" character varying(255),
    "ip_address" character varying(255),
    "resource_path" character varying(2550),
    "representation" text,
    "error" character varying(255),
    "resource_type" character varying(64),
    CONSTRAINT "constraint_admin_event_entity" PRIMARY KEY ("id")
) WITH (oids = false);


CREATE TABLE "public"."associated_policy" (
    "policy_id" character varying(36) NOT NULL,
    "associated_policy_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_farsrpap" PRIMARY KEY ("policy_id", "associated_policy_id")
) WITH (oids = false);

CREATE INDEX "idx_assoc_pol_assoc_pol_id" ON "public"."associated_policy" USING btree ("associated_policy_id");

INSERT INTO "associated_policy" ("policy_id", "associated_policy_id") VALUES
('ebe9b1e1-5e56-4382-a659-62f65cdd2611',	'592c5f1c-ed21-414d-8648-eff224d3f5d2'),
('cced5405-8bfa-4b90-be5b-c9273cb9d5a6',	'f96c1955-837b-4bd0-bf4e-c2590408df2f');

CREATE TABLE "public"."authentication_execution" (
    "id" character varying(36) NOT NULL,
    "alias" character varying(255),
    "authenticator" character varying(36),
    "realm_id" character varying(36),
    "flow_id" character varying(36),
    "requirement" integer,
    "priority" integer,
    "authenticator_flow" boolean DEFAULT false NOT NULL,
    "auth_flow_id" character varying(36),
    "auth_config" character varying(36),
    CONSTRAINT "constraint_auth_exec_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_auth_exec_flow" ON "public"."authentication_execution" USING btree ("flow_id");

CREATE INDEX "idx_auth_exec_realm_flow" ON "public"."authentication_execution" USING btree ("realm_id", "flow_id");

INSERT INTO "authentication_execution" ("id", "alias", "authenticator", "realm_id", "flow_id", "requirement", "priority", "authenticator_flow", "auth_flow_id", "auth_config") VALUES
('a508a884-6ff1-42c0-b39c-147804cf7326',	NULL,	'auth-cookie',	'master',	'5f343310-cd75-4dc3-b67c-dcd75479db08',	2,	10,	'f',	NULL,	NULL),
('5b256c02-aeb8-4536-a075-0e1785208a39',	NULL,	'auth-spnego',	'master',	'5f343310-cd75-4dc3-b67c-dcd75479db08',	3,	20,	'f',	NULL,	NULL),
('91d93fe0-96c2-41c2-a9e3-61748b09d434',	NULL,	'identity-provider-redirector',	'master',	'5f343310-cd75-4dc3-b67c-dcd75479db08',	2,	25,	'f',	NULL,	NULL),
('c95f732b-b195-4030-a6c6-677cbc638013',	NULL,	NULL,	'master',	'5f343310-cd75-4dc3-b67c-dcd75479db08',	2,	30,	't',	'68e769eb-b072-4b72-92ad-6b01643655cc',	NULL),
('5990fdc0-7c43-4963-8014-4b8e1bc07ed9',	NULL,	'auth-username-password-form',	'master',	'68e769eb-b072-4b72-92ad-6b01643655cc',	0,	10,	'f',	NULL,	NULL),
('79eaba47-f75c-47c7-899c-ea0c1d56b052',	NULL,	NULL,	'master',	'68e769eb-b072-4b72-92ad-6b01643655cc',	1,	20,	't',	'5266d880-8c3c-4219-acd5-653200684a85',	NULL),
('70ec6fd5-231b-4e30-99f1-c9c5f309bc0f',	NULL,	'conditional-user-configured',	'master',	'5266d880-8c3c-4219-acd5-653200684a85',	0,	10,	'f',	NULL,	NULL),
('b234f6ad-3fe7-4bac-9520-98afec1e3bbb',	NULL,	'auth-otp-form',	'master',	'5266d880-8c3c-4219-acd5-653200684a85',	0,	20,	'f',	NULL,	NULL),
('14730eb0-4731-4ee7-b1fb-df4abd39f1e0',	NULL,	'direct-grant-validate-username',	'master',	'68da857b-5b86-4f93-a5d0-722560464526',	0,	10,	'f',	NULL,	NULL),
('b25f88b6-0095-4d8a-a840-40a8ac3021f7',	NULL,	'direct-grant-validate-password',	'master',	'68da857b-5b86-4f93-a5d0-722560464526',	0,	20,	'f',	NULL,	NULL),
('0249e466-7f02-471d-a326-dc80e925f5eb',	NULL,	NULL,	'master',	'68da857b-5b86-4f93-a5d0-722560464526',	1,	30,	't',	'5fac0fa5-0d3c-478a-be5e-dfbac35a1b72',	NULL),
('c310fdd6-5e35-4973-8470-b1efe10b6457',	NULL,	'conditional-user-configured',	'master',	'5fac0fa5-0d3c-478a-be5e-dfbac35a1b72',	0,	10,	'f',	NULL,	NULL),
('c6dd2ae2-6dab-4d3c-ba00-2713e482aa6e',	NULL,	'direct-grant-validate-otp',	'master',	'5fac0fa5-0d3c-478a-be5e-dfbac35a1b72',	0,	20,	'f',	NULL,	NULL),
('2924d05c-ca37-48bb-9e18-b2a651d3fa2c',	NULL,	'registration-page-form',	'master',	'6afcc42e-d31f-44fb-97a4-0bffe6205293',	0,	10,	't',	'1769342d-daf6-4cbc-b9ca-6125c3740f0c',	NULL),
('d040390f-d33f-4ee1-a8e7-1547401ff732',	NULL,	'registration-user-creation',	'master',	'1769342d-daf6-4cbc-b9ca-6125c3740f0c',	0,	20,	'f',	NULL,	NULL),
('5a5bab74-2e3a-452b-bd8c-096a220ba9d8',	NULL,	'registration-profile-action',	'master',	'1769342d-daf6-4cbc-b9ca-6125c3740f0c',	0,	40,	'f',	NULL,	NULL),
('8037638e-dabc-4f50-ab30-5c82f8322148',	NULL,	'registration-password-action',	'master',	'1769342d-daf6-4cbc-b9ca-6125c3740f0c',	0,	50,	'f',	NULL,	NULL),
('c527cc3e-643e-48da-9a07-0e249fe4cd4c',	NULL,	'registration-recaptcha-action',	'master',	'1769342d-daf6-4cbc-b9ca-6125c3740f0c',	3,	60,	'f',	NULL,	NULL),
('3646cbb0-155b-4dad-bbd6-f172694a94f6',	NULL,	'reset-credentials-choose-user',	'master',	'23145558-40c0-489e-8388-93ef7811eb59',	0,	10,	'f',	NULL,	NULL),
('99e9c960-efe0-48e1-9b9e-8d6c141ebfd3',	NULL,	'reset-credential-email',	'master',	'23145558-40c0-489e-8388-93ef7811eb59',	0,	20,	'f',	NULL,	NULL),
('18e44d5f-21e0-47c6-8993-c98f2e682e38',	NULL,	'reset-password',	'master',	'23145558-40c0-489e-8388-93ef7811eb59',	0,	30,	'f',	NULL,	NULL),
('fb0e2a47-574d-4d72-80b0-076b807377db',	NULL,	NULL,	'master',	'23145558-40c0-489e-8388-93ef7811eb59',	1,	40,	't',	'f94e2c74-0ef3-4e40-9f17-803a2a76b391',	NULL),
('300d043b-98b5-4894-8470-1e61902b28a1',	NULL,	'conditional-user-configured',	'master',	'f94e2c74-0ef3-4e40-9f17-803a2a76b391',	0,	10,	'f',	NULL,	NULL),
('c8f2e775-c388-45da-bb8f-65b0f57b77e2',	NULL,	'reset-otp',	'master',	'f94e2c74-0ef3-4e40-9f17-803a2a76b391',	0,	20,	'f',	NULL,	NULL),
('8099e3a0-4802-4f36-ab3c-e93e4206cd7e',	NULL,	'client-secret',	'master',	'6694495f-dd73-496d-8c42-76e6275eac69',	2,	10,	'f',	NULL,	NULL),
('0285836f-b295-48dd-828e-29731afb7750',	NULL,	'client-jwt',	'master',	'6694495f-dd73-496d-8c42-76e6275eac69',	2,	20,	'f',	NULL,	NULL),
('f9c5b43d-78cb-48a4-bbfc-65ed80c055dc',	NULL,	'client-secret-jwt',	'master',	'6694495f-dd73-496d-8c42-76e6275eac69',	2,	30,	'f',	NULL,	NULL),
('2fe56f48-ab3a-460d-a324-0d96ad1c9324',	NULL,	'client-x509',	'master',	'6694495f-dd73-496d-8c42-76e6275eac69',	2,	40,	'f',	NULL,	NULL),
('bc2721f6-5cd7-4076-919b-7a1a58001ea5',	NULL,	'idp-review-profile',	'master',	'62ea6839-575b-4cd0-ab64-77de98f36e4c',	0,	10,	'f',	NULL,	'37541037-94f9-423e-8cdb-e51213ec220c'),
('96cf7a2b-cf39-45cf-be65-b441bc842e74',	NULL,	NULL,	'master',	'62ea6839-575b-4cd0-ab64-77de98f36e4c',	0,	20,	't',	'8341f320-5ec2-46e5-93ef-f79f64cc03c0',	NULL),
('5b7010e9-47cc-43dd-a6cf-f63e765ba05c',	NULL,	'idp-create-user-if-unique',	'master',	'8341f320-5ec2-46e5-93ef-f79f64cc03c0',	2,	10,	'f',	NULL,	'8c4fa9c3-59a6-430e-b9f7-f4be2ac02e85'),
('3414bc88-8a72-4e0e-981a-49056d6b25b1',	NULL,	NULL,	'master',	'8341f320-5ec2-46e5-93ef-f79f64cc03c0',	2,	20,	't',	'9ebb3d58-190e-473a-9aa8-caf1c24683ea',	NULL),
('ad3de897-4bd7-482d-bfc6-4b78355dbae8',	NULL,	'idp-confirm-link',	'master',	'9ebb3d58-190e-473a-9aa8-caf1c24683ea',	0,	10,	'f',	NULL,	NULL),
('b267231c-cbaa-4016-992e-14281f707498',	NULL,	NULL,	'master',	'9ebb3d58-190e-473a-9aa8-caf1c24683ea',	0,	20,	't',	'40c6f12a-cf43-4316-9142-d6844f3fc20e',	NULL),
('5e5a2f93-77e0-476f-b374-0c46b3fe1a5e',	NULL,	'idp-email-verification',	'master',	'40c6f12a-cf43-4316-9142-d6844f3fc20e',	2,	10,	'f',	NULL,	NULL),
('9b0da7a2-a0f1-4714-921a-504a733b39dc',	NULL,	NULL,	'master',	'40c6f12a-cf43-4316-9142-d6844f3fc20e',	2,	20,	't',	'e00c008a-8d0c-49d1-825e-108c98b0b7f3',	NULL),
('09ed3439-afae-4e0c-8950-3d4fd7de232c',	NULL,	'idp-username-password-form',	'master',	'e00c008a-8d0c-49d1-825e-108c98b0b7f3',	0,	10,	'f',	NULL,	NULL),
('1cdfa8b9-8d9d-4ece-8141-3ea30d021e3f',	NULL,	NULL,	'master',	'e00c008a-8d0c-49d1-825e-108c98b0b7f3',	1,	20,	't',	'143c910f-b762-4754-99aa-64a3ab82227a',	NULL),
('90b7d304-56cc-4456-a84b-8ac57c594241',	NULL,	'conditional-user-configured',	'master',	'143c910f-b762-4754-99aa-64a3ab82227a',	0,	10,	'f',	NULL,	NULL),
('e63b5c78-88a9-482f-bc61-3efee195852b',	NULL,	'auth-otp-form',	'master',	'143c910f-b762-4754-99aa-64a3ab82227a',	0,	20,	'f',	NULL,	NULL),
('cab5e275-23aa-4560-b4a7-48f7672b091a',	NULL,	'http-basic-authenticator',	'master',	'83ac419e-6cb9-437e-aa00-7688798fb9fd',	0,	10,	'f',	NULL,	NULL),
('426a3dd6-c3ad-4a7a-83bf-7b6b01b9c794',	NULL,	'docker-http-basic-authenticator',	'master',	'018527cf-77fd-4855-ac41-c4298622d8ff',	0,	10,	'f',	NULL,	NULL),
('ad433fbf-cb5a-460a-bc62-5b64d01b03d5',	NULL,	'no-cookie-redirect',	'master',	'2adc6260-0b7b-4941-a853-1384c7db9056',	0,	10,	'f',	NULL,	NULL),
('d7396e2e-0334-4291-8e8a-b594d614f0a6',	NULL,	NULL,	'master',	'2adc6260-0b7b-4941-a853-1384c7db9056',	0,	20,	't',	'1b0fb046-5dfe-446c-b6af-29dce8227593',	NULL),
('2db2cabf-68d1-48bd-96fe-ea3a9f4cb3ba',	NULL,	'basic-auth',	'master',	'1b0fb046-5dfe-446c-b6af-29dce8227593',	0,	10,	'f',	NULL,	NULL),
('4d90d755-cd81-4bd0-b7fb-26c0090e35e7',	NULL,	'basic-auth-otp',	'master',	'1b0fb046-5dfe-446c-b6af-29dce8227593',	3,	20,	'f',	NULL,	NULL),
('95f369ff-a83a-401c-bffa-7e9c04136113',	NULL,	'auth-spnego',	'master',	'1b0fb046-5dfe-446c-b6af-29dce8227593',	3,	30,	'f',	NULL,	NULL),
('9e6c7beb-e314-41d8-b4c1-3037d4632f05',	NULL,	'auth-cookie',	'r4dc10',	'12766784-2989-461c-a6a4-169948f8c64d',	2,	10,	'f',	NULL,	NULL),
('d391f6d0-7814-44f5-8819-f554dc5a597e',	NULL,	'auth-spnego',	'r4dc10',	'12766784-2989-461c-a6a4-169948f8c64d',	3,	20,	'f',	NULL,	NULL),
('3884ce27-f96a-4d1e-b8b1-ca66f9b62d73',	NULL,	'identity-provider-redirector',	'r4dc10',	'12766784-2989-461c-a6a4-169948f8c64d',	2,	25,	'f',	NULL,	NULL),
('676c19d7-5cc3-4be2-b078-b9da5a941999',	NULL,	NULL,	'r4dc10',	'12766784-2989-461c-a6a4-169948f8c64d',	2,	30,	't',	'b4c54b11-dc5f-4542-b125-7ed1bf105e73',	NULL),
('3e5bdeea-279b-4cc1-be1f-2ff95a5a9b55',	NULL,	'auth-username-password-form',	'r4dc10',	'b4c54b11-dc5f-4542-b125-7ed1bf105e73',	0,	10,	'f',	NULL,	NULL),
('cabb1450-bff8-4053-945d-f472fc2f6876',	NULL,	NULL,	'r4dc10',	'b4c54b11-dc5f-4542-b125-7ed1bf105e73',	1,	20,	't',	'4a6b3026-3f55-4814-a353-c03ecce1165b',	NULL),
('ae944512-d882-4c76-b343-64af8985f394',	NULL,	'conditional-user-configured',	'r4dc10',	'4a6b3026-3f55-4814-a353-c03ecce1165b',	0,	10,	'f',	NULL,	NULL),
('66d64ef3-7b5e-4b5b-a877-88faa14689d8',	NULL,	'auth-otp-form',	'r4dc10',	'4a6b3026-3f55-4814-a353-c03ecce1165b',	0,	20,	'f',	NULL,	NULL),
('cc0d4964-9b63-4ce2-8036-32fa47875bd6',	NULL,	'direct-grant-validate-username',	'r4dc10',	'9ed6060a-2309-411e-807c-843581a49f77',	0,	10,	'f',	NULL,	NULL),
('51472c21-6fdc-4b8e-bd68-2ea902d59422',	NULL,	'direct-grant-validate-password',	'r4dc10',	'9ed6060a-2309-411e-807c-843581a49f77',	0,	20,	'f',	NULL,	NULL),
('d8d2323b-2506-4084-b121-921374b970f8',	NULL,	NULL,	'r4dc10',	'9ed6060a-2309-411e-807c-843581a49f77',	1,	30,	't',	'26e80ba8-3115-4993-b258-f4985438838a',	NULL),
('03aae15e-0e5a-4f24-b866-7486a028b2dd',	NULL,	'conditional-user-configured',	'r4dc10',	'26e80ba8-3115-4993-b258-f4985438838a',	0,	10,	'f',	NULL,	NULL),
('7bef21ef-49c8-4f7a-bef3-49cc2b6f1183',	NULL,	'direct-grant-validate-otp',	'r4dc10',	'26e80ba8-3115-4993-b258-f4985438838a',	0,	20,	'f',	NULL,	NULL),
('e0f267a2-04b7-446b-96de-f8e8c18d812c',	NULL,	'registration-page-form',	'r4dc10',	'062dc398-10cc-4b67-a97d-90121698f988',	0,	10,	't',	'e719799a-9037-43f4-8597-c110847173bd',	NULL),
('2cef3c10-94ab-4a9a-a3bd-defe63107627',	NULL,	'registration-user-creation',	'r4dc10',	'e719799a-9037-43f4-8597-c110847173bd',	0,	20,	'f',	NULL,	NULL),
('eb98a706-a83a-46b7-96fa-cd0613d7c0fd',	NULL,	'registration-profile-action',	'r4dc10',	'e719799a-9037-43f4-8597-c110847173bd',	0,	40,	'f',	NULL,	NULL),
('4c1901b1-e5df-49cf-bfc3-65a14ed7f2f3',	NULL,	'registration-password-action',	'r4dc10',	'e719799a-9037-43f4-8597-c110847173bd',	0,	50,	'f',	NULL,	NULL),
('5fbdb8f5-3821-420a-9427-9802ea24a8ea',	NULL,	'registration-recaptcha-action',	'r4dc10',	'e719799a-9037-43f4-8597-c110847173bd',	3,	60,	'f',	NULL,	NULL),
('bcdc8af6-4684-4b44-8b9c-40c4c98569ef',	NULL,	'reset-credentials-choose-user',	'r4dc10',	'9ff5aaef-2144-4a8c-9e0e-4db89fbd5993',	0,	10,	'f',	NULL,	NULL),
('9cb8af2a-4398-4995-aa03-4508c9ac5608',	NULL,	'reset-credential-email',	'r4dc10',	'9ff5aaef-2144-4a8c-9e0e-4db89fbd5993',	0,	20,	'f',	NULL,	NULL),
('f423f7d0-7958-4de2-acdc-e2ffd17ff24e',	NULL,	'reset-password',	'r4dc10',	'9ff5aaef-2144-4a8c-9e0e-4db89fbd5993',	0,	30,	'f',	NULL,	NULL),
('cb2e811a-2c8b-42f3-bfa9-f463fdf1ebf1',	NULL,	NULL,	'r4dc10',	'9ff5aaef-2144-4a8c-9e0e-4db89fbd5993',	1,	40,	't',	'173439e8-8a34-4007-b3cb-6076b2646806',	NULL),
('d1542dcc-4042-4247-aa31-9beb711b3adf',	NULL,	'conditional-user-configured',	'r4dc10',	'173439e8-8a34-4007-b3cb-6076b2646806',	0,	10,	'f',	NULL,	NULL),
('93427f1a-b8d5-49cc-af81-18f5fe496683',	NULL,	'reset-otp',	'r4dc10',	'173439e8-8a34-4007-b3cb-6076b2646806',	0,	20,	'f',	NULL,	NULL),
('107f90ea-d375-4ca3-9be5-2ca44feda1ab',	NULL,	'client-secret',	'r4dc10',	'51648ab5-78e6-4293-be54-ac042cb75b7c',	2,	10,	'f',	NULL,	NULL),
('16ae7535-7d0a-4f53-86a4-508fa6f02884',	NULL,	'client-jwt',	'r4dc10',	'51648ab5-78e6-4293-be54-ac042cb75b7c',	2,	20,	'f',	NULL,	NULL),
('ee6ced29-3db5-4c10-9da4-b354fedc237d',	NULL,	'client-secret-jwt',	'r4dc10',	'51648ab5-78e6-4293-be54-ac042cb75b7c',	2,	30,	'f',	NULL,	NULL),
('be260a22-7dd8-415e-9803-cbc4e9e1e971',	NULL,	'client-x509',	'r4dc10',	'51648ab5-78e6-4293-be54-ac042cb75b7c',	2,	40,	'f',	NULL,	NULL),
('a20cacbe-427f-4a0d-9836-91cb15bbdb43',	NULL,	'idp-review-profile',	'r4dc10',	'6b0b7338-0623-408b-b98d-37352455c646',	0,	10,	'f',	NULL,	'22cd5ed9-19c1-4218-9513-df15fd9cfce4'),
('37e30ab2-cc3c-449a-8915-f292a4fae877',	NULL,	NULL,	'r4dc10',	'6b0b7338-0623-408b-b98d-37352455c646',	0,	20,	't',	'de4081f4-0618-4d58-b8a2-d5dbd67dc703',	NULL),
('5177c92e-d0d1-4261-b296-b9795f4764ce',	NULL,	'idp-create-user-if-unique',	'r4dc10',	'de4081f4-0618-4d58-b8a2-d5dbd67dc703',	2,	10,	'f',	NULL,	'60ecfcad-1062-4c1c-9590-5d52f37c0179'),
('51c46fbd-6684-41c4-8b01-33b53abffd7e',	NULL,	NULL,	'r4dc10',	'de4081f4-0618-4d58-b8a2-d5dbd67dc703',	2,	20,	't',	'81071053-3aa3-48fb-80b8-1ff87586ca5f',	NULL),
('1347e71f-e03c-4a02-9c7a-5044a55a0d5d',	NULL,	'idp-confirm-link',	'r4dc10',	'81071053-3aa3-48fb-80b8-1ff87586ca5f',	0,	10,	'f',	NULL,	NULL),
('bf9c35ee-beec-4856-88a5-e7923da5aa8f',	NULL,	NULL,	'r4dc10',	'81071053-3aa3-48fb-80b8-1ff87586ca5f',	0,	20,	't',	'f1ec6e10-6339-4d1f-80d4-1876dbcfdb22',	NULL),
('2c99d998-ac2a-4b1f-bb1b-6a88e1a05cc5',	NULL,	'idp-email-verification',	'r4dc10',	'f1ec6e10-6339-4d1f-80d4-1876dbcfdb22',	2,	10,	'f',	NULL,	NULL),
('12a1a443-c1ef-4d68-9fb9-e30c8a53cea2',	NULL,	NULL,	'r4dc10',	'f1ec6e10-6339-4d1f-80d4-1876dbcfdb22',	2,	20,	't',	'4fbfb35a-e31a-47bb-b6b6-49bc3ee58a57',	NULL),
('14ffea61-6e27-446e-9a6e-446d30f44086',	NULL,	'idp-username-password-form',	'r4dc10',	'4fbfb35a-e31a-47bb-b6b6-49bc3ee58a57',	0,	10,	'f',	NULL,	NULL),
('1ed9730d-993a-43d0-a864-bb8b5d955b07',	NULL,	NULL,	'r4dc10',	'4fbfb35a-e31a-47bb-b6b6-49bc3ee58a57',	1,	20,	't',	'c86fccef-a3d3-420d-91a5-64a00fe3605d',	NULL),
('3142c108-0f6b-4c13-8a89-62249ca2910c',	NULL,	'conditional-user-configured',	'r4dc10',	'c86fccef-a3d3-420d-91a5-64a00fe3605d',	0,	10,	'f',	NULL,	NULL),
('8d63e92a-6a8e-494b-9f38-e62ae69a759e',	NULL,	'auth-otp-form',	'r4dc10',	'c86fccef-a3d3-420d-91a5-64a00fe3605d',	0,	20,	'f',	NULL,	NULL),
('ca100f10-cdc3-43cf-9165-06e706cb16e1',	NULL,	'http-basic-authenticator',	'r4dc10',	'557ae2c1-bab6-42fc-a8ba-8edd1b8baf1a',	0,	10,	'f',	NULL,	NULL),
('2574f13c-5e54-49c5-a9a2-b8784f24b33f',	NULL,	'docker-http-basic-authenticator',	'r4dc10',	'2dc71bac-db0d-47af-985c-7909df2ddb26',	0,	10,	'f',	NULL,	NULL),
('098216c1-ecba-45e8-a940-7886b6ed5c77',	NULL,	'no-cookie-redirect',	'r4dc10',	'23033c32-a422-4dc1-abb2-c99c92aa6f28',	0,	10,	'f',	NULL,	NULL),
('314aa67b-28ad-4acd-9b4d-cdac755862c2',	NULL,	NULL,	'r4dc10',	'23033c32-a422-4dc1-abb2-c99c92aa6f28',	0,	20,	't',	'7bb0a477-d63e-4a8b-99be-c6b1e22f98ea',	NULL),
('6fc6f0f7-dcf2-4595-bf58-1105a629aec2',	NULL,	'basic-auth',	'r4dc10',	'7bb0a477-d63e-4a8b-99be-c6b1e22f98ea',	0,	10,	'f',	NULL,	NULL),
('c12e9888-4152-471e-8e71-6d54e61945bd',	NULL,	'basic-auth-otp',	'r4dc10',	'7bb0a477-d63e-4a8b-99be-c6b1e22f98ea',	3,	20,	'f',	NULL,	NULL),
('bb7e13aa-b58b-404c-aa70-9a830b454981',	NULL,	'auth-spnego',	'r4dc10',	'7bb0a477-d63e-4a8b-99be-c6b1e22f98ea',	3,	30,	'f',	NULL,	NULL);

CREATE TABLE "public"."authentication_flow" (
    "id" character varying(36) NOT NULL,
    "alias" character varying(255),
    "description" character varying(255),
    "realm_id" character varying(36),
    "provider_id" character varying(36) DEFAULT 'basic-flow' NOT NULL,
    "top_level" boolean DEFAULT false NOT NULL,
    "built_in" boolean DEFAULT false NOT NULL,
    CONSTRAINT "constraint_auth_flow_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_auth_flow_realm" ON "public"."authentication_flow" USING btree ("realm_id");

INSERT INTO "authentication_flow" ("id", "alias", "description", "realm_id", "provider_id", "top_level", "built_in") VALUES
('5f343310-cd75-4dc3-b67c-dcd75479db08',	'browser',	'browser based authentication',	'master',	'basic-flow',	't',	't'),
('68e769eb-b072-4b72-92ad-6b01643655cc',	'forms',	'Username, password, otp and other auth forms.',	'master',	'basic-flow',	'f',	't'),
('5266d880-8c3c-4219-acd5-653200684a85',	'Browser - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'master',	'basic-flow',	'f',	't'),
('68da857b-5b86-4f93-a5d0-722560464526',	'direct grant',	'OpenID Connect Resource Owner Grant',	'master',	'basic-flow',	't',	't'),
('5fac0fa5-0d3c-478a-be5e-dfbac35a1b72',	'Direct Grant - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'master',	'basic-flow',	'f',	't'),
('6afcc42e-d31f-44fb-97a4-0bffe6205293',	'registration',	'registration flow',	'master',	'basic-flow',	't',	't'),
('1769342d-daf6-4cbc-b9ca-6125c3740f0c',	'registration form',	'registration form',	'master',	'form-flow',	'f',	't'),
('23145558-40c0-489e-8388-93ef7811eb59',	'reset credentials',	'Reset credentials for a user if they forgot their password or something',	'master',	'basic-flow',	't',	't'),
('f94e2c74-0ef3-4e40-9f17-803a2a76b391',	'Reset - Conditional OTP',	'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.',	'master',	'basic-flow',	'f',	't'),
('6694495f-dd73-496d-8c42-76e6275eac69',	'clients',	'Base authentication for clients',	'master',	'client-flow',	't',	't'),
('62ea6839-575b-4cd0-ab64-77de98f36e4c',	'first broker login',	'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account',	'master',	'basic-flow',	't',	't'),
('8341f320-5ec2-46e5-93ef-f79f64cc03c0',	'User creation or linking',	'Flow for the existing/non-existing user alternatives',	'master',	'basic-flow',	'f',	't'),
('9ebb3d58-190e-473a-9aa8-caf1c24683ea',	'Handle Existing Account',	'Handle what to do if there is existing account with same email/username like authenticated identity provider',	'master',	'basic-flow',	'f',	't'),
('40c6f12a-cf43-4316-9142-d6844f3fc20e',	'Account verification options',	'Method with which to verity the existing account',	'master',	'basic-flow',	'f',	't'),
('e00c008a-8d0c-49d1-825e-108c98b0b7f3',	'Verify Existing Account by Re-authentication',	'Reauthentication of existing account',	'master',	'basic-flow',	'f',	't'),
('143c910f-b762-4754-99aa-64a3ab82227a',	'First broker login - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'master',	'basic-flow',	'f',	't'),
('83ac419e-6cb9-437e-aa00-7688798fb9fd',	'saml ecp',	'SAML ECP Profile Authentication Flow',	'master',	'basic-flow',	't',	't'),
('018527cf-77fd-4855-ac41-c4298622d8ff',	'docker auth',	'Used by Docker clients to authenticate against the IDP',	'master',	'basic-flow',	't',	't'),
('2adc6260-0b7b-4941-a853-1384c7db9056',	'http challenge',	'An authentication flow based on challenge-response HTTP Authentication Schemes',	'master',	'basic-flow',	't',	't'),
('1b0fb046-5dfe-446c-b6af-29dce8227593',	'Authentication Options',	'Authentication options.',	'master',	'basic-flow',	'f',	't'),
('12766784-2989-461c-a6a4-169948f8c64d',	'browser',	'browser based authentication',	'r4dc10',	'basic-flow',	't',	't'),
('b4c54b11-dc5f-4542-b125-7ed1bf105e73',	'forms',	'Username, password, otp and other auth forms.',	'r4dc10',	'basic-flow',	'f',	't'),
('4a6b3026-3f55-4814-a353-c03ecce1165b',	'Browser - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'r4dc10',	'basic-flow',	'f',	't'),
('9ed6060a-2309-411e-807c-843581a49f77',	'direct grant',	'OpenID Connect Resource Owner Grant',	'r4dc10',	'basic-flow',	't',	't'),
('26e80ba8-3115-4993-b258-f4985438838a',	'Direct Grant - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'r4dc10',	'basic-flow',	'f',	't'),
('062dc398-10cc-4b67-a97d-90121698f988',	'registration',	'registration flow',	'r4dc10',	'basic-flow',	't',	't'),
('e719799a-9037-43f4-8597-c110847173bd',	'registration form',	'registration form',	'r4dc10',	'form-flow',	'f',	't'),
('9ff5aaef-2144-4a8c-9e0e-4db89fbd5993',	'reset credentials',	'Reset credentials for a user if they forgot their password or something',	'r4dc10',	'basic-flow',	't',	't'),
('173439e8-8a34-4007-b3cb-6076b2646806',	'Reset - Conditional OTP',	'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.',	'r4dc10',	'basic-flow',	'f',	't'),
('51648ab5-78e6-4293-be54-ac042cb75b7c',	'clients',	'Base authentication for clients',	'r4dc10',	'client-flow',	't',	't'),
('6b0b7338-0623-408b-b98d-37352455c646',	'first broker login',	'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account',	'r4dc10',	'basic-flow',	't',	't'),
('de4081f4-0618-4d58-b8a2-d5dbd67dc703',	'User creation or linking',	'Flow for the existing/non-existing user alternatives',	'r4dc10',	'basic-flow',	'f',	't'),
('81071053-3aa3-48fb-80b8-1ff87586ca5f',	'Handle Existing Account',	'Handle what to do if there is existing account with same email/username like authenticated identity provider',	'r4dc10',	'basic-flow',	'f',	't'),
('f1ec6e10-6339-4d1f-80d4-1876dbcfdb22',	'Account verification options',	'Method with which to verity the existing account',	'r4dc10',	'basic-flow',	'f',	't'),
('4fbfb35a-e31a-47bb-b6b6-49bc3ee58a57',	'Verify Existing Account by Re-authentication',	'Reauthentication of existing account',	'r4dc10',	'basic-flow',	'f',	't'),
('c86fccef-a3d3-420d-91a5-64a00fe3605d',	'First broker login - Conditional OTP',	'Flow to determine if the OTP is required for the authentication',	'r4dc10',	'basic-flow',	'f',	't'),
('557ae2c1-bab6-42fc-a8ba-8edd1b8baf1a',	'saml ecp',	'SAML ECP Profile Authentication Flow',	'r4dc10',	'basic-flow',	't',	't'),
('2dc71bac-db0d-47af-985c-7909df2ddb26',	'docker auth',	'Used by Docker clients to authenticate against the IDP',	'r4dc10',	'basic-flow',	't',	't'),
('23033c32-a422-4dc1-abb2-c99c92aa6f28',	'http challenge',	'An authentication flow based on challenge-response HTTP Authentication Schemes',	'r4dc10',	'basic-flow',	't',	't'),
('7bb0a477-d63e-4a8b-99be-c6b1e22f98ea',	'Authentication Options',	'Authentication options.',	'r4dc10',	'basic-flow',	'f',	't');

CREATE TABLE "public"."authenticator_config" (
    "id" character varying(36) NOT NULL,
    "alias" character varying(255),
    "realm_id" character varying(36),
    CONSTRAINT "constraint_auth_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_auth_config_realm" ON "public"."authenticator_config" USING btree ("realm_id");

INSERT INTO "authenticator_config" ("id", "alias", "realm_id") VALUES
('37541037-94f9-423e-8cdb-e51213ec220c',	'review profile config',	'master'),
('8c4fa9c3-59a6-430e-b9f7-f4be2ac02e85',	'create unique user config',	'master'),
('22cd5ed9-19c1-4218-9513-df15fd9cfce4',	'review profile config',	'r4dc10'),
('60ecfcad-1062-4c1c-9590-5d52f37c0179',	'create unique user config',	'r4dc10');

CREATE TABLE "public"."authenticator_config_entry" (
    "authenticator_id" character varying(36) NOT NULL,
    "value" text,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_auth_cfg_pk" PRIMARY KEY ("authenticator_id", "name")
) WITH (oids = false);

INSERT INTO "authenticator_config_entry" ("authenticator_id", "value", "name") VALUES
('37541037-94f9-423e-8cdb-e51213ec220c',	'missing',	'update.profile.on.first.login'),
('8c4fa9c3-59a6-430e-b9f7-f4be2ac02e85',	'false',	'require.password.update.after.registration'),
('22cd5ed9-19c1-4218-9513-df15fd9cfce4',	'missing',	'update.profile.on.first.login'),
('60ecfcad-1062-4c1c-9590-5d52f37c0179',	'false',	'require.password.update.after.registration');

CREATE TABLE "public"."broker_link" (
    "identity_provider" character varying(255) NOT NULL,
    "storage_provider_id" character varying(255),
    "realm_id" character varying(36) NOT NULL,
    "broker_user_id" character varying(255),
    "broker_username" character varying(255),
    "token" text,
    "user_id" character varying(255) NOT NULL,
    CONSTRAINT "constr_broker_link_pk" PRIMARY KEY ("identity_provider", "user_id")
) WITH (oids = false);


CREATE TABLE "public"."client" (
    "id" character varying(36) NOT NULL,
    "enabled" boolean DEFAULT false NOT NULL,
    "full_scope_allowed" boolean DEFAULT false NOT NULL,
    "client_id" character varying(255),
    "not_before" integer,
    "public_client" boolean DEFAULT false NOT NULL,
    "secret" character varying(255),
    "base_url" character varying(255),
    "bearer_only" boolean DEFAULT false NOT NULL,
    "management_url" character varying(255),
    "surrogate_auth_required" boolean DEFAULT false NOT NULL,
    "realm_id" character varying(36),
    "protocol" character varying(255),
    "node_rereg_timeout" integer DEFAULT '0',
    "frontchannel_logout" boolean DEFAULT false NOT NULL,
    "consent_required" boolean DEFAULT false NOT NULL,
    "name" character varying(255),
    "service_accounts_enabled" boolean DEFAULT false NOT NULL,
    "client_authenticator_type" character varying(255),
    "root_url" character varying(255),
    "description" character varying(255),
    "registration_token" character varying(255),
    "standard_flow_enabled" boolean DEFAULT true NOT NULL,
    "implicit_flow_enabled" boolean DEFAULT false NOT NULL,
    "direct_access_grants_enabled" boolean DEFAULT false NOT NULL,
    "always_display_in_console" boolean DEFAULT false NOT NULL,
    CONSTRAINT "constraint_7" PRIMARY KEY ("id"),
    CONSTRAINT "uk_b71cjlbenv945rb6gcon438at" UNIQUE ("realm_id", "client_id")
) WITH (oids = false);

CREATE INDEX "idx_client_id" ON "public"."client" USING btree ("client_id");

INSERT INTO "client" ("id", "enabled", "full_scope_allowed", "client_id", "not_before", "public_client", "secret", "base_url", "bearer_only", "management_url", "surrogate_auth_required", "realm_id", "protocol", "node_rereg_timeout", "frontchannel_logout", "consent_required", "name", "service_accounts_enabled", "client_authenticator_type", "root_url", "description", "registration_token", "standard_flow_enabled", "implicit_flow_enabled", "direct_access_grants_enabled", "always_display_in_console") VALUES
('c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	't',	'master-realm',	0,	'f',	'2d03f1f4-50ed-482e-94c8-213ad7e5b733',	NULL,	't',	NULL,	'f',	'master',	NULL,	0,	'f',	'f',	'master Realm',	'f',	'client-secret',	NULL,	NULL,	NULL,	't',	'f',	'f',	'f'),
('a6705522-6765-4697-851d-da311aa73ec2',	't',	'f',	'account',	0,	'f',	'd989df1e-9d36-4b05-a93e-8a7a97536309',	'/realms/master/account/',	'f',	NULL,	'f',	'master',	'openid-connect',	0,	'f',	'f',	'${client_account}',	'f',	'client-secret',	'${authBaseUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('ff236875-1e2d-4681-941f-420e7c05ff64',	't',	'f',	'account-console',	0,	't',	'8e1ab336-a68e-49cb-bbf1-87ecdf17aaea',	'/realms/master/account/',	'f',	NULL,	'f',	'master',	'openid-connect',	0,	'f',	'f',	'${client_account-console}',	'f',	'client-secret',	'${authBaseUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	't',	'f',	'broker',	0,	'f',	'6f1bbb72-f9c0-433b-9aec-24b845836beb',	NULL,	'f',	NULL,	'f',	'master',	'openid-connect',	0,	'f',	'f',	'${client_broker}',	'f',	'client-secret',	NULL,	NULL,	NULL,	't',	'f',	'f',	'f'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	't',	'f',	'security-admin-console',	0,	't',	'f437741f-dbaf-4000-9625-651c6ae5050d',	'/admin/master/console/',	'f',	NULL,	'f',	'master',	'openid-connect',	0,	'f',	'f',	'${client_security-admin-console}',	'f',	'client-secret',	'${authAdminUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('232b070c-5503-4c6b-879d-cb469f84df3e',	't',	'f',	'admin-cli',	0,	't',	'3da7b3a7-8191-4fd0-8553-a67e7a8e26c9',	NULL,	'f',	NULL,	'f',	'master',	'openid-connect',	0,	'f',	'f',	'${client_admin-cli}',	'f',	'client-secret',	NULL,	NULL,	NULL,	'f',	'f',	't',	'f'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	't',	't',	'tp4',	0,	'f',	'ae695631-6cd8-4cd8-b354-99be5f8ba28a',	NULL,	'f',	NULL,	'f',	'master',	'openid-connect',	-1,	'f',	'f',	NULL,	't',	'client-secret',	NULL,	NULL,	NULL,	't',	'f',	't',	'f'),
('057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	't',	'r4dc10-realm',	0,	'f',	'8a01eb9b-a094-4dc6-8e1b-32a2f9d0b869',	NULL,	't',	NULL,	'f',	'master',	NULL,	0,	'f',	'f',	'r4dc10 Realm',	'f',	'client-secret',	NULL,	NULL,	NULL,	't',	'f',	'f',	'f'),
('4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'f',	'realm-management',	0,	'f',	'58b3096d-c0f5-4d27-b51f-8cf11a1967bc',	NULL,	't',	NULL,	'f',	'r4dc10',	'openid-connect',	0,	'f',	'f',	'${client_realm-management}',	'f',	'client-secret',	NULL,	NULL,	NULL,	't',	'f',	'f',	'f'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	't',	'f',	'account',	0,	'f',	'8a98f56e-11bd-42aa-9e86-ec4dbcc91d5b',	'/realms/r4dc10/account/',	'f',	NULL,	'f',	'r4dc10',	'openid-connect',	0,	'f',	'f',	'${client_account}',	'f',	'client-secret',	'${authBaseUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	't',	'f',	'account-console',	0,	't',	'5d9e6825-91a4-4eb3-bafd-afd121665bd6',	'/realms/r4dc10/account/',	'f',	NULL,	'f',	'r4dc10',	'openid-connect',	0,	'f',	'f',	'${client_account-console}',	'f',	'client-secret',	'${authBaseUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('d1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	't',	'f',	'broker',	0,	'f',	'd858496a-f19a-49a6-8892-f0b4a142aab4',	NULL,	'f',	NULL,	'f',	'r4dc10',	'openid-connect',	0,	'f',	'f',	'${client_broker}',	'f',	'client-secret',	NULL,	NULL,	NULL,	't',	'f',	'f',	'f'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	't',	'f',	'security-admin-console',	0,	't',	'6d1ce0f2-8384-42a8-9b22-eb6e09170769',	'/admin/r4dc10/console/',	'f',	NULL,	'f',	'r4dc10',	'openid-connect',	0,	'f',	'f',	'${client_security-admin-console}',	'f',	'client-secret',	'${authAdminUrl}',	NULL,	NULL,	't',	'f',	'f',	'f'),
('d7bf6a28-4f32-438d-8707-1a2f0a7a4fa2',	't',	'f',	'admin-cli',	0,	't',	'79b6cb3f-3be5-4faa-ac83-0218adf6cb09',	NULL,	'f',	NULL,	'f',	'r4dc10',	'openid-connect',	0,	'f',	'f',	'${client_admin-cli}',	'f',	'client-secret',	NULL,	NULL,	NULL,	'f',	'f',	't',	'f'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	't',	't',	'tp4',	0,	'f',	'171da615-dc31-43d7-9c76-5d0f15bb2b4f',	'http://localhost:5000',	'f',	NULL,	'f',	'r4dc10',	'openid-connect',	-1,	'f',	'f',	NULL,	't',	'client-secret',	NULL,	NULL,	NULL,	't',	't',	't',	'f');

CREATE TABLE "public"."client_attributes" (
    "client_id" character varying(36) NOT NULL,
    "value" character varying(4000),
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_3c" PRIMARY KEY ("client_id", "name")
) WITH (oids = false);

INSERT INTO "client_attributes" ("client_id", "value", "name") VALUES
('ff236875-1e2d-4681-941f-420e7c05ff64',	'S256',	'pkce.code.challenge.method'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'S256',	'pkce.code.challenge.method'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'saml.server.signature'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'saml.server.signature.keyinfo.ext'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'saml.assertion.signature'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'saml.client.signature'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'saml.encrypt'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'saml.authnstatement'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'saml.onetimeuse.condition'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'saml_force_name_id_format'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'saml.multivalued.roles'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'saml.force.post.binding'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'exclude.session.state.from.auth.response'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'tls.client.certificate.bound.access.tokens'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'false',	'display.on.consent.screen'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'S256',	'pkce.code.challenge.method'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'S256',	'pkce.code.challenge.method'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'saml.server.signature'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'saml.server.signature.keyinfo.ext'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'saml.assertion.signature'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'saml.client.signature'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'saml.encrypt'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'saml.authnstatement'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'saml.onetimeuse.condition'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'saml_force_name_id_format'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'saml.multivalued.roles'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'saml.force.post.binding'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'exclude.session.state.from.auth.response'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'tls.client.certificate.bound.access.tokens'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'false',	'display.on.consent.screen'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'base',	'login_theme');

CREATE TABLE "public"."client_auth_flow_bindings" (
    "client_id" character varying(36) NOT NULL,
    "flow_id" character varying(36),
    "binding_name" character varying(255) NOT NULL,
    CONSTRAINT "c_cli_flow_bind" PRIMARY KEY ("client_id", "binding_name")
) WITH (oids = false);


CREATE TABLE "public"."client_default_roles" (
    "client_id" character varying(36) NOT NULL,
    "role_id" character varying(36) NOT NULL,
    CONSTRAINT "constr_client_default_roles" PRIMARY KEY ("client_id", "role_id"),
    CONSTRAINT "uk_8aelwnibji49avxsrtuf6xjow" UNIQUE ("role_id")
) WITH (oids = false);

CREATE INDEX "idx_client_def_roles_client" ON "public"."client_default_roles" USING btree ("client_id");

INSERT INTO "client_default_roles" ("client_id", "role_id") VALUES
('a6705522-6765-4697-851d-da311aa73ec2',	'ceba32d8-e9c6-4718-8aa2-bfb7cea43fc1'),
('a6705522-6765-4697-851d-da311aa73ec2',	'c9a1686c-5044-49a0-9ce4-b29c241b52eb'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'2ca65888-39b1-401f-8673-a2619db4ba61'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'732c0f47-d6da-4e60-8616-a8c0cff622a5');

CREATE TABLE "public"."client_initial_access" (
    "id" character varying(36) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "timestamp" integer,
    "expiration" integer,
    "count" integer,
    "remaining_count" integer,
    CONSTRAINT "cnstr_client_init_acc_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_client_init_acc_realm" ON "public"."client_initial_access" USING btree ("realm_id");


CREATE TABLE "public"."client_node_registrations" (
    "client_id" character varying(36) NOT NULL,
    "value" integer,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_84" PRIMARY KEY ("client_id", "name")
) WITH (oids = false);


CREATE TABLE "public"."client_scope" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255),
    "realm_id" character varying(36),
    "description" character varying(255),
    "protocol" character varying(255),
    CONSTRAINT "pk_cli_template" PRIMARY KEY ("id"),
    CONSTRAINT "uk_cli_scope" UNIQUE ("realm_id", "name")
) WITH (oids = false);

CREATE INDEX "idx_realm_clscope" ON "public"."client_scope" USING btree ("realm_id");

INSERT INTO "client_scope" ("id", "name", "realm_id", "description", "protocol") VALUES
('ed029660-8c73-4b0d-98fb-7e22069be540',	'offline_access',	'master',	'OpenID Connect built-in scope: offline_access',	'openid-connect'),
('b83bf671-6af1-4813-913a-9d7d3d27d604',	'role_list',	'master',	'SAML role list',	'saml'),
('b40a8d27-b455-4fb8-86c6-67443ad5be7c',	'profile',	'master',	'OpenID Connect built-in scope: profile',	'openid-connect'),
('f32dda2b-912e-4d4f-8648-be0c8e2592c3',	'email',	'master',	'OpenID Connect built-in scope: email',	'openid-connect'),
('bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'address',	'master',	'OpenID Connect built-in scope: address',	'openid-connect'),
('c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'phone',	'master',	'OpenID Connect built-in scope: phone',	'openid-connect'),
('7aab54da-f6d2-469c-b77e-24ec610f83d8',	'roles',	'master',	'OpenID Connect scope for add user roles to the access token',	'openid-connect'),
('bd609fd8-a84d-428e-b204-4f4370b8efe5',	'web-origins',	'master',	'OpenID Connect scope for add allowed web origins to the access token',	'openid-connect'),
('526196c2-5eea-43dc-8673-6f79036355e0',	'microprofile-jwt',	'master',	'Microprofile - JWT built-in scope',	'openid-connect'),
('e93bbd5a-b885-4c82-a31e-3a6defc28478',	'offline_access',	'r4dc10',	'OpenID Connect built-in scope: offline_access',	'openid-connect'),
('74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a',	'role_list',	'r4dc10',	'SAML role list',	'saml'),
('67363a99-ccfd-44b7-a497-35dbdd73f9a5',	'profile',	'r4dc10',	'OpenID Connect built-in scope: profile',	'openid-connect'),
('0648f987-e3d4-475c-8d80-aeea9b6754f8',	'email',	'r4dc10',	'OpenID Connect built-in scope: email',	'openid-connect'),
('c1bf5367-8241-4eab-80ab-9010fba9da30',	'address',	'r4dc10',	'OpenID Connect built-in scope: address',	'openid-connect'),
('9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'phone',	'r4dc10',	'OpenID Connect built-in scope: phone',	'openid-connect'),
('989793f4-44d5-4cdf-a46a-29eb821c66f3',	'roles',	'r4dc10',	'OpenID Connect scope for add user roles to the access token',	'openid-connect'),
('642eaf07-8f62-4377-9e50-907dbcfda3eb',	'web-origins',	'r4dc10',	'OpenID Connect scope for add allowed web origins to the access token',	'openid-connect'),
('f91b58f8-3fd2-4c41-9311-3babfe9628b8',	'microprofile-jwt',	'r4dc10',	'Microprofile - JWT built-in scope',	'openid-connect');

CREATE TABLE "public"."client_scope_attributes" (
    "scope_id" character varying(36) NOT NULL,
    "value" character varying(2048),
    "name" character varying(255) NOT NULL,
    CONSTRAINT "pk_cl_tmpl_attr" PRIMARY KEY ("scope_id", "name")
) WITH (oids = false);

CREATE INDEX "idx_clscope_attrs" ON "public"."client_scope_attributes" USING btree ("scope_id");

INSERT INTO "client_scope_attributes" ("scope_id", "value", "name") VALUES
('ed029660-8c73-4b0d-98fb-7e22069be540',	'true',	'display.on.consent.screen'),
('ed029660-8c73-4b0d-98fb-7e22069be540',	'${offlineAccessScopeConsentText}',	'consent.screen.text'),
('b83bf671-6af1-4813-913a-9d7d3d27d604',	'true',	'display.on.consent.screen'),
('b83bf671-6af1-4813-913a-9d7d3d27d604',	'${samlRoleListScopeConsentText}',	'consent.screen.text'),
('b40a8d27-b455-4fb8-86c6-67443ad5be7c',	'true',	'display.on.consent.screen'),
('b40a8d27-b455-4fb8-86c6-67443ad5be7c',	'${profileScopeConsentText}',	'consent.screen.text'),
('b40a8d27-b455-4fb8-86c6-67443ad5be7c',	'true',	'include.in.token.scope'),
('f32dda2b-912e-4d4f-8648-be0c8e2592c3',	'true',	'display.on.consent.screen'),
('f32dda2b-912e-4d4f-8648-be0c8e2592c3',	'${emailScopeConsentText}',	'consent.screen.text'),
('f32dda2b-912e-4d4f-8648-be0c8e2592c3',	'true',	'include.in.token.scope'),
('bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'true',	'display.on.consent.screen'),
('bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'${addressScopeConsentText}',	'consent.screen.text'),
('bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'true',	'include.in.token.scope'),
('c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'true',	'display.on.consent.screen'),
('c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'${phoneScopeConsentText}',	'consent.screen.text'),
('c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'true',	'include.in.token.scope'),
('7aab54da-f6d2-469c-b77e-24ec610f83d8',	'true',	'display.on.consent.screen'),
('7aab54da-f6d2-469c-b77e-24ec610f83d8',	'${rolesScopeConsentText}',	'consent.screen.text'),
('7aab54da-f6d2-469c-b77e-24ec610f83d8',	'false',	'include.in.token.scope'),
('bd609fd8-a84d-428e-b204-4f4370b8efe5',	'false',	'display.on.consent.screen'),
('bd609fd8-a84d-428e-b204-4f4370b8efe5',	'',	'consent.screen.text'),
('bd609fd8-a84d-428e-b204-4f4370b8efe5',	'false',	'include.in.token.scope'),
('526196c2-5eea-43dc-8673-6f79036355e0',	'false',	'display.on.consent.screen'),
('526196c2-5eea-43dc-8673-6f79036355e0',	'true',	'include.in.token.scope'),
('e93bbd5a-b885-4c82-a31e-3a6defc28478',	'true',	'display.on.consent.screen'),
('e93bbd5a-b885-4c82-a31e-3a6defc28478',	'${offlineAccessScopeConsentText}',	'consent.screen.text'),
('74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a',	'true',	'display.on.consent.screen'),
('74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a',	'${samlRoleListScopeConsentText}',	'consent.screen.text'),
('67363a99-ccfd-44b7-a497-35dbdd73f9a5',	'true',	'display.on.consent.screen'),
('67363a99-ccfd-44b7-a497-35dbdd73f9a5',	'${profileScopeConsentText}',	'consent.screen.text'),
('67363a99-ccfd-44b7-a497-35dbdd73f9a5',	'true',	'include.in.token.scope'),
('0648f987-e3d4-475c-8d80-aeea9b6754f8',	'true',	'display.on.consent.screen'),
('0648f987-e3d4-475c-8d80-aeea9b6754f8',	'${emailScopeConsentText}',	'consent.screen.text'),
('0648f987-e3d4-475c-8d80-aeea9b6754f8',	'true',	'include.in.token.scope'),
('c1bf5367-8241-4eab-80ab-9010fba9da30',	'true',	'display.on.consent.screen'),
('c1bf5367-8241-4eab-80ab-9010fba9da30',	'${addressScopeConsentText}',	'consent.screen.text'),
('c1bf5367-8241-4eab-80ab-9010fba9da30',	'true',	'include.in.token.scope'),
('9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'true',	'display.on.consent.screen'),
('9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'${phoneScopeConsentText}',	'consent.screen.text'),
('9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'true',	'include.in.token.scope'),
('989793f4-44d5-4cdf-a46a-29eb821c66f3',	'true',	'display.on.consent.screen'),
('989793f4-44d5-4cdf-a46a-29eb821c66f3',	'${rolesScopeConsentText}',	'consent.screen.text'),
('989793f4-44d5-4cdf-a46a-29eb821c66f3',	'false',	'include.in.token.scope'),
('642eaf07-8f62-4377-9e50-907dbcfda3eb',	'false',	'display.on.consent.screen'),
('642eaf07-8f62-4377-9e50-907dbcfda3eb',	'',	'consent.screen.text'),
('642eaf07-8f62-4377-9e50-907dbcfda3eb',	'false',	'include.in.token.scope'),
('f91b58f8-3fd2-4c41-9311-3babfe9628b8',	'false',	'display.on.consent.screen'),
('f91b58f8-3fd2-4c41-9311-3babfe9628b8',	'true',	'include.in.token.scope');

CREATE TABLE "public"."client_scope_client" (
    "client_id" character varying(36) NOT NULL,
    "scope_id" character varying(36) NOT NULL,
    "default_scope" boolean DEFAULT false NOT NULL,
    CONSTRAINT "c_cli_scope_bind" PRIMARY KEY ("client_id", "scope_id")
) WITH (oids = false);

CREATE INDEX "idx_cl_clscope" ON "public"."client_scope_client" USING btree ("scope_id");

CREATE INDEX "idx_clscope_cl" ON "public"."client_scope_client" USING btree ("client_id");

INSERT INTO "client_scope_client" ("client_id", "scope_id", "default_scope") VALUES
('a6705522-6765-4697-851d-da311aa73ec2',	'b83bf671-6af1-4813-913a-9d7d3d27d604',	't'),
('ff236875-1e2d-4681-941f-420e7c05ff64',	'b83bf671-6af1-4813-913a-9d7d3d27d604',	't'),
('232b070c-5503-4c6b-879d-cb469f84df3e',	'b83bf671-6af1-4813-913a-9d7d3d27d604',	't'),
('1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	'b83bf671-6af1-4813-913a-9d7d3d27d604',	't'),
('c8a970d0-c9e9-4b80-b8a1-6055b483b181',	'b83bf671-6af1-4813-913a-9d7d3d27d604',	't'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'b83bf671-6af1-4813-913a-9d7d3d27d604',	't'),
('a6705522-6765-4697-851d-da311aa73ec2',	'b40a8d27-b455-4fb8-86c6-67443ad5be7c',	't'),
('a6705522-6765-4697-851d-da311aa73ec2',	'bd609fd8-a84d-428e-b204-4f4370b8efe5',	't'),
('a6705522-6765-4697-851d-da311aa73ec2',	'7aab54da-f6d2-469c-b77e-24ec610f83d8',	't'),
('a6705522-6765-4697-851d-da311aa73ec2',	'f32dda2b-912e-4d4f-8648-be0c8e2592c3',	't'),
('ff236875-1e2d-4681-941f-420e7c05ff64',	'b40a8d27-b455-4fb8-86c6-67443ad5be7c',	't'),
('ff236875-1e2d-4681-941f-420e7c05ff64',	'bd609fd8-a84d-428e-b204-4f4370b8efe5',	't'),
('ff236875-1e2d-4681-941f-420e7c05ff64',	'7aab54da-f6d2-469c-b77e-24ec610f83d8',	't'),
('ff236875-1e2d-4681-941f-420e7c05ff64',	'f32dda2b-912e-4d4f-8648-be0c8e2592c3',	't'),
('232b070c-5503-4c6b-879d-cb469f84df3e',	'b40a8d27-b455-4fb8-86c6-67443ad5be7c',	't'),
('232b070c-5503-4c6b-879d-cb469f84df3e',	'bd609fd8-a84d-428e-b204-4f4370b8efe5',	't'),
('232b070c-5503-4c6b-879d-cb469f84df3e',	'7aab54da-f6d2-469c-b77e-24ec610f83d8',	't'),
('232b070c-5503-4c6b-879d-cb469f84df3e',	'f32dda2b-912e-4d4f-8648-be0c8e2592c3',	't'),
('1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	'b40a8d27-b455-4fb8-86c6-67443ad5be7c',	't'),
('1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	'bd609fd8-a84d-428e-b204-4f4370b8efe5',	't'),
('1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	'7aab54da-f6d2-469c-b77e-24ec610f83d8',	't'),
('1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	'f32dda2b-912e-4d4f-8648-be0c8e2592c3',	't'),
('c8a970d0-c9e9-4b80-b8a1-6055b483b181',	'b40a8d27-b455-4fb8-86c6-67443ad5be7c',	't'),
('c8a970d0-c9e9-4b80-b8a1-6055b483b181',	'bd609fd8-a84d-428e-b204-4f4370b8efe5',	't'),
('c8a970d0-c9e9-4b80-b8a1-6055b483b181',	'7aab54da-f6d2-469c-b77e-24ec610f83d8',	't'),
('c8a970d0-c9e9-4b80-b8a1-6055b483b181',	'f32dda2b-912e-4d4f-8648-be0c8e2592c3',	't'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'b40a8d27-b455-4fb8-86c6-67443ad5be7c',	't'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'bd609fd8-a84d-428e-b204-4f4370b8efe5',	't'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'7aab54da-f6d2-469c-b77e-24ec610f83d8',	't'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'f32dda2b-912e-4d4f-8648-be0c8e2592c3',	't'),
('a6705522-6765-4697-851d-da311aa73ec2',	'ed029660-8c73-4b0d-98fb-7e22069be540',	'f'),
('a6705522-6765-4697-851d-da311aa73ec2',	'526196c2-5eea-43dc-8673-6f79036355e0',	'f'),
('a6705522-6765-4697-851d-da311aa73ec2',	'bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'f'),
('a6705522-6765-4697-851d-da311aa73ec2',	'c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'f'),
('ff236875-1e2d-4681-941f-420e7c05ff64',	'ed029660-8c73-4b0d-98fb-7e22069be540',	'f'),
('ff236875-1e2d-4681-941f-420e7c05ff64',	'526196c2-5eea-43dc-8673-6f79036355e0',	'f'),
('ff236875-1e2d-4681-941f-420e7c05ff64',	'bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'f'),
('ff236875-1e2d-4681-941f-420e7c05ff64',	'c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'f'),
('232b070c-5503-4c6b-879d-cb469f84df3e',	'ed029660-8c73-4b0d-98fb-7e22069be540',	'f'),
('232b070c-5503-4c6b-879d-cb469f84df3e',	'526196c2-5eea-43dc-8673-6f79036355e0',	'f'),
('232b070c-5503-4c6b-879d-cb469f84df3e',	'bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'f'),
('232b070c-5503-4c6b-879d-cb469f84df3e',	'c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'f'),
('1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	'ed029660-8c73-4b0d-98fb-7e22069be540',	'f'),
('1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	'526196c2-5eea-43dc-8673-6f79036355e0',	'f'),
('1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	'bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'f'),
('1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	'c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'f'),
('c8a970d0-c9e9-4b80-b8a1-6055b483b181',	'ed029660-8c73-4b0d-98fb-7e22069be540',	'f'),
('c8a970d0-c9e9-4b80-b8a1-6055b483b181',	'526196c2-5eea-43dc-8673-6f79036355e0',	'f'),
('c8a970d0-c9e9-4b80-b8a1-6055b483b181',	'bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'f'),
('c8a970d0-c9e9-4b80-b8a1-6055b483b181',	'c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'f'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'ed029660-8c73-4b0d-98fb-7e22069be540',	'f'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'526196c2-5eea-43dc-8673-6f79036355e0',	'f'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'f'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'f'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'b83bf671-6af1-4813-913a-9d7d3d27d604',	't'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'b40a8d27-b455-4fb8-86c6-67443ad5be7c',	't'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'bd609fd8-a84d-428e-b204-4f4370b8efe5',	't'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'7aab54da-f6d2-469c-b77e-24ec610f83d8',	't'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'f32dda2b-912e-4d4f-8648-be0c8e2592c3',	't'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'ed029660-8c73-4b0d-98fb-7e22069be540',	'f'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'526196c2-5eea-43dc-8673-6f79036355e0',	'f'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'f'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'f'),
('057cdf02-645c-4a7d-9749-61cb4b3ff850',	'b83bf671-6af1-4813-913a-9d7d3d27d604',	't'),
('057cdf02-645c-4a7d-9749-61cb4b3ff850',	'b40a8d27-b455-4fb8-86c6-67443ad5be7c',	't'),
('057cdf02-645c-4a7d-9749-61cb4b3ff850',	'bd609fd8-a84d-428e-b204-4f4370b8efe5',	't'),
('057cdf02-645c-4a7d-9749-61cb4b3ff850',	'7aab54da-f6d2-469c-b77e-24ec610f83d8',	't'),
('057cdf02-645c-4a7d-9749-61cb4b3ff850',	'f32dda2b-912e-4d4f-8648-be0c8e2592c3',	't'),
('057cdf02-645c-4a7d-9749-61cb4b3ff850',	'ed029660-8c73-4b0d-98fb-7e22069be540',	'f'),
('057cdf02-645c-4a7d-9749-61cb4b3ff850',	'526196c2-5eea-43dc-8673-6f79036355e0',	'f'),
('057cdf02-645c-4a7d-9749-61cb4b3ff850',	'bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'f'),
('057cdf02-645c-4a7d-9749-61cb4b3ff850',	'c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'f'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a',	't'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a',	't'),
('d7bf6a28-4f32-438d-8707-1a2f0a7a4fa2',	'74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a',	't'),
('d1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	'74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a',	't'),
('4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	'74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a',	't'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a',	't'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'989793f4-44d5-4cdf-a46a-29eb821c66f3',	't'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'0648f987-e3d4-475c-8d80-aeea9b6754f8',	't'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'67363a99-ccfd-44b7-a497-35dbdd73f9a5',	't'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'642eaf07-8f62-4377-9e50-907dbcfda3eb',	't'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'989793f4-44d5-4cdf-a46a-29eb821c66f3',	't'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'0648f987-e3d4-475c-8d80-aeea9b6754f8',	't'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'67363a99-ccfd-44b7-a497-35dbdd73f9a5',	't'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'642eaf07-8f62-4377-9e50-907dbcfda3eb',	't'),
('d7bf6a28-4f32-438d-8707-1a2f0a7a4fa2',	'989793f4-44d5-4cdf-a46a-29eb821c66f3',	't'),
('d7bf6a28-4f32-438d-8707-1a2f0a7a4fa2',	'0648f987-e3d4-475c-8d80-aeea9b6754f8',	't'),
('d7bf6a28-4f32-438d-8707-1a2f0a7a4fa2',	'67363a99-ccfd-44b7-a497-35dbdd73f9a5',	't'),
('d7bf6a28-4f32-438d-8707-1a2f0a7a4fa2',	'642eaf07-8f62-4377-9e50-907dbcfda3eb',	't'),
('d1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	'989793f4-44d5-4cdf-a46a-29eb821c66f3',	't'),
('d1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	'0648f987-e3d4-475c-8d80-aeea9b6754f8',	't'),
('d1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	'67363a99-ccfd-44b7-a497-35dbdd73f9a5',	't'),
('d1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	'642eaf07-8f62-4377-9e50-907dbcfda3eb',	't'),
('4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	'989793f4-44d5-4cdf-a46a-29eb821c66f3',	't'),
('4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	'0648f987-e3d4-475c-8d80-aeea9b6754f8',	't'),
('4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	'67363a99-ccfd-44b7-a497-35dbdd73f9a5',	't'),
('4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	'642eaf07-8f62-4377-9e50-907dbcfda3eb',	't'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'989793f4-44d5-4cdf-a46a-29eb821c66f3',	't'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'0648f987-e3d4-475c-8d80-aeea9b6754f8',	't'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'67363a99-ccfd-44b7-a497-35dbdd73f9a5',	't'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'642eaf07-8f62-4377-9e50-907dbcfda3eb',	't'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'e93bbd5a-b885-4c82-a31e-3a6defc28478',	'f'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'f91b58f8-3fd2-4c41-9311-3babfe9628b8',	'f'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'c1bf5367-8241-4eab-80ab-9010fba9da30',	'f'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'f'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'e93bbd5a-b885-4c82-a31e-3a6defc28478',	'f'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'f91b58f8-3fd2-4c41-9311-3babfe9628b8',	'f'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'c1bf5367-8241-4eab-80ab-9010fba9da30',	'f'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'f'),
('d7bf6a28-4f32-438d-8707-1a2f0a7a4fa2',	'e93bbd5a-b885-4c82-a31e-3a6defc28478',	'f'),
('d7bf6a28-4f32-438d-8707-1a2f0a7a4fa2',	'f91b58f8-3fd2-4c41-9311-3babfe9628b8',	'f'),
('d7bf6a28-4f32-438d-8707-1a2f0a7a4fa2',	'c1bf5367-8241-4eab-80ab-9010fba9da30',	'f'),
('d7bf6a28-4f32-438d-8707-1a2f0a7a4fa2',	'9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'f'),
('d1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	'e93bbd5a-b885-4c82-a31e-3a6defc28478',	'f'),
('d1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	'f91b58f8-3fd2-4c41-9311-3babfe9628b8',	'f'),
('d1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	'c1bf5367-8241-4eab-80ab-9010fba9da30',	'f'),
('d1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	'9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'f'),
('4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	'e93bbd5a-b885-4c82-a31e-3a6defc28478',	'f'),
('4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	'f91b58f8-3fd2-4c41-9311-3babfe9628b8',	'f'),
('4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	'c1bf5367-8241-4eab-80ab-9010fba9da30',	'f'),
('4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	'9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'f'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'e93bbd5a-b885-4c82-a31e-3a6defc28478',	'f'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'f91b58f8-3fd2-4c41-9311-3babfe9628b8',	'f'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'c1bf5367-8241-4eab-80ab-9010fba9da30',	'f'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'f'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a',	't'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'989793f4-44d5-4cdf-a46a-29eb821c66f3',	't'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'0648f987-e3d4-475c-8d80-aeea9b6754f8',	't'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'67363a99-ccfd-44b7-a497-35dbdd73f9a5',	't'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'642eaf07-8f62-4377-9e50-907dbcfda3eb',	't'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'e93bbd5a-b885-4c82-a31e-3a6defc28478',	'f'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'f91b58f8-3fd2-4c41-9311-3babfe9628b8',	'f'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'c1bf5367-8241-4eab-80ab-9010fba9da30',	'f'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'f');

CREATE TABLE "public"."client_scope_role_mapping" (
    "scope_id" character varying(36) NOT NULL,
    "role_id" character varying(36) NOT NULL,
    CONSTRAINT "pk_template_scope" PRIMARY KEY ("scope_id", "role_id")
) WITH (oids = false);

CREATE INDEX "idx_clscope_role" ON "public"."client_scope_role_mapping" USING btree ("scope_id");

CREATE INDEX "idx_role_clscope" ON "public"."client_scope_role_mapping" USING btree ("role_id");

INSERT INTO "client_scope_role_mapping" ("scope_id", "role_id") VALUES
('ed029660-8c73-4b0d-98fb-7e22069be540',	'f45e30f7-8e89-48c2-a8d6-57e30bd1f549'),
('e93bbd5a-b885-4c82-a31e-3a6defc28478',	'16e0c766-4ac4-4ce4-8b47-89fadf51313d');

CREATE TABLE "public"."client_session" (
    "id" character varying(36) NOT NULL,
    "client_id" character varying(36),
    "redirect_uri" character varying(255),
    "state" character varying(255),
    "timestamp" integer,
    "session_id" character varying(36),
    "auth_method" character varying(255),
    "realm_id" character varying(255),
    "auth_user_id" character varying(36),
    "current_action" character varying(36),
    CONSTRAINT "constraint_8" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_client_session_session" ON "public"."client_session" USING btree ("session_id");


CREATE TABLE "public"."client_session_auth_status" (
    "authenticator" character varying(36) NOT NULL,
    "status" integer,
    "client_session" character varying(36) NOT NULL,
    CONSTRAINT "constraint_auth_status_pk" PRIMARY KEY ("client_session", "authenticator")
) WITH (oids = false);


CREATE TABLE "public"."client_session_note" (
    "name" character varying(255) NOT NULL,
    "value" character varying(255),
    "client_session" character varying(36) NOT NULL,
    CONSTRAINT "constraint_5e" PRIMARY KEY ("client_session", "name")
) WITH (oids = false);


CREATE TABLE "public"."client_session_prot_mapper" (
    "protocol_mapper_id" character varying(36) NOT NULL,
    "client_session" character varying(36) NOT NULL,
    CONSTRAINT "constraint_cs_pmp_pk" PRIMARY KEY ("client_session", "protocol_mapper_id")
) WITH (oids = false);


CREATE TABLE "public"."client_session_role" (
    "role_id" character varying(255) NOT NULL,
    "client_session" character varying(36) NOT NULL,
    CONSTRAINT "constraint_5" PRIMARY KEY ("client_session", "role_id")
) WITH (oids = false);


CREATE TABLE "public"."client_user_session_note" (
    "name" character varying(255) NOT NULL,
    "value" character varying(2048),
    "client_session" character varying(36) NOT NULL,
    CONSTRAINT "constr_cl_usr_ses_note" PRIMARY KEY ("client_session", "name")
) WITH (oids = false);


CREATE TABLE "public"."component" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255),
    "parent_id" character varying(36),
    "provider_id" character varying(36),
    "provider_type" character varying(255),
    "realm_id" character varying(36),
    "sub_type" character varying(255),
    CONSTRAINT "constr_component_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_component_provider_type" ON "public"."component" USING btree ("provider_type");

CREATE INDEX "idx_component_realm" ON "public"."component" USING btree ("realm_id");

INSERT INTO "component" ("id", "name", "parent_id", "provider_id", "provider_type", "realm_id", "sub_type") VALUES
('54ac0fbf-b02b-4a63-9055-dcf1df22b261',	'Trusted Hosts',	'master',	'trusted-hosts',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'master',	'anonymous'),
('770e25bf-2469-437c-906e-9865e8ffe62d',	'Consent Required',	'master',	'consent-required',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'master',	'anonymous'),
('6644608b-d962-44b6-b162-7b1402142d14',	'Full Scope Disabled',	'master',	'scope',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'master',	'anonymous'),
('96c16821-7707-40ae-9ce9-3a4a8bd833c2',	'Max Clients Limit',	'master',	'max-clients',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'master',	'anonymous'),
('c053afd7-37cb-452c-8331-b4676e652527',	'Allowed Protocol Mapper Types',	'master',	'allowed-protocol-mappers',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'master',	'anonymous'),
('605aa6d3-fb69-4e1e-b103-9f52cdcb4c03',	'Allowed Client Scopes',	'master',	'allowed-client-templates',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'master',	'anonymous'),
('f899c1e0-8f16-4cb0-8c39-68cb81450099',	'Allowed Protocol Mapper Types',	'master',	'allowed-protocol-mappers',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'master',	'authenticated'),
('47cc734c-e2f5-49a7-bfc1-242b50d86353',	'Allowed Client Scopes',	'master',	'allowed-client-templates',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'master',	'authenticated'),
('b5b29e23-85ca-4c54-b38c-a73fad8403fc',	'fallback-HS256',	'master',	'hmac-generated',	'org.keycloak.keys.KeyProvider',	'master',	NULL),
('632ff91f-c240-4bb6-8490-30560d4456bf',	'fallback-RS256',	'master',	'rsa-generated',	'org.keycloak.keys.KeyProvider',	'master',	NULL),
('c858af85-2ff5-4133-9967-e40e8c810257',	'rsa-generated',	'r4dc10',	'rsa-generated',	'org.keycloak.keys.KeyProvider',	'r4dc10',	NULL),
('92fa28bb-6cc6-43a7-b524-861c414cfbb2',	'hmac-generated',	'r4dc10',	'hmac-generated',	'org.keycloak.keys.KeyProvider',	'r4dc10',	NULL),
('a4c30cea-a3be-45ea-9fb3-147147e7d0eb',	'aes-generated',	'r4dc10',	'aes-generated',	'org.keycloak.keys.KeyProvider',	'r4dc10',	NULL),
('1820921c-14ea-4957-ba06-8db3f906749d',	'Trusted Hosts',	'r4dc10',	'trusted-hosts',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'r4dc10',	'anonymous'),
('ebb9a60d-0a9b-493e-b269-ccabe83bbe48',	'Consent Required',	'r4dc10',	'consent-required',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'r4dc10',	'anonymous'),
('a6407857-a515-4a51-976d-48cf9b5a1f5e',	'Full Scope Disabled',	'r4dc10',	'scope',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'r4dc10',	'anonymous'),
('c50030ee-68be-4174-8630-cf00090479dd',	'Max Clients Limit',	'r4dc10',	'max-clients',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'r4dc10',	'anonymous'),
('2289090f-4433-4baa-abf7-9c94cc447502',	'Allowed Protocol Mapper Types',	'r4dc10',	'allowed-protocol-mappers',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'r4dc10',	'anonymous'),
('0c0908de-dd75-4c86-acaf-599f6048d87c',	'Allowed Client Scopes',	'r4dc10',	'allowed-client-templates',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'r4dc10',	'anonymous'),
('d04e3e77-a102-481c-8f5b-d2a335461b63',	'Allowed Protocol Mapper Types',	'r4dc10',	'allowed-protocol-mappers',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'r4dc10',	'authenticated'),
('eb982cbb-28f2-47ef-9f49-a96f9a3b0293',	'Allowed Client Scopes',	'r4dc10',	'allowed-client-templates',	'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',	'r4dc10',	'authenticated');

CREATE TABLE "public"."component_config" (
    "id" character varying(36) NOT NULL,
    "component_id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" character varying(4000),
    CONSTRAINT "constr_component_config_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_compo_config_compo" ON "public"."component_config" USING btree ("component_id");

INSERT INTO "component_config" ("id", "component_id", "name", "value") VALUES
('26463cdf-c189-489d-a199-a2510e0c29b8',	'96c16821-7707-40ae-9ce9-3a4a8bd833c2',	'max-clients',	'200'),
('7e14490f-232c-4763-9b02-8e49c4b7f4f7',	'f899c1e0-8f16-4cb0-8c39-68cb81450099',	'allowed-protocol-mapper-types',	'saml-user-attribute-mapper'),
('fd803b57-6596-46fd-b7e7-8b5f2f31911b',	'f899c1e0-8f16-4cb0-8c39-68cb81450099',	'allowed-protocol-mapper-types',	'oidc-full-name-mapper'),
('2f34fdc5-2791-497b-9d91-96565229a699',	'f899c1e0-8f16-4cb0-8c39-68cb81450099',	'allowed-protocol-mapper-types',	'oidc-sha256-pairwise-sub-mapper'),
('3d1c65fd-7ad1-4395-aa9a-d64c206164fb',	'f899c1e0-8f16-4cb0-8c39-68cb81450099',	'allowed-protocol-mapper-types',	'saml-role-list-mapper'),
('6cdec10f-a351-4086-a9ee-3637112c22f0',	'f899c1e0-8f16-4cb0-8c39-68cb81450099',	'allowed-protocol-mapper-types',	'oidc-usermodel-property-mapper'),
('abf12194-61d4-4af2-ada5-aad94e1f50ba',	'f899c1e0-8f16-4cb0-8c39-68cb81450099',	'allowed-protocol-mapper-types',	'saml-user-property-mapper'),
('663af0da-e935-4195-b94a-d9a7bfaacf86',	'f899c1e0-8f16-4cb0-8c39-68cb81450099',	'allowed-protocol-mapper-types',	'oidc-usermodel-attribute-mapper'),
('02e51b06-ccdf-4d59-8ec2-2d0904bd8f42',	'f899c1e0-8f16-4cb0-8c39-68cb81450099',	'allowed-protocol-mapper-types',	'oidc-address-mapper'),
('8e8a7fbc-45b5-4194-9a07-7f7105d7a3fb',	'c053afd7-37cb-452c-8331-b4676e652527',	'allowed-protocol-mapper-types',	'saml-user-property-mapper'),
('d9cf219d-0e0f-4f4a-a59c-1c770eab2979',	'c053afd7-37cb-452c-8331-b4676e652527',	'allowed-protocol-mapper-types',	'saml-user-attribute-mapper'),
('1bba9797-ab01-439e-9148-8fffdb1a4725',	'c053afd7-37cb-452c-8331-b4676e652527',	'allowed-protocol-mapper-types',	'oidc-usermodel-attribute-mapper'),
('5e8ccee9-da52-4d82-b460-3b78d556aea0',	'c053afd7-37cb-452c-8331-b4676e652527',	'allowed-protocol-mapper-types',	'oidc-full-name-mapper'),
('1eaf48de-4c49-416f-9eb9-3427ed77e3d9',	'c053afd7-37cb-452c-8331-b4676e652527',	'allowed-protocol-mapper-types',	'saml-role-list-mapper'),
('217da1a3-02a7-4429-a5ba-40418d34f01b',	'c053afd7-37cb-452c-8331-b4676e652527',	'allowed-protocol-mapper-types',	'oidc-sha256-pairwise-sub-mapper'),
('cf5ff28c-51bb-4d74-ae9a-57e935406604',	'c053afd7-37cb-452c-8331-b4676e652527',	'allowed-protocol-mapper-types',	'oidc-address-mapper'),
('2458f58b-bc4a-4798-b638-96d09291e7b9',	'c053afd7-37cb-452c-8331-b4676e652527',	'allowed-protocol-mapper-types',	'oidc-usermodel-property-mapper'),
('f9f7a783-d166-4b08-be71-4fbe25f88a41',	'47cc734c-e2f5-49a7-bfc1-242b50d86353',	'allow-default-scopes',	'true'),
('4ca88205-d65a-45c8-b411-ce4ecea1e568',	'54ac0fbf-b02b-4a63-9055-dcf1df22b261',	'client-uris-must-match',	'true'),
('42c1f815-2b14-4a38-b98d-7c388fe3b820',	'54ac0fbf-b02b-4a63-9055-dcf1df22b261',	'host-sending-registration-request-must-match',	'true'),
('9e1599cb-7931-4111-b96f-a1df947b02d0',	'605aa6d3-fb69-4e1e-b103-9f52cdcb4c03',	'allow-default-scopes',	'true'),
('8881f1e4-0551-4b10-be23-afa5c433eb32',	'b5b29e23-85ca-4c54-b38c-a73fad8403fc',	'priority',	'-100'),
('a527b000-5a51-4db6-91fd-e5f7cad8812c',	'b5b29e23-85ca-4c54-b38c-a73fad8403fc',	'kid',	'3805b96c-bcf4-4948-9f8e-054f547c2449'),
('14702136-26b9-4050-b06d-bc7d7944361d',	'b5b29e23-85ca-4c54-b38c-a73fad8403fc',	'algorithm',	'HS256'),
('c72e6d58-3de2-4fbe-87c5-d005c49f5bfa',	'b5b29e23-85ca-4c54-b38c-a73fad8403fc',	'secret',	'y9gGekLiGMxdhBAcVFVUobkayxtUVB4j6ZTvfZCU5RXGOU0Xpy0PDIx5KBCziDrfbbfC726_M5eaG0ULGrUDNg'),
('c5cdf1ad-4091-46c9-967f-6e31d0640c13',	'632ff91f-c240-4bb6-8490-30560d4456bf',	'priority',	'-100'),
('56332ef9-2821-4b40-8a18-20f077b284c2',	'632ff91f-c240-4bb6-8490-30560d4456bf',	'certificate',	'MIICmzCCAYMCBgGGmUYkuzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwMjI4MTgyNDE2WhcNMzMwMjI4MTgyNTU2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDCqmA+iVmV+7ZPCca9x9HaHpmWxieHRqUPAhR1qbapZs8qN6sqzi6QIKcX25fGLZruedz5JI2UUycmcHiwudE3aicPFmBNvbUnPllen/Ws4afMnGKmHVfG5eWwr4K4PruZa1IMABN2bsIo2jABmR9gLlptdqR6QsKXqwney8Vlp8+6dkkPY1Eu24lkP71vNocMUZ12zdnN/yb/l7dq/zip4jwO5iK9simi2Jg7YLAc6dY4rMNkzUpCPqZ2VSMj5ZYoYALjJmBY1FiUATa4WGIfgDnWb5flgFybERRDr7ZqOmVWAv66TsqK9jSfbDUJR3/5r6pDy67ZN7U+fA5rMsM9AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHNJJ7YKZIj2xVBNlrZMzc6BBhA3x+irClJdmZ5TOMLCM1Dmqo4ARF5uwzH3itst9QJwYg0+LNN1Z1V99SA+IjTrAxsPNH4Dzj3y8bgo4dLTpUMBW9mj7S0xFjRwm2z+Aybodd5J/hQDR74PJpjg9RqUqhDO+D27TxVb6ocVYiJG2VUot8jgstIz1BmOTXxz4nsGlGG+md7WPLPVptIaDCTdCNZXqUplOeWDT9P7jc/RuB4e2gy5AJFbu8FocUVq+aAxUzRcSAk/fek2g/fnpE1NVuxJ/cp1lPsdGwhMByrCfqCIfbZ/49yAbY0+Q8GXn9J2bvNer+FhE+sLuOBlSZA='),
('d1d932e4-58f6-46a4-9e9a-4cf6a40cae56',	'632ff91f-c240-4bb6-8490-30560d4456bf',	'algorithm',	'RS256'),
('9a9ec746-a24d-4737-9cd6-b9c394365d39',	'632ff91f-c240-4bb6-8490-30560d4456bf',	'privateKey',	'MIIEpAIBAAKCAQEAwqpgPolZlfu2TwnGvcfR2h6ZlsYnh0alDwIUdam2qWbPKjerKs4ukCCnF9uXxi2a7nnc+SSNlFMnJnB4sLnRN2onDxZgTb21Jz5ZXp/1rOGnzJxiph1XxuXlsK+CuD67mWtSDAATdm7CKNowAZkfYC5abXakekLCl6sJ3svFZafPunZJD2NRLtuJZD+9bzaHDFGdds3Zzf8m/5e3av84qeI8DuYivbIpotiYO2CwHOnWOKzDZM1KQj6mdlUjI+WWKGAC4yZgWNRYlAE2uFhiH4A51m+X5YBcmxEUQ6+2ajplVgL+uk7KivY0n2w1CUd/+a+qQ8uu2Te1PnwOazLDPQIDAQABAoIBAH9mV+S1qU7SVMc3g70yqDGTMzuM5dPPtTi0SMWU07ncUhq0Ii66j5i99f1UNul5cVs/oBHiDVKUdRvgIeyvP7B/pZ5nK5HVZViQopaeI4AIkvQDKUDEFW1TilZvFyMT010d8q1t407wP9vSp/Zzyyf8TiwzqINna8ktJCGOxNq4q3GmfiqU+8J7A6z8wIp4ffRGI0kNtkWHF+65IyCh/MpjzkNE+QshkEHZk2whd4hnsJWwnBXGmjdkLuSFExmz0raLlFLW6VOTvOIdst/8nvIJafPiAECHLvhgRj4JFM5hAOS2YaueuB/RZAj379zTPPRsl9JULKz/V/C9SsNpKRUCgYEA6N94xeAp00/DfEcfPomh7ZjQKeQM170X5fqMBprElgJgPJinYUgVblzJtnR+NVutXv+q82V+nX+QIJjcxeykkCtTSpPTP/CenCr5K+DoHtiwGSbdoNOc5+6BypnhpicbtLDOf5prckGWKLgqHj3BfzrksOielku0IsiWS9bjoRMCgYEA1f+GSlbCgt7SHCqnvc4BFR3LtzPY0ieNU/olhI0u0KJiF3wxxy7F5pdnyfIp7o2BPf5JYi8yBojU3RYYOtgJfq8FK6IMYSts1Fz7t5rm3yAQBZSfRLNWRu1fGXJrkgFYyvsGs/uOBN856Gx6VptfvtFkzshP9uywfgeK1k0p5G8CgYBIr7gay2VCt9rkp65w7rTEXLZc3PnFPRiAiDu8tAI4cHVpdJyKGN3XnM65TJM4RG1RAaxyXHOw5WgvRIdkoACdn2hYFtwRUSGwzRkJQSIyvp/4udDjqimHm0KX4oA0RHC5bZaG7cQr3ZzpCNLcrZoABHntXi5h6y9GzCVddq2GUQKBgQCQZEV8S2YbX7Vtg+qCy0k3sk8OYlFeG4nkq9g8w/Zel/KP3iDIQOsPWAGT5W4dpCUca0OgmC+s8Q6PzqSyr6pYbEeU1VZ9Cgv4jnTZwg8dZkjpOwrsFAWW/fs49FdYwMfkzdQMBSQibWxpQyiY32WPH0JhtA8gkTvVDcnEJ3SoyQKBgQDa2NT8IBQe/mFQzeObia3GCkfuhGV6Ld8S0ujvEWzvlSk8J9z7JSxMFU3IZG4Tm1ki44TfYL7SNoBcXsYTttDH0J4sOpB3nQro/yDCN2CiQ7rSn16SrrOTL4CC0DBZj3gzoizIeoydVPhqzJv5alRMVeFW6aVOI5JT7mQeSkxKuA=='),
('05af9fb1-1f03-4600-b656-f21d6ca240dd',	'c858af85-2ff5-4133-9967-e40e8c810257',	'certificate',	'MIICmzCCAYMCBgGGnBVyyTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZyNGRjMTAwHhcNMjMwMzAxMDcyOTU2WhcNMzMwMzAxMDczMTM2WjARMQ8wDQYDVQQDDAZyNGRjMTAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCK96b4KD1zfk85QaGoA9cfWjnVBWSxtbWbVdA+h5L5XxDvKDhnicpNQU3dgbB4lN1VDYRSkoTsGPJ3x3Y8OAqsync/V3AGmO0En1rFNnrz2DKM1/++tQ3phs97LXtdhXWGT/t//kx44bRy0NJX3O9IOtBYF8/YACqUfVe+l9tbgdhpCDxUg54iRK2MX/MQOBBUqiLODJFfe+JrBQxfspCUu6GgSq68IogWhK8AkjDlKD4v8nSB4a19QGlO41DCvsYw/gVd8ZVxzvoN7E5qvXEJQ8Bibycu4e8g3c+MG1vq5FbNefNebzm18KxGJ6/bw7KY24M+kj8mZcrvgpml83LjAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABb0L+dGRfU+W4fPr88izPNHvX+kqbKBWSDX/yxr1JLzC3OFUOAg34N6MiFObRzhjgLbRadTDkMtPrZgEzpSJ252p5r4wVMNUBNsFcU3i1Qfkd1iuTzGEJsaNL7xeNoTDZsKWw8iD8kNoWPD/0nFXG6t67Q9eJUjSkV3TqvR7qCHQaTI0bO9sRvXUgaRSNQQv9dhqCVb1d04aa0NbVoGRDMGZhlb6OiAtGWYsYlY4+LOgw8tNCvxt3m0TyQFQWAAxjuRoAhh6uv3Gr+h5HH6tETsI0KfkEsIscvVyPPhBiOSFgwrNHQBtJQOs7tulwaNpxiDuXbekfuwYRt1WpHjakI='),
('391255f6-a47c-471b-b3b0-9fc25089d0f3',	'c858af85-2ff5-4133-9967-e40e8c810257',	'privateKey',	'MIIEowIBAAKCAQEAivem+Cg9c35POUGhqAPXH1o51QVksbW1m1XQPoeS+V8Q7yg4Z4nKTUFN3YGweJTdVQ2EUpKE7Bjyd8d2PDgKrMp3P1dwBpjtBJ9axTZ689gyjNf/vrUN6YbPey17XYV1hk/7f/5MeOG0ctDSV9zvSDrQWBfP2AAqlH1XvpfbW4HYaQg8VIOeIkStjF/zEDgQVKoizgyRX3viawUMX7KQlLuhoEquvCKIFoSvAJIw5Sg+L/J0geGtfUBpTuNQwr7GMP4FXfGVcc76DexOar1xCUPAYm8nLuHvIN3PjBtb6uRWzXnzXm85tfCsRiev28OymNuDPpI/JmXK74KZpfNy4wIDAQABAoIBAArKekOw1DzApSQ8DXJ/gdfkaLM67PvDsWtzeW0xl98XW7hGdkLL91KSbJpztKFYZetx1kGXMQ0oTsOwUGUSsPmD60iW4JMSku0V9rVzqo5+zkYTi79iTcdBeaEGAhtb/qlEUrI4q/WDCUEVKBA8jrQcJQuCJdiPAr9vED4ziowLZtJOkJC4PRoySMDxiDg33AuI5HW4a39o7k/wYyuYtALS5hUOuck2HemAIqB/qUA/4zt4g95gyRsZRMo6eysNLz9T+XAGCcF8sue4Dm9WUeKblElJbALwT1sIv8lURcIOjQOTMnG427bz/pzCvWHmxSENFX8MPqsi0sLgmZJnOgkCgYEAxIzDT3pVDK5cQxeuAqU6LNlwA7kyDQ+B2/fkHQH2aqTnOkGJf5utnk/Ry/Y5yuv4T7P6jLUm7tkHHQOtW/w4raoAgZTnA91G66mQbeypKddPbSLSf/43pIL5wC4rT3HHo6nAihjyKpKVQ0qSINPKxZmmqWe4LMGNgjMIlRLJrp8CgYEAtQAq0tSbozA6kNOn3rkpPOcvDf9USxMJSA2t7uoKcR2chScTveTzhgqbigUMgFZlB2rTxQttJpOavlwMlfmQse40QgmO4XzdjeSjM3mqLLAyDeKdCl9hyas3X5lLS/2/7z9H0pAgEwVj4hQDt/JiT/R7GVEnwaLLnM9sXNv2yT0CgYAdCXapPTdnYjL7LnpkpahMi+sCgc+lIk9bAepPZsTSyH3om1oG4ibqJnymF0A+fFH45Gv1caXIz4M/hBWOa1qsPVtJyYe/iGc71Zcixj3PkqGHTAexJQtvYHIpNCjt2a9WvHNXc4wDQhiPEms4MlHYk3SNvmb1JbsUKxnvfBETnQKBgElDMxI5anHoUJxUf6tgKTf0n5A73EOzBdu7Zb7Bzs4wXS1sPsprRMLpwkFgf8nmrmgNLoCgemLV9hm9Kn7+EDplH5PnSIUuxILtm713LpF+FBSYuFX9e5hkjDpO0zKEGE9fvtOU8NaiJObakRLAsliIrdb2iXAQU/g54TPI+SBFAoGBALgcHofLIadIx+gzDjBfLpREfs6NwA7VVF1M2h/YgktgQi6wyTfY4KYMgwfSIEL5ZZ4UkNF3+kKeoGjqPSK+jiXlBr1uEMRWQevbf73ExOnVKBaRR+D+zrqzY2ivWe0j4a3U8ZRJQ2kng1MWxYUIlfBcf/Sv51GQlxwOFqlTQnaQ'),
('29c71a5a-85c7-4a66-8c47-a36067285b46',	'c858af85-2ff5-4133-9967-e40e8c810257',	'priority',	'100'),
('d2c03328-cc21-4683-bbfe-d1a45a604a0f',	'92fa28bb-6cc6-43a7-b524-861c414cfbb2',	'algorithm',	'HS256'),
('8002ab30-49cf-4383-9d3b-51fea6e6c313',	'92fa28bb-6cc6-43a7-b524-861c414cfbb2',	'kid',	'd93930c0-0cc6-4709-8b08-2e8c5d1d4585'),
('2534fa0a-c98e-4bc7-8b7c-88659efce57b',	'92fa28bb-6cc6-43a7-b524-861c414cfbb2',	'priority',	'100'),
('59412d68-9205-4ee4-87d2-3ab55d24b901',	'92fa28bb-6cc6-43a7-b524-861c414cfbb2',	'secret',	'FDd8F6pS4hj5mKx60dipEuC6xEZQ4zpG72D33ep8GJJOCNU61gBhgKPT7V81MFg0TrEMnELEvnul4_1hIyy3jg'),
('a89b90e4-3ff9-489c-a25d-c5fadf5dcd0e',	'a4c30cea-a3be-45ea-9fb3-147147e7d0eb',	'priority',	'100'),
('38058085-50eb-488f-a9d7-75aca280f319',	'a4c30cea-a3be-45ea-9fb3-147147e7d0eb',	'secret',	'tbSbk2cJ9FuErpoVp2diXA'),
('2f3dff6a-d8c6-4b01-a697-3fd65fbe8558',	'a4c30cea-a3be-45ea-9fb3-147147e7d0eb',	'kid',	'ddb6460c-9f8f-4622-a14a-0a77cfb3b3c8'),
('f59476a6-9ae3-401a-bc91-27853c312b06',	'd04e3e77-a102-481c-8f5b-d2a335461b63',	'allowed-protocol-mapper-types',	'oidc-address-mapper'),
('f814b865-6296-4368-b15b-01ac3548a4bc',	'd04e3e77-a102-481c-8f5b-d2a335461b63',	'allowed-protocol-mapper-types',	'oidc-full-name-mapper'),
('a471b6ed-7682-4645-af13-ee9fe0f741da',	'd04e3e77-a102-481c-8f5b-d2a335461b63',	'allowed-protocol-mapper-types',	'oidc-sha256-pairwise-sub-mapper'),
('a9eb5c25-8932-446b-a6e3-c3123aaba2da',	'd04e3e77-a102-481c-8f5b-d2a335461b63',	'allowed-protocol-mapper-types',	'saml-user-property-mapper'),
('937a57ef-5fc5-479c-a0df-5ce737c0dd6c',	'd04e3e77-a102-481c-8f5b-d2a335461b63',	'allowed-protocol-mapper-types',	'saml-role-list-mapper'),
('fcc64871-fbcb-40a3-a995-0d600da6899b',	'd04e3e77-a102-481c-8f5b-d2a335461b63',	'allowed-protocol-mapper-types',	'oidc-usermodel-property-mapper'),
('464a03b1-5baa-4f14-8c24-3a2d2d861bfa',	'd04e3e77-a102-481c-8f5b-d2a335461b63',	'allowed-protocol-mapper-types',	'saml-user-attribute-mapper'),
('8f654b85-fe43-4b52-bfb4-40fdad85208c',	'd04e3e77-a102-481c-8f5b-d2a335461b63',	'allowed-protocol-mapper-types',	'oidc-usermodel-attribute-mapper'),
('72d37774-8f52-421c-ac55-aad11b57f189',	'0c0908de-dd75-4c86-acaf-599f6048d87c',	'allow-default-scopes',	'true'),
('f7ea5d0c-5b25-431e-a229-24dc2ac08da0',	'1820921c-14ea-4957-ba06-8db3f906749d',	'host-sending-registration-request-must-match',	'true'),
('a689e6b5-edac-40fa-a819-b80e4db35e57',	'1820921c-14ea-4957-ba06-8db3f906749d',	'client-uris-must-match',	'true'),
('2fea087c-b68d-4964-b473-f195a595508e',	'2289090f-4433-4baa-abf7-9c94cc447502',	'allowed-protocol-mapper-types',	'oidc-usermodel-property-mapper'),
('8bdddc10-4944-47b7-88a2-6c84a0bf5fa9',	'2289090f-4433-4baa-abf7-9c94cc447502',	'allowed-protocol-mapper-types',	'oidc-address-mapper'),
('203767b9-fa73-4105-ac9d-33a6c162dfc7',	'2289090f-4433-4baa-abf7-9c94cc447502',	'allowed-protocol-mapper-types',	'saml-user-attribute-mapper'),
('c7eaa431-06b5-4575-be0b-92a97e6d6732',	'2289090f-4433-4baa-abf7-9c94cc447502',	'allowed-protocol-mapper-types',	'oidc-sha256-pairwise-sub-mapper'),
('ec23785e-8c33-404a-9939-0e059f677452',	'2289090f-4433-4baa-abf7-9c94cc447502',	'allowed-protocol-mapper-types',	'oidc-full-name-mapper'),
('3790821f-b1a3-45e4-9be0-76fb93f28caf',	'2289090f-4433-4baa-abf7-9c94cc447502',	'allowed-protocol-mapper-types',	'oidc-usermodel-attribute-mapper'),
('aedcd64e-24e0-4b67-a428-63ae71184ed3',	'2289090f-4433-4baa-abf7-9c94cc447502',	'allowed-protocol-mapper-types',	'saml-role-list-mapper'),
('5f763433-fa8a-4d6c-bae1-eb2af84ac648',	'2289090f-4433-4baa-abf7-9c94cc447502',	'allowed-protocol-mapper-types',	'saml-user-property-mapper'),
('bcf3ea08-dfad-43b4-a6a6-5c1c70d8e156',	'eb982cbb-28f2-47ef-9f49-a96f9a3b0293',	'allow-default-scopes',	'true'),
('5ab3e292-b22a-460b-a268-8fb21c9ddebb',	'c50030ee-68be-4174-8630-cf00090479dd',	'max-clients',	'200');

CREATE TABLE "public"."composite_role" (
    "composite" character varying(36) NOT NULL,
    "child_role" character varying(36) NOT NULL,
    CONSTRAINT "constraint_composite_role" PRIMARY KEY ("composite", "child_role")
) WITH (oids = false);

CREATE INDEX "idx_composite" ON "public"."composite_role" USING btree ("composite");

CREATE INDEX "idx_composite_child" ON "public"."composite_role" USING btree ("child_role");

INSERT INTO "composite_role" ("composite", "child_role") VALUES
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'8da7d299-7c6a-43d7-84a5-e045cc0e154c'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'ff619129-5fde-4f20-9a4e-9b409d2d36ad'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'90bb7dad-5d82-4fe9-b3c0-4e9fbc0751a7'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'842ee560-2bf7-4956-841f-9725b2f0f4d0'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'9506aa9b-39b4-4be4-8323-90976c78d5e2'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'bd094475-9794-4e78-9f1f-4ec8eab6a2d3'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'077e7831-b01d-493d-95ae-ed8325b8aad6'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'45bf08ea-91c8-4f19-91ca-b67cd5c9212b'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'dc150116-7d7b-4919-bace-208db1871fbb'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'c000c9d0-0141-4bd4-a7e3-84658c6393f1'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'c4c3fc12-032d-4d37-b829-aa58cf8d31c5'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'cdec0e02-3357-451e-95c8-93d75373d346'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'e31773d7-c975-485d-a947-e52fe57fa354'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'8d3f4827-c1cf-4523-aa98-6e0307de48ce'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'49b7be72-8fe2-45ac-8dcf-86d041d50a2d'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'16abb812-4f78-47ce-b9f3-1db17d73528a'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'a4e02317-4c90-4512-9452-30b9d78c56fa'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'572008ae-3b45-4a99-8af8-a5da921d42e3'),
('9506aa9b-39b4-4be4-8323-90976c78d5e2',	'16abb812-4f78-47ce-b9f3-1db17d73528a'),
('842ee560-2bf7-4956-841f-9725b2f0f4d0',	'49b7be72-8fe2-45ac-8dcf-86d041d50a2d'),
('842ee560-2bf7-4956-841f-9725b2f0f4d0',	'572008ae-3b45-4a99-8af8-a5da921d42e3'),
('c9a1686c-5044-49a0-9ce4-b29c241b52eb',	'0bbd6e40-1335-42da-8fdf-3670c60d0042'),
('b5a3382a-6073-4ee3-869b-8c94bc3989c8',	'52f5726d-0209-477b-be02-fc3cab59636f'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'a75747b0-6525-4396-bf43-f2204a9b39a3'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'3795f42f-07c2-4fea-b14d-1d08f029d40c'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'aed2b43a-0b0b-4b4f-b007-ee73717625c3'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'1e4a0a06-d17d-460e-91ba-8c78c9353943'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'fda247a5-e13c-4164-a4b8-ec3a6a87a2a2'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'ceceb936-9727-4a20-a515-98beb61be7ad'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'0f2f6aaa-db64-4948-96ba-c238d654a602'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'a8bea86a-5951-45ca-a028-9657db9dee5f'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'b070f99c-59c4-4206-950c-9d5771be1671'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'7982d26a-3082-454c-b747-3a61e186f0ca'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'39dabbbe-5605-40c4-9d41-5480c02ff196'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'f8004689-078d-4753-9711-aca000b2e9cb'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'19109ade-d086-4758-a6d1-127c06209d5b'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'89ebcf21-d32c-4153-aac7-69f802330f32'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'0310e7b8-82bd-42ba-91c3-827dcc2e8f29'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'1bbe7b83-66ee-4343-b506-9d9c5265970b'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'0b8c9c91-e1ac-49b8-9e84-1e698210df55'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'f2c18110-f058-4206-b26f-ce7820873fb4'),
('fda247a5-e13c-4164-a4b8-ec3a6a87a2a2',	'1bbe7b83-66ee-4343-b506-9d9c5265970b'),
('1e4a0a06-d17d-460e-91ba-8c78c9353943',	'0310e7b8-82bd-42ba-91c3-827dcc2e8f29'),
('1e4a0a06-d17d-460e-91ba-8c78c9353943',	'f2c18110-f058-4206-b26f-ce7820873fb4'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'0860ebb9-321a-4d63-9bf2-e70b94196a75'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'930a9a2c-3288-419c-8858-4dc629249c55'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'1a602829-4629-4cc3-96a9-89721b192069'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'99b00c72-94d2-45b2-9153-6c5c122f08e8'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'2f627c2c-f304-4210-bc9a-67c16620b790'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'f80b10bf-bc59-4250-9b78-a9af2e4dd10c'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'993027d7-8c93-457d-8854-049b40d9c568'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'9e43eccf-b631-48ff-b9ce-471146f94c41'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'c87555f3-5dfb-4e2b-ab3e-20d86806ed20'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'8b161077-d5da-4f44-ad83-f529becd3b4f'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'9a325bcd-1cd0-4d54-b3e3-80d87a26dd07'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'd86475a6-53a0-4f90-9468-36b30b730519'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'6979f7f3-050e-4eac-8fd6-81a6ee706ae9'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'2991714a-2f71-4b9f-b2dc-d08ed16ee200'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'da0bdc8c-1524-436d-9e68-4c42ad434b6f'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'86b8659f-e603-4a3d-86dd-3b447083eb2c'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'75995c46-73aa-45ad-9ea8-dcecce907e9e'),
('99b00c72-94d2-45b2-9153-6c5c122f08e8',	'da0bdc8c-1524-436d-9e68-4c42ad434b6f'),
('1a602829-4629-4cc3-96a9-89721b192069',	'2991714a-2f71-4b9f-b2dc-d08ed16ee200'),
('1a602829-4629-4cc3-96a9-89721b192069',	'75995c46-73aa-45ad-9ea8-dcecce907e9e'),
('732c0f47-d6da-4e60-8616-a8c0cff622a5',	'3788bc83-87e9-4524-872d-4d2664d91177'),
('69d06b97-1a40-4a0d-9645-1a17103dea09',	'8192a055-b4b0-4ba9-b305-cdbd4ea00180'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'bb6ab464-1aad-4a10-b046-059569e0deef'),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'd58aafab-2a38-4941-89e9-dffc448f7cd2'),
('24861f9b-55b9-44a3-b890-2da05c9b5088',	'6419a6c7-e23c-4ba2-8fe2-e9536079e63e'),
('24861f9b-55b9-44a3-b890-2da05c9b5088',	'24861f9b-55b9-44a3-b890-2da05c9b5088'),
('24861f9b-55b9-44a3-b890-2da05c9b5088',	'ed1284b2-0ac6-4251-b11d-30ee7fb1c53d'),
('24861f9b-55b9-44a3-b890-2da05c9b5088',	'390a0acb-4976-4529-bdf3-bc9162f8c170');

CREATE TABLE "public"."credential" (
    "id" character varying(36) NOT NULL,
    "salt" bytea,
    "type" character varying(255),
    "user_id" character varying(36),
    "created_date" bigint,
    "user_label" character varying(255),
    "secret_data" text,
    "credential_data" text,
    "priority" integer,
    CONSTRAINT "constraint_f" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_user_credential" ON "public"."credential" USING btree ("user_id");

INSERT INTO "credential" ("id", "salt", "type", "user_id", "created_date", "user_label", "secret_data", "credential_data", "priority") VALUES
('7440c2b2-c931-4cea-982a-5febe0a0e5b7',	NULL,	'password',	'81991cd4-c1bc-46ab-947e-3110e09638f2',	1677607469977,	NULL,	'{"value":"KSY9YaLzeEh/FLMUEtXEopQQ7fgnwe1O4O5w5zB4CXa60qcG8YgytF1LUetfQYElbUEAqRpBdFMOisWk4FFgGg==","salt":"i3WRUqDgWxaz0HTeTdcUkw=="}',	'{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}',	10),
('e70b7ced-afdb-426f-85d3-53d15b6e5a43',	NULL,	'password',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c',	1677696077407,	NULL,	'{"value":"UiTOLmqIr5FpAgCWD3G+ME7s3bpttastDswtBzcOjD7OWlGFQgUIJkMuydp5iZgdwykOSLDqgOI3sTnBGJJ4nw==","salt":"7afrn9m1WtCw27hmuXcFrA=="}',	'{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}',	10),
('1dba84c2-bf61-44e4-95ca-54b985234124',	NULL,	'password',	'4464a296-2424-4ea6-92e2-f73d31c04fb7',	1677696139739,	NULL,	'{"value":"bETeaxNLweqc3LXVPZnmG44NeQlxiC6vDGUrIRqSMnpwdD+vD3aTURm7QVOAAbxPYeoCAOQfsr71mTYNhX3c6g==","salt":"g9Ib0yXGGiXRgeQKnQjKrQ=="}',	'{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}',	10);

CREATE TABLE "public"."databasechangelog" (
    "id" character varying(255) NOT NULL,
    "author" character varying(255) NOT NULL,
    "filename" character varying(255) NOT NULL,
    "dateexecuted" timestamp NOT NULL,
    "orderexecuted" integer NOT NULL,
    "exectype" character varying(10) NOT NULL,
    "md5sum" character varying(35),
    "description" character varying(255),
    "comments" character varying(255),
    "tag" character varying(255),
    "liquibase" character varying(20),
    "contexts" character varying(255),
    "labels" character varying(255),
    "deployment_id" character varying(10)
) WITH (oids = false);

INSERT INTO "databasechangelog" ("id", "author", "filename", "dateexecuted", "orderexecuted", "exectype", "md5sum", "description", "comments", "tag", "liquibase", "contexts", "labels", "deployment_id") VALUES
('1.0.0.Final-KEYCLOAK-5461',	'sthorger@redhat.com',	'META-INF/jpa-changelog-1.0.0.Final.xml',	'2023-02-28 18:04:06.877185',	1,	'EXECUTED',	'7:4e70412f24a3f382c82183742ec79317',	'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.0.0.Final-KEYCLOAK-5461',	'sthorger@redhat.com',	'META-INF/db2-jpa-changelog-1.0.0.Final.xml',	'2023-02-28 18:04:06.913013',	2,	'MARK_RAN',	'7:cb16724583e9675711801c6875114f28',	'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.1.0.Beta1',	'sthorger@redhat.com',	'META-INF/jpa-changelog-1.1.0.Beta1.xml',	'2023-02-28 18:04:07.008255',	3,	'EXECUTED',	'7:0310eb8ba07cec616460794d42ade0fa',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.1.0.Final',	'sthorger@redhat.com',	'META-INF/jpa-changelog-1.1.0.Final.xml',	'2023-02-28 18:04:07.025282',	4,	'EXECUTED',	'7:5d25857e708c3233ef4439df1f93f012',	'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.2.0.Beta1',	'psilva@redhat.com',	'META-INF/jpa-changelog-1.2.0.Beta1.xml',	'2023-02-28 18:04:07.289804',	5,	'EXECUTED',	'7:c7a54a1041d58eb3817a4a883b4d4e84',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.2.0.Beta1',	'psilva@redhat.com',	'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml',	'2023-02-28 18:04:07.297857',	6,	'MARK_RAN',	'7:2e01012df20974c1c2a605ef8afe25b7',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.2.0.RC1',	'bburke@redhat.com',	'META-INF/jpa-changelog-1.2.0.CR1.xml',	'2023-02-28 18:04:07.879864',	7,	'EXECUTED',	'7:0f08df48468428e0f30ee59a8ec01a41',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.2.0.RC1',	'bburke@redhat.com',	'META-INF/db2-jpa-changelog-1.2.0.CR1.xml',	'2023-02-28 18:04:07.913243',	8,	'MARK_RAN',	'7:a77ea2ad226b345e7d689d366f185c8c',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.2.0.Final',	'keycloak',	'META-INF/jpa-changelog-1.2.0.Final.xml',	'2023-02-28 18:04:07.973586',	9,	'EXECUTED',	'7:a3377a2059aefbf3b90ebb4c4cc8e2ab',	'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.3.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-1.3.0.xml',	'2023-02-28 18:04:08.425741',	10,	'EXECUTED',	'7:04c1dbedc2aa3e9756d1a1668e003451',	'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.4.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-1.4.0.xml',	'2023-02-28 18:04:08.7377',	11,	'EXECUTED',	'7:36ef39ed560ad07062d956db861042ba',	'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.4.0',	'bburke@redhat.com',	'META-INF/db2-jpa-changelog-1.4.0.xml',	'2023-02-28 18:04:08.744065',	12,	'MARK_RAN',	'7:d909180b2530479a716d3f9c9eaea3d7',	'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.5.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-1.5.0.xml',	'2023-02-28 18:04:08.818718',	13,	'EXECUTED',	'7:cf12b04b79bea5152f165eb41f3955f6',	'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.6.1_from15',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.6.1.xml',	'2023-02-28 18:04:08.922692',	14,	'EXECUTED',	'7:7e32c8f05c755e8675764e7d5f514509',	'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.6.1_from16-pre',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.6.1.xml',	'2023-02-28 18:04:08.929969',	15,	'MARK_RAN',	'7:980ba23cc0ec39cab731ce903dd01291',	'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.6.1_from16',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.6.1.xml',	'2023-02-28 18:04:08.940275',	16,	'MARK_RAN',	'7:2fa220758991285312eb84f3b4ff5336',	'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.6.1',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.6.1.xml',	'2023-02-28 18:04:08.952167',	17,	'EXECUTED',	'7:d41d8cd98f00b204e9800998ecf8427e',	'empty',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.7.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-1.7.0.xml',	'2023-02-28 18:04:09.167262',	18,	'EXECUTED',	'7:91ace540896df890cc00a0490ee52bbc',	'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.8.0',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.8.0.xml',	'2023-02-28 18:04:09.358942',	19,	'EXECUTED',	'7:c31d1646dfa2618a9335c00e07f89f24',	'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.8.0-2',	'keycloak',	'META-INF/jpa-changelog-1.8.0.xml',	'2023-02-28 18:04:09.424883',	20,	'EXECUTED',	'7:df8bc21027a4f7cbbb01f6344e89ce07',	'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authz-3.4.0.CR1-resource-server-pk-change-part1',	'glavoie@gmail.com',	'META-INF/jpa-changelog-authz-3.4.0.CR1.xml',	'2023-02-28 18:04:10.618789',	45,	'EXECUTED',	'7:6a48ce645a3525488a90fbf76adf3bb3',	'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.8.0',	'mposolda@redhat.com',	'META-INF/db2-jpa-changelog-1.8.0.xml',	'2023-02-28 18:04:09.4328',	21,	'MARK_RAN',	'7:f987971fe6b37d963bc95fee2b27f8df',	'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.8.0-2',	'keycloak',	'META-INF/db2-jpa-changelog-1.8.0.xml',	'2023-02-28 18:04:09.442823',	22,	'MARK_RAN',	'7:df8bc21027a4f7cbbb01f6344e89ce07',	'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.9.0',	'mposolda@redhat.com',	'META-INF/jpa-changelog-1.9.0.xml',	'2023-02-28 18:04:09.534515',	23,	'EXECUTED',	'7:ed2dc7f799d19ac452cbcda56c929e47',	'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.9.1',	'keycloak',	'META-INF/jpa-changelog-1.9.1.xml',	'2023-02-28 18:04:09.547035',	24,	'EXECUTED',	'7:80b5db88a5dda36ece5f235be8757615',	'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.9.1',	'keycloak',	'META-INF/db2-jpa-changelog-1.9.1.xml',	'2023-02-28 18:04:09.552588',	25,	'MARK_RAN',	'7:1437310ed1305a9b93f8848f301726ce',	'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('1.9.2',	'keycloak',	'META-INF/jpa-changelog-1.9.2.xml',	'2023-02-28 18:04:09.626654',	26,	'EXECUTED',	'7:b82ffb34850fa0836be16deefc6a87c4',	'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authz-2.0.0',	'psilva@redhat.com',	'META-INF/jpa-changelog-authz-2.0.0.xml',	'2023-02-28 18:04:09.807374',	27,	'EXECUTED',	'7:9cc98082921330d8d9266decdd4bd658',	'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authz-2.5.1',	'psilva@redhat.com',	'META-INF/jpa-changelog-authz-2.5.1.xml',	'2023-02-28 18:04:09.816364',	28,	'EXECUTED',	'7:03d64aeed9cb52b969bd30a7ac0db57e',	'update tableName=RESOURCE_SERVER_POLICY',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('2.1.0-KEYCLOAK-5461',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.1.0.xml',	'2023-02-28 18:04:09.940666',	29,	'EXECUTED',	'7:f1f9fd8710399d725b780f463c6b21cd',	'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('2.2.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.2.0.xml',	'2023-02-28 18:04:09.967566',	30,	'EXECUTED',	'7:53188c3eb1107546e6f765835705b6c1',	'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('2.3.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.3.0.xml',	'2023-02-28 18:04:10.003209',	31,	'EXECUTED',	'7:d6e6f3bc57a0c5586737d1351725d4d4',	'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('2.4.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.4.0.xml',	'2023-02-28 18:04:10.013407',	32,	'EXECUTED',	'7:454d604fbd755d9df3fd9c6329043aa5',	'customChange',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('2.5.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.5.0.xml',	'2023-02-28 18:04:10.024273',	33,	'EXECUTED',	'7:57e98a3077e29caf562f7dbf80c72600',	'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('2.5.0-unicode-oracle',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-2.5.0.xml',	'2023-02-28 18:04:10.028697',	34,	'MARK_RAN',	'7:e4c7e8f2256210aee71ddc42f538b57a',	'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('2.5.0-unicode-other-dbs',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-2.5.0.xml',	'2023-02-28 18:04:10.078144',	35,	'EXECUTED',	'7:09a43c97e49bc626460480aa1379b522',	'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('2.5.0-duplicate-email-support',	'slawomir@dabek.name',	'META-INF/jpa-changelog-2.5.0.xml',	'2023-02-28 18:04:10.086878',	36,	'EXECUTED',	'7:26bfc7c74fefa9126f2ce702fb775553',	'addColumn tableName=REALM',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('2.5.0-unique-group-names',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-2.5.0.xml',	'2023-02-28 18:04:10.099401',	37,	'EXECUTED',	'7:a161e2ae671a9020fff61e996a207377',	'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('2.5.1',	'bburke@redhat.com',	'META-INF/jpa-changelog-2.5.1.xml',	'2023-02-28 18:04:10.106586',	38,	'EXECUTED',	'7:37fc1781855ac5388c494f1442b3f717',	'addColumn tableName=FED_USER_CONSENT',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('3.0.0',	'bburke@redhat.com',	'META-INF/jpa-changelog-3.0.0.xml',	'2023-02-28 18:04:10.113329',	39,	'EXECUTED',	'7:13a27db0dae6049541136adad7261d27',	'addColumn tableName=IDENTITY_PROVIDER',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('3.2.0-fix',	'keycloak',	'META-INF/jpa-changelog-3.2.0.xml',	'2023-02-28 18:04:10.117216',	40,	'MARK_RAN',	'7:550300617e3b59e8af3a6294df8248a3',	'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('3.2.0-fix-with-keycloak-5416',	'keycloak',	'META-INF/jpa-changelog-3.2.0.xml',	'2023-02-28 18:04:10.120913',	41,	'MARK_RAN',	'7:e3a9482b8931481dc2772a5c07c44f17',	'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('3.2.0-fix-offline-sessions',	'hmlnarik',	'META-INF/jpa-changelog-3.2.0.xml',	'2023-02-28 18:04:10.129583',	42,	'EXECUTED',	'7:72b07d85a2677cb257edb02b408f332d',	'customChange',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('3.2.0-fixed',	'keycloak',	'META-INF/jpa-changelog-3.2.0.xml',	'2023-02-28 18:04:10.567651',	43,	'EXECUTED',	'7:a72a7858967bd414835d19e04d880312',	'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('3.3.0',	'keycloak',	'META-INF/jpa-changelog-3.3.0.xml',	'2023-02-28 18:04:10.600192',	44,	'EXECUTED',	'7:94edff7cf9ce179e7e85f0cd78a3cf2c',	'addColumn tableName=USER_ENTITY',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-authz-3.4.0.CR1.xml',	'2023-02-28 18:04:10.631753',	46,	'EXECUTED',	'7:e64b5dcea7db06077c6e57d3b9e5ca14',	'customChange',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed',	'glavoie@gmail.com',	'META-INF/jpa-changelog-authz-3.4.0.CR1.xml',	'2023-02-28 18:04:10.639402',	47,	'MARK_RAN',	'7:fd8cf02498f8b1e72496a20afc75178c',	'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex',	'glavoie@gmail.com',	'META-INF/jpa-changelog-authz-3.4.0.CR1.xml',	'2023-02-28 18:04:10.752976',	48,	'EXECUTED',	'7:542794f25aa2b1fbabb7e577d6646319',	'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authn-3.4.0.CR1-refresh-token-max-reuse',	'glavoie@gmail.com',	'META-INF/jpa-changelog-authz-3.4.0.CR1.xml',	'2023-02-28 18:04:10.797022',	49,	'EXECUTED',	'7:edad604c882df12f74941dac3cc6d650',	'addColumn tableName=REALM',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('3.4.0',	'keycloak',	'META-INF/jpa-changelog-3.4.0.xml',	'2023-02-28 18:04:11.144391',	50,	'EXECUTED',	'7:0f88b78b7b46480eb92690cbf5e44900',	'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('3.4.0-KEYCLOAK-5230',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-3.4.0.xml',	'2023-02-28 18:04:11.29482',	51,	'EXECUTED',	'7:d560e43982611d936457c327f872dd59',	'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('3.4.1',	'psilva@redhat.com',	'META-INF/jpa-changelog-3.4.1.xml',	'2023-02-28 18:04:11.304067',	52,	'EXECUTED',	'7:c155566c42b4d14ef07059ec3b3bbd8e',	'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('3.4.2',	'keycloak',	'META-INF/jpa-changelog-3.4.2.xml',	'2023-02-28 18:04:11.309719',	53,	'EXECUTED',	'7:b40376581f12d70f3c89ba8ddf5b7dea',	'update tableName=REALM',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('3.4.2-KEYCLOAK-5172',	'mkanis@redhat.com',	'META-INF/jpa-changelog-3.4.2.xml',	'2023-02-28 18:04:11.314938',	54,	'EXECUTED',	'7:a1132cc395f7b95b3646146c2e38f168',	'update tableName=CLIENT',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.0.0-KEYCLOAK-6335',	'bburke@redhat.com',	'META-INF/jpa-changelog-4.0.0.xml',	'2023-02-28 18:04:11.332124',	55,	'EXECUTED',	'7:d8dc5d89c789105cfa7ca0e82cba60af',	'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.0.0-CLEANUP-UNUSED-TABLE',	'bburke@redhat.com',	'META-INF/jpa-changelog-4.0.0.xml',	'2023-02-28 18:04:11.353586',	56,	'EXECUTED',	'7:7822e0165097182e8f653c35517656a3',	'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.0.0-KEYCLOAK-6228',	'bburke@redhat.com',	'META-INF/jpa-changelog-4.0.0.xml',	'2023-02-28 18:04:11.455814',	57,	'EXECUTED',	'7:c6538c29b9c9a08f9e9ea2de5c2b6375',	'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.0.0-KEYCLOAK-5579-fixed',	'mposolda@redhat.com',	'META-INF/jpa-changelog-4.0.0.xml',	'2023-02-28 18:04:11.890571',	58,	'EXECUTED',	'7:6d4893e36de22369cf73bcb051ded875',	'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authz-4.0.0.CR1',	'psilva@redhat.com',	'META-INF/jpa-changelog-authz-4.0.0.CR1.xml',	'2023-02-28 18:04:12.004932',	59,	'EXECUTED',	'7:57960fc0b0f0dd0563ea6f8b2e4a1707',	'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authz-4.0.0.Beta3',	'psilva@redhat.com',	'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml',	'2023-02-28 18:04:12.018002',	60,	'EXECUTED',	'7:2b4b8bff39944c7097977cc18dbceb3b',	'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authz-4.2.0.Final',	'mhajas@redhat.com',	'META-INF/jpa-changelog-authz-4.2.0.Final.xml',	'2023-02-28 18:04:12.037412',	61,	'EXECUTED',	'7:2aa42a964c59cd5b8ca9822340ba33a8',	'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authz-4.2.0.Final-KEYCLOAK-9944',	'hmlnarik@redhat.com',	'META-INF/jpa-changelog-authz-4.2.0.Final.xml',	'2023-02-28 18:04:12.056293',	62,	'EXECUTED',	'7:9ac9e58545479929ba23f4a3087a0346',	'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.2.0-KEYCLOAK-6313',	'wadahiro@gmail.com',	'META-INF/jpa-changelog-4.2.0.xml',	'2023-02-28 18:04:12.068361',	63,	'EXECUTED',	'7:14d407c35bc4fe1976867756bcea0c36',	'addColumn tableName=REQUIRED_ACTION_PROVIDER',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.3.0-KEYCLOAK-7984',	'wadahiro@gmail.com',	'META-INF/jpa-changelog-4.3.0.xml',	'2023-02-28 18:04:12.074011',	64,	'EXECUTED',	'7:241a8030c748c8548e346adee548fa93',	'update tableName=REQUIRED_ACTION_PROVIDER',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.6.0-KEYCLOAK-7950',	'psilva@redhat.com',	'META-INF/jpa-changelog-4.6.0.xml',	'2023-02-28 18:04:12.079447',	65,	'EXECUTED',	'7:7d3182f65a34fcc61e8d23def037dc3f',	'update tableName=RESOURCE_SERVER_RESOURCE',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.6.0-KEYCLOAK-8377',	'keycloak',	'META-INF/jpa-changelog-4.6.0.xml',	'2023-02-28 18:04:12.119301',	66,	'EXECUTED',	'7:b30039e00a0b9715d430d1b0636728fa',	'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.6.0-KEYCLOAK-8555',	'gideonray@gmail.com',	'META-INF/jpa-changelog-4.6.0.xml',	'2023-02-28 18:04:12.140817',	67,	'EXECUTED',	'7:3797315ca61d531780f8e6f82f258159',	'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.7.0-KEYCLOAK-1267',	'sguilhen@redhat.com',	'META-INF/jpa-changelog-4.7.0.xml',	'2023-02-28 18:04:12.151862',	68,	'EXECUTED',	'7:c7aa4c8d9573500c2d347c1941ff0301',	'addColumn tableName=REALM',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.7.0-KEYCLOAK-7275',	'keycloak',	'META-INF/jpa-changelog-4.7.0.xml',	'2023-02-28 18:04:12.187741',	69,	'EXECUTED',	'7:b207faee394fc074a442ecd42185a5dd',	'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('4.8.0-KEYCLOAK-8835',	'sguilhen@redhat.com',	'META-INF/jpa-changelog-4.8.0.xml',	'2023-02-28 18:04:12.205023',	70,	'EXECUTED',	'7:ab9a9762faaba4ddfa35514b212c4922',	'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('authz-7.0.0-KEYCLOAK-10443',	'psilva@redhat.com',	'META-INF/jpa-changelog-authz-7.0.0.xml',	'2023-02-28 18:04:12.214074',	71,	'EXECUTED',	'7:b9710f74515a6ccb51b72dc0d19df8c4',	'addColumn tableName=RESOURCE_SERVER',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('8.0.0-adding-credential-columns',	'keycloak',	'META-INF/jpa-changelog-8.0.0.xml',	'2023-02-28 18:04:12.243961',	72,	'EXECUTED',	'7:ec9707ae4d4f0b7452fee20128083879',	'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('8.0.0-updating-credential-data-not-oracle',	'keycloak',	'META-INF/jpa-changelog-8.0.0.xml',	'2023-02-28 18:04:12.261405',	73,	'EXECUTED',	'7:03b3f4b264c3c68ba082250a80b74216',	'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('8.0.0-updating-credential-data-oracle',	'keycloak',	'META-INF/jpa-changelog-8.0.0.xml',	'2023-02-28 18:04:12.266129',	74,	'MARK_RAN',	'7:64c5728f5ca1f5aa4392217701c4fe23',	'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('8.0.0-credential-cleanup-fixed',	'keycloak',	'META-INF/jpa-changelog-8.0.0.xml',	'2023-02-28 18:04:12.311757',	75,	'EXECUTED',	'7:b48da8c11a3d83ddd6b7d0c8c2219345',	'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('8.0.0-resource-tag-support',	'keycloak',	'META-INF/jpa-changelog-8.0.0.xml',	'2023-02-28 18:04:12.370277',	76,	'EXECUTED',	'7:a73379915c23bfad3e8f5c6d5c0aa4bd',	'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('9.0.0-always-display-client',	'keycloak',	'META-INF/jpa-changelog-9.0.0.xml',	'2023-02-28 18:04:12.384314',	77,	'EXECUTED',	'7:39e0073779aba192646291aa2332493d',	'addColumn tableName=CLIENT',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('9.0.0-drop-constraints-for-column-increase',	'keycloak',	'META-INF/jpa-changelog-9.0.0.xml',	'2023-02-28 18:04:12.388361',	78,	'MARK_RAN',	'7:81f87368f00450799b4bf42ea0b3ec34',	'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('9.0.0-increase-column-size-federated-fk',	'keycloak',	'META-INF/jpa-changelog-9.0.0.xml',	'2023-02-28 18:04:12.516823',	79,	'EXECUTED',	'7:20b37422abb9fb6571c618148f013a15',	'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('9.0.0-recreate-constraints-after-column-increase',	'keycloak',	'META-INF/jpa-changelog-9.0.0.xml',	'2023-02-28 18:04:12.538462',	80,	'MARK_RAN',	'7:1970bb6cfb5ee800736b95ad3fb3c78a',	'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('9.0.1-add-index-to-client.client_id',	'keycloak',	'META-INF/jpa-changelog-9.0.1.xml',	'2023-02-28 18:04:12.645283',	81,	'EXECUTED',	'7:45d9b25fc3b455d522d8dcc10a0f4c80',	'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('9.0.1-KEYCLOAK-12579-drop-constraints',	'keycloak',	'META-INF/jpa-changelog-9.0.1.xml',	'2023-02-28 18:04:12.66631',	82,	'MARK_RAN',	'7:890ae73712bc187a66c2813a724d037f',	'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('9.0.1-KEYCLOAK-12579-add-not-null-constraint',	'keycloak',	'META-INF/jpa-changelog-9.0.1.xml',	'2023-02-28 18:04:12.701678',	83,	'EXECUTED',	'7:0a211980d27fafe3ff50d19a3a29b538',	'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('9.0.1-KEYCLOAK-12579-recreate-constraints',	'keycloak',	'META-INF/jpa-changelog-9.0.1.xml',	'2023-02-28 18:04:12.740007',	84,	'MARK_RAN',	'7:a161e2ae671a9020fff61e996a207377',	'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('9.0.1-add-index-to-events',	'keycloak',	'META-INF/jpa-changelog-9.0.1.xml',	'2023-02-28 18:04:12.844831',	85,	'EXECUTED',	'7:01c49302201bdf815b0a18d1f98a55dc',	'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007'),
('map-remove-ri',	'keycloak',	'META-INF/jpa-changelog-11.0.0.xml',	'2023-02-28 18:04:12.855892',	86,	'EXECUTED',	'7:3dace6b144c11f53f1ad2c0361279b86',	'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9',	'',	NULL,	'3.5.4',	NULL,	NULL,	'7607445007');

CREATE TABLE "public"."databasechangeloglock" (
    "id" integer NOT NULL,
    "locked" boolean NOT NULL,
    "lockgranted" timestamp,
    "lockedby" character varying(255),
    CONSTRAINT "pk_databasechangeloglock" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "databasechangeloglock" ("id", "locked", "lockgranted", "lockedby") VALUES
(1,	'f',	NULL,	NULL),
(1000,	'f',	NULL,	NULL),
(1001,	'f',	NULL,	NULL);

CREATE TABLE "public"."default_client_scope" (
    "realm_id" character varying(36) NOT NULL,
    "scope_id" character varying(36) NOT NULL,
    "default_scope" boolean DEFAULT false NOT NULL,
    CONSTRAINT "r_def_cli_scope_bind" PRIMARY KEY ("realm_id", "scope_id")
) WITH (oids = false);

CREATE INDEX "idx_defcls_realm" ON "public"."default_client_scope" USING btree ("realm_id");

CREATE INDEX "idx_defcls_scope" ON "public"."default_client_scope" USING btree ("scope_id");

INSERT INTO "default_client_scope" ("realm_id", "scope_id", "default_scope") VALUES
('master',	'ed029660-8c73-4b0d-98fb-7e22069be540',	'f'),
('master',	'b83bf671-6af1-4813-913a-9d7d3d27d604',	't'),
('master',	'b40a8d27-b455-4fb8-86c6-67443ad5be7c',	't'),
('master',	'f32dda2b-912e-4d4f-8648-be0c8e2592c3',	't'),
('master',	'bd23fa9b-9bc9-4532-95d6-aad2011fa008',	'f'),
('master',	'c5993dc6-d05a-40ee-add4-aa0abc5da38f',	'f'),
('master',	'7aab54da-f6d2-469c-b77e-24ec610f83d8',	't'),
('master',	'bd609fd8-a84d-428e-b204-4f4370b8efe5',	't'),
('master',	'526196c2-5eea-43dc-8673-6f79036355e0',	'f'),
('r4dc10',	'e93bbd5a-b885-4c82-a31e-3a6defc28478',	'f'),
('r4dc10',	'74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a',	't'),
('r4dc10',	'67363a99-ccfd-44b7-a497-35dbdd73f9a5',	't'),
('r4dc10',	'0648f987-e3d4-475c-8d80-aeea9b6754f8',	't'),
('r4dc10',	'c1bf5367-8241-4eab-80ab-9010fba9da30',	'f'),
('r4dc10',	'9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a',	'f'),
('r4dc10',	'989793f4-44d5-4cdf-a46a-29eb821c66f3',	't'),
('r4dc10',	'642eaf07-8f62-4377-9e50-907dbcfda3eb',	't'),
('r4dc10',	'f91b58f8-3fd2-4c41-9311-3babfe9628b8',	'f');

CREATE TABLE "public"."event_entity" (
    "id" character varying(36) NOT NULL,
    "client_id" character varying(255),
    "details_json" character varying(2550),
    "error" character varying(255),
    "ip_address" character varying(255),
    "realm_id" character varying(255),
    "session_id" character varying(255),
    "event_time" bigint,
    "type" character varying(255),
    "user_id" character varying(255),
    CONSTRAINT "constraint_4" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_event_time" ON "public"."event_entity" USING btree ("realm_id", "event_time");

INSERT INTO "event_entity" ("id", "client_id", "details_json", "error", "ip_address", "realm_id", "session_id", "event_time", "type", "user_id") VALUES
('385c9cdb-8dc7-418c-ac20-92e7394210a3',	'tp4',	'{"auth_method":"openid-connect","token_id":"ea8fd4e3-4132-410b-8136-7b271a297185","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"8a668d90-8e65-43c1-89d9-630f65240062","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'1b87a9d3-6d3b-4b9f-804d-9fe373a18ab0',	1677743059782,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('143a6ebf-ef96-436d-acea-7213d866c5c4',	NULL,	'null',	'invalid_request',	'172.20.0.1',	'r4dc10',	NULL,	1677826323473,	'LOGIN_ERROR',	NULL),
('a257647b-740f-49c9-8e3b-36709767e538',	'tp4',	'{"token_id":"43b9759a-66fa-435f-b030-156f7d94599c","grant_type":"client_credentials","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"2014101d-4ad1-44cb-b98d-5b845795a7c9","client_auth_method":"client-secret","username":"service-account-tp4"}',	NULL,	'172.20.0.1',	'r4dc10',	'55f73102-a6c6-44c3-b925-88052b397d81',	1677826706509,	'CLIENT_LOGIN',	'a6f35c53-8f7d-47da-a1f0-2a3f6e8bcabe'),
('3572f811-814b-4c66-a5cd-d01b3a7155d9',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/auth"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677828873373,	'LOGIN_ERROR',	NULL),
('13e6e4c2-9390-4f8c-8a1d-08add38da1ac',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/auth"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677828890460,	'LOGIN_ERROR',	NULL),
('7124d0d1-2984-4d74-9147-b608b95eb201',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/auth"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677828953074,	'LOGIN_ERROR',	NULL),
('b043d72e-2450-4b38-8e19-f104fa05bc02',	'tp4',	'{"grant_type":"client_credentials"}',	'invalid_client_credentials',	'172.20.0.1',	'r4dc10',	NULL,	1677829463626,	'CLIENT_LOGIN_ERROR',	NULL),
('b87a8592-6f11-4148-9712-ad9be0b10a13',	'tp4',	'{"auth_method":"openid-connect","token_id":"0fc4123c-6162-431a-844e-03aff58e3711","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"84b9b026-3dff-40a2-a29b-fbc458075ece","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'a258e107-637f-46a3-8f55-52c607ebfbd9',	1677829620375,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('eb2f6692-5406-442f-9dcb-eabd3da2ff8b',	'tp4',	'{"auth_method":"openid-connect","token_id":"74cf3f58-932a-4050-8486-2fc64e248804","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"0141010b-19dd-4ae0-9f7d-e4aa3856f11d","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'60f6a318-7da6-4a50-b182-340491441696',	1677829632539,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('e1fca63e-8f50-48bf-9475-8749f9949db7',	'tp4',	'{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"sam"}',	'invalid_user_credentials',	'172.20.0.1',	'r4dc10',	NULL,	1677829648951,	'LOGIN_ERROR',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('91c0e4bf-e692-4878-983e-e4cbcdd52207',	'tp4',	'{"auth_method":"openid-connect","token_id":"47482831-4a8c-4bdf-b1bb-1dae656c8562","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"675a1477-6e81-4fdf-a5ec-a232b9a9a5e9","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'b86ef151-c22e-473c-9798-b6e868f80580',	1677830903967,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('520a6c49-7303-49ec-9391-50bf42e4b6ec',	'tp4',	'{"auth_method":"openid-connect","token_id":"6e95c1b9-c296-4ddd-85dc-751026575fb4","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"4f6ca51e-434a-498a-a1db-8e199d5be3ec","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'ede9f130-beca-4d6e-b81f-96e838cf9f14',	1677830940111,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('1788d4df-1139-409e-9bfa-12d57a054df0',	'tp4',	'{"auth_method":"openid-connect","token_id":"cef01990-1e9e-4299-ba7a-9f7f54666634","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"b32880e2-8824-4039-888a-6f73faba8641","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'd8a83b44-b369-43ed-afc1-39323aaeb0de',	1677831033767,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('6bf4c9a6-ce45-4a0a-947d-a6e0f3a4fea4',	'tp4',	'{"auth_method":"openid-connect","token_id":"3130a8a0-f4ba-42ba-b89a-e7aa75fded53","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"de0b7425-6f0f-4835-9102-0491c9a5b1ab","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'5103fc03-657f-4b7c-bcc1-44dd39c63cff',	1677831127067,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('1b5860ef-5293-47d0-9599-894d9637d834',	'tp4',	'{"auth_method":"openid-connect","token_id":"ecbe51b7-679a-4993-9f2d-1a93bfca74b3","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"2cb41aed-2941-48c8-adf9-0300707aee5e","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'ce88dec9-62b1-4a53-a0a8-57c69d3bff4e',	1677831188199,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('a924eb84-a366-4dd7-9181-fd8ed0cec78a',	'tp4',	'{"auth_method":"openid-connect","token_id":"ad6097c1-100b-4c70-86a9-1cddb95c024d","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"cb9a334e-fef6-49fd-8306-c193a0527615","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'48ca7498-4228-42b3-9a33-afe747b3293e',	1677832145769,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('5ab99b1a-1ee3-44ea-a787-c40d0f565322',	'tp4',	'{"auth_method":"openid-connect","token_id":"5fde3e0c-d1de-4652-995c-038c1a3450c9","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"ebd4a210-d52a-4755-8aa6-139684e1218f","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'a013afc0-5479-4b27-bfb0-00fc9dda15ee',	1677835275705,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('d86dc287-3c46-489e-90f1-a5b097a5bc2c',	'tp4',	'{"auth_method":"openid-connect","token_id":"8ed15797-2cc0-4da2-b25f-ccf528db2433","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"e915fc3b-51f5-4e8d-9428-f4c834c1194c","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'9041cfcd-d85a-409b-9928-32c042804770',	1677835332093,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('284c860a-3933-484c-b419-6d17ccb63185',	'tp4',	'{"auth_method":"openid-connect","token_id":"75848cac-3747-4d89-a905-2c219b82bdc2","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"6661443c-4482-49e3-a2ec-f3d50a90f1fe","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'2e8701da-7c36-4411-9349-8dd0792164c6',	1677835462592,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('8b7c825c-3c01-4e44-b001-6f200e26411f',	'tp4',	'{"auth_method":"openid-connect","token_id":"9dd080f1-ae29-4e2a-8ba4-393169f3df28","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"1ac37ee1-83e1-4835-8365-f63fb59d119c","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'3edcfd20-2e8a-496c-8cca-5c7dd565c31b',	1677835511440,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('1f55b0c1-fd36-45ca-a98c-043d875540b0',	'tp4',	'{"auth_method":"openid-connect","token_id":"556312b3-e579-4229-8dc3-662532108daf","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"44d45ec6-0354-43c5-8084-e6296174ab08","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'2341b98a-2f0f-47dd-8faa-52dc4b32db96',	1677835545604,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('3a8bc963-ea8a-470c-896d-ea09fb9677be',	'tp4',	'{"auth_method":"openid-connect","token_id":"5656464b-efd8-4f1a-aaf1-03b11c03721c","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"d6ce2dd8-00bf-4538-9464-b04140203ce2","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'2d10cbd7-4c71-4b2c-aaba-87ce4a93c6d0',	1677835627663,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('0d98cedd-5c6f-407e-af9b-094163bf4540',	'tp4',	'{"auth_method":"openid-connect","token_id":"da613bc5-60da-4aa8-9b94-fc821125b679","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"d818ea55-f1cd-499a-9d0b-5c00d2fc519f","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'47a4aa34-1e49-4976-b9bb-48d5b561d326',	1677835692028,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('a3a3e74a-c8bd-4558-9a26-96c679d5a239',	'tp4',	'{"auth_method":"openid-connect","token_id":"06c92d3d-df08-4d6e-8e46-95ac1aed59c2","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"7901098a-e8ed-4364-b2d1-086b65d75d03","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'b7ded983-727a-48b9-89b7-e572aa9368dc',	1677835845039,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('7cbd1717-bcb6-49f5-8d03-6c287cd514ee',	'tp4',	'{"auth_method":"openid-connect","token_id":"ac917315-31b3-47cd-85e6-774805c12a7d","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"bc0432e4-de38-4264-99ef-872b7029cb1c","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'37058483-6247-4121-9b65-400142897b10',	1677836112543,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('c89dbd15-4e7e-4cd6-853d-079684e578c2',	'tp4',	'{"auth_method":"openid-connect","token_id":"97d8cc3d-8692-4636-9bfb-617a5db5efb8","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"3813812e-9263-46f7-9ddf-f9d99343183b","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'c54bc263-b7da-4d6e-b81a-0b2a3a31f903',	1677836144955,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('6c22b861-fdff-49aa-90b1-f7c16ac0ce7d',	'tp4',	'{"auth_method":"openid-connect","token_id":"c5c694dc-f1dc-473f-b1e6-7c01da9ce236","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"ca75e2ef-a7d8-4edb-8c27-86db6b281a92","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'1fe7788c-b8d1-4932-8249-b62c79ab7d16',	1677836253669,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('e78bfabf-ceb8-45df-b4e5-4bf08a803bd6',	'tp4',	'{"auth_method":"openid-connect","token_id":"bf5c095f-34fc-41f8-88cc-6f0912e2d555","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"55bb7045-77b8-4786-b2cf-5c4650724e08","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'cbff6958-e372-4a40-b0d8-11fb911effa9',	1677836402360,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('b56db929-3d16-4d63-a6f0-12dec4104be2',	'tp4',	'{"auth_method":"openid-connect","token_id":"f7091308-1c78-4775-a947-472122bddf3d","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"45c03575-b6a1-49b6-8708-6c7e8597b7c8","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'cea67976-7194-478e-a40e-edace8bc9097',	1677837994439,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('deb60c53-71ff-4489-afbe-ea14807ab450',	'tp4',	'{"auth_method":"openid-connect","token_id":"8aae785d-9aac-4938-b847-e336b36045ed","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"33671726-f9ff-4ceb-9d4e-52d6f12c417c","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'd1741c04-1146-4875-9e33-01a123147a1e',	1677838041340,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('2dc66115-eed1-4c37-86bf-8fdeb05cea5f',	'tp4',	'{"auth_method":"openid-connect","token_id":"4a74eb82-b059-4c06-8bcd-04b8a59ba0e7","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"91ed90c0-4ae1-4836-a5c6-b735445d6592","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'b9ae07db-0407-4a6a-b107-bfdf014e9cdd',	1677838252137,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('e41b4af2-8ff5-44a3-a65e-18577ed97b6c',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/authorized"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677838974190,	'LOGIN_ERROR',	NULL),
('150414cf-ed03-4654-800b-948fab31be4c',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/authorized"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677839164511,	'LOGIN_ERROR',	NULL),
('55d4872f-084a-40ae-a87f-a07c8cf4ee4b',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/authorized"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677839267510,	'LOGIN_ERROR',	NULL),
('8cbefda5-e57d-4bf7-a053-e010487f746b',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/authorized"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677839271816,	'LOGIN_ERROR',	NULL),
('7b86341d-1e90-4a1e-8549-521f870aaad5',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/authorized"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677839308098,	'LOGIN_ERROR',	NULL),
('0efcf920-0db6-46e7-87b3-a8f6b17ccadf',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/authorized"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677839309556,	'LOGIN_ERROR',	NULL),
('14efcab7-9f5d-4ca4-979d-33874d3274f8',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/authorized"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677839310395,	'LOGIN_ERROR',	NULL),
('f951c248-21db-490e-9e42-9841cf61ff97',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/authorized"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677839310999,	'LOGIN_ERROR',	NULL),
('f314c942-d3f3-4dbc-8d9a-5749bd399787',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/authorized"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677839337409,	'LOGIN_ERROR',	NULL),
('6e34403e-39fc-4def-b633-81e8fadbac26',	'tp4',	'{"redirect_uri":"http://127.0.0.1:5000/authorized"}',	'invalid_redirect_uri',	'172.20.0.1',	'r4dc10',	NULL,	1677839339386,	'LOGIN_ERROR',	NULL),
('ae361bab-81bb-4aa7-b601-31febbc331a9',	'tp4',	'{"response_type":"code","redirect_uri":"http://localhost:5000/authorized","response_mode":"query"}',	'invalid_request',	'172.20.0.1',	'r4dc10',	NULL,	1677839357210,	'LOGIN_ERROR',	NULL),
('ebcbc65d-9997-4a79-83ad-37159d1fbdec',	'tp4',	'{"response_type":"code","redirect_uri":"http://localhost:5000/authorized","response_mode":"query"}',	'invalid_request',	'172.20.0.1',	'r4dc10',	NULL,	1677839371558,	'LOGIN_ERROR',	NULL),
('3a43b6f4-33ec-4669-b483-915bfcf6be6c',	'tp4',	'{"auth_method":"openid-connect","token_id":"9aec5805-7912-46a9-9877-101b67fdef47","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"c308cb24-88c6-43ea-a25f-89e2c451ea96","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'c70f0fa5-1646-4ffb-ac98-a4840f8a995f',	1677839616076,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('19c022c3-4552-4d22-8330-9a7bc8193bb3',	'tp4',	'{"auth_method":"openid-connect","token_id":"14fc5e4c-3a23-43b7-a7fc-e574d4148406","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"9b55504f-d57c-4c9c-8ef8-69472d0b1748","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'adc1983f-ddb1-450c-aacf-8737296db020',	1677839966456,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('e7019a0b-ed97-4476-bbd6-d5b40555222e',	'tp4',	'{"auth_method":"openid-connect","token_id":"149b9902-d0e4-40d5-9b00-5afbe0dcac85","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"d8078047-0e4a-4652-a6c0-90deb59dea03","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'7a4b14a7-42a3-43cf-a880-ca67c80d5dfd',	1677840071737,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('bf8583e7-e0a0-4ad3-b1dc-045152a7609e',	'tp4',	'{"auth_method":"openid-connect","token_id":"b33ddca4-37ac-441b-8d93-fa74be4a6f40","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"de69e5a7-a307-4f60-b95f-c482a36fed6a","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'2d2ab4ef-b841-433e-a75a-37984eaac0a3',	1677840197153,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('7ff28819-a5c4-4d86-bd02-aee028ab3e6d',	'tp4',	'{"auth_method":"openid-connect","token_id":"632a01b8-b677-4e15-baba-85bb2a8b7b78","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"dc674543-0323-4ee0-ad8c-d499ac2ab7f5","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'c2ec3a69-6808-4bd7-9b76-e238eca70f0f',	1677841039052,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('4508c157-ae35-49f2-90b4-97068b2077c0',	'tp4',	'{"auth_method":"openid-connect","token_id":"a0bbdad4-55b9-4300-a02a-50363599b47e","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"229515cc-d449-4728-9cf3-cfc7ba2032ad","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'24795ce2-0776-42e1-997a-399843f39c7f',	1677841219926,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('ee389d99-3c07-473e-a279-924478bbfa02',	'tp4',	'{"auth_method":"openid-connect","token_id":"3cf5933b-dd0b-4ceb-99f1-36dbdaf313b0","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"a3330538-94af-4d80-b899-57f5eb753b19","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'2fbe9236-fc0b-4833-a385-9fff9fea0463',	1677841353205,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('306c9bca-ded6-488b-9345-4250aabf2ef9',	'tp4',	'{"auth_method":"openid-connect","token_id":"113ca1d5-bf88-4dab-b2a1-00f960b0ec68","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"c954997a-7d76-468c-b520-aef542ee4274","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'756e2fad-24a7-4da6-92e0-bc4ad7d5629a',	1677841641852,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('588e6563-c64d-4019-8522-538cf2a22a2a',	'tp4',	'{"auth_method":"openid-connect","token_id":"40a454e5-48c8-45f5-bca7-eb803dff5786","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"f00c74f3-5b7b-4fda-8e7c-4186b6314f28","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'259e12e3-e7e2-4518-b8fd-3e28a73e4699',	1677841793575,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('56307ed4-73d8-4912-9d6a-fe3a75fd053c',	'tp4',	'{"auth_method":"openid-connect","token_id":"ec469613-2654-474c-b75f-d5d2d1f2aaf0","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"2dd2d8ed-b97c-4ea7-a07b-2040b620e4a7","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'0006db26-2c88-480b-83e6-5c259bb3fe70',	1677841912856,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('8aa0e8f3-1496-48bf-b8b6-2ef9c0b30f8f',	'tp4',	'{"auth_method":"openid-connect","token_id":"ef22b9a5-7619-477a-b47a-2c42d93aae49","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"36a53457-9816-4ba1-8d82-aa6f890a0dbe","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'217204db-794a-4435-9b04-0320a1cc3afa',	1677841929404,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('df20e1ca-323c-4ce6-8a81-eb65858bf9af',	'tp4',	'{"auth_method":"openid-connect","token_id":"36b62033-949b-4f45-802f-9f2a97d39ec7","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"fa78dcca-ff09-4711-b776-a9572a80a760","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'86d1560d-083b-4dfa-a5e3-fd19baf73cfa',	1677841967486,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('62ffa151-ad77-4c6e-891c-ccae0d3b2c4c',	'tp4',	'{"auth_method":"openid-connect","token_id":"e1cd6ff5-b311-4c83-93d7-061cdbe56d13","grant_type":"password","refresh_token_type":"Refresh","scope":"openid email profile","refresh_token_id":"18e3529a-68ef-46ed-adde-3a906c5037e0","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'1579f99e-480f-4fe1-955a-3b9d810e1891',	1677841996440,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('bb455f15-09e3-4246-a6d8-0dba70745292',	NULL,	'null',	'invalid_request',	'172.20.0.1',	'r4dc10',	NULL,	1677842377228,	'LOGIN_ERROR',	NULL),
('401d25d4-363c-48f3-9fad-61d4cd69ab96',	'tp4',	'{"auth_method":"openid-connect","token_id":"8a55d9ca-3a6e-4a60-a373-c7998c74051a","grant_type":"password","refresh_token_type":"Refresh","scope":"email profile","refresh_token_id":"51c83c7d-2e30-40f5-a544-f3daabde074f","client_auth_method":"client-secret","username":"sam"}',	NULL,	'172.20.0.1',	'r4dc10',	'2f6009b1-325b-4ec8-a9c0-06f457d87a58',	1677842765423,	'LOGIN',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c');

CREATE TABLE "public"."fed_user_attribute" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    "value" character varying(2024),
    CONSTRAINT "constr_fed_user_attr_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_fu_attribute" ON "public"."fed_user_attribute" USING btree ("user_id", "realm_id", "name");


CREATE TABLE "public"."fed_user_consent" (
    "id" character varying(36) NOT NULL,
    "client_id" character varying(255),
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    "created_date" bigint,
    "last_updated_date" bigint,
    "client_storage_provider" character varying(36),
    "external_client_id" character varying(255),
    CONSTRAINT "constr_fed_user_consent_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_fu_cnsnt_ext" ON "public"."fed_user_consent" USING btree ("user_id", "client_storage_provider", "external_client_id");

CREATE INDEX "idx_fu_consent" ON "public"."fed_user_consent" USING btree ("user_id", "client_id");

CREATE INDEX "idx_fu_consent_ru" ON "public"."fed_user_consent" USING btree ("realm_id", "user_id");


CREATE TABLE "public"."fed_user_consent_cl_scope" (
    "user_consent_id" character varying(36) NOT NULL,
    "scope_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_fgrntcsnt_clsc_pm" PRIMARY KEY ("user_consent_id", "scope_id")
) WITH (oids = false);


CREATE TABLE "public"."fed_user_credential" (
    "id" character varying(36) NOT NULL,
    "salt" bytea,
    "type" character varying(255),
    "created_date" bigint,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    "user_label" character varying(255),
    "secret_data" text,
    "credential_data" text,
    "priority" integer,
    CONSTRAINT "constr_fed_user_cred_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_fu_credential" ON "public"."fed_user_credential" USING btree ("user_id", "type");

CREATE INDEX "idx_fu_credential_ru" ON "public"."fed_user_credential" USING btree ("realm_id", "user_id");


CREATE TABLE "public"."fed_user_group_membership" (
    "group_id" character varying(36) NOT NULL,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    CONSTRAINT "constr_fed_user_group" PRIMARY KEY ("group_id", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_fu_group_membership" ON "public"."fed_user_group_membership" USING btree ("user_id", "group_id");

CREATE INDEX "idx_fu_group_membership_ru" ON "public"."fed_user_group_membership" USING btree ("realm_id", "user_id");


CREATE TABLE "public"."fed_user_required_action" (
    "required_action" character varying(255) DEFAULT ' ' NOT NULL,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    CONSTRAINT "constr_fed_required_action" PRIMARY KEY ("required_action", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_fu_required_action" ON "public"."fed_user_required_action" USING btree ("user_id", "required_action");

CREATE INDEX "idx_fu_required_action_ru" ON "public"."fed_user_required_action" USING btree ("realm_id", "user_id");


CREATE TABLE "public"."fed_user_role_mapping" (
    "role_id" character varying(36) NOT NULL,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "storage_provider_id" character varying(36),
    CONSTRAINT "constr_fed_user_role" PRIMARY KEY ("role_id", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_fu_role_mapping" ON "public"."fed_user_role_mapping" USING btree ("user_id", "role_id");

CREATE INDEX "idx_fu_role_mapping_ru" ON "public"."fed_user_role_mapping" USING btree ("realm_id", "user_id");


CREATE TABLE "public"."federated_identity" (
    "identity_provider" character varying(255) NOT NULL,
    "realm_id" character varying(36),
    "federated_user_id" character varying(255),
    "federated_username" character varying(255),
    "token" text,
    "user_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_40" PRIMARY KEY ("identity_provider", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_fedidentity_feduser" ON "public"."federated_identity" USING btree ("federated_user_id");

CREATE INDEX "idx_fedidentity_user" ON "public"."federated_identity" USING btree ("user_id");


CREATE TABLE "public"."federated_user" (
    "id" character varying(255) NOT NULL,
    "storage_provider_id" character varying(255),
    "realm_id" character varying(36) NOT NULL,
    CONSTRAINT "constr_federated_user" PRIMARY KEY ("id")
) WITH (oids = false);


CREATE TABLE "public"."group_attribute" (
    "id" character varying(36) DEFAULT 'sybase-needs-something-here' NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" character varying(255),
    "group_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_group_attribute_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_group_attr_group" ON "public"."group_attribute" USING btree ("group_id");


CREATE TABLE "public"."group_role_mapping" (
    "role_id" character varying(36) NOT NULL,
    "group_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_group_role" PRIMARY KEY ("role_id", "group_id")
) WITH (oids = false);

CREATE INDEX "idx_group_role_mapp_group" ON "public"."group_role_mapping" USING btree ("group_id");


CREATE TABLE "public"."identity_provider" (
    "internal_id" character varying(36) NOT NULL,
    "enabled" boolean DEFAULT false NOT NULL,
    "provider_alias" character varying(255),
    "provider_id" character varying(255),
    "store_token" boolean DEFAULT false NOT NULL,
    "authenticate_by_default" boolean DEFAULT false NOT NULL,
    "realm_id" character varying(36),
    "add_token_role" boolean DEFAULT true NOT NULL,
    "trust_email" boolean DEFAULT false NOT NULL,
    "first_broker_login_flow_id" character varying(36),
    "post_broker_login_flow_id" character varying(36),
    "provider_display_name" character varying(255),
    "link_only" boolean DEFAULT false NOT NULL,
    CONSTRAINT "constraint_2b" PRIMARY KEY ("internal_id"),
    CONSTRAINT "uk_2daelwnibji49avxsrtuf6xj33" UNIQUE ("provider_alias", "realm_id")
) WITH (oids = false);

CREATE INDEX "idx_ident_prov_realm" ON "public"."identity_provider" USING btree ("realm_id");


CREATE TABLE "public"."identity_provider_config" (
    "identity_provider_id" character varying(36) NOT NULL,
    "value" text,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_d" PRIMARY KEY ("identity_provider_id", "name")
) WITH (oids = false);


CREATE TABLE "public"."identity_provider_mapper" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "idp_alias" character varying(255) NOT NULL,
    "idp_mapper_name" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_idpm" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_id_prov_mapp_realm" ON "public"."identity_provider_mapper" USING btree ("realm_id");


CREATE TABLE "public"."idp_mapper_config" (
    "idp_mapper_id" character varying(36) NOT NULL,
    "value" text,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_idpmconfig" PRIMARY KEY ("idp_mapper_id", "name")
) WITH (oids = false);


CREATE TABLE "public"."keycloak_group" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255),
    "parent_group" character varying(36) NOT NULL,
    "realm_id" character varying(36),
    CONSTRAINT "constraint_group" PRIMARY KEY ("id"),
    CONSTRAINT "sibling_names" UNIQUE ("realm_id", "parent_group", "name")
) WITH (oids = false);


CREATE TABLE "public"."keycloak_role" (
    "id" character varying(36) NOT NULL,
    "client_realm_constraint" character varying(255),
    "client_role" boolean DEFAULT false NOT NULL,
    "description" character varying(255),
    "name" character varying(255),
    "realm_id" character varying(255),
    "client" character varying(36),
    "realm" character varying(36),
    CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE ("name", "client_realm_constraint"),
    CONSTRAINT "constraint_a" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_keycloak_role_client" ON "public"."keycloak_role" USING btree ("client");

CREATE INDEX "idx_keycloak_role_realm" ON "public"."keycloak_role" USING btree ("realm");

INSERT INTO "keycloak_role" ("id", "client_realm_constraint", "client_role", "description", "name", "realm_id", "client", "realm") VALUES
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'master',	'f',	'${role_admin}',	'admin',	'master',	NULL,	'master'),
('8da7d299-7c6a-43d7-84a5-e045cc0e154c',	'master',	'f',	'${role_create-realm}',	'create-realm',	'master',	NULL,	'master'),
('ff619129-5fde-4f20-9a4e-9b409d2d36ad',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_create-client}',	'create-client',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('90bb7dad-5d82-4fe9-b3c0-4e9fbc0751a7',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_view-realm}',	'view-realm',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('842ee560-2bf7-4956-841f-9725b2f0f4d0',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_view-users}',	'view-users',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('9506aa9b-39b4-4be4-8323-90976c78d5e2',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_view-clients}',	'view-clients',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('bd094475-9794-4e78-9f1f-4ec8eab6a2d3',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_view-events}',	'view-events',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('077e7831-b01d-493d-95ae-ed8325b8aad6',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_view-identity-providers}',	'view-identity-providers',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('45bf08ea-91c8-4f19-91ca-b67cd5c9212b',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_view-authorization}',	'view-authorization',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('dc150116-7d7b-4919-bace-208db1871fbb',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_manage-realm}',	'manage-realm',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('c000c9d0-0141-4bd4-a7e3-84658c6393f1',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_manage-users}',	'manage-users',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('c4c3fc12-032d-4d37-b829-aa58cf8d31c5',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_manage-clients}',	'manage-clients',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('cdec0e02-3357-451e-95c8-93d75373d346',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_manage-events}',	'manage-events',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('e31773d7-c975-485d-a947-e52fe57fa354',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_manage-identity-providers}',	'manage-identity-providers',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('8d3f4827-c1cf-4523-aa98-6e0307de48ce',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_manage-authorization}',	'manage-authorization',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('49b7be72-8fe2-45ac-8dcf-86d041d50a2d',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_query-users}',	'query-users',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('16abb812-4f78-47ce-b9f3-1db17d73528a',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_query-clients}',	'query-clients',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('a4e02317-4c90-4512-9452-30b9d78c56fa',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_query-realms}',	'query-realms',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('572008ae-3b45-4a99-8af8-a5da921d42e3',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_query-groups}',	'query-groups',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('ceba32d8-e9c6-4718-8aa2-bfb7cea43fc1',	'a6705522-6765-4697-851d-da311aa73ec2',	't',	'${role_view-profile}',	'view-profile',	'master',	'a6705522-6765-4697-851d-da311aa73ec2',	NULL),
('c9a1686c-5044-49a0-9ce4-b29c241b52eb',	'a6705522-6765-4697-851d-da311aa73ec2',	't',	'${role_manage-account}',	'manage-account',	'master',	'a6705522-6765-4697-851d-da311aa73ec2',	NULL),
('0bbd6e40-1335-42da-8fdf-3670c60d0042',	'a6705522-6765-4697-851d-da311aa73ec2',	't',	'${role_manage-account-links}',	'manage-account-links',	'master',	'a6705522-6765-4697-851d-da311aa73ec2',	NULL),
('e851359d-5036-425f-83db-54442e6335ec',	'a6705522-6765-4697-851d-da311aa73ec2',	't',	'${role_view-applications}',	'view-applications',	'master',	'a6705522-6765-4697-851d-da311aa73ec2',	NULL),
('52f5726d-0209-477b-be02-fc3cab59636f',	'a6705522-6765-4697-851d-da311aa73ec2',	't',	'${role_view-consent}',	'view-consent',	'master',	'a6705522-6765-4697-851d-da311aa73ec2',	NULL),
('b5a3382a-6073-4ee3-869b-8c94bc3989c8',	'a6705522-6765-4697-851d-da311aa73ec2',	't',	'${role_manage-consent}',	'manage-consent',	'master',	'a6705522-6765-4697-851d-da311aa73ec2',	NULL),
('267744de-69db-40b9-8639-7b0d044e600c',	'1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	't',	'${role_read-token}',	'read-token',	'master',	'1acf150f-69e9-4b2c-abf3-f98295f7eb7b',	NULL),
('a75747b0-6525-4396-bf43-f2204a9b39a3',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	't',	'${role_impersonation}',	'impersonation',	'master',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	NULL),
('f45e30f7-8e89-48c2-a8d6-57e30bd1f549',	'master',	'f',	'${role_offline-access}',	'offline_access',	'master',	NULL,	'master'),
('91e68ff8-b9bb-4c81-8ab9-9ecc4b80e9e3',	'master',	'f',	'${role_uma_authorization}',	'uma_authorization',	'master',	NULL,	'master'),
('5214c02d-de88-476a-a8c9-c11c17f20f56',	'6f27ed60-7ce0-490a-ab65-6e32912cffe0',	't',	NULL,	'uma_protection',	'master',	'6f27ed60-7ce0-490a-ab65-6e32912cffe0',	NULL),
('3795f42f-07c2-4fea-b14d-1d08f029d40c',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_create-client}',	'create-client',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('aed2b43a-0b0b-4b4f-b007-ee73717625c3',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_view-realm}',	'view-realm',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('1e4a0a06-d17d-460e-91ba-8c78c9353943',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_view-users}',	'view-users',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('fda247a5-e13c-4164-a4b8-ec3a6a87a2a2',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_view-clients}',	'view-clients',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('ceceb936-9727-4a20-a515-98beb61be7ad',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_view-events}',	'view-events',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('0f2f6aaa-db64-4948-96ba-c238d654a602',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_view-identity-providers}',	'view-identity-providers',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('a8bea86a-5951-45ca-a028-9657db9dee5f',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_view-authorization}',	'view-authorization',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('b070f99c-59c4-4206-950c-9d5771be1671',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_manage-realm}',	'manage-realm',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('7982d26a-3082-454c-b747-3a61e186f0ca',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_manage-users}',	'manage-users',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('39dabbbe-5605-40c4-9d41-5480c02ff196',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_manage-clients}',	'manage-clients',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('f8004689-078d-4753-9711-aca000b2e9cb',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_manage-events}',	'manage-events',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('19109ade-d086-4758-a6d1-127c06209d5b',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_manage-identity-providers}',	'manage-identity-providers',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('89ebcf21-d32c-4153-aac7-69f802330f32',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_manage-authorization}',	'manage-authorization',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('0310e7b8-82bd-42ba-91c3-827dcc2e8f29',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_query-users}',	'query-users',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('1bbe7b83-66ee-4343-b506-9d9c5265970b',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_query-clients}',	'query-clients',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('0b8c9c91-e1ac-49b8-9e84-1e698210df55',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_query-realms}',	'query-realms',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('f2c18110-f058-4206-b26f-ce7820873fb4',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_query-groups}',	'query-groups',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('66a38226-7263-4bb2-9cb4-a26a3e003048',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_realm-admin}',	'realm-admin',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('0860ebb9-321a-4d63-9bf2-e70b94196a75',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_create-client}',	'create-client',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('930a9a2c-3288-419c-8858-4dc629249c55',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_view-realm}',	'view-realm',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('1a602829-4629-4cc3-96a9-89721b192069',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_view-users}',	'view-users',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('99b00c72-94d2-45b2-9153-6c5c122f08e8',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_view-clients}',	'view-clients',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('2f627c2c-f304-4210-bc9a-67c16620b790',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_view-events}',	'view-events',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('f80b10bf-bc59-4250-9b78-a9af2e4dd10c',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_view-identity-providers}',	'view-identity-providers',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('993027d7-8c93-457d-8854-049b40d9c568',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_view-authorization}',	'view-authorization',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('9e43eccf-b631-48ff-b9ce-471146f94c41',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_manage-realm}',	'manage-realm',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('c87555f3-5dfb-4e2b-ab3e-20d86806ed20',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_manage-users}',	'manage-users',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('8b161077-d5da-4f44-ad83-f529becd3b4f',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_manage-clients}',	'manage-clients',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('9a325bcd-1cd0-4d54-b3e3-80d87a26dd07',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_manage-events}',	'manage-events',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('d86475a6-53a0-4f90-9468-36b30b730519',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_manage-identity-providers}',	'manage-identity-providers',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('6979f7f3-050e-4eac-8fd6-81a6ee706ae9',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_manage-authorization}',	'manage-authorization',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('2991714a-2f71-4b9f-b2dc-d08ed16ee200',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_query-users}',	'query-users',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('da0bdc8c-1524-436d-9e68-4c42ad434b6f',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_query-clients}',	'query-clients',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('86b8659f-e603-4a3d-86dd-3b447083eb2c',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_query-realms}',	'query-realms',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('75995c46-73aa-45ad-9ea8-dcecce907e9e',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_query-groups}',	'query-groups',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('2ca65888-39b1-401f-8673-a2619db4ba61',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	't',	'${role_view-profile}',	'view-profile',	'r4dc10',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	NULL),
('732c0f47-d6da-4e60-8616-a8c0cff622a5',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	't',	'${role_manage-account}',	'manage-account',	'r4dc10',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	NULL),
('3788bc83-87e9-4524-872d-4d2664d91177',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	't',	'${role_manage-account-links}',	'manage-account-links',	'r4dc10',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	NULL),
('6b19142f-a0ea-4805-84cc-b6f679ef68a7',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	't',	'${role_view-applications}',	'view-applications',	'r4dc10',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	NULL),
('8192a055-b4b0-4ba9-b305-cdbd4ea00180',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	't',	'${role_view-consent}',	'view-consent',	'r4dc10',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	NULL),
('69d06b97-1a40-4a0d-9645-1a17103dea09',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	't',	'${role_manage-consent}',	'manage-consent',	'r4dc10',	'0c3ae588-fd06-4d48-9750-2e1c61ebde60',	NULL),
('bb6ab464-1aad-4a10-b046-059569e0deef',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	't',	'${role_impersonation}',	'impersonation',	'master',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	NULL),
('d58aafab-2a38-4941-89e9-dffc448f7cd2',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	't',	'${role_impersonation}',	'impersonation',	'r4dc10',	'4254f0dd-6b29-4695-a59d-8a4ba2c7dd68',	NULL),
('59aef6fa-a802-491b-8b6e-4cf699ed3bdf',	'd1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	't',	'${role_read-token}',	'read-token',	'r4dc10',	'd1688158-12d3-47b9-bc52-4d4c3c1ed6eb',	NULL),
('16e0c766-4ac4-4ce4-8b47-89fadf51313d',	'r4dc10',	'f',	'${role_offline-access}',	'offline_access',	'r4dc10',	NULL,	'r4dc10'),
('6225b6bb-b45a-46a6-a666-3fbec676402a',	'r4dc10',	'f',	'${role_uma_authorization}',	'uma_authorization',	'r4dc10',	NULL,	'r4dc10'),
('c8531370-57ed-47e9-9b58-7c7a97d3796a',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	't',	NULL,	'uma_protection',	'r4dc10',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	NULL),
('24861f9b-55b9-44a3-b890-2da05c9b5088',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	't',	NULL,	'admin',	'r4dc10',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	NULL),
('6419a6c7-e23c-4ba2-8fe2-e9536079e63e',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	't',	NULL,	'create',	'r4dc10',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	NULL),
('ed1284b2-0ac6-4251-b11d-30ee7fb1c53d',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	't',	NULL,	'delete',	'r4dc10',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	NULL),
('a69f6fd1-2efd-48bb-9ec6-343763f3af4a',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	't',	NULL,	'update',	'r4dc10',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	NULL),
('390a0acb-4976-4529-bdf3-bc9162f8c170',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	't',	NULL,	'read',	'r4dc10',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	NULL);

CREATE TABLE "public"."migration_model" (
    "id" character varying(36) NOT NULL,
    "version" character varying(36),
    "update_time" bigint DEFAULT '0' NOT NULL,
    CONSTRAINT "constraint_migmod" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_update_time" ON "public"."migration_model" USING btree ("update_time");

INSERT INTO "migration_model" ("id", "version", "update_time") VALUES
('4bctj',	'11.0.2',	1677607465);

CREATE TABLE "public"."offline_client_session" (
    "user_session_id" character varying(36) NOT NULL,
    "client_id" character varying(255) NOT NULL,
    "offline_flag" character varying(4) NOT NULL,
    "timestamp" integer,
    "data" text,
    "client_storage_provider" character varying(36) DEFAULT 'local' NOT NULL,
    "external_client_id" character varying(255) DEFAULT 'local' NOT NULL,
    CONSTRAINT "constraint_offl_cl_ses_pk3" PRIMARY KEY ("user_session_id", "client_id", "client_storage_provider", "external_client_id", "offline_flag")
) WITH (oids = false);

CREATE INDEX "idx_us_sess_id_on_cl_sess" ON "public"."offline_client_session" USING btree ("user_session_id");


CREATE TABLE "public"."offline_user_session" (
    "user_session_id" character varying(36) NOT NULL,
    "user_id" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    "created_on" integer NOT NULL,
    "offline_flag" character varying(4) NOT NULL,
    "data" text,
    "last_session_refresh" integer DEFAULT '0' NOT NULL,
    CONSTRAINT "constraint_offl_us_ses_pk2" PRIMARY KEY ("user_session_id", "offline_flag")
) WITH (oids = false);

CREATE INDEX "idx_offline_uss_createdon" ON "public"."offline_user_session" USING btree ("created_on");


CREATE TABLE "public"."policy_config" (
    "policy_id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" text,
    CONSTRAINT "constraint_dpc" PRIMARY KEY ("policy_id", "name")
) WITH (oids = false);

INSERT INTO "policy_config" ("policy_id", "name", "value") VALUES
('592c5f1c-ed21-414d-8648-eff224d3f5d2',	'code',	'// by default, grants any permission associated with this policy
$evaluation.grant();
'),
('ebe9b1e1-5e56-4382-a659-62f65cdd2611',	'defaultResourceType',	'urn:tp4:resources:default'),
('f96c1955-837b-4bd0-bf4e-c2590408df2f',	'code',	'// by default, grants any permission associated with this policy
$evaluation.grant();
'),
('cced5405-8bfa-4b90-be5b-c9273cb9d5a6',	'defaultResourceType',	'urn:tp4:resources:default');

CREATE TABLE "public"."protocol_mapper" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "protocol" character varying(255) NOT NULL,
    "protocol_mapper_name" character varying(255) NOT NULL,
    "client_id" character varying(36),
    "client_scope_id" character varying(36),
    CONSTRAINT "constraint_pcm" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_clscope_protmap" ON "public"."protocol_mapper" USING btree ("client_scope_id");

CREATE INDEX "idx_protocol_mapper_client" ON "public"."protocol_mapper" USING btree ("client_id");

INSERT INTO "protocol_mapper" ("id", "name", "protocol", "protocol_mapper_name", "client_id", "client_scope_id") VALUES
('cf95415f-b702-4711-a663-7c169dbb1d05',	'audience resolve',	'openid-connect',	'oidc-audience-resolve-mapper',	'ff236875-1e2d-4681-941f-420e7c05ff64',	NULL),
('c9c10421-a0b2-47ea-9471-d429fb4765ff',	'locale',	'openid-connect',	'oidc-usermodel-attribute-mapper',	'3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	NULL),
('cce517aa-79f3-45d4-962c-dfe6039e91b4',	'role list',	'saml',	'saml-role-list-mapper',	NULL,	'b83bf671-6af1-4813-913a-9d7d3d27d604'),
('34c618fc-970c-47a7-81f2-82b4407a0571',	'full name',	'openid-connect',	'oidc-full-name-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('c92e31ae-6693-4f4e-b175-b0c8f8977dec',	'family name',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('a3d1c92b-8c51-485a-8b01-f3c9cad5ff7c',	'given name',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('a77c0489-9385-42c4-9735-86c645d45abe',	'middle name',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('f666b50b-9e62-4d5d-8b60-eb65e22a207a',	'nickname',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('323115bd-b0fb-4d8e-8b5b-054be0ff1652',	'username',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('0adecc9e-5bbf-40a6-a04a-969db619ba5f',	'profile',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('cdf9687d-4a9c-41c5-b41d-6393533f174e',	'picture',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('50c40927-0c53-4725-928a-71e2991b613a',	'website',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('47ea36e9-aa4b-4fef-9a5c-221aba80651f',	'gender',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('6d977eab-5628-44dc-b76c-a324fc352c88',	'birthdate',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('abe0e3aa-ba47-4e6e-96a0-cc01df2da4b4',	'zoneinfo',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('b8a1616b-79ff-4dad-86d6-5ee740ed9a7f',	'locale',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('a016f6e1-3bd6-445a-8110-94c73fb7fc42',	'updated at',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'b40a8d27-b455-4fb8-86c6-67443ad5be7c'),
('3359edae-341c-4aee-8a7c-53a37c7e3d75',	'email',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'f32dda2b-912e-4d4f-8648-be0c8e2592c3'),
('e278377a-9ea5-4a68-b078-cd0da6a7f6bc',	'email verified',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'f32dda2b-912e-4d4f-8648-be0c8e2592c3'),
('a049e3ab-c7e8-4d9c-818c-8143a728e4ad',	'address',	'openid-connect',	'oidc-address-mapper',	NULL,	'bd23fa9b-9bc9-4532-95d6-aad2011fa008'),
('7d72b99b-063a-4b9f-aa2a-3b82403acae5',	'phone number',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'c5993dc6-d05a-40ee-add4-aa0abc5da38f'),
('3d763e09-bf7f-4cd6-837e-691556185ae8',	'phone number verified',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'c5993dc6-d05a-40ee-add4-aa0abc5da38f'),
('f10dafca-7f41-483e-bc0c-a98d18e5fb0d',	'realm roles',	'openid-connect',	'oidc-usermodel-realm-role-mapper',	NULL,	'7aab54da-f6d2-469c-b77e-24ec610f83d8'),
('723dee93-4f5a-41e2-99e3-f4940815dfd0',	'client roles',	'openid-connect',	'oidc-usermodel-client-role-mapper',	NULL,	'7aab54da-f6d2-469c-b77e-24ec610f83d8'),
('bbb9515b-ff86-456a-9b4a-cf1757054cb5',	'audience resolve',	'openid-connect',	'oidc-audience-resolve-mapper',	NULL,	'7aab54da-f6d2-469c-b77e-24ec610f83d8'),
('8b33c977-9e64-47e0-abd4-fcd3c7f6d6fd',	'allowed web origins',	'openid-connect',	'oidc-allowed-origins-mapper',	NULL,	'bd609fd8-a84d-428e-b204-4f4370b8efe5'),
('427a1c70-3fcb-44c0-b75e-ebe50657075d',	'upn',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'526196c2-5eea-43dc-8673-6f79036355e0'),
('cca7a2fa-4514-48d5-97a8-cdc599c9c8c0',	'groups',	'openid-connect',	'oidc-usermodel-realm-role-mapper',	NULL,	'526196c2-5eea-43dc-8673-6f79036355e0'),
('7cf29e89-5a00-430d-a79a-1af1405e5a81',	'Client ID',	'openid-connect',	'oidc-usersessionmodel-note-mapper',	'6f27ed60-7ce0-490a-ab65-6e32912cffe0',	NULL),
('d7acd4cb-4a33-4098-a386-0ed7ee5dc9ce',	'Client Host',	'openid-connect',	'oidc-usersessionmodel-note-mapper',	'6f27ed60-7ce0-490a-ab65-6e32912cffe0',	NULL),
('bbcea311-f30b-4700-b258-8c62a8f6373b',	'Client IP Address',	'openid-connect',	'oidc-usersessionmodel-note-mapper',	'6f27ed60-7ce0-490a-ab65-6e32912cffe0',	NULL),
('ef25b1da-918d-4735-bad9-9e7c8fdf6a38',	'audience resolve',	'openid-connect',	'oidc-audience-resolve-mapper',	'0fe28e08-8f06-4b65-835b-945b30ca3f6e',	NULL),
('e7241682-ac77-4b90-ae4f-041e60293ec7',	'role list',	'saml',	'saml-role-list-mapper',	NULL,	'74f7a6b2-ecf9-4d6f-bc9b-60a6aac0c19a'),
('e66f7ab3-a8a3-4759-affc-3e08e0305cd8',	'full name',	'openid-connect',	'oidc-full-name-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('97fe6cad-38c7-48d5-be8e-aefc11c939a9',	'family name',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('cbe09675-5623-4564-8600-31fd7e18a461',	'given name',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('67318b3d-b74a-44d1-a31f-13e76b8fe8bb',	'middle name',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('24ccfb48-36aa-4695-8b89-35c140815749',	'nickname',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('d451c938-0c34-4e9d-96e7-9a8b34cecd20',	'username',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('5c0b27ab-b630-4855-ad00-082cb3383608',	'profile',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('1e7d8400-d9ad-4c11-9d0e-67f41061b375',	'picture',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('3c9338c1-4a49-41fa-b9b5-ac6ac9aef1e8',	'website',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('684bf142-5c03-417e-88b5-ec60d3b3a71a',	'gender',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('936bf49f-7fd1-4eb6-b66e-c33be4f7451f',	'birthdate',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('1272272a-1357-42d4-9d00-06d13ad8b758',	'zoneinfo',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('f89532bc-467a-4e61-b7be-b93bb093e437',	'locale',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('f5af2093-3150-4a01-945c-aefdd67f5a52',	'updated at',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'67363a99-ccfd-44b7-a497-35dbdd73f9a5'),
('8d9f9403-1b2b-411e-b00e-f19099b07986',	'email',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'0648f987-e3d4-475c-8d80-aeea9b6754f8'),
('d3ee0673-67ee-4e6a-8e51-cf9625aad9fd',	'email verified',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'0648f987-e3d4-475c-8d80-aeea9b6754f8'),
('809a4179-ac83-4ce4-b057-4ea09ae586cf',	'address',	'openid-connect',	'oidc-address-mapper',	NULL,	'c1bf5367-8241-4eab-80ab-9010fba9da30'),
('5864634a-8f11-4c2d-8e58-37e5af314225',	'phone number',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a'),
('d7973974-b38a-405c-8e6d-ee7ceda78e9b',	'phone number verified',	'openid-connect',	'oidc-usermodel-attribute-mapper',	NULL,	'9ed4d8f3-a4fa-4711-99b6-c0997d1f3f3a'),
('890bb8bd-7e54-46e9-98d0-b2f01365ab34',	'realm roles',	'openid-connect',	'oidc-usermodel-realm-role-mapper',	NULL,	'989793f4-44d5-4cdf-a46a-29eb821c66f3'),
('5404dcdb-e16c-4793-a041-12fbbf8c8979',	'client roles',	'openid-connect',	'oidc-usermodel-client-role-mapper',	NULL,	'989793f4-44d5-4cdf-a46a-29eb821c66f3'),
('9882990b-34a5-4bfe-b11a-2f7173b9131c',	'audience resolve',	'openid-connect',	'oidc-audience-resolve-mapper',	NULL,	'989793f4-44d5-4cdf-a46a-29eb821c66f3'),
('b970f208-fb1e-4f0b-9801-1651ad66780f',	'allowed web origins',	'openid-connect',	'oidc-allowed-origins-mapper',	NULL,	'642eaf07-8f62-4377-9e50-907dbcfda3eb'),
('20bd1cb2-e02b-4883-b7a0-4d9beba8d0d2',	'upn',	'openid-connect',	'oidc-usermodel-property-mapper',	NULL,	'f91b58f8-3fd2-4c41-9311-3babfe9628b8'),
('c61df69a-6a20-461e-ac84-ee7dbf0c88ca',	'groups',	'openid-connect',	'oidc-usermodel-realm-role-mapper',	NULL,	'f91b58f8-3fd2-4c41-9311-3babfe9628b8'),
('233efc1d-5a8e-46b8-9c9e-3dff2913392c',	'locale',	'openid-connect',	'oidc-usermodel-attribute-mapper',	'f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	NULL),
('2274e228-b1a2-4e5e-ba5e-9f2a278f4edf',	'Client ID',	'openid-connect',	'oidc-usersessionmodel-note-mapper',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	NULL),
('e2c4a504-7d90-4255-aed1-17b5809b6b8f',	'Client Host',	'openid-connect',	'oidc-usersessionmodel-note-mapper',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	NULL),
('9f82fecf-2dee-445f-8262-dcc680408cd6',	'Client IP Address',	'openid-connect',	'oidc-usersessionmodel-note-mapper',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	NULL);

CREATE TABLE "public"."protocol_mapper_config" (
    "protocol_mapper_id" character varying(36) NOT NULL,
    "value" text,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_pmconfig" PRIMARY KEY ("protocol_mapper_id", "name")
) WITH (oids = false);

INSERT INTO "protocol_mapper_config" ("protocol_mapper_id", "value", "name") VALUES
('c9c10421-a0b2-47ea-9471-d429fb4765ff',	'true',	'userinfo.token.claim'),
('c9c10421-a0b2-47ea-9471-d429fb4765ff',	'locale',	'user.attribute'),
('c9c10421-a0b2-47ea-9471-d429fb4765ff',	'true',	'id.token.claim'),
('c9c10421-a0b2-47ea-9471-d429fb4765ff',	'true',	'access.token.claim'),
('c9c10421-a0b2-47ea-9471-d429fb4765ff',	'locale',	'claim.name'),
('c9c10421-a0b2-47ea-9471-d429fb4765ff',	'String',	'jsonType.label'),
('cce517aa-79f3-45d4-962c-dfe6039e91b4',	'false',	'single'),
('cce517aa-79f3-45d4-962c-dfe6039e91b4',	'Basic',	'attribute.nameformat'),
('cce517aa-79f3-45d4-962c-dfe6039e91b4',	'Role',	'attribute.name'),
('34c618fc-970c-47a7-81f2-82b4407a0571',	'true',	'userinfo.token.claim'),
('34c618fc-970c-47a7-81f2-82b4407a0571',	'true',	'id.token.claim'),
('34c618fc-970c-47a7-81f2-82b4407a0571',	'true',	'access.token.claim'),
('c92e31ae-6693-4f4e-b175-b0c8f8977dec',	'true',	'userinfo.token.claim'),
('c92e31ae-6693-4f4e-b175-b0c8f8977dec',	'lastName',	'user.attribute'),
('c92e31ae-6693-4f4e-b175-b0c8f8977dec',	'true',	'id.token.claim'),
('c92e31ae-6693-4f4e-b175-b0c8f8977dec',	'true',	'access.token.claim'),
('c92e31ae-6693-4f4e-b175-b0c8f8977dec',	'family_name',	'claim.name'),
('c92e31ae-6693-4f4e-b175-b0c8f8977dec',	'String',	'jsonType.label'),
('a3d1c92b-8c51-485a-8b01-f3c9cad5ff7c',	'true',	'userinfo.token.claim'),
('a3d1c92b-8c51-485a-8b01-f3c9cad5ff7c',	'firstName',	'user.attribute'),
('a3d1c92b-8c51-485a-8b01-f3c9cad5ff7c',	'true',	'id.token.claim'),
('a3d1c92b-8c51-485a-8b01-f3c9cad5ff7c',	'true',	'access.token.claim'),
('a3d1c92b-8c51-485a-8b01-f3c9cad5ff7c',	'given_name',	'claim.name'),
('a3d1c92b-8c51-485a-8b01-f3c9cad5ff7c',	'String',	'jsonType.label'),
('a77c0489-9385-42c4-9735-86c645d45abe',	'true',	'userinfo.token.claim'),
('a77c0489-9385-42c4-9735-86c645d45abe',	'middleName',	'user.attribute'),
('a77c0489-9385-42c4-9735-86c645d45abe',	'true',	'id.token.claim'),
('a77c0489-9385-42c4-9735-86c645d45abe',	'true',	'access.token.claim'),
('a77c0489-9385-42c4-9735-86c645d45abe',	'middle_name',	'claim.name'),
('a77c0489-9385-42c4-9735-86c645d45abe',	'String',	'jsonType.label'),
('f666b50b-9e62-4d5d-8b60-eb65e22a207a',	'true',	'userinfo.token.claim'),
('f666b50b-9e62-4d5d-8b60-eb65e22a207a',	'nickname',	'user.attribute'),
('f666b50b-9e62-4d5d-8b60-eb65e22a207a',	'true',	'id.token.claim'),
('f666b50b-9e62-4d5d-8b60-eb65e22a207a',	'true',	'access.token.claim'),
('f666b50b-9e62-4d5d-8b60-eb65e22a207a',	'nickname',	'claim.name'),
('f666b50b-9e62-4d5d-8b60-eb65e22a207a',	'String',	'jsonType.label'),
('323115bd-b0fb-4d8e-8b5b-054be0ff1652',	'true',	'userinfo.token.claim'),
('323115bd-b0fb-4d8e-8b5b-054be0ff1652',	'username',	'user.attribute'),
('323115bd-b0fb-4d8e-8b5b-054be0ff1652',	'true',	'id.token.claim'),
('323115bd-b0fb-4d8e-8b5b-054be0ff1652',	'true',	'access.token.claim'),
('323115bd-b0fb-4d8e-8b5b-054be0ff1652',	'preferred_username',	'claim.name'),
('323115bd-b0fb-4d8e-8b5b-054be0ff1652',	'String',	'jsonType.label'),
('0adecc9e-5bbf-40a6-a04a-969db619ba5f',	'true',	'userinfo.token.claim'),
('0adecc9e-5bbf-40a6-a04a-969db619ba5f',	'profile',	'user.attribute'),
('0adecc9e-5bbf-40a6-a04a-969db619ba5f',	'true',	'id.token.claim'),
('0adecc9e-5bbf-40a6-a04a-969db619ba5f',	'true',	'access.token.claim'),
('0adecc9e-5bbf-40a6-a04a-969db619ba5f',	'profile',	'claim.name'),
('0adecc9e-5bbf-40a6-a04a-969db619ba5f',	'String',	'jsonType.label'),
('cdf9687d-4a9c-41c5-b41d-6393533f174e',	'true',	'userinfo.token.claim'),
('cdf9687d-4a9c-41c5-b41d-6393533f174e',	'picture',	'user.attribute'),
('cdf9687d-4a9c-41c5-b41d-6393533f174e',	'true',	'id.token.claim'),
('cdf9687d-4a9c-41c5-b41d-6393533f174e',	'true',	'access.token.claim'),
('cdf9687d-4a9c-41c5-b41d-6393533f174e',	'picture',	'claim.name'),
('cdf9687d-4a9c-41c5-b41d-6393533f174e',	'String',	'jsonType.label'),
('50c40927-0c53-4725-928a-71e2991b613a',	'true',	'userinfo.token.claim'),
('50c40927-0c53-4725-928a-71e2991b613a',	'website',	'user.attribute'),
('50c40927-0c53-4725-928a-71e2991b613a',	'true',	'id.token.claim'),
('50c40927-0c53-4725-928a-71e2991b613a',	'true',	'access.token.claim'),
('50c40927-0c53-4725-928a-71e2991b613a',	'website',	'claim.name'),
('50c40927-0c53-4725-928a-71e2991b613a',	'String',	'jsonType.label'),
('47ea36e9-aa4b-4fef-9a5c-221aba80651f',	'true',	'userinfo.token.claim'),
('47ea36e9-aa4b-4fef-9a5c-221aba80651f',	'gender',	'user.attribute'),
('47ea36e9-aa4b-4fef-9a5c-221aba80651f',	'true',	'id.token.claim'),
('47ea36e9-aa4b-4fef-9a5c-221aba80651f',	'true',	'access.token.claim'),
('47ea36e9-aa4b-4fef-9a5c-221aba80651f',	'gender',	'claim.name'),
('47ea36e9-aa4b-4fef-9a5c-221aba80651f',	'String',	'jsonType.label'),
('6d977eab-5628-44dc-b76c-a324fc352c88',	'true',	'userinfo.token.claim'),
('6d977eab-5628-44dc-b76c-a324fc352c88',	'birthdate',	'user.attribute'),
('6d977eab-5628-44dc-b76c-a324fc352c88',	'true',	'id.token.claim'),
('6d977eab-5628-44dc-b76c-a324fc352c88',	'true',	'access.token.claim'),
('6d977eab-5628-44dc-b76c-a324fc352c88',	'birthdate',	'claim.name'),
('6d977eab-5628-44dc-b76c-a324fc352c88',	'String',	'jsonType.label'),
('abe0e3aa-ba47-4e6e-96a0-cc01df2da4b4',	'true',	'userinfo.token.claim'),
('abe0e3aa-ba47-4e6e-96a0-cc01df2da4b4',	'zoneinfo',	'user.attribute'),
('abe0e3aa-ba47-4e6e-96a0-cc01df2da4b4',	'true',	'id.token.claim'),
('abe0e3aa-ba47-4e6e-96a0-cc01df2da4b4',	'true',	'access.token.claim'),
('abe0e3aa-ba47-4e6e-96a0-cc01df2da4b4',	'zoneinfo',	'claim.name'),
('abe0e3aa-ba47-4e6e-96a0-cc01df2da4b4',	'String',	'jsonType.label'),
('b8a1616b-79ff-4dad-86d6-5ee740ed9a7f',	'true',	'userinfo.token.claim'),
('b8a1616b-79ff-4dad-86d6-5ee740ed9a7f',	'locale',	'user.attribute'),
('b8a1616b-79ff-4dad-86d6-5ee740ed9a7f',	'true',	'id.token.claim'),
('b8a1616b-79ff-4dad-86d6-5ee740ed9a7f',	'true',	'access.token.claim'),
('b8a1616b-79ff-4dad-86d6-5ee740ed9a7f',	'locale',	'claim.name'),
('b8a1616b-79ff-4dad-86d6-5ee740ed9a7f',	'String',	'jsonType.label'),
('a016f6e1-3bd6-445a-8110-94c73fb7fc42',	'true',	'userinfo.token.claim'),
('a016f6e1-3bd6-445a-8110-94c73fb7fc42',	'updatedAt',	'user.attribute'),
('a016f6e1-3bd6-445a-8110-94c73fb7fc42',	'true',	'id.token.claim'),
('a016f6e1-3bd6-445a-8110-94c73fb7fc42',	'true',	'access.token.claim'),
('a016f6e1-3bd6-445a-8110-94c73fb7fc42',	'updated_at',	'claim.name'),
('a016f6e1-3bd6-445a-8110-94c73fb7fc42',	'String',	'jsonType.label'),
('3359edae-341c-4aee-8a7c-53a37c7e3d75',	'true',	'userinfo.token.claim'),
('3359edae-341c-4aee-8a7c-53a37c7e3d75',	'email',	'user.attribute'),
('3359edae-341c-4aee-8a7c-53a37c7e3d75',	'true',	'id.token.claim'),
('3359edae-341c-4aee-8a7c-53a37c7e3d75',	'true',	'access.token.claim'),
('3359edae-341c-4aee-8a7c-53a37c7e3d75',	'email',	'claim.name'),
('3359edae-341c-4aee-8a7c-53a37c7e3d75',	'String',	'jsonType.label'),
('e278377a-9ea5-4a68-b078-cd0da6a7f6bc',	'true',	'userinfo.token.claim'),
('e278377a-9ea5-4a68-b078-cd0da6a7f6bc',	'emailVerified',	'user.attribute'),
('e278377a-9ea5-4a68-b078-cd0da6a7f6bc',	'true',	'id.token.claim'),
('e278377a-9ea5-4a68-b078-cd0da6a7f6bc',	'true',	'access.token.claim'),
('e278377a-9ea5-4a68-b078-cd0da6a7f6bc',	'email_verified',	'claim.name'),
('e278377a-9ea5-4a68-b078-cd0da6a7f6bc',	'boolean',	'jsonType.label'),
('a049e3ab-c7e8-4d9c-818c-8143a728e4ad',	'formatted',	'user.attribute.formatted'),
('a049e3ab-c7e8-4d9c-818c-8143a728e4ad',	'country',	'user.attribute.country'),
('a049e3ab-c7e8-4d9c-818c-8143a728e4ad',	'postal_code',	'user.attribute.postal_code'),
('a049e3ab-c7e8-4d9c-818c-8143a728e4ad',	'true',	'userinfo.token.claim'),
('a049e3ab-c7e8-4d9c-818c-8143a728e4ad',	'street',	'user.attribute.street'),
('a049e3ab-c7e8-4d9c-818c-8143a728e4ad',	'true',	'id.token.claim'),
('a049e3ab-c7e8-4d9c-818c-8143a728e4ad',	'region',	'user.attribute.region'),
('a049e3ab-c7e8-4d9c-818c-8143a728e4ad',	'true',	'access.token.claim'),
('a049e3ab-c7e8-4d9c-818c-8143a728e4ad',	'locality',	'user.attribute.locality'),
('7d72b99b-063a-4b9f-aa2a-3b82403acae5',	'true',	'userinfo.token.claim'),
('7d72b99b-063a-4b9f-aa2a-3b82403acae5',	'phoneNumber',	'user.attribute'),
('7d72b99b-063a-4b9f-aa2a-3b82403acae5',	'true',	'id.token.claim'),
('7d72b99b-063a-4b9f-aa2a-3b82403acae5',	'true',	'access.token.claim'),
('7d72b99b-063a-4b9f-aa2a-3b82403acae5',	'phone_number',	'claim.name'),
('7d72b99b-063a-4b9f-aa2a-3b82403acae5',	'String',	'jsonType.label'),
('3d763e09-bf7f-4cd6-837e-691556185ae8',	'true',	'userinfo.token.claim'),
('3d763e09-bf7f-4cd6-837e-691556185ae8',	'phoneNumberVerified',	'user.attribute'),
('3d763e09-bf7f-4cd6-837e-691556185ae8',	'true',	'id.token.claim'),
('3d763e09-bf7f-4cd6-837e-691556185ae8',	'true',	'access.token.claim'),
('3d763e09-bf7f-4cd6-837e-691556185ae8',	'phone_number_verified',	'claim.name'),
('3d763e09-bf7f-4cd6-837e-691556185ae8',	'boolean',	'jsonType.label'),
('f10dafca-7f41-483e-bc0c-a98d18e5fb0d',	'true',	'multivalued'),
('f10dafca-7f41-483e-bc0c-a98d18e5fb0d',	'foo',	'user.attribute'),
('f10dafca-7f41-483e-bc0c-a98d18e5fb0d',	'true',	'access.token.claim'),
('f10dafca-7f41-483e-bc0c-a98d18e5fb0d',	'realm_access.roles',	'claim.name'),
('f10dafca-7f41-483e-bc0c-a98d18e5fb0d',	'String',	'jsonType.label'),
('723dee93-4f5a-41e2-99e3-f4940815dfd0',	'true',	'multivalued'),
('723dee93-4f5a-41e2-99e3-f4940815dfd0',	'foo',	'user.attribute'),
('723dee93-4f5a-41e2-99e3-f4940815dfd0',	'true',	'access.token.claim'),
('723dee93-4f5a-41e2-99e3-f4940815dfd0',	'resource_access.${client_id}.roles',	'claim.name'),
('723dee93-4f5a-41e2-99e3-f4940815dfd0',	'String',	'jsonType.label'),
('427a1c70-3fcb-44c0-b75e-ebe50657075d',	'true',	'userinfo.token.claim'),
('427a1c70-3fcb-44c0-b75e-ebe50657075d',	'username',	'user.attribute'),
('427a1c70-3fcb-44c0-b75e-ebe50657075d',	'true',	'id.token.claim'),
('427a1c70-3fcb-44c0-b75e-ebe50657075d',	'true',	'access.token.claim'),
('427a1c70-3fcb-44c0-b75e-ebe50657075d',	'upn',	'claim.name'),
('427a1c70-3fcb-44c0-b75e-ebe50657075d',	'String',	'jsonType.label'),
('cca7a2fa-4514-48d5-97a8-cdc599c9c8c0',	'true',	'multivalued'),
('cca7a2fa-4514-48d5-97a8-cdc599c9c8c0',	'foo',	'user.attribute'),
('cca7a2fa-4514-48d5-97a8-cdc599c9c8c0',	'true',	'id.token.claim'),
('cca7a2fa-4514-48d5-97a8-cdc599c9c8c0',	'true',	'access.token.claim'),
('cca7a2fa-4514-48d5-97a8-cdc599c9c8c0',	'groups',	'claim.name'),
('cca7a2fa-4514-48d5-97a8-cdc599c9c8c0',	'String',	'jsonType.label'),
('7cf29e89-5a00-430d-a79a-1af1405e5a81',	'clientId',	'user.session.note'),
('7cf29e89-5a00-430d-a79a-1af1405e5a81',	'true',	'id.token.claim'),
('7cf29e89-5a00-430d-a79a-1af1405e5a81',	'true',	'access.token.claim'),
('7cf29e89-5a00-430d-a79a-1af1405e5a81',	'clientId',	'claim.name'),
('7cf29e89-5a00-430d-a79a-1af1405e5a81',	'String',	'jsonType.label'),
('d7acd4cb-4a33-4098-a386-0ed7ee5dc9ce',	'clientHost',	'user.session.note'),
('d7acd4cb-4a33-4098-a386-0ed7ee5dc9ce',	'true',	'id.token.claim'),
('d7acd4cb-4a33-4098-a386-0ed7ee5dc9ce',	'true',	'access.token.claim'),
('d7acd4cb-4a33-4098-a386-0ed7ee5dc9ce',	'clientHost',	'claim.name'),
('d7acd4cb-4a33-4098-a386-0ed7ee5dc9ce',	'String',	'jsonType.label'),
('bbcea311-f30b-4700-b258-8c62a8f6373b',	'clientAddress',	'user.session.note'),
('bbcea311-f30b-4700-b258-8c62a8f6373b',	'true',	'id.token.claim'),
('bbcea311-f30b-4700-b258-8c62a8f6373b',	'true',	'access.token.claim'),
('bbcea311-f30b-4700-b258-8c62a8f6373b',	'clientAddress',	'claim.name'),
('bbcea311-f30b-4700-b258-8c62a8f6373b',	'String',	'jsonType.label'),
('e7241682-ac77-4b90-ae4f-041e60293ec7',	'false',	'single'),
('e7241682-ac77-4b90-ae4f-041e60293ec7',	'Basic',	'attribute.nameformat'),
('e7241682-ac77-4b90-ae4f-041e60293ec7',	'Role',	'attribute.name'),
('e66f7ab3-a8a3-4759-affc-3e08e0305cd8',	'true',	'userinfo.token.claim'),
('e66f7ab3-a8a3-4759-affc-3e08e0305cd8',	'true',	'id.token.claim'),
('e66f7ab3-a8a3-4759-affc-3e08e0305cd8',	'true',	'access.token.claim'),
('97fe6cad-38c7-48d5-be8e-aefc11c939a9',	'true',	'userinfo.token.claim'),
('97fe6cad-38c7-48d5-be8e-aefc11c939a9',	'lastName',	'user.attribute'),
('97fe6cad-38c7-48d5-be8e-aefc11c939a9',	'true',	'id.token.claim'),
('97fe6cad-38c7-48d5-be8e-aefc11c939a9',	'true',	'access.token.claim'),
('97fe6cad-38c7-48d5-be8e-aefc11c939a9',	'family_name',	'claim.name'),
('97fe6cad-38c7-48d5-be8e-aefc11c939a9',	'String',	'jsonType.label'),
('cbe09675-5623-4564-8600-31fd7e18a461',	'true',	'userinfo.token.claim'),
('cbe09675-5623-4564-8600-31fd7e18a461',	'firstName',	'user.attribute'),
('cbe09675-5623-4564-8600-31fd7e18a461',	'true',	'id.token.claim'),
('cbe09675-5623-4564-8600-31fd7e18a461',	'true',	'access.token.claim'),
('cbe09675-5623-4564-8600-31fd7e18a461',	'given_name',	'claim.name'),
('cbe09675-5623-4564-8600-31fd7e18a461',	'String',	'jsonType.label'),
('67318b3d-b74a-44d1-a31f-13e76b8fe8bb',	'true',	'userinfo.token.claim'),
('67318b3d-b74a-44d1-a31f-13e76b8fe8bb',	'middleName',	'user.attribute'),
('67318b3d-b74a-44d1-a31f-13e76b8fe8bb',	'true',	'id.token.claim'),
('67318b3d-b74a-44d1-a31f-13e76b8fe8bb',	'true',	'access.token.claim'),
('67318b3d-b74a-44d1-a31f-13e76b8fe8bb',	'middle_name',	'claim.name'),
('67318b3d-b74a-44d1-a31f-13e76b8fe8bb',	'String',	'jsonType.label'),
('24ccfb48-36aa-4695-8b89-35c140815749',	'true',	'userinfo.token.claim'),
('24ccfb48-36aa-4695-8b89-35c140815749',	'nickname',	'user.attribute'),
('24ccfb48-36aa-4695-8b89-35c140815749',	'true',	'id.token.claim'),
('24ccfb48-36aa-4695-8b89-35c140815749',	'true',	'access.token.claim'),
('24ccfb48-36aa-4695-8b89-35c140815749',	'nickname',	'claim.name'),
('24ccfb48-36aa-4695-8b89-35c140815749',	'String',	'jsonType.label'),
('d451c938-0c34-4e9d-96e7-9a8b34cecd20',	'true',	'userinfo.token.claim'),
('d451c938-0c34-4e9d-96e7-9a8b34cecd20',	'username',	'user.attribute'),
('d451c938-0c34-4e9d-96e7-9a8b34cecd20',	'true',	'id.token.claim'),
('d451c938-0c34-4e9d-96e7-9a8b34cecd20',	'true',	'access.token.claim'),
('d451c938-0c34-4e9d-96e7-9a8b34cecd20',	'preferred_username',	'claim.name'),
('d451c938-0c34-4e9d-96e7-9a8b34cecd20',	'String',	'jsonType.label'),
('5c0b27ab-b630-4855-ad00-082cb3383608',	'true',	'userinfo.token.claim'),
('5c0b27ab-b630-4855-ad00-082cb3383608',	'profile',	'user.attribute'),
('5c0b27ab-b630-4855-ad00-082cb3383608',	'true',	'id.token.claim'),
('5c0b27ab-b630-4855-ad00-082cb3383608',	'true',	'access.token.claim'),
('5c0b27ab-b630-4855-ad00-082cb3383608',	'profile',	'claim.name'),
('5c0b27ab-b630-4855-ad00-082cb3383608',	'String',	'jsonType.label'),
('1e7d8400-d9ad-4c11-9d0e-67f41061b375',	'true',	'userinfo.token.claim'),
('1e7d8400-d9ad-4c11-9d0e-67f41061b375',	'picture',	'user.attribute'),
('1e7d8400-d9ad-4c11-9d0e-67f41061b375',	'true',	'id.token.claim'),
('1e7d8400-d9ad-4c11-9d0e-67f41061b375',	'true',	'access.token.claim'),
('1e7d8400-d9ad-4c11-9d0e-67f41061b375',	'picture',	'claim.name'),
('1e7d8400-d9ad-4c11-9d0e-67f41061b375',	'String',	'jsonType.label'),
('3c9338c1-4a49-41fa-b9b5-ac6ac9aef1e8',	'true',	'userinfo.token.claim'),
('3c9338c1-4a49-41fa-b9b5-ac6ac9aef1e8',	'website',	'user.attribute'),
('3c9338c1-4a49-41fa-b9b5-ac6ac9aef1e8',	'true',	'id.token.claim'),
('3c9338c1-4a49-41fa-b9b5-ac6ac9aef1e8',	'true',	'access.token.claim'),
('3c9338c1-4a49-41fa-b9b5-ac6ac9aef1e8',	'website',	'claim.name'),
('3c9338c1-4a49-41fa-b9b5-ac6ac9aef1e8',	'String',	'jsonType.label'),
('684bf142-5c03-417e-88b5-ec60d3b3a71a',	'true',	'userinfo.token.claim'),
('684bf142-5c03-417e-88b5-ec60d3b3a71a',	'gender',	'user.attribute'),
('684bf142-5c03-417e-88b5-ec60d3b3a71a',	'true',	'id.token.claim'),
('684bf142-5c03-417e-88b5-ec60d3b3a71a',	'true',	'access.token.claim'),
('684bf142-5c03-417e-88b5-ec60d3b3a71a',	'gender',	'claim.name'),
('684bf142-5c03-417e-88b5-ec60d3b3a71a',	'String',	'jsonType.label'),
('936bf49f-7fd1-4eb6-b66e-c33be4f7451f',	'true',	'userinfo.token.claim'),
('936bf49f-7fd1-4eb6-b66e-c33be4f7451f',	'birthdate',	'user.attribute'),
('936bf49f-7fd1-4eb6-b66e-c33be4f7451f',	'true',	'id.token.claim'),
('936bf49f-7fd1-4eb6-b66e-c33be4f7451f',	'true',	'access.token.claim'),
('936bf49f-7fd1-4eb6-b66e-c33be4f7451f',	'birthdate',	'claim.name'),
('936bf49f-7fd1-4eb6-b66e-c33be4f7451f',	'String',	'jsonType.label'),
('1272272a-1357-42d4-9d00-06d13ad8b758',	'true',	'userinfo.token.claim'),
('1272272a-1357-42d4-9d00-06d13ad8b758',	'zoneinfo',	'user.attribute'),
('1272272a-1357-42d4-9d00-06d13ad8b758',	'true',	'id.token.claim'),
('1272272a-1357-42d4-9d00-06d13ad8b758',	'true',	'access.token.claim'),
('1272272a-1357-42d4-9d00-06d13ad8b758',	'zoneinfo',	'claim.name'),
('1272272a-1357-42d4-9d00-06d13ad8b758',	'String',	'jsonType.label'),
('f89532bc-467a-4e61-b7be-b93bb093e437',	'true',	'userinfo.token.claim'),
('f89532bc-467a-4e61-b7be-b93bb093e437',	'locale',	'user.attribute'),
('f89532bc-467a-4e61-b7be-b93bb093e437',	'true',	'id.token.claim'),
('f89532bc-467a-4e61-b7be-b93bb093e437',	'true',	'access.token.claim'),
('f89532bc-467a-4e61-b7be-b93bb093e437',	'locale',	'claim.name'),
('f89532bc-467a-4e61-b7be-b93bb093e437',	'String',	'jsonType.label'),
('f5af2093-3150-4a01-945c-aefdd67f5a52',	'true',	'userinfo.token.claim'),
('f5af2093-3150-4a01-945c-aefdd67f5a52',	'updatedAt',	'user.attribute'),
('f5af2093-3150-4a01-945c-aefdd67f5a52',	'true',	'id.token.claim'),
('f5af2093-3150-4a01-945c-aefdd67f5a52',	'true',	'access.token.claim'),
('f5af2093-3150-4a01-945c-aefdd67f5a52',	'updated_at',	'claim.name'),
('f5af2093-3150-4a01-945c-aefdd67f5a52',	'String',	'jsonType.label'),
('8d9f9403-1b2b-411e-b00e-f19099b07986',	'true',	'userinfo.token.claim'),
('8d9f9403-1b2b-411e-b00e-f19099b07986',	'email',	'user.attribute'),
('8d9f9403-1b2b-411e-b00e-f19099b07986',	'true',	'id.token.claim'),
('8d9f9403-1b2b-411e-b00e-f19099b07986',	'true',	'access.token.claim'),
('8d9f9403-1b2b-411e-b00e-f19099b07986',	'email',	'claim.name'),
('8d9f9403-1b2b-411e-b00e-f19099b07986',	'String',	'jsonType.label'),
('d3ee0673-67ee-4e6a-8e51-cf9625aad9fd',	'true',	'userinfo.token.claim'),
('d3ee0673-67ee-4e6a-8e51-cf9625aad9fd',	'emailVerified',	'user.attribute'),
('d3ee0673-67ee-4e6a-8e51-cf9625aad9fd',	'true',	'id.token.claim'),
('d3ee0673-67ee-4e6a-8e51-cf9625aad9fd',	'true',	'access.token.claim'),
('d3ee0673-67ee-4e6a-8e51-cf9625aad9fd',	'email_verified',	'claim.name'),
('d3ee0673-67ee-4e6a-8e51-cf9625aad9fd',	'boolean',	'jsonType.label'),
('809a4179-ac83-4ce4-b057-4ea09ae586cf',	'formatted',	'user.attribute.formatted'),
('809a4179-ac83-4ce4-b057-4ea09ae586cf',	'country',	'user.attribute.country'),
('809a4179-ac83-4ce4-b057-4ea09ae586cf',	'postal_code',	'user.attribute.postal_code'),
('809a4179-ac83-4ce4-b057-4ea09ae586cf',	'true',	'userinfo.token.claim'),
('809a4179-ac83-4ce4-b057-4ea09ae586cf',	'street',	'user.attribute.street'),
('809a4179-ac83-4ce4-b057-4ea09ae586cf',	'true',	'id.token.claim'),
('809a4179-ac83-4ce4-b057-4ea09ae586cf',	'region',	'user.attribute.region'),
('809a4179-ac83-4ce4-b057-4ea09ae586cf',	'true',	'access.token.claim'),
('809a4179-ac83-4ce4-b057-4ea09ae586cf',	'locality',	'user.attribute.locality'),
('5864634a-8f11-4c2d-8e58-37e5af314225',	'true',	'userinfo.token.claim'),
('5864634a-8f11-4c2d-8e58-37e5af314225',	'phoneNumber',	'user.attribute'),
('5864634a-8f11-4c2d-8e58-37e5af314225',	'true',	'id.token.claim'),
('5864634a-8f11-4c2d-8e58-37e5af314225',	'true',	'access.token.claim'),
('5864634a-8f11-4c2d-8e58-37e5af314225',	'phone_number',	'claim.name'),
('5864634a-8f11-4c2d-8e58-37e5af314225',	'String',	'jsonType.label'),
('d7973974-b38a-405c-8e6d-ee7ceda78e9b',	'true',	'userinfo.token.claim'),
('d7973974-b38a-405c-8e6d-ee7ceda78e9b',	'phoneNumberVerified',	'user.attribute'),
('d7973974-b38a-405c-8e6d-ee7ceda78e9b',	'true',	'id.token.claim'),
('d7973974-b38a-405c-8e6d-ee7ceda78e9b',	'true',	'access.token.claim'),
('d7973974-b38a-405c-8e6d-ee7ceda78e9b',	'phone_number_verified',	'claim.name'),
('d7973974-b38a-405c-8e6d-ee7ceda78e9b',	'boolean',	'jsonType.label'),
('890bb8bd-7e54-46e9-98d0-b2f01365ab34',	'true',	'multivalued'),
('890bb8bd-7e54-46e9-98d0-b2f01365ab34',	'foo',	'user.attribute'),
('890bb8bd-7e54-46e9-98d0-b2f01365ab34',	'true',	'access.token.claim'),
('890bb8bd-7e54-46e9-98d0-b2f01365ab34',	'realm_access.roles',	'claim.name'),
('890bb8bd-7e54-46e9-98d0-b2f01365ab34',	'String',	'jsonType.label'),
('5404dcdb-e16c-4793-a041-12fbbf8c8979',	'true',	'multivalued'),
('5404dcdb-e16c-4793-a041-12fbbf8c8979',	'foo',	'user.attribute'),
('5404dcdb-e16c-4793-a041-12fbbf8c8979',	'true',	'access.token.claim'),
('5404dcdb-e16c-4793-a041-12fbbf8c8979',	'resource_access.${client_id}.roles',	'claim.name'),
('5404dcdb-e16c-4793-a041-12fbbf8c8979',	'String',	'jsonType.label'),
('20bd1cb2-e02b-4883-b7a0-4d9beba8d0d2',	'true',	'userinfo.token.claim'),
('20bd1cb2-e02b-4883-b7a0-4d9beba8d0d2',	'username',	'user.attribute'),
('20bd1cb2-e02b-4883-b7a0-4d9beba8d0d2',	'true',	'id.token.claim'),
('20bd1cb2-e02b-4883-b7a0-4d9beba8d0d2',	'true',	'access.token.claim'),
('20bd1cb2-e02b-4883-b7a0-4d9beba8d0d2',	'upn',	'claim.name'),
('20bd1cb2-e02b-4883-b7a0-4d9beba8d0d2',	'String',	'jsonType.label'),
('c61df69a-6a20-461e-ac84-ee7dbf0c88ca',	'true',	'multivalued'),
('c61df69a-6a20-461e-ac84-ee7dbf0c88ca',	'foo',	'user.attribute'),
('c61df69a-6a20-461e-ac84-ee7dbf0c88ca',	'true',	'id.token.claim'),
('c61df69a-6a20-461e-ac84-ee7dbf0c88ca',	'true',	'access.token.claim'),
('c61df69a-6a20-461e-ac84-ee7dbf0c88ca',	'groups',	'claim.name'),
('c61df69a-6a20-461e-ac84-ee7dbf0c88ca',	'String',	'jsonType.label'),
('233efc1d-5a8e-46b8-9c9e-3dff2913392c',	'true',	'userinfo.token.claim'),
('233efc1d-5a8e-46b8-9c9e-3dff2913392c',	'locale',	'user.attribute'),
('233efc1d-5a8e-46b8-9c9e-3dff2913392c',	'true',	'id.token.claim'),
('233efc1d-5a8e-46b8-9c9e-3dff2913392c',	'true',	'access.token.claim'),
('233efc1d-5a8e-46b8-9c9e-3dff2913392c',	'locale',	'claim.name'),
('233efc1d-5a8e-46b8-9c9e-3dff2913392c',	'String',	'jsonType.label'),
('2274e228-b1a2-4e5e-ba5e-9f2a278f4edf',	'clientId',	'user.session.note'),
('2274e228-b1a2-4e5e-ba5e-9f2a278f4edf',	'true',	'id.token.claim'),
('2274e228-b1a2-4e5e-ba5e-9f2a278f4edf',	'true',	'access.token.claim'),
('2274e228-b1a2-4e5e-ba5e-9f2a278f4edf',	'clientId',	'claim.name'),
('2274e228-b1a2-4e5e-ba5e-9f2a278f4edf',	'String',	'jsonType.label'),
('e2c4a504-7d90-4255-aed1-17b5809b6b8f',	'clientHost',	'user.session.note'),
('e2c4a504-7d90-4255-aed1-17b5809b6b8f',	'true',	'id.token.claim'),
('e2c4a504-7d90-4255-aed1-17b5809b6b8f',	'true',	'access.token.claim'),
('e2c4a504-7d90-4255-aed1-17b5809b6b8f',	'clientHost',	'claim.name'),
('e2c4a504-7d90-4255-aed1-17b5809b6b8f',	'String',	'jsonType.label'),
('9f82fecf-2dee-445f-8262-dcc680408cd6',	'clientAddress',	'user.session.note'),
('9f82fecf-2dee-445f-8262-dcc680408cd6',	'true',	'id.token.claim'),
('9f82fecf-2dee-445f-8262-dcc680408cd6',	'true',	'access.token.claim'),
('9f82fecf-2dee-445f-8262-dcc680408cd6',	'clientAddress',	'claim.name'),
('9f82fecf-2dee-445f-8262-dcc680408cd6',	'String',	'jsonType.label');

CREATE TABLE "public"."realm" (
    "id" character varying(36) NOT NULL,
    "access_code_lifespan" integer,
    "user_action_lifespan" integer,
    "access_token_lifespan" integer,
    "account_theme" character varying(255),
    "admin_theme" character varying(255),
    "email_theme" character varying(255),
    "enabled" boolean DEFAULT false NOT NULL,
    "events_enabled" boolean DEFAULT false NOT NULL,
    "events_expiration" bigint,
    "login_theme" character varying(255),
    "name" character varying(255),
    "not_before" integer,
    "password_policy" character varying(2550),
    "registration_allowed" boolean DEFAULT false NOT NULL,
    "remember_me" boolean DEFAULT false NOT NULL,
    "reset_password_allowed" boolean DEFAULT false NOT NULL,
    "social" boolean DEFAULT false NOT NULL,
    "ssl_required" character varying(255),
    "sso_idle_timeout" integer,
    "sso_max_lifespan" integer,
    "update_profile_on_soc_login" boolean DEFAULT false NOT NULL,
    "verify_email" boolean DEFAULT false NOT NULL,
    "master_admin_client" character varying(36),
    "login_lifespan" integer,
    "internationalization_enabled" boolean DEFAULT false NOT NULL,
    "default_locale" character varying(255),
    "reg_email_as_username" boolean DEFAULT false NOT NULL,
    "admin_events_enabled" boolean DEFAULT false NOT NULL,
    "admin_events_details_enabled" boolean DEFAULT false NOT NULL,
    "edit_username_allowed" boolean DEFAULT false NOT NULL,
    "otp_policy_counter" integer DEFAULT '0',
    "otp_policy_window" integer DEFAULT '1',
    "otp_policy_period" integer DEFAULT '30',
    "otp_policy_digits" integer DEFAULT '6',
    "otp_policy_alg" character varying(36) DEFAULT 'HmacSHA1',
    "otp_policy_type" character varying(36) DEFAULT 'totp',
    "browser_flow" character varying(36),
    "registration_flow" character varying(36),
    "direct_grant_flow" character varying(36),
    "reset_credentials_flow" character varying(36),
    "client_auth_flow" character varying(36),
    "offline_session_idle_timeout" integer DEFAULT '0',
    "revoke_refresh_token" boolean DEFAULT false NOT NULL,
    "access_token_life_implicit" integer DEFAULT '0',
    "login_with_email_allowed" boolean DEFAULT true NOT NULL,
    "duplicate_emails_allowed" boolean DEFAULT false NOT NULL,
    "docker_auth_flow" character varying(36),
    "refresh_token_max_reuse" integer DEFAULT '0',
    "allow_user_managed_access" boolean DEFAULT false NOT NULL,
    "sso_max_lifespan_remember_me" integer DEFAULT '0' NOT NULL,
    "sso_idle_timeout_remember_me" integer DEFAULT '0' NOT NULL,
    CONSTRAINT "constraint_4a" PRIMARY KEY ("id"),
    CONSTRAINT "uk_orvsdmla56612eaefiq6wl5oi" UNIQUE ("name")
) WITH (oids = false);

CREATE INDEX "idx_realm_master_adm_cli" ON "public"."realm" USING btree ("master_admin_client");

INSERT INTO "realm" ("id", "access_code_lifespan", "user_action_lifespan", "access_token_lifespan", "account_theme", "admin_theme", "email_theme", "enabled", "events_enabled", "events_expiration", "login_theme", "name", "not_before", "password_policy", "registration_allowed", "remember_me", "reset_password_allowed", "social", "ssl_required", "sso_idle_timeout", "sso_max_lifespan", "update_profile_on_soc_login", "verify_email", "master_admin_client", "login_lifespan", "internationalization_enabled", "default_locale", "reg_email_as_username", "admin_events_enabled", "admin_events_details_enabled", "edit_username_allowed", "otp_policy_counter", "otp_policy_window", "otp_policy_period", "otp_policy_digits", "otp_policy_alg", "otp_policy_type", "browser_flow", "registration_flow", "direct_grant_flow", "reset_credentials_flow", "client_auth_flow", "offline_session_idle_timeout", "revoke_refresh_token", "access_token_life_implicit", "login_with_email_allowed", "duplicate_emails_allowed", "docker_auth_flow", "refresh_token_max_reuse", "allow_user_managed_access", "sso_max_lifespan_remember_me", "sso_idle_timeout_remember_me") VALUES
('master',	60,	300,	60,	NULL,	NULL,	NULL,	't',	'f',	0,	NULL,	'master',	0,	NULL,	'f',	'f',	'f',	'f',	'EXTERNAL',	1800,	36000,	'f',	'f',	'c8a970d0-c9e9-4b80-b8a1-6055b483b181',	1800,	'f',	NULL,	'f',	'f',	'f',	'f',	0,	1,	30,	6,	'HmacSHA1',	'totp',	'5f343310-cd75-4dc3-b67c-dcd75479db08',	'6afcc42e-d31f-44fb-97a4-0bffe6205293',	'68da857b-5b86-4f93-a5d0-722560464526',	'23145558-40c0-489e-8388-93ef7811eb59',	'6694495f-dd73-496d-8c42-76e6275eac69',	2592000,	'f',	900,	't',	'f',	'018527cf-77fd-4855-ac41-c4298622d8ff',	0,	'f',	0,	0),
('r4dc10',	60,	300,	300,	NULL,	NULL,	NULL,	't',	't',	0,	NULL,	'r4dc10',	1677743221,	NULL,	'f',	'f',	'f',	'f',	'EXTERNAL',	1800,	36000,	'f',	'f',	'057cdf02-645c-4a7d-9749-61cb4b3ff850',	1800,	'f',	NULL,	'f',	'f',	'f',	'f',	0,	1,	30,	6,	'HmacSHA1',	'totp',	'12766784-2989-461c-a6a4-169948f8c64d',	'062dc398-10cc-4b67-a97d-90121698f988',	'9ed6060a-2309-411e-807c-843581a49f77',	'9ff5aaef-2144-4a8c-9e0e-4db89fbd5993',	'51648ab5-78e6-4293-be54-ac042cb75b7c',	2592000,	'f',	900,	't',	'f',	'2dc71bac-db0d-47af-985c-7909df2ddb26',	0,	'f',	0,	0);

CREATE TABLE "public"."realm_attribute" (
    "name" character varying(255) NOT NULL,
    "value" character varying(255),
    "realm_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_9" PRIMARY KEY ("name", "realm_id")
) WITH (oids = false);

CREATE INDEX "idx_realm_attr_realm" ON "public"."realm_attribute" USING btree ("realm_id");

INSERT INTO "realm_attribute" ("name", "value", "realm_id") VALUES
('_browser_header.contentSecurityPolicyReportOnly',	'',	'master'),
('_browser_header.xContentTypeOptions',	'nosniff',	'master'),
('_browser_header.xRobotsTag',	'none',	'master'),
('_browser_header.xFrameOptions',	'SAMEORIGIN',	'master'),
('_browser_header.contentSecurityPolicy',	'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';',	'master'),
('_browser_header.xXSSProtection',	'1; mode=block',	'master'),
('_browser_header.strictTransportSecurity',	'max-age=31536000; includeSubDomains',	'master'),
('bruteForceProtected',	'false',	'master'),
('permanentLockout',	'false',	'master'),
('maxFailureWaitSeconds',	'900',	'master'),
('minimumQuickLoginWaitSeconds',	'60',	'master'),
('waitIncrementSeconds',	'60',	'master'),
('quickLoginCheckMilliSeconds',	'1000',	'master'),
('maxDeltaTimeSeconds',	'43200',	'master'),
('failureFactor',	'30',	'master'),
('displayName',	'Keycloak',	'master'),
('displayNameHtml',	'<div class="kc-logo-text"><span>Keycloak</span></div>',	'master'),
('offlineSessionMaxLifespanEnabled',	'false',	'master'),
('offlineSessionMaxLifespan',	'5184000',	'master'),
('displayName',	'r4dc10',	'r4dc10'),
('bruteForceProtected',	'false',	'r4dc10'),
('permanentLockout',	'false',	'r4dc10'),
('maxFailureWaitSeconds',	'900',	'r4dc10'),
('minimumQuickLoginWaitSeconds',	'60',	'r4dc10'),
('waitIncrementSeconds',	'60',	'r4dc10'),
('quickLoginCheckMilliSeconds',	'1000',	'r4dc10'),
('maxDeltaTimeSeconds',	'43200',	'r4dc10'),
('failureFactor',	'30',	'r4dc10'),
('actionTokenGeneratedByAdminLifespan',	'43200',	'r4dc10'),
('actionTokenGeneratedByUserLifespan',	'300',	'r4dc10'),
('offlineSessionMaxLifespanEnabled',	'false',	'r4dc10'),
('offlineSessionMaxLifespan',	'5184000',	'r4dc10'),
('clientSessionIdleTimeout',	'0',	'r4dc10'),
('clientSessionMaxLifespan',	'0',	'r4dc10'),
('clientOfflineSessionIdleTimeout',	'0',	'r4dc10'),
('clientOfflineSessionMaxLifespan',	'0',	'r4dc10'),
('webAuthnPolicyRpEntityName',	'keycloak',	'r4dc10'),
('webAuthnPolicySignatureAlgorithms',	'ES256',	'r4dc10'),
('webAuthnPolicyRpId',	'',	'r4dc10'),
('webAuthnPolicyAttestationConveyancePreference',	'not specified',	'r4dc10'),
('webAuthnPolicyAuthenticatorAttachment',	'not specified',	'r4dc10'),
('webAuthnPolicyRequireResidentKey',	'not specified',	'r4dc10'),
('webAuthnPolicyUserVerificationRequirement',	'not specified',	'r4dc10'),
('webAuthnPolicyCreateTimeout',	'0',	'r4dc10'),
('webAuthnPolicyAvoidSameAuthenticatorRegister',	'false',	'r4dc10'),
('webAuthnPolicyRpEntityNamePasswordless',	'keycloak',	'r4dc10'),
('webAuthnPolicySignatureAlgorithmsPasswordless',	'ES256',	'r4dc10'),
('webAuthnPolicyRpIdPasswordless',	'',	'r4dc10'),
('webAuthnPolicyAttestationConveyancePreferencePasswordless',	'not specified',	'r4dc10'),
('webAuthnPolicyAuthenticatorAttachmentPasswordless',	'not specified',	'r4dc10'),
('webAuthnPolicyRequireResidentKeyPasswordless',	'not specified',	'r4dc10'),
('webAuthnPolicyUserVerificationRequirementPasswordless',	'not specified',	'r4dc10'),
('webAuthnPolicyCreateTimeoutPasswordless',	'0',	'r4dc10'),
('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless',	'false',	'r4dc10'),
('_browser_header.contentSecurityPolicyReportOnly',	'',	'r4dc10'),
('_browser_header.xContentTypeOptions',	'nosniff',	'r4dc10'),
('_browser_header.xRobotsTag',	'none',	'r4dc10'),
('_browser_header.xFrameOptions',	'SAMEORIGIN',	'r4dc10'),
('_browser_header.contentSecurityPolicy',	'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';',	'r4dc10'),
('_browser_header.xXSSProtection',	'1; mode=block',	'r4dc10'),
('_browser_header.strictTransportSecurity',	'max-age=31536000; includeSubDomains',	'r4dc10');

CREATE TABLE "public"."realm_default_groups" (
    "realm_id" character varying(36) NOT NULL,
    "group_id" character varying(36) NOT NULL,
    CONSTRAINT "con_group_id_def_groups" UNIQUE ("group_id"),
    CONSTRAINT "constr_realm_default_groups" PRIMARY KEY ("realm_id", "group_id")
) WITH (oids = false);

CREATE INDEX "idx_realm_def_grp_realm" ON "public"."realm_default_groups" USING btree ("realm_id");


CREATE TABLE "public"."realm_default_roles" (
    "realm_id" character varying(36) NOT NULL,
    "role_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_realm_default_roles" PRIMARY KEY ("realm_id", "role_id"),
    CONSTRAINT "uk_h4wpd7w4hsoolni3h0sw7btje" UNIQUE ("role_id")
) WITH (oids = false);

CREATE INDEX "idx_realm_def_roles_realm" ON "public"."realm_default_roles" USING btree ("realm_id");

INSERT INTO "realm_default_roles" ("realm_id", "role_id") VALUES
('master',	'f45e30f7-8e89-48c2-a8d6-57e30bd1f549'),
('master',	'91e68ff8-b9bb-4c81-8ab9-9ecc4b80e9e3'),
('r4dc10',	'16e0c766-4ac4-4ce4-8b47-89fadf51313d'),
('r4dc10',	'6225b6bb-b45a-46a6-a666-3fbec676402a');

CREATE TABLE "public"."realm_enabled_event_types" (
    "realm_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constr_realm_enabl_event_types" PRIMARY KEY ("realm_id", "value")
) WITH (oids = false);

CREATE INDEX "idx_realm_evt_types_realm" ON "public"."realm_enabled_event_types" USING btree ("realm_id");

INSERT INTO "realm_enabled_event_types" ("realm_id", "value") VALUES
('r4dc10',	'UPDATE_CONSENT_ERROR'),
('r4dc10',	'SEND_RESET_PASSWORD'),
('r4dc10',	'GRANT_CONSENT'),
('r4dc10',	'UPDATE_TOTP'),
('r4dc10',	'REMOVE_TOTP'),
('r4dc10',	'REVOKE_GRANT'),
('r4dc10',	'LOGIN_ERROR'),
('r4dc10',	'CLIENT_LOGIN'),
('r4dc10',	'RESET_PASSWORD_ERROR'),
('r4dc10',	'IMPERSONATE_ERROR'),
('r4dc10',	'CODE_TO_TOKEN_ERROR'),
('r4dc10',	'CUSTOM_REQUIRED_ACTION'),
('r4dc10',	'RESTART_AUTHENTICATION'),
('r4dc10',	'UPDATE_PROFILE_ERROR'),
('r4dc10',	'IMPERSONATE'),
('r4dc10',	'LOGIN'),
('r4dc10',	'UPDATE_PASSWORD_ERROR'),
('r4dc10',	'CLIENT_INITIATED_ACCOUNT_LINKING'),
('r4dc10',	'TOKEN_EXCHANGE'),
('r4dc10',	'REGISTER'),
('r4dc10',	'LOGOUT'),
('r4dc10',	'CLIENT_REGISTER'),
('r4dc10',	'IDENTITY_PROVIDER_LINK_ACCOUNT'),
('r4dc10',	'UPDATE_PASSWORD'),
('r4dc10',	'FEDERATED_IDENTITY_LINK_ERROR'),
('r4dc10',	'CLIENT_DELETE'),
('r4dc10',	'IDENTITY_PROVIDER_FIRST_LOGIN'),
('r4dc10',	'VERIFY_EMAIL'),
('r4dc10',	'CLIENT_DELETE_ERROR'),
('r4dc10',	'CLIENT_LOGIN_ERROR'),
('r4dc10',	'RESTART_AUTHENTICATION_ERROR'),
('r4dc10',	'REMOVE_FEDERATED_IDENTITY_ERROR'),
('r4dc10',	'EXECUTE_ACTIONS'),
('r4dc10',	'TOKEN_EXCHANGE_ERROR'),
('r4dc10',	'PERMISSION_TOKEN'),
('r4dc10',	'SEND_IDENTITY_PROVIDER_LINK_ERROR'),
('r4dc10',	'EXECUTE_ACTION_TOKEN_ERROR'),
('r4dc10',	'SEND_VERIFY_EMAIL'),
('r4dc10',	'EXECUTE_ACTIONS_ERROR'),
('r4dc10',	'REMOVE_FEDERATED_IDENTITY'),
('r4dc10',	'IDENTITY_PROVIDER_POST_LOGIN'),
('r4dc10',	'IDENTITY_PROVIDER_LINK_ACCOUNT_ERROR'),
('r4dc10',	'UPDATE_EMAIL'),
('r4dc10',	'REGISTER_ERROR'),
('r4dc10',	'REVOKE_GRANT_ERROR'),
('r4dc10',	'LOGOUT_ERROR'),
('r4dc10',	'UPDATE_EMAIL_ERROR'),
('r4dc10',	'EXECUTE_ACTION_TOKEN'),
('r4dc10',	'CLIENT_UPDATE_ERROR'),
('r4dc10',	'UPDATE_PROFILE'),
('r4dc10',	'FEDERATED_IDENTITY_LINK'),
('r4dc10',	'CLIENT_REGISTER_ERROR'),
('r4dc10',	'SEND_VERIFY_EMAIL_ERROR'),
('r4dc10',	'SEND_IDENTITY_PROVIDER_LINK'),
('r4dc10',	'RESET_PASSWORD'),
('r4dc10',	'CLIENT_INITIATED_ACCOUNT_LINKING_ERROR'),
('r4dc10',	'UPDATE_CONSENT'),
('r4dc10',	'REMOVE_TOTP_ERROR'),
('r4dc10',	'VERIFY_EMAIL_ERROR'),
('r4dc10',	'SEND_RESET_PASSWORD_ERROR'),
('r4dc10',	'CLIENT_UPDATE'),
('r4dc10',	'IDENTITY_PROVIDER_POST_LOGIN_ERROR'),
('r4dc10',	'CUSTOM_REQUIRED_ACTION_ERROR'),
('r4dc10',	'UPDATE_TOTP_ERROR'),
('r4dc10',	'CODE_TO_TOKEN'),
('r4dc10',	'GRANT_CONSENT_ERROR'),
('r4dc10',	'IDENTITY_PROVIDER_FIRST_LOGIN_ERROR');

CREATE TABLE "public"."realm_events_listeners" (
    "realm_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constr_realm_events_listeners" PRIMARY KEY ("realm_id", "value")
) WITH (oids = false);

CREATE INDEX "idx_realm_evt_list_realm" ON "public"."realm_events_listeners" USING btree ("realm_id");

INSERT INTO "realm_events_listeners" ("realm_id", "value") VALUES
('master',	'jboss-logging'),
('r4dc10',	'jboss-logging');

CREATE TABLE "public"."realm_required_credential" (
    "type" character varying(255) NOT NULL,
    "form_label" character varying(255),
    "input" boolean DEFAULT false NOT NULL,
    "secret" boolean DEFAULT false NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_92" PRIMARY KEY ("realm_id", "type")
) WITH (oids = false);

INSERT INTO "realm_required_credential" ("type", "form_label", "input", "secret", "realm_id") VALUES
('password',	'password',	't',	't',	'master'),
('password',	'password',	't',	't',	'r4dc10');

CREATE TABLE "public"."realm_smtp_config" (
    "realm_id" character varying(36) NOT NULL,
    "value" character varying(255),
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_e" PRIMARY KEY ("realm_id", "name")
) WITH (oids = false);


CREATE TABLE "public"."realm_supported_locales" (
    "realm_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constr_realm_supported_locales" PRIMARY KEY ("realm_id", "value")
) WITH (oids = false);

CREATE INDEX "idx_realm_supp_local_realm" ON "public"."realm_supported_locales" USING btree ("realm_id");


CREATE TABLE "public"."redirect_uris" (
    "client_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constraint_redirect_uris" PRIMARY KEY ("client_id", "value")
) WITH (oids = false);

CREATE INDEX "idx_redir_uri_client" ON "public"."redirect_uris" USING btree ("client_id");

INSERT INTO "redirect_uris" ("client_id", "value") VALUES
('a6705522-6765-4697-851d-da311aa73ec2',	'/realms/master/account/*'),
('ff236875-1e2d-4681-941f-420e7c05ff64',	'/realms/master/account/*'),
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'/admin/master/console/*'),
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'http://localhost:80'),
('0c3ae588-fd06-4d48-9750-2e1c61ebde60',	'/realms/r4dc10/account/*'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'/realms/r4dc10/account/*'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'/admin/r4dc10/console/*'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'http://localhost:5000/*');

CREATE TABLE "public"."required_action_config" (
    "required_action_id" character varying(36) NOT NULL,
    "value" text,
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_req_act_cfg_pk" PRIMARY KEY ("required_action_id", "name")
) WITH (oids = false);


CREATE TABLE "public"."required_action_provider" (
    "id" character varying(36) NOT NULL,
    "alias" character varying(255),
    "name" character varying(255),
    "realm_id" character varying(36),
    "enabled" boolean DEFAULT false NOT NULL,
    "default_action" boolean DEFAULT false NOT NULL,
    "provider_id" character varying(255),
    "priority" integer,
    CONSTRAINT "constraint_req_act_prv_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_req_act_prov_realm" ON "public"."required_action_provider" USING btree ("realm_id");

INSERT INTO "required_action_provider" ("id", "alias", "name", "realm_id", "enabled", "default_action", "provider_id", "priority") VALUES
('c7ce7dd1-e8d6-4a9b-a39c-93e1cce3d56b',	'VERIFY_EMAIL',	'Verify Email',	'master',	't',	'f',	'VERIFY_EMAIL',	50),
('6bc07211-d17f-4f5a-a8ad-0c1122282294',	'UPDATE_PROFILE',	'Update Profile',	'master',	't',	'f',	'UPDATE_PROFILE',	40),
('e0f942c3-91bf-467c-bdc6-16dc677ca006',	'CONFIGURE_TOTP',	'Configure OTP',	'master',	't',	'f',	'CONFIGURE_TOTP',	10),
('e10d148e-ac85-48ed-ad6b-54cec0d5b364',	'UPDATE_PASSWORD',	'Update Password',	'master',	't',	'f',	'UPDATE_PASSWORD',	30),
('1ad38223-24c8-47a9-9e47-c35162a588af',	'terms_and_conditions',	'Terms and Conditions',	'master',	'f',	'f',	'terms_and_conditions',	20),
('b6f68230-3e45-45ab-81ef-3f829d710abb',	'update_user_locale',	'Update User Locale',	'master',	't',	'f',	'update_user_locale',	1000),
('59b21bf9-0daf-4be7-8637-63360fba84d1',	'VERIFY_EMAIL',	'Verify Email',	'r4dc10',	't',	'f',	'VERIFY_EMAIL',	50),
('8ad9cfd9-f01f-44b1-b868-8e0e674db143',	'UPDATE_PROFILE',	'Update Profile',	'r4dc10',	't',	'f',	'UPDATE_PROFILE',	40),
('4a8a0dbd-80b8-4726-817e-a6cef6d2e722',	'CONFIGURE_TOTP',	'Configure OTP',	'r4dc10',	't',	'f',	'CONFIGURE_TOTP',	10),
('11b57d5a-dad5-45ab-a6b0-e636b43f18d0',	'UPDATE_PASSWORD',	'Update Password',	'r4dc10',	't',	'f',	'UPDATE_PASSWORD',	30),
('025eb1ce-a0f3-4e24-b554-bca341658659',	'terms_and_conditions',	'Terms and Conditions',	'r4dc10',	'f',	'f',	'terms_and_conditions',	20),
('6ec7b310-f115-48ea-8877-d6c6e7de9c82',	'update_user_locale',	'Update User Locale',	'r4dc10',	't',	'f',	'update_user_locale',	1000);

CREATE TABLE "public"."resource_attribute" (
    "id" character varying(36) DEFAULT 'sybase-needs-something-here' NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" character varying(255),
    "resource_id" character varying(36) NOT NULL,
    CONSTRAINT "res_attr_pk" PRIMARY KEY ("id")
) WITH (oids = false);


CREATE TABLE "public"."resource_policy" (
    "resource_id" character varying(36) NOT NULL,
    "policy_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_farsrpp" PRIMARY KEY ("resource_id", "policy_id")
) WITH (oids = false);

CREATE INDEX "idx_res_policy_policy" ON "public"."resource_policy" USING btree ("policy_id");


CREATE TABLE "public"."resource_scope" (
    "resource_id" character varying(36) NOT NULL,
    "scope_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_farsrsp" PRIMARY KEY ("resource_id", "scope_id")
) WITH (oids = false);

CREATE INDEX "idx_res_scope_scope" ON "public"."resource_scope" USING btree ("scope_id");


CREATE TABLE "public"."resource_server" (
    "id" character varying(36) NOT NULL,
    "allow_rs_remote_mgmt" boolean DEFAULT false NOT NULL,
    "policy_enforce_mode" character varying(15) NOT NULL,
    "decision_strategy" smallint DEFAULT '1' NOT NULL,
    CONSTRAINT "pk_resource_server" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "resource_server" ("id", "allow_rs_remote_mgmt", "policy_enforce_mode", "decision_strategy") VALUES
('6f27ed60-7ce0-490a-ab65-6e32912cffe0',	't',	'0',	1),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	't',	'0',	1);

CREATE TABLE "public"."resource_server_perm_ticket" (
    "id" character varying(36) NOT NULL,
    "owner" character varying(255) NOT NULL,
    "requester" character varying(255) NOT NULL,
    "created_timestamp" bigint NOT NULL,
    "granted_timestamp" bigint,
    "resource_id" character varying(36) NOT NULL,
    "scope_id" character varying(36),
    "resource_server_id" character varying(36) NOT NULL,
    "policy_id" character varying(36),
    CONSTRAINT "constraint_fapmt" PRIMARY KEY ("id"),
    CONSTRAINT "uk_frsr6t700s9v50bu18ws5pmt" UNIQUE ("owner", "requester", "resource_server_id", "resource_id", "scope_id")
) WITH (oids = false);


CREATE TABLE "public"."resource_server_policy" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "description" character varying(255),
    "type" character varying(255) NOT NULL,
    "decision_strategy" character varying(20),
    "logic" character varying(20),
    "resource_server_id" character varying(36) NOT NULL,
    "owner" character varying(255),
    CONSTRAINT "constraint_farsrp" PRIMARY KEY ("id"),
    CONSTRAINT "uk_frsrpt700s9v50bu18ws5ha6" UNIQUE ("name", "resource_server_id")
) WITH (oids = false);

CREATE INDEX "idx_res_serv_pol_res_serv" ON "public"."resource_server_policy" USING btree ("resource_server_id");

INSERT INTO "resource_server_policy" ("id", "name", "description", "type", "decision_strategy", "logic", "resource_server_id", "owner") VALUES
('592c5f1c-ed21-414d-8648-eff224d3f5d2',	'Default Policy',	'A policy that grants access only for users within this realm',	'js',	'0',	'0',	'6f27ed60-7ce0-490a-ab65-6e32912cffe0',	NULL),
('ebe9b1e1-5e56-4382-a659-62f65cdd2611',	'Default Permission',	'A permission that applies to the default resource type',	'resource',	'1',	'0',	'6f27ed60-7ce0-490a-ab65-6e32912cffe0',	NULL),
('f96c1955-837b-4bd0-bf4e-c2590408df2f',	'Default Policy',	'A policy that grants access only for users within this realm',	'js',	'0',	'0',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	NULL),
('cced5405-8bfa-4b90-be5b-c9273cb9d5a6',	'Default Permission',	'A permission that applies to the default resource type',	'resource',	'1',	'0',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	NULL);

CREATE TABLE "public"."resource_server_resource" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "type" character varying(255),
    "icon_uri" character varying(255),
    "owner" character varying(255) NOT NULL,
    "resource_server_id" character varying(36) NOT NULL,
    "owner_managed_access" boolean DEFAULT false NOT NULL,
    "display_name" character varying(255),
    CONSTRAINT "constraint_farsr" PRIMARY KEY ("id"),
    CONSTRAINT "uk_frsr6t700s9v50bu18ws5ha6" UNIQUE ("name", "owner", "resource_server_id")
) WITH (oids = false);

CREATE INDEX "idx_res_srv_res_res_srv" ON "public"."resource_server_resource" USING btree ("resource_server_id");

INSERT INTO "resource_server_resource" ("id", "name", "type", "icon_uri", "owner", "resource_server_id", "owner_managed_access", "display_name") VALUES
('a9c81055-ee09-4a24-87c1-24ad30b5a78e',	'Default Resource',	'urn:tp4:resources:default',	NULL,	'6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'6f27ed60-7ce0-490a-ab65-6e32912cffe0',	'f',	NULL),
('68cfc3db-6a1b-42d6-8d17-cc51288bb876',	'Default Resource',	'urn:tp4:resources:default',	NULL,	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'f',	NULL);

CREATE TABLE "public"."resource_server_scope" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "icon_uri" character varying(255),
    "resource_server_id" character varying(36) NOT NULL,
    "display_name" character varying(255),
    CONSTRAINT "constraint_farsrs" PRIMARY KEY ("id"),
    CONSTRAINT "uk_frsrst700s9v50bu18ws5ha6" UNIQUE ("name", "resource_server_id")
) WITH (oids = false);

CREATE INDEX "idx_res_srv_scope_res_srv" ON "public"."resource_server_scope" USING btree ("resource_server_id");


CREATE TABLE "public"."resource_uris" (
    "resource_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constraint_resour_uris_pk" PRIMARY KEY ("resource_id", "value")
) WITH (oids = false);

INSERT INTO "resource_uris" ("resource_id", "value") VALUES
('a9c81055-ee09-4a24-87c1-24ad30b5a78e',	'/*'),
('68cfc3db-6a1b-42d6-8d17-cc51288bb876',	'/*');

CREATE TABLE "public"."role_attribute" (
    "id" character varying(36) NOT NULL,
    "role_id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" character varying(255),
    CONSTRAINT "constraint_role_attribute_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_role_attribute" ON "public"."role_attribute" USING btree ("role_id");


CREATE TABLE "public"."scope_mapping" (
    "client_id" character varying(36) NOT NULL,
    "role_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_81" PRIMARY KEY ("client_id", "role_id")
) WITH (oids = false);

CREATE INDEX "idx_scope_mapping_role" ON "public"."scope_mapping" USING btree ("role_id");

INSERT INTO "scope_mapping" ("client_id", "role_id") VALUES
('ff236875-1e2d-4681-941f-420e7c05ff64',	'c9a1686c-5044-49a0-9ce4-b29c241b52eb'),
('0fe28e08-8f06-4b65-835b-945b30ca3f6e',	'732c0f47-d6da-4e60-8616-a8c0cff622a5');

CREATE TABLE "public"."scope_policy" (
    "scope_id" character varying(36) NOT NULL,
    "policy_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_farsrsps" PRIMARY KEY ("scope_id", "policy_id")
) WITH (oids = false);

CREATE INDEX "idx_scope_policy_policy" ON "public"."scope_policy" USING btree ("policy_id");


CREATE TABLE "public"."user_attribute" (
    "name" character varying(255) NOT NULL,
    "value" character varying(255),
    "user_id" character varying(36) NOT NULL,
    "id" character varying(36) DEFAULT 'sybase-needs-something-here' NOT NULL,
    CONSTRAINT "constraint_user_attribute_pk" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_user_attribute" ON "public"."user_attribute" USING btree ("user_id");


CREATE TABLE "public"."user_consent" (
    "id" character varying(36) NOT NULL,
    "client_id" character varying(255),
    "user_id" character varying(36) NOT NULL,
    "created_date" bigint,
    "last_updated_date" bigint,
    "client_storage_provider" character varying(36),
    "external_client_id" character varying(255),
    CONSTRAINT "constraint_grntcsnt_pm" PRIMARY KEY ("id"),
    CONSTRAINT "uk_jkuwuvd56ontgsuhogm8uewrt" UNIQUE ("client_id", "client_storage_provider", "external_client_id", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_user_consent" ON "public"."user_consent" USING btree ("user_id");


CREATE TABLE "public"."user_consent_client_scope" (
    "user_consent_id" character varying(36) NOT NULL,
    "scope_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_grntcsnt_clsc_pm" PRIMARY KEY ("user_consent_id", "scope_id")
) WITH (oids = false);

CREATE INDEX "idx_usconsent_clscope" ON "public"."user_consent_client_scope" USING btree ("user_consent_id");


CREATE TABLE "public"."user_entity" (
    "id" character varying(36) NOT NULL,
    "email" character varying(255),
    "email_constraint" character varying(255),
    "email_verified" boolean DEFAULT false NOT NULL,
    "enabled" boolean DEFAULT false NOT NULL,
    "federation_link" character varying(255),
    "first_name" character varying(255),
    "last_name" character varying(255),
    "realm_id" character varying(255),
    "username" character varying(255),
    "created_timestamp" bigint,
    "service_account_client_link" character varying(255),
    "not_before" integer DEFAULT '0' NOT NULL,
    CONSTRAINT "constraint_fb" PRIMARY KEY ("id"),
    CONSTRAINT "uk_dykn684sl8up1crfei6eckhd7" UNIQUE ("realm_id", "email_constraint"),
    CONSTRAINT "uk_ru8tt6t700s9v50bu18ws5ha6" UNIQUE ("realm_id", "username")
) WITH (oids = false);

CREATE INDEX "idx_user_email" ON "public"."user_entity" USING btree ("email");

INSERT INTO "user_entity" ("id", "email", "email_constraint", "email_verified", "enabled", "federation_link", "first_name", "last_name", "realm_id", "username", "created_timestamp", "service_account_client_link", "not_before") VALUES
('81991cd4-c1bc-46ab-947e-3110e09638f2',	NULL,	'b6b6f372-73aa-4a26-8ca8-8fb5ce76aeba',	'f',	't',	NULL,	NULL,	NULL,	'master',	'admin',	1677607469383,	NULL,	0),
('a8559f87-4ada-46c8-9939-3f87e0d3bc50',	NULL,	'a0d40ab0-14b1-4461-bc72-a822ec1462df',	'f',	't',	NULL,	NULL,	NULL,	'master',	'service-account-tp4',	1677654760425,	'6f27ed60-7ce0-490a-ab65-6e32912cffe0',	0),
('4464a296-2424-4ea6-92e2-f73d31c04fb7',	NULL,	'2b7cbdd5-aa51-44d2-bc05-612c1fe86eca',	'f',	't',	NULL,	'Bob',	NULL,	'r4dc10',	'bob',	1677696129133,	NULL,	0),
('a6f35c53-8f7d-47da-a1f0-2a3f6e8bcabe',	NULL,	'aa2a1485-7546-4939-8c02-5440c6acb45a',	'f',	't',	NULL,	NULL,	NULL,	'r4dc10',	'service-account-tp4',	1677744142748,	'6b09bff7-97df-44d8-abb8-f0e8a983aa41',	0),
('ac6fcb40-fa9c-4bac-a027-e6c984ec800c',	'sam@univ-grenoble-alpes.fr',	'sam@univ-grenoble-alpes.fr',	'f',	't',	NULL,	'Sam',	NULL,	'r4dc10',	'sam',	1677696035415,	NULL,	0);

CREATE TABLE "public"."user_federation_config" (
    "user_federation_provider_id" character varying(36) NOT NULL,
    "value" character varying(255),
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_f9" PRIMARY KEY ("user_federation_provider_id", "name")
) WITH (oids = false);


CREATE TABLE "public"."user_federation_mapper" (
    "id" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "federation_provider_id" character varying(36) NOT NULL,
    "federation_mapper_type" character varying(255) NOT NULL,
    "realm_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_fedmapperpm" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_usr_fed_map_fed_prv" ON "public"."user_federation_mapper" USING btree ("federation_provider_id");

CREATE INDEX "idx_usr_fed_map_realm" ON "public"."user_federation_mapper" USING btree ("realm_id");


CREATE TABLE "public"."user_federation_mapper_config" (
    "user_federation_mapper_id" character varying(36) NOT NULL,
    "value" character varying(255),
    "name" character varying(255) NOT NULL,
    CONSTRAINT "constraint_fedmapper_cfg_pm" PRIMARY KEY ("user_federation_mapper_id", "name")
) WITH (oids = false);


CREATE TABLE "public"."user_federation_provider" (
    "id" character varying(36) NOT NULL,
    "changed_sync_period" integer,
    "display_name" character varying(255),
    "full_sync_period" integer,
    "last_sync" integer,
    "priority" integer,
    "provider_name" character varying(255),
    "realm_id" character varying(36),
    CONSTRAINT "constraint_5c" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "idx_usr_fed_prv_realm" ON "public"."user_federation_provider" USING btree ("realm_id");


CREATE TABLE "public"."user_group_membership" (
    "group_id" character varying(36) NOT NULL,
    "user_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_user_group" PRIMARY KEY ("group_id", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_user_group_mapping" ON "public"."user_group_membership" USING btree ("user_id");


CREATE TABLE "public"."user_required_action" (
    "user_id" character varying(36) NOT NULL,
    "required_action" character varying(255) DEFAULT ' ' NOT NULL,
    CONSTRAINT "constraint_required_action" PRIMARY KEY ("required_action", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_user_reqactions" ON "public"."user_required_action" USING btree ("user_id");


CREATE TABLE "public"."user_role_mapping" (
    "role_id" character varying(255) NOT NULL,
    "user_id" character varying(36) NOT NULL,
    CONSTRAINT "constraint_c" PRIMARY KEY ("role_id", "user_id")
) WITH (oids = false);

CREATE INDEX "idx_user_role_mapping" ON "public"."user_role_mapping" USING btree ("user_id");

INSERT INTO "user_role_mapping" ("role_id", "user_id") VALUES
('91e68ff8-b9bb-4c81-8ab9-9ecc4b80e9e3',	'81991cd4-c1bc-46ab-947e-3110e09638f2'),
('c9a1686c-5044-49a0-9ce4-b29c241b52eb',	'81991cd4-c1bc-46ab-947e-3110e09638f2'),
('f45e30f7-8e89-48c2-a8d6-57e30bd1f549',	'81991cd4-c1bc-46ab-947e-3110e09638f2'),
('ceba32d8-e9c6-4718-8aa2-bfb7cea43fc1',	'81991cd4-c1bc-46ab-947e-3110e09638f2'),
('46cf0cb2-6023-4282-889a-09dbf2407d6c',	'81991cd4-c1bc-46ab-947e-3110e09638f2'),
('91e68ff8-b9bb-4c81-8ab9-9ecc4b80e9e3',	'a8559f87-4ada-46c8-9939-3f87e0d3bc50'),
('c9a1686c-5044-49a0-9ce4-b29c241b52eb',	'a8559f87-4ada-46c8-9939-3f87e0d3bc50'),
('f45e30f7-8e89-48c2-a8d6-57e30bd1f549',	'a8559f87-4ada-46c8-9939-3f87e0d3bc50'),
('ceba32d8-e9c6-4718-8aa2-bfb7cea43fc1',	'a8559f87-4ada-46c8-9939-3f87e0d3bc50'),
('5214c02d-de88-476a-a8c9-c11c17f20f56',	'a8559f87-4ada-46c8-9939-3f87e0d3bc50'),
('16e0c766-4ac4-4ce4-8b47-89fadf51313d',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('6225b6bb-b45a-46a6-a666-3fbec676402a',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('16e0c766-4ac4-4ce4-8b47-89fadf51313d',	'4464a296-2424-4ea6-92e2-f73d31c04fb7'),
('6225b6bb-b45a-46a6-a666-3fbec676402a',	'4464a296-2424-4ea6-92e2-f73d31c04fb7'),
('16e0c766-4ac4-4ce4-8b47-89fadf51313d',	'a6f35c53-8f7d-47da-a1f0-2a3f6e8bcabe'),
('2ca65888-39b1-401f-8673-a2619db4ba61',	'a6f35c53-8f7d-47da-a1f0-2a3f6e8bcabe'),
('6225b6bb-b45a-46a6-a666-3fbec676402a',	'a6f35c53-8f7d-47da-a1f0-2a3f6e8bcabe'),
('732c0f47-d6da-4e60-8616-a8c0cff622a5',	'a6f35c53-8f7d-47da-a1f0-2a3f6e8bcabe'),
('c8531370-57ed-47e9-9b58-7c7a97d3796a',	'a6f35c53-8f7d-47da-a1f0-2a3f6e8bcabe'),
('24861f9b-55b9-44a3-b890-2da05c9b5088',	'ac6fcb40-fa9c-4bac-a027-e6c984ec800c'),
('6419a6c7-e23c-4ba2-8fe2-e9536079e63e',	'4464a296-2424-4ea6-92e2-f73d31c04fb7'),
('390a0acb-4976-4529-bdf3-bc9162f8c170',	'4464a296-2424-4ea6-92e2-f73d31c04fb7');

CREATE TABLE "public"."user_session" (
    "id" character varying(36) NOT NULL,
    "auth_method" character varying(255),
    "ip_address" character varying(255),
    "last_session_refresh" integer,
    "login_username" character varying(255),
    "realm_id" character varying(255),
    "remember_me" boolean DEFAULT false NOT NULL,
    "started" integer,
    "user_id" character varying(255),
    "user_session_state" integer,
    "broker_session_id" character varying(255),
    "broker_user_id" character varying(255),
    CONSTRAINT "constraint_57" PRIMARY KEY ("id")
) WITH (oids = false);


CREATE TABLE "public"."user_session_note" (
    "user_session" character varying(36) NOT NULL,
    "name" character varying(255) NOT NULL,
    "value" character varying(2048),
    CONSTRAINT "constraint_usn_pk" PRIMARY KEY ("user_session", "name")
) WITH (oids = false);


CREATE TABLE "public"."username_login_failure" (
    "realm_id" character varying(36) NOT NULL,
    "username" character varying(255) NOT NULL,
    "failed_login_not_before" integer,
    "last_failure" bigint,
    "last_ip_failure" character varying(255),
    "num_failures" integer,
    CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY ("realm_id", "username")
) WITH (oids = false);


CREATE TABLE "public"."web_origins" (
    "client_id" character varying(36) NOT NULL,
    "value" character varying(255) NOT NULL,
    CONSTRAINT "constraint_web_origins" PRIMARY KEY ("client_id", "value")
) WITH (oids = false);

CREATE INDEX "idx_web_orig_client" ON "public"."web_origins" USING btree ("client_id");

INSERT INTO "web_origins" ("client_id", "value") VALUES
('3a6b95ee-69dc-4f8a-aa40-e0e98349f1fe',	'+'),
('f858fcf6-fbe8-412b-b08e-5f6afa8e3478',	'+'),
('6b09bff7-97df-44d8-abb8-f0e8a983aa41',	'http://localhost:5000');

ALTER TABLE ONLY "public"."associated_policy" ADD CONSTRAINT "fk_frsr5s213xcx4wnkog82ssrfy" FOREIGN KEY (associated_policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."associated_policy" ADD CONSTRAINT "fk_frsrpas14xcx4wnkog82ssrfy" FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."authentication_execution" ADD CONSTRAINT "fk_auth_exec_flow" FOREIGN KEY (flow_id) REFERENCES authentication_flow(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."authentication_execution" ADD CONSTRAINT "fk_auth_exec_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."authentication_flow" ADD CONSTRAINT "fk_auth_flow_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."authenticator_config" ADD CONSTRAINT "fk_auth_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client" ADD CONSTRAINT "fk_p56ctinxxb9gsk57fo49f9tac" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_attributes" ADD CONSTRAINT "fk3c47c64beacca966" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_default_roles" ADD CONSTRAINT "fk_8aelwnibji49avxsrtuf6xjow" FOREIGN KEY (role_id) REFERENCES keycloak_role(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."client_default_roles" ADD CONSTRAINT "fk_nuilts7klwqw2h8m2b5joytky" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_initial_access" ADD CONSTRAINT "fk_client_init_acc_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_node_registrations" ADD CONSTRAINT "fk4129723ba992f594" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_scope" ADD CONSTRAINT "fk_realm_cli_scope" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_scope_attributes" ADD CONSTRAINT "fk_cl_scope_attr_scope" FOREIGN KEY (scope_id) REFERENCES client_scope(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_scope_client" ADD CONSTRAINT "fk_c_cli_scope_client" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."client_scope_client" ADD CONSTRAINT "fk_c_cli_scope_scope" FOREIGN KEY (scope_id) REFERENCES client_scope(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_scope_role_mapping" ADD CONSTRAINT "fk_cl_scope_rm_role" FOREIGN KEY (role_id) REFERENCES keycloak_role(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."client_scope_role_mapping" ADD CONSTRAINT "fk_cl_scope_rm_scope" FOREIGN KEY (scope_id) REFERENCES client_scope(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_session" ADD CONSTRAINT "fk_b4ao2vcvat6ukau74wbwtfqo1" FOREIGN KEY (session_id) REFERENCES user_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_session_auth_status" ADD CONSTRAINT "auth_status_constraint" FOREIGN KEY (client_session) REFERENCES client_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_session_note" ADD CONSTRAINT "fk5edfb00ff51c2736" FOREIGN KEY (client_session) REFERENCES client_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_session_prot_mapper" ADD CONSTRAINT "fk_33a8sgqw18i532811v7o2dk89" FOREIGN KEY (client_session) REFERENCES client_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_session_role" ADD CONSTRAINT "fk_11b7sgqw18i532811v7o2dv76" FOREIGN KEY (client_session) REFERENCES client_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."client_user_session_note" ADD CONSTRAINT "fk_cl_usr_ses_note" FOREIGN KEY (client_session) REFERENCES client_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."component" ADD CONSTRAINT "fk_component_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."component_config" ADD CONSTRAINT "fk_component_config" FOREIGN KEY (component_id) REFERENCES component(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."composite_role" ADD CONSTRAINT "fk_a63wvekftu8jo1pnj81e7mce2" FOREIGN KEY (composite) REFERENCES keycloak_role(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."composite_role" ADD CONSTRAINT "fk_gr7thllb9lu8q4vqa4524jjy8" FOREIGN KEY (child_role) REFERENCES keycloak_role(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."credential" ADD CONSTRAINT "fk_pfyr0glasqyl0dei3kl69r6v0" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."default_client_scope" ADD CONSTRAINT "fk_r_def_cli_scope_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."default_client_scope" ADD CONSTRAINT "fk_r_def_cli_scope_scope" FOREIGN KEY (scope_id) REFERENCES client_scope(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."federated_identity" ADD CONSTRAINT "fk404288b92ef007a6" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."group_attribute" ADD CONSTRAINT "fk_group_attribute_group" FOREIGN KEY (group_id) REFERENCES keycloak_group(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."group_role_mapping" ADD CONSTRAINT "fk_group_role_group" FOREIGN KEY (group_id) REFERENCES keycloak_group(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."group_role_mapping" ADD CONSTRAINT "fk_group_role_role" FOREIGN KEY (role_id) REFERENCES keycloak_role(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."identity_provider" ADD CONSTRAINT "fk2b4ebc52ae5c3b34" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."identity_provider_config" ADD CONSTRAINT "fkdc4897cf864c4e43" FOREIGN KEY (identity_provider_id) REFERENCES identity_provider(internal_id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."identity_provider_mapper" ADD CONSTRAINT "fk_idpm_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."idp_mapper_config" ADD CONSTRAINT "fk_idpmconfig" FOREIGN KEY (idp_mapper_id) REFERENCES identity_provider_mapper(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."keycloak_group" ADD CONSTRAINT "fk_group_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."keycloak_role" ADD CONSTRAINT "fk_6vyqfe4cn4wlq8r6kt5vdsj5c" FOREIGN KEY (realm) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."policy_config" ADD CONSTRAINT "fkdc34197cf864c4e43" FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."protocol_mapper" ADD CONSTRAINT "fk_cli_scope_mapper" FOREIGN KEY (client_scope_id) REFERENCES client_scope(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."protocol_mapper" ADD CONSTRAINT "fk_pcm_realm" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."protocol_mapper_config" ADD CONSTRAINT "fk_pmconfig" FOREIGN KEY (protocol_mapper_id) REFERENCES protocol_mapper(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."realm_attribute" ADD CONSTRAINT "fk_8shxd6l3e9atqukacxgpffptw" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."realm_default_groups" ADD CONSTRAINT "fk_def_groups_group" FOREIGN KEY (group_id) REFERENCES keycloak_group(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."realm_default_groups" ADD CONSTRAINT "fk_def_groups_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."realm_default_roles" ADD CONSTRAINT "fk_evudb1ppw84oxfax2drs03icc" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."realm_default_roles" ADD CONSTRAINT "fk_h4wpd7w4hsoolni3h0sw7btje" FOREIGN KEY (role_id) REFERENCES keycloak_role(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."realm_enabled_event_types" ADD CONSTRAINT "fk_h846o4h0w8epx5nwedrf5y69j" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."realm_events_listeners" ADD CONSTRAINT "fk_h846o4h0w8epx5nxev9f5y69j" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."realm_required_credential" ADD CONSTRAINT "fk_5hg65lybevavkqfki3kponh9v" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."realm_smtp_config" ADD CONSTRAINT "fk_70ej8xdxgxd0b9hh6180irr0o" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."realm_supported_locales" ADD CONSTRAINT "fk_supported_locales_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."redirect_uris" ADD CONSTRAINT "fk_1burs8pb4ouj97h5wuppahv9f" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."required_action_provider" ADD CONSTRAINT "fk_req_act_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."resource_attribute" ADD CONSTRAINT "fk_5hrm2vlf9ql5fu022kqepovbr" FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."resource_policy" ADD CONSTRAINT "fk_frsrpos53xcx4wnkog82ssrfy" FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."resource_policy" ADD CONSTRAINT "fk_frsrpp213xcx4wnkog82ssrfy" FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."resource_scope" ADD CONSTRAINT "fk_frsrpos13xcx4wnkog82ssrfy" FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."resource_scope" ADD CONSTRAINT "fk_frsrps213xcx4wnkog82ssrfy" FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."resource_server_perm_ticket" ADD CONSTRAINT "fk_frsrho213xcx4wnkog82sspmt" FOREIGN KEY (resource_server_id) REFERENCES resource_server(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."resource_server_perm_ticket" ADD CONSTRAINT "fk_frsrho213xcx4wnkog83sspmt" FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."resource_server_perm_ticket" ADD CONSTRAINT "fk_frsrho213xcx4wnkog84sspmt" FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."resource_server_perm_ticket" ADD CONSTRAINT "fk_frsrpo2128cx4wnkog82ssrfy" FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."resource_server_policy" ADD CONSTRAINT "fk_frsrpo213xcx4wnkog82ssrfy" FOREIGN KEY (resource_server_id) REFERENCES resource_server(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."resource_server_resource" ADD CONSTRAINT "fk_frsrho213xcx4wnkog82ssrfy" FOREIGN KEY (resource_server_id) REFERENCES resource_server(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."resource_server_scope" ADD CONSTRAINT "fk_frsrso213xcx4wnkog82ssrfy" FOREIGN KEY (resource_server_id) REFERENCES resource_server(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."resource_uris" ADD CONSTRAINT "fk_resource_server_uris" FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."role_attribute" ADD CONSTRAINT "fk_role_attribute_id" FOREIGN KEY (role_id) REFERENCES keycloak_role(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."scope_mapping" ADD CONSTRAINT "fk_ouse064plmlr732lxjcn1q5f1" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."scope_mapping" ADD CONSTRAINT "fk_p3rh9grku11kqfrs4fltt7rnq" FOREIGN KEY (role_id) REFERENCES keycloak_role(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."scope_policy" ADD CONSTRAINT "fk_frsrasp13xcx4wnkog82ssrfy" FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."scope_policy" ADD CONSTRAINT "fk_frsrpass3xcx4wnkog82ssrfy" FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."user_attribute" ADD CONSTRAINT "fk_5hrm2vlf9ql5fu043kqepovbr" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."user_consent" ADD CONSTRAINT "fk_grntcsnt_user" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."user_consent_client_scope" ADD CONSTRAINT "fk_grntcsnt_clsc_usc" FOREIGN KEY (user_consent_id) REFERENCES user_consent(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."user_federation_config" ADD CONSTRAINT "fk_t13hpu1j94r2ebpekr39x5eu5" FOREIGN KEY (user_federation_provider_id) REFERENCES user_federation_provider(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."user_federation_mapper" ADD CONSTRAINT "fk_fedmapperpm_fedprv" FOREIGN KEY (federation_provider_id) REFERENCES user_federation_provider(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."user_federation_mapper" ADD CONSTRAINT "fk_fedmapperpm_realm" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."user_federation_mapper_config" ADD CONSTRAINT "fk_fedmapper_cfg" FOREIGN KEY (user_federation_mapper_id) REFERENCES user_federation_mapper(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."user_federation_provider" ADD CONSTRAINT "fk_1fj32f6ptolw2qy60cd8n01e8" FOREIGN KEY (realm_id) REFERENCES realm(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."user_group_membership" ADD CONSTRAINT "fk_user_group_user" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."user_required_action" ADD CONSTRAINT "fk_6qj3w1jw9cvafhe19bwsiuvmd" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."user_role_mapping" ADD CONSTRAINT "fk_c4fqv34p1mbylloxang7b1q3l" FOREIGN KEY (user_id) REFERENCES user_entity(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."user_session_note" ADD CONSTRAINT "fk5edfb00ff51d3472" FOREIGN KEY (user_session) REFERENCES user_session(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."web_origins" ADD CONSTRAINT "fk_lojpho213xcx4wnkog82ssrfy" FOREIGN KEY (client_id) REFERENCES client(id) NOT DEFERRABLE;

-- 2023-03-03 16:22:55.711391+00