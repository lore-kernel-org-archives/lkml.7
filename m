Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B03C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AB921019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iqLNf58T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEHC4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:56:17 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:6036
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfEHC4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9gvqt0XJdPSzj9E3jFStJCOm6RS90M2eRVKkjipMqw=;
 b=iqLNf58TBz/OE4diaLkd/IQ842minFhcOyX7NkCTEip4+dUS/wSvA1Qi0T0tG1BCloYZADB9pXbGFWdwanc2wWdxPvuQAsNLvAyRgjkiGcBQPGYe30ZQmX0jJlYKlySQO/G4usCU5i4PW0VIQ3AE83EZm1uGLCpwJHcQEheWXnQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5153.eurprd04.prod.outlook.com (20.177.40.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Wed, 8 May 2019 02:56:13 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 02:56:13 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: [PATCH V2 3/4] defconfig: arm64: enable i.MX8 SCU octop driver
Thread-Topic: [PATCH V2 3/4] defconfig: arm64: enable i.MX8 SCU octop driver
Thread-Index: AQHVBUmYMzQ7RIdxX0y7f2q2q1an2Q==
Date:   Wed, 8 May 2019 02:56:12 +0000
Message-ID: <20190508030927.16668-3-peng.fan@nxp.com>
References: <20190508030927.16668-1-peng.fan@nxp.com>
In-Reply-To: <20190508030927.16668-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0P153CA0028.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1121948-363f-4ca1-9717-08d6d360bae1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5153;
x-ms-traffictypediagnostic: AM0PR04MB5153:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB5153EA00CA8CE43950E399D288320@AM0PR04MB5153.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(26005)(1076003)(68736007)(66446008)(4744005)(14454004)(2501003)(66946007)(186003)(52116002)(305945005)(102836004)(7736002)(316002)(66556008)(64756008)(66476007)(53936002)(73956011)(25786009)(7416002)(50226002)(8936002)(5660300002)(4326008)(71190400001)(71200400001)(6512007)(478600001)(54906003)(110136005)(6116002)(76176011)(3846002)(2906002)(36756003)(81156014)(81166006)(8676002)(86362001)(2201001)(66066001)(6436002)(6486002)(446003)(11346002)(2616005)(256004)(6506007)(486006)(44832011)(386003)(99286004)(476003)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5153;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9waepFXsJHw5ZdqDNy2P/wlUr/ry4thFKBHc+fhoGi8HZo3b6LUxj/1TwRJAbAvK+9b1N6URCI7sLLPmdVvAhLhCeFNmanfgK4CSxYMTwBMPT1oHZDWIdcZ01BxN36Y1OkhfD6tCYG4xeo2ZG7+nMwHkU7QJJMwWQw/6WqNK1/VOqtRMjwWDgQt7ywtaJ14eX0j1gCF5v6cIchTQcRPIovgbIzsjzOv7HabFjx40npDMGkD434pFdvW9Nfgq1rIejta/W8wSshJIOnFPSVSHqbqYgSkM7C/9F3VyV5BM9wZOJDw/RGl80Y2yaCXMy+Mt1txlZZl5lCMKwcjX3I4cJ1AR9wxnG0Va1J6eZc36E69IcIbOWAdG/iJ5bvvm78aV3w0gvMPQLn4OGzfF3JuOKtug0Ji4Ng8rCRsMcZrVGsg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1121948-363f-4ca1-9717-08d6d360bae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 02:56:13.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5153
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
aWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCi0tLQ0KDQpWMjoNCiBy
ZW5hbWUgcGF0Y2ggdGl0bGUsIGFkZCByZXZpZXcgdGFnDQoNCiBhcmNoL2FybTY0L2NvbmZpZ3Mv
ZGVmY29uZmlnIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIGIvYXJjaC9hcm02NC9jb25maWdz
L2RlZmNvbmZpZw0KaW5kZXggZWIzMWMyMGU5OTE0Li45ZDhhNTEyZmMzZDUgMTAwNjQ0DQotLS0g
YS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQorKysgYi9hcmNoL2FybTY0L2NvbmZpZ3Mv
ZGVmY29uZmlnDQpAQCAtNzQ4LDYgKzc0OCw3IEBAIENPTkZJR19ISVNJX1BNVT15DQogQ09ORklH
X1FDT01fTDJfUE1VPXkNCiBDT05GSUdfUUNPTV9MM19QTVU9eQ0KIENPTkZJR19OVk1FTV9JTVhf
T0NPVFA9eQ0KK0NPTkZJR19OVk1FTV9JTVhfT0NPVFBfU0NVPXkNCiBDT05GSUdfUUNPTV9RRlBS
T009eQ0KIENPTkZJR19ST0NLQ0hJUF9FRlVTRT15DQogQ09ORklHX1VOSVBISUVSX0VGVVNFPXkN
Ci0tIA0KMi4xNi40DQoNCg==
