Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F646C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEA42173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dArcrniZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfEVBrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:47:43 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:44933
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728175AbfEVBrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeFKX+lnbRylikJpEHNU/WnUY8Eqh5Z3VPRC5oL+UFU=;
 b=dArcrniZsfPDLu7c6tf5WvKWRG7fUiDAU3zzIgNB6gn0hS0NY4kixNhJIeUgPNq0gIwtv6vlUox7MSMcUxXJv1zKErON52QBuAzuqX7SMUy3B0NKspzfZ+X+UrcqegeIYDjNUTOOjdsw3lN72EhGMAgewACkAIwL5jMY90KaDbQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5954.eurprd04.prod.outlook.com (20.178.115.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Wed, 22 May 2019 01:47:10 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 01:47:10 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH V3 RESEND 4/4] arm64: dts: imx: add i.MX8QXP ocotp support
Thread-Topic: [PATCH V3 RESEND 4/4] arm64: dts: imx: add i.MX8QXP ocotp
 support
Thread-Index: AQHVEEBFHYq4wRKGNkCe3grnXRuQgg==
Date:   Wed, 22 May 2019 01:47:10 +0000
Message-ID: <20190522020040.30283-4-peng.fan@nxp.com>
References: <20190522020040.30283-1-peng.fan@nxp.com>
In-Reply-To: <20190522020040.30283-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:36::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a4d938b-cb03-4b58-3720-08d6de57678e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5954;
x-ms-traffictypediagnostic: AM0PR04MB5954:
x-microsoft-antispam-prvs: <AM0PR04MB5954C2FCBCAD4A5F0C73EC8388000@AM0PR04MB5954.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(44832011)(486006)(2501003)(186003)(305945005)(11346002)(446003)(476003)(2616005)(2906002)(76176011)(71190400001)(71200400001)(14454004)(52116002)(99286004)(256004)(102836004)(26005)(6116002)(3846002)(6506007)(68736007)(386003)(498600001)(5660300002)(54906003)(110136005)(6512007)(6486002)(50226002)(4326008)(66066001)(25786009)(6436002)(53936002)(2201001)(8676002)(8936002)(81166006)(81156014)(4744005)(73956011)(66946007)(86362001)(66476007)(66556008)(64756008)(66446008)(1076003)(7416002)(36756003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5954;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rtOIy19y7rsOJdrC238H30DM4R/EGy/HgsgUqzEPm0G43t6u7Ghq2D5oW0I2nR4S5F61eG+RfOW0o/glDb+s1b+Ruf5FurJzJVxGFWs4VoBMNdnb7p/FAKpVCsknsUtRyoGsvgy7K0xpXPj9S8+vNWN8PW2RfPB4FPV6tFwVE9sjouKV2klfORuStpqR5XW0/ibnlT/pAoeRteuy//C8Nx6Nwv9KUXXYvTuqDmEFQ4OaY5DekL1zgTyZzhRARNpeBCz96VW4X/OCRGPWqUAcELGNMrUGJ63fDCIdT0zRAUo6UrLQGaCWMWY413cgsKFPXZezLldAoGG51PiuS1lVBUjXKris9dmWi2ECe9HxuMe7mRftUsvOF1StZm8QXgviyvPhmHz0ck42RbU/8oaxIzgxCuJbodWGVOY+ZBdwVzk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4d938b-cb03-4b58-3720-08d6de57678e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 01:47:10.5725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGkuTVg4UVhQIG9jb3RwIG5vZGUNCg0KQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+DQpDYzogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4NCkNjOiBTaGF3
biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQpDYzogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBl
bmd1dHJvbml4LmRlPg0KQ2M6IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0
cm9uaXguZGU+DQpDYzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KQ2M6IE5Y
UCBMaW51eCBUZWFtIDxsaW51eC1pbXhAbnhwLmNvbT4NCkNjOiBBbnNvbiBIdWFuZyA8YW5zb24u
aHVhbmdAbnhwLmNvbT4NCkNjOiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+
DQpDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPg0KU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQot
LS0NCg0KVjM6DQogQWRkIFItYiB0YWcNClYyOg0KIG1vdmUgYWRkcmVzcy9zaXplLWNlbGxzIGJl
bG93IGNvbXBhdGlibGUsIGFkZCAic2N1Ig0KDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OHF4cC5kdHNpIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhw
LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCmluZGV4
IDA2ODNlZTJhNDhhZS4uNzI1ZDM0MWVlMTYwIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4cXhwLmR0c2kNCkBAIC0xNDEsNiArMTQxLDEyIEBADQogCQkJY29tcGF0aWJs
ZSA9ICJmc2wsaW14OHF4cC1pb211eGMiOw0KIAkJfTsNCiANCisJCW9jb3RwOiBpbXg4cXgtb2Nv
dHAgew0KKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2N1LW9jb3RwIjsNCisJCQkjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCisJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCisJCX07DQorDQogCQlw
ZDogaW14OHF4LXBkIHsNCiAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjdS1wZCI7DQog
CQkJI3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwxPjsNCi0tIA0KMi4xNi40DQoNCg==
