Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB76C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB10206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mt5yQen0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfEEN2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:28:30 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:31475
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfEEN23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWOdS3wl2qiqbXznmAXeC9QirXsYQwvBZw0ozzFNLjA=;
 b=Mt5yQen0KLyiAmkiBXunFFCejACKrlJniyZWy3zux9pxvZFMt7q16719uhE3zQzOgQHj2C0zB+28nAwfJs5J2s22jYKjdC1Fk3SLnbbl4Bhr6hik3g+YCX7zX9wXV4s1px4PYNeTzlxJ1IpjK+HN9f/FmL6iFXh2ZWugEz97780=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4259.eurprd04.prod.outlook.com (52.134.126.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Sun, 5 May 2019 13:28:24 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 13:28:24 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
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
Subject: [PATCH 3/4] defconfig: arm64: enable i.MX8 nvmem driver
Thread-Topic: [PATCH 3/4] defconfig: arm64: enable i.MX8 nvmem driver
Thread-Index: AQHVA0Zq+beVlbBNaEGi+F3t9OPu2g==
Date:   Sun, 5 May 2019 13:28:24 +0000
Message-ID: <20190505134130.28071-3-peng.fan@nxp.com>
References: <20190505134130.28071-1-peng.fan@nxp.com>
In-Reply-To: <20190505134130.28071-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c22e852-ff8f-4934-81a6-08d6d15d8c8f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4259;
x-ms-traffictypediagnostic: AM0PR04MB4259:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB42592E031F645CABC0528AA688370@AM0PR04MB4259.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(366004)(346002)(189003)(199004)(486006)(54906003)(110136005)(68736007)(446003)(2906002)(11346002)(476003)(2616005)(8936002)(8676002)(66066001)(81166006)(7416002)(7736002)(305945005)(44832011)(53936002)(36756003)(50226002)(4326008)(25786009)(86362001)(2201001)(1076003)(4744005)(5660300002)(81156014)(52116002)(99286004)(76176011)(102836004)(316002)(6506007)(3846002)(6116002)(386003)(478600001)(256004)(6512007)(71200400001)(14454004)(6486002)(6436002)(2501003)(66946007)(73956011)(186003)(71190400001)(66446008)(26005)(66476007)(66556008)(64756008)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4259;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SpRktwC4t2dkCFZIIkX4Ksd4VhT8DebFCPyt55X+x6Qn0YNDv5MhzOW7+h6hxOFqBxGTnbQ5gpU/P+Kc9ijPZEx12yAmjboZFn7MMSqQ7vwCdzal5AJyAJHuCVT57FGCVo/KWzVc2VafRlwYwULjPkPgWGj8RzaIcQMp3BgkOCHCL1MSdNTbZcgLCwMLabQ9EJ+F6a4HB8MrjfaSdo1LrFotZXHPQNtNn8f2sjhYqKvSLjxIIZdgSFWo7utDjPSC+VlX4dbvjvFHpRVP+tQfRyfLPdomwqXKKgieM5m9z6dP2GxnYflMigBOsxb/Zi1cgmeOM4EJupQoNmL3uSz+RlD9Kh3IeWNPVSDEZ/NzPLbb7dcEIF1pBhutpzw1R0nR+GT3dkB5qfLNs/IaAWZ9hzMNgxWJfr9JsufL8PntKCA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c22e852-ff8f-4934-81a6-08d6d15d8c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 13:28:24.5709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QnVpbGQgaW4gQ09ORklHX05WTUVNX0lNWF9PQ09UUF9TQ1UuDQoNClNpZ25lZC1vZmYtYnk6IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KQ2M6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5t
YXJpbmFzQGFybS5jb20+DQpDYzogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+DQpD
YzogU2hhd24gR3VvIDxzaGF3bi5ndW9AbGluYXJvLm9yZz4NCkNjOiBBbmR5IEdyb3NzIDxhbmR5
Lmdyb3NzQGxpbmFyby5vcmc+DQpDYzogTWF4aW1lIFJpcGFyZCA8bWF4aW1lLnJpcGFyZEBib290
bGluLmNvbT4NCkNjOiBPbG9mIEpvaGFuc3NvbiA8b2xvZkBsaXhvbS5uZXQ+DQpDYzogSmFnYW4g
VGVraSA8amFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb20+DQpDYzogQmpvcm4gQW5kZXJzc29uIDxi
am9ybi5hbmRlcnNzb25AbGluYXJvLm9yZz4NCkNjOiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQu
Y3Jlc3RlekBueHAuY29tPg0KQ2M6IE1hcmMgR29uemFsZXogPG1hcmMudy5nb256YWxlekBmcmVl
LmZyPg0KQ2M6IEVucmljIEJhbGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxldGJvQGNvbGxhYm9y
YS5jb20+DQpDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQotLS0NCiBh
cmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIGIv
YXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KaW5kZXggZWIzMWMyMGU5OTE0Li45ZDhhNTEy
ZmMzZDUgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQorKysgYi9h
cmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQpAQCAtNzQ4LDYgKzc0OCw3IEBAIENPTkZJR19I
SVNJX1BNVT15DQogQ09ORklHX1FDT01fTDJfUE1VPXkNCiBDT05GSUdfUUNPTV9MM19QTVU9eQ0K
IENPTkZJR19OVk1FTV9JTVhfT0NPVFA9eQ0KK0NPTkZJR19OVk1FTV9JTVhfT0NPVFBfU0NVPXkN
CiBDT05GSUdfUUNPTV9RRlBST009eQ0KIENPTkZJR19ST0NLQ0hJUF9FRlVTRT15DQogQ09ORklH
X1VOSVBISUVSX0VGVVNFPXkNCi0tIA0KMi4xNi40DQoNCg==
