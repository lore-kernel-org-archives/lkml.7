Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C00C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7952184E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UwcHju96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfEVBrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:47:40 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:44933
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727294AbfEVBrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atuw0vm2vG5b5veSw8QMxIgSohixJ8N+8t5oMhh5Mek=;
 b=UwcHju96Dc/eCnTv4vqJ1RBcuWGq6V3ffTp0+aySbVdWP9kgalTJ5eWoPUqA4NmY9m/lKSmhjxuZ0pnLFeSm4fDNM7B1gmjWoGMP4A2G+PeRTCq86IGRFzeHrabXxd/qQy7LSlnrhpUOXRKSoAd6I4UYRBZEAqlvgBZY3PgBA4E=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5954.eurprd04.prod.outlook.com (20.178.115.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Wed, 22 May 2019 01:47:05 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 01:47:05 +0000
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH V3 RESEND 3/4] defconfig: arm64: enable i.MX8 SCU octop driver
Thread-Topic: [PATCH V3 RESEND 3/4] defconfig: arm64: enable i.MX8 SCU octop
 driver
Thread-Index: AQHVEEBCaBd2PozlHEuFjnNzl2G7GA==
Date:   Wed, 22 May 2019 01:47:05 +0000
Message-ID: <20190522020040.30283-3-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 576187f7-f0c6-483e-480e-08d6de576491
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5954;
x-ms-traffictypediagnostic: AM0PR04MB5954:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB5954CBAE9B3BDD7A75EA9EE888000@AM0PR04MB5954.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(44832011)(486006)(2501003)(186003)(305945005)(11346002)(446003)(476003)(2616005)(2906002)(76176011)(71190400001)(71200400001)(14454004)(52116002)(99286004)(256004)(102836004)(26005)(6116002)(3846002)(6506007)(68736007)(386003)(498600001)(5660300002)(54906003)(110136005)(6512007)(6486002)(50226002)(4326008)(66066001)(25786009)(6436002)(53936002)(2201001)(8676002)(8936002)(81166006)(81156014)(4744005)(73956011)(66946007)(86362001)(66476007)(66556008)(64756008)(66446008)(1076003)(7416002)(36756003)(7736002)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5954;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2YL9Cs0Nu9wjShkxVh3KufJVW6fTVMizwq5Ox/+ZvSHNEOL1UlQPEuvIFqDG9pJ8yZo/BkQwls4pY30g2nr8VnjDHP8VBvYFSuyQvfD6VMH9I/qDFemdfsURNj8bAbscOiPenS/UMK2nDU6BNT1jv86LpUcgq8P6Aac9jmKxhN6psv8WmFbJbYQkGb0MaPFYsrIxaDzgqv6WO29e7sj72/eMBI9SXojWCtFsbkNmtzyFmqK/u/KnmCIZ/+BH/L0H+jyuHLZLMHzYxLj95ccEGB/k31vT+T52pFCzUKhKzXsU8Z/Kvy6YBFsgbo3u6xbwXhnmr/r0oNWBZG2rFWgCO/XL2g3kHhGbplcuXbNyZ8G2LsaVRPZPJSZNBzKhwJdAjH7JyWKTpbFOBvlo+jfnjPOCQxIr/Dzzbirc4OAk1vE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576187f7-f0c6-483e-480e-08d6de576491
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 01:47:05.5354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QnVpbGQgaW4gQ09ORklHX05WTUVNX0lNWF9PQ09UUF9TQ1UuDQoNCkNjOiBDYXRhbGluIE1hcmlu
YXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPg0KQ2M6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNv
bkBhcm0uY29tPg0KQ2M6IFNoYXduIEd1byA8c2hhd24uZ3VvQGxpbmFyby5vcmc+DQpDYzogQW5k
eSBHcm9zcyA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPg0KQ2M6IE1heGltZSBSaXBhcmQgPG1heGlt
ZS5yaXBhcmRAYm9vdGxpbi5jb20+DQpDYzogT2xvZiBKb2hhbnNzb24gPG9sb2ZAbGl4b20ubmV0
Pg0KQ2M6IEphZ2FuIFRla2kgPGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tPg0KQ2M6IEJqb3Ju
IEFuZGVyc3NvbiA8Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc+DQpDYzogTGVvbmFyZCBDcmVz
dGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCkNjOiBNYXJjIEdvbnphbGV6IDxtYXJjLncu
Z29uemFsZXpAZnJlZS5mcj4NCkNjOiBFbnJpYyBCYWxsZXRibyBpIFNlcnJhIDxlbnJpYy5iYWxs
ZXRib0Bjb2xsYWJvcmEuY29tPg0KQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCi0tLQ0KDQpWMzoNCiBO
byBjaGFuZ2UNClYyOg0KIHJlbmFtZSBwYXRjaCB0aXRsZSwgYWRkIHJldmlldyB0YWcNCg0KIGFy
Y2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgYi9h
cmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQppbmRleCA5NzlhOTVjOTE1YjYuLjMyYjg1MTAy
Yjg1NyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCisrKyBiL2Fy
Y2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcNCkBAIC03NDgsNiArNzQ4LDcgQEAgQ09ORklHX0hJ
U0lfUE1VPXkNCiBDT05GSUdfUUNPTV9MMl9QTVU9eQ0KIENPTkZJR19RQ09NX0wzX1BNVT15DQog
Q09ORklHX05WTUVNX0lNWF9PQ09UUD15DQorQ09ORklHX05WTUVNX0lNWF9PQ09UUF9TQ1U9eQ0K
IENPTkZJR19RQ09NX1FGUFJPTT15DQogQ09ORklHX1JPQ0tDSElQX0VGVVNFPXkNCiBDT05GSUdf
VU5JUEhJRVJfRUZVU0U9eQ0KLS0gDQoyLjE2LjQNCg0K
