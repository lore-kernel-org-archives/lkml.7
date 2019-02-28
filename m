Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8086F2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BbA5Eu6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbfB1Vm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:42:59 -0500
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:35150
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfB1Vmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayniLkqldnb7Y9ZHXcrFeOxI+yorFX6x48/SHkZBnuc=;
 b=BbA5Eu6X/5JSBmP0kTJlqQI6lRX6I+hU5Q59W/4oVyhxOtfFhYVFdt8YMIWZS8PvwPMhJbPCH8nxkJvu/mosjOeGaGHgJ5nmvr1GUcxg9uKhKx2vMe1bV6g8vYVTV5mEtffJF3YXRtRWdYbeX6uenCxwCq+mx/f16YCAEOUe6Jg=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5795.eurprd04.prod.outlook.com (20.178.118.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 21:42:45 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 21:42:45 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 2/3] arm64: dts: imx8mq: Add the buck vdd_arm regulator
Thread-Topic: [PATCH v3 2/3] arm64: dts: imx8mq: Add the buck vdd_arm
 regulator
Thread-Index: AQHUz66KhBgUt/ZhC0a5i8M3xPL7zw==
Date:   Thu, 28 Feb 2019 21:42:45 +0000
Message-ID: <1551390149-15443-3-git-send-email-abel.vesa@nxp.com>
References: <1551390149-15443-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1551390149-15443-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P194CA0012.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::22) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f5d6e1-fe73-40c6-4a72-08d69dc5acca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5795;
x-ms-traffictypediagnostic: AM0PR04MB5795:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5795;23:A9r126wi3e5+a2xPp7Bmn492PDrB6uxqaEm4jue?=
 =?iso-8859-1?Q?mOwc0zeRwWjAEs8rZZTNG0fpwnE9INwVPs2iY709MRx0i6Ju9TuK3sa+RF?=
 =?iso-8859-1?Q?sAgzTa3XVGfInV5jSEm+2d2S2gnFEYLgh2LgY1wOw8hX3jiqJxd2kraHC4?=
 =?iso-8859-1?Q?UO+ReOnyDlWUeLdQ8fgdcgF7qWpIXcGdLqHAeBCaJ4rgM6QWrwTK8JbxZT?=
 =?iso-8859-1?Q?6bEMT5GT54hZAOyMGq5naiUYckNu7TuA8jBX9H/w0KUCwYWFdzEpt5kMbv?=
 =?iso-8859-1?Q?iGdCV4Le+cyAhao8U2nANOREOyMGqMCME7b7nj3p/OZN7AZqcDnVVtIr6Z?=
 =?iso-8859-1?Q?8gQnH6bjALOXvjjI350CArTD3qUENR0Kh5cyMRxaVNSgz2V2TsoOaM8eg0?=
 =?iso-8859-1?Q?OAHtsSv7VWRaF5iGzI7SYIub+DrA214L5T1WCdvxdNtASa8EysIl9j6Gkh?=
 =?iso-8859-1?Q?moH4HmabDpOTsn7awQ5SpcSYENwQm5k1qaNaoL7V76Rpc0pRIZh2NKhwb2?=
 =?iso-8859-1?Q?akz+0FcU/e7+bgSBYjA6krvJwjW41pX+m6EpSPEgDVOc/xhMlOawUlqB9Z?=
 =?iso-8859-1?Q?gryKH7vKWOJ7P4kXK4m3oeqalk7bZb4o3hNsWaqGWDT7tmLUF43MUMNXlo?=
 =?iso-8859-1?Q?QGnsVvoQ4vT8dS42D1HQs2UeASROIro5r4JmheFtlWOXLSxaJEORyym8Lm?=
 =?iso-8859-1?Q?m6QqxvbCri+toYjo663FEcE43z57cQyJk4YkLWa2V1TQAPJXvf0vCAfS1q?=
 =?iso-8859-1?Q?v0EWX9GIH02e0OGsVzOZezsJhr7lM0aGNCsr/p3btpMqwmuOU0PALXhYlA?=
 =?iso-8859-1?Q?7GxIcTnt/wj0VVcCL1HulfC4bXH4K+8fRmNB73qgfpcQIReY/7QiKuw6+B?=
 =?iso-8859-1?Q?QX76xJGim5zJ6voKG0kkoYwFpfZ3wsZIC5gzlVgHxovW6bTVKwXvIix9OI?=
 =?iso-8859-1?Q?8QAMaVw4v2OkL1Ws9ISQD7J+oJ6rzUYleYP4nOy+MIcRq/sIw1KARrJ/Pg?=
 =?iso-8859-1?Q?IIWcxwDt1naA948iipVeqJcnpM8ntiiEwnQ4HVgX1jSMtT0YyGf++RLfNR?=
 =?iso-8859-1?Q?/0J5pbfZp+AsjSCf8s+HfaZACFYAVeZwqgaOD46oAqkl19YIX/SBMATkxm?=
 =?iso-8859-1?Q?P9bDCTQjEeFX6N5GQ4ERivz91NfHVqI3FHm811nOpdHPhSsjCj2LmizQ+V?=
 =?iso-8859-1?Q?12h2ZrnzP3rxAVIvRj4AN3ePGTYSeUZyU05xFM+ZrfNIv7LhQyTZWkoK1V?=
 =?iso-8859-1?Q?VbOIm31plf3TvIXE9nRBwTqNWx7k+XI4wuad52zN2FDkMFEUKYF7Gcssyc?=
 =?iso-8859-1?Q?e6Q3FUkGHmO9Kq7gRvtNBMt5re/6q+PNUZeliAG6LpnPaag5yT/xBOHolu?=
 =?iso-8859-1?Q?8JiECoF8=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB579529E3CDAFB0CA49378E17F6750@AM0PR04MB5795.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(25786009)(316002)(446003)(3846002)(2616005)(476003)(6436002)(110136005)(486006)(54906003)(44832011)(76176011)(106356001)(11346002)(99286004)(6486002)(105586002)(14454004)(102836004)(8936002)(68736007)(186003)(66066001)(26005)(36756003)(71190400001)(71200400001)(6512007)(5660300002)(50226002)(305945005)(53936002)(8676002)(7416002)(81166006)(81156014)(6116002)(2906002)(256004)(478600001)(386003)(7736002)(52116002)(86362001)(97736004)(6506007)(6636002)(4326008)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5795;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gr6zdoK7SZrtOZwHnol+CS+1T35Lg3O0Hd7EyI/SYkbLjIYp5X9IL/VASuQBfkdk8wXy8GvSXaW8A6mWEo0uoX7GWMUWn9C24F3C2fQ5BqDtf+t5Yph1M+P4fxgJqZbR50fxfGhzOhKMbwbXPamkZIXapzFtmSoFzOMr655PPcRpXsozwK/QMVvYrENS6EZsclNGvSQrZFS7t2YxxAp2CrJhuHdJZXItamQ+dtKDFcSyoEGEpskGfTzwJpkDrZuWeunhqRDDky5lQigvlXerxmcH/Lchojyql29y8hclGR1GleQDjBNrgkjIGLJ4LT1zl8sX7xOX4c6vq1nyNbpe8q6czEZjE41nW7OfzDD8up6uyUeE8gAdlD5CvJmmHfsAnQdr6Octm1gw1EvHPGlZzxSEDjuFmpqPrZ6SLC5LASA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f5d6e1-fe73-40c6-4a72-08d69dc5acca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 21:42:44.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the schematics, this is a MP2147 switch converter
which is controlled by GPIO1_IO13. When set the gpio is set to
high the regulator output is set to 0.9V. When the gpio is set
to low the regulator output is set to 1V.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 35 ++++++++++++++++++++++++=
++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 54737bf..afea110 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -31,6 +31,34 @@
 		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	buck2_reg: regulator-buck2 {
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_buck2>;
+		compatible =3D "regulator-gpio";
+		regulator-name =3D "vdd_arm";
+		regulator-min-microvolt =3D <900000>;
+		regulator-max-microvolt =3D <1000000>;
+		gpios =3D <&gpio1 13 GPIO_ACTIVE_HIGH>;
+		states =3D <1000000 0x0
+			  900000 0x1>;
+	};
+};
+
+&A53_0 {
+	cpu-supply =3D <&buck2_reg>;
+};
+
+&A53_1 {
+	cpu-supply =3D <&buck2_reg>;
+};
+
+&A53_2 {
+	cpu-supply =3D <&buck2_reg>;
+};
+
+&A53_3 {
+	cpu-supply =3D <&buck2_reg>;
 };
=20
 &fec1 {
@@ -203,6 +231,13 @@
 };
=20
 &iomuxc {
+	pinctrl_buck2: vddarmgrp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13		0x19
+		>;
+
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins =3D <
 			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
--=20
2.7.4

