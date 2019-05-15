Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A53C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271E420843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X54YMTl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEOHyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:54:12 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:22405
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfEOHyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atuw0vm2vG5b5veSw8QMxIgSohixJ8N+8t5oMhh5Mek=;
 b=X54YMTl3wYmNwXYOJqoq99YmrtD1DBJIavOkUpt53zqYo6OPUiA0THAUPwLzYbCMNPB7qo2510D42McQTPgarAbfMHETss7bwNDHW9gpMH2zwsnA1GBVF0c6i4tg4tSboWR72SEziYkXQW5DQlUHhlyTMM7h42HtxD061Lzh4EI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4644.eurprd04.prod.outlook.com (52.135.149.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Wed, 15 May 2019 07:53:34 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 07:53:34 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
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
Subject: [PATCH V3 3/4] defconfig: arm64: enable i.MX8 SCU octop driver
Thread-Topic: [PATCH V3 3/4] defconfig: arm64: enable i.MX8 SCU octop driver
Thread-Index: AQHVCvNMhS1OyIt63E63UNMkVlEQZQ==
Date:   Wed, 15 May 2019 07:53:34 +0000
Message-ID: <20190515080703.19147-3-peng.fan@nxp.com>
References: <20190515080703.19147-1-peng.fan@nxp.com>
In-Reply-To: <20190515080703.19147-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15b5011e-b68b-4291-d7bf-08d6d90a6e51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4644;
x-ms-traffictypediagnostic: AM0PR04MB4644:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB4644E66B86EEC290F3BF386F88090@AM0PR04MB4644.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(99286004)(54906003)(256004)(110136005)(50226002)(478600001)(8936002)(14454004)(2501003)(66066001)(71190400001)(71200400001)(52116002)(102836004)(53936002)(7736002)(4326008)(305945005)(6506007)(81156014)(386003)(81166006)(25786009)(8676002)(6636002)(66476007)(66446008)(64756008)(76176011)(66946007)(73956011)(66556008)(486006)(3846002)(44832011)(476003)(6512007)(6436002)(2616005)(446003)(11346002)(68736007)(6486002)(186003)(7416002)(2906002)(6116002)(316002)(1076003)(36756003)(26005)(86362001)(5660300002)(2201001)(4744005)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4644;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gFTimrszKPlTjblWyhT+4KdGC4VERPvvCQ05cPRrYK+y3szh4jDK9sbsVfGLMEEUxWMCIHB09Zzx8It4m5uUU20FYZz2F/CljXCoPvAbnRMVE8aW0xIh8VA8Y7hYaoLA64STu0P4k3SWYz0q5zO7c0eJK1gB+8YktlNb9+Xqm9ZS07CvOacI+pVsUwEsJWO3e/7B7mNbD0vhiva8X6PGRSEZu9Bfu+bNsxsxBhmMZNwG8x4gLuj1JfB/R5L6xBuWAb7JfXs1wX75otIpY8IEU65z6tS021BxUYTxm17sirdt48mkICZRHboc1k7v1aQo3Q0f/k7cHA+RtAoSxPCEQWXPOiUdkZ+fj2HYouDk4M9jDkaZE1Y4VkMpXbbnoomurDpBV+42Zt+I2Cq+MMY6/n1RwlW9UqdyCp+xnotCKM8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b5011e-b68b-4291-d7bf-08d6d90a6e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 07:53:34.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4644
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
