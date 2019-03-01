Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BA6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624AA20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="inGV9vSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbfCAQhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:37:21 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:54658
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728517AbfCAQhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cMcEAe4cGfX2xVIc5wvI4pEr7LwKkRv+GtyG6hvJO0=;
 b=inGV9vSEcUomM4o+mQNb8ATQsDkZT+J9SxL7DSyg/V7ze4Q7661jnaAHgmB4MjHzyYrm8jbLsbbsvZ2N4XxNnWayTmnBqF62rGXdKcSM8YCoYP+7rHiSWCdBG8RULWAZ4ecB1RED9p1NdSeeqtf8sGAs4M+Gf73SrpgkNT7cRB8=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3648.eurprd04.prod.outlook.com (52.134.14.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 1 Mar 2019 16:36:36 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 16:36:36 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v5 4/4] arm64: dts: imx8mq-evk: Enable audio codec wm8524
Thread-Topic: [PATCH v5 4/4] arm64: dts: imx8mq-evk: Enable audio codec wm8524
Thread-Index: AQHU0EzvmbmmBYzki0GfnU9Q6JIYFA==
Date:   Fri, 1 Mar 2019 16:36:36 +0000
Message-ID: <20190301163604.10618-5-daniel.baluta@nxp.com>
References: <20190301163604.10618-1-daniel.baluta@nxp.com>
In-Reply-To: <20190301163604.10618-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d786eef-b15c-49c7-4f54-08d69e641226
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3648;
x-ms-traffictypediagnostic: VI1PR0402MB3648:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3648;23:E3rGOw+5ALH8aeGPgUXb8EYdN4s08kOeJNoks?=
 =?iso-8859-1?Q?vrbsjASDnC7nNc0lcSaL3ikI4IIb6bJJsgb3qTElyYnMc6cZwEM0016RAu?=
 =?iso-8859-1?Q?FDnVhSGi0/ZZbjvR2Tvg9Eru03Zx5s9fxRyRbFjP5BqqIXa3ChEWIBSYI+?=
 =?iso-8859-1?Q?Y+OPXI7K71QQZirm1T5ZQaigPvV5I5o15NfLErEMXFJEL9dvUCDH14+vt1?=
 =?iso-8859-1?Q?F4wgthmPwkiDXlPyVHDK720X8e7XsAOxxe7/khbo7mWM/JxpYLnus0SsA5?=
 =?iso-8859-1?Q?Cam92M4nSw6HfHCkKArWmHbWXdhztIodxQQa2JdhyFCfFW2sADYmBYClI1?=
 =?iso-8859-1?Q?FjwxgvRbtMxOiB/9VQzUIfeIIuqIgdb8QJT4FVwwS2BbyG+mnqiID7B6tC?=
 =?iso-8859-1?Q?tK80fEu0aREP8Rlj6db0Y6J2aYx+86AW3UzsKrBacJnV0Jn3L7VpyiNUUq?=
 =?iso-8859-1?Q?SZ9znw8pKH5uRIi2rBV3OwYOd17r8wKG/SAGlcTOi5elw+IjPTXIOoeSLW?=
 =?iso-8859-1?Q?pFv9EQ6B75tcKx80PapKOyLpTNZobakapkXQ+ob9fztqgIGxdPLhtQIgMU?=
 =?iso-8859-1?Q?sIrONjoNsaEc+9wtuid7pRNrgMcly+aB39WzoKwv/ijC4OIZnUJz/EWS9L?=
 =?iso-8859-1?Q?8owaSqv3+P6FKdm9RQTAlmGtTgpDSbsUGJqpe53HuFCb9YiA1lVXR+xQ2x?=
 =?iso-8859-1?Q?rkIL1fzmWWM8i5t03Fit1BRzRL6CBKa4bnT2yp6KlfZs54C3Bb+GkUdgQi?=
 =?iso-8859-1?Q?RliVi9N93uSNi82icBWi0NvvnaBRmJaBANT7V4MFaxL5Bjj0WwVTg4xzPV?=
 =?iso-8859-1?Q?tHDNYHcBueeu/YSY+8luu+qWs9J9ZQLktNIUg/9L0UZhwopYAB6XVL70lY?=
 =?iso-8859-1?Q?Ssl6v5yja3wLve12XQ7WzaUycPM184R1AJf8INMrs2yAiHjNC+PNOC/Bh0?=
 =?iso-8859-1?Q?g+2kY3gcLAfjSRHTTkEZGU3dntweB1FudIxgX4h3MIAtJSLeLY9IseRPpA?=
 =?iso-8859-1?Q?zhgAGSFvAjv1zTBczgY5vxRjXEtnhtjxQk6HG1MqDjRJQXKk7nSRVMAz3c?=
 =?iso-8859-1?Q?4CqhJshX/KS9KQAbc4JJlx9ewyX2i/0jCL8f56+tYOMZPIK3GTaNw/thzE?=
 =?iso-8859-1?Q?4njKFLSWK8JYZ8Dp8U+R6FqFgU4B4Vz/1154fRmYTk+ruZtDQJ6EVWdQNo?=
 =?iso-8859-1?Q?29BHK0uv889IB0ufifE4c7DasIIRjOgmotP+QLDu+/aEtIFGdMzrQh22Yw?=
 =?iso-8859-1?Q?LQi2BtDjbI4s9alr8I0k86J7prtaVPnYUne4BOwEFWHDywb9ngoo0PmloK?=
 =?iso-8859-1?Q?HVnmzPeflBUFGuc2bzftmZJLCSV8des57GQ9+Ah+9xfIQ8tQ68TLz9NIdo?=
 =?iso-8859-1?Q?DpBlGYQtNlwBDcxodDm2Oxx5m4CYI17euGP2DLUGs/yEQPlp2Muvg=3D?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3648452D054993790C8D6A0EF9760@VI1PR0402MB3648.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(68736007)(478600001)(76176011)(6916009)(99286004)(386003)(53936002)(66066001)(52116002)(7416002)(4326008)(2501003)(14454004)(54906003)(6512007)(106356001)(2906002)(86362001)(316002)(105586002)(256004)(11346002)(6486002)(486006)(1730700003)(186003)(476003)(102836004)(8676002)(25786009)(81166006)(6116002)(2616005)(446003)(5640700003)(3846002)(97736004)(50226002)(26005)(8936002)(71190400001)(5660300002)(6436002)(305945005)(71200400001)(2351001)(6506007)(1076003)(44832011)(7736002)(36756003)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3648;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L+oMkyueosjEuTW7hgl0BiuPFS3hGsYOr4+O1Q8H3X29SCfKcXXN9G0ksJy16jtgTFy6Gs8U/BybAVxH2mEaYE8KsLzeEnqjvJCpETYR8VBe+aRpp796YUw4FIo87xL3mDoK3LzPF7pgcUW5VzUnZPpzoHWuCa649ddssKhaZWwi0e8RmzUtk0X3CImLRE0GmZHKHIw/4zogTq5v0El1vYHgFMiicYG5HnCaJPG4jIvb72XaGwC3by3d2uynR6xYLt6zlLK06q5x2BWnBFIvnCf5hE4MAyn6QjSVZtjDe/8vx46Tm55BqFod7CjeRtCaGxr0o/5n9hprlUCIT9zVlgbyE1PbB+TLrXr7bKAqdYiNcNkHZXD8qpYYwmFh3l/Kb7WBM0U9ZMv3ocKEiK/6ZMgnPR/WK2kRXRcVHqrVJxs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d786eef-b15c-49c7-4f54-08d69e641226
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 16:36:36.0644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main Audio DAC used on the EVK board is wm8524.
The EVK provides the MCLK to wm8524.

Digital interface is SAI2 which includes three signals:
SYNC_CLK, BCLK and DACDAT.

This patch sets:
	* SAI2 pinctrl configuration
	* clock hierarchy
	* wm8524 codec

Then uses simple-card machine driver to connect them
into a sound card.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 48 ++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 54737bf1772f..8666af6bea5b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -31,6 +31,35 @@
 		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	wm8524: audio-codec {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "wlf,wm8524";
+		clocks =3D <&clk IMX8MQ_CLK_SAI2_ROOT>;
+		clock-names =3D "mclk";
+		wlf,mute-gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
+	};
+
+	sound-wm8524 {
+		compatible =3D "simple-audio-card";
+		simple-audio-card,name =3D "wm8524-audio";
+		simple-audio-card,format =3D "i2s";
+		simple-audio-card,frame-master =3D <&cpudai>;
+		simple-audio-card,bitclock-master =3D <&cpudai>;
+		simple-audio-card,widgets =3D
+			"Line", "Left Line Out Jack",
+			"Line", "Right Line Out Jack";
+		simple-audio-card,routing =3D
+			"Left Line Out Jack", "LINEVOUTL",
+			"Right Line Out Jack", "LINEVOUTR";
+		cpudai: simple-audio-card,cpu {
+			sound-dai =3D <&sai2>;
+		};
+		link_codec: simple-audio-card,codec {
+			sound-dai =3D <&wm8524>;
+			clocks =3D <&clk IMX8MQ_CLK_SAI2_ROOT>;
+		};
+	};
 };
=20
 &fec1 {
@@ -52,6 +81,15 @@
 	};
 };
=20
+&sai2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_sai2>;
+	assigned-clocks =3D <&clk IMX8MQ_CLK_SAI2>;
+	assigned-clock-parents =3D <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates =3D <24576000>;
+	status =3D "okay";
+};
+
 &i2c1 {
 	clock-frequency =3D <100000>;
 	pinctrl-names =3D "default";
@@ -223,6 +261,16 @@
 		>;
 	};
=20
+	pinctrl_sai2: sai2grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
+			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
+			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK        0xd6
+			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
+			MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8       0xd6
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins =3D <
 			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
--=20
2.17.1

