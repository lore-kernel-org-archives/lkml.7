Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D846C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2011720873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kz0Gr+Dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfEOOmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:42:39 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:20292
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbfEOOmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMve6dwHHrqRGTtyS31i6HGfZ2Wfl1AM2fGbmNH9H2A=;
 b=Kz0Gr+DdwoZNfBlFb02N8e5EofjXgDLI7COny6p0V2XFMAyD5vPUKXDSowUpKULpvtI+GYQeGjWv43xNBjXPjbeERAXYD6RCts2mLQCcgil77kQ5of5manltrS19sqKSgtkmfqVTD4y9L3pJrzHhnrdCD0TVEgNj1mo+1rhqchA=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 14:42:29 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::888f:9ea:6f65:508f]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::888f:9ea:6f65:508f%6]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 14:42:29 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
Thread-Topic: [PATCH v3 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
Thread-Index: AQHVCyxr/1Fx7JEh8EGBF02px5rSJw==
Date:   Wed, 15 May 2019 14:42:29 +0000
Message-ID: <20190515144210.25596-3-daniel.baluta@nxp.com>
References: <20190515144210.25596-1-daniel.baluta@nxp.com>
In-Reply-To: <20190515144210.25596-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0094.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::23) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a9c0405-474e-4f81-2bfe-08d6d9438e44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2895;
x-ms-traffictypediagnostic: VI1PR0402MB2895:
x-microsoft-antispam-prvs: <VI1PR0402MB28953AAF14A7CD8747407D4CF9090@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(189003)(199004)(54906003)(5640700003)(6506007)(76176011)(6916009)(478600001)(6512007)(66446008)(14454004)(99286004)(102836004)(36756003)(52116002)(386003)(73956011)(66946007)(7416002)(3846002)(6116002)(64756008)(66476007)(66556008)(446003)(2616005)(476003)(11346002)(53936002)(316002)(486006)(44832011)(5660300002)(2351001)(71200400001)(71190400001)(1076003)(7736002)(26005)(305945005)(186003)(6486002)(86362001)(2501003)(4326008)(66066001)(25786009)(256004)(14444005)(68736007)(81166006)(8676002)(50226002)(81156014)(1730700003)(6436002)(2906002)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2895;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lFwqlPL5PI821QFOLcoHtpjPdeboZUbAnY81BswGHH267HX8YlTrx15W6f83gn5xs8HFMxXou0t8R3Sv0IYZZI6Oo3yCYe9lXfPdEdgw7othSFKDv7fLKzf++fliEBmVz0FJTNtfYzx53oZRo37IiKhI6ahB9IYzcYwr/s2FTkz+RjKBuatORJ195WtIzEdNHTRG3aiH3hox5JN8tZT8ci4FhECkEQnEQ7U/BLXVFZpk4S/FD4ZPc8ck21P7YG4jmzQwhBIzjRSx2rigp4mmJlnBF88KPoQquwHplswILkLiNtAb1+lCxibktyBSIpm8LItVyYJzMv3ul8pXUvhzzEaxHzLiVCELyvrqOCOqStFIJQ9CsAwHUjgwsHRj/NA5Ly6i+MIUHMNwNDzl3rrT13sehW5TaZvZE66ep+6zz9Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <127BF082BBC1824D9BA7AEC6678EAD49@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9c0405-474e-4f81-2bfe-08d6d9438e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 14:42:29.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MM has one wm8524 audio codec connected with
SAI3 digital audio interface.

This patch uses simple-card machine driver in order
to enable wm8524 codec.

We need to set:
	* SAI3 pinctrl configuration
	* codec reset gpio pinctrl configuration
	* clock hierarchy
	* codec node
	* simple-card configuration

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mm-evk.dts
index 2d5d89475b76..7c578d8762b9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -37,6 +37,37 @@
 		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	wm8524: audio-codec {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "wlf,wm8524";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_gpio_wlf>;
+		wlf,mute-gpios =3D <&gpio5 21 GPIO_ACTIVE_LOW>;
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
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai =3D <&sai3>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai =3D <&wm8524>;
+			clocks =3D <&clk IMX8MM_CLK_SAI3_ROOT>;
+		};
+	};
 };
=20
 &fec1 {
@@ -61,6 +92,15 @@
 	};
 };
=20
+&sai3 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_sai3>;
+	assigned-clocks =3D <&clk IMX8MM_CLK_SAI3>;
+	assigned-clock-parents =3D <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates =3D <24576000>;
+	status =3D "okay";
+};
+
 &uart2 { /* console */
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_uart2>;
@@ -124,12 +164,27 @@
 		>;
 	};
=20
+	pinctrl_gpio_wlf: gpiowlfgrp {
+		fsl,pins =3D <
+			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21        0xd6
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmc {
 		fsl,pins =3D <
 			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
 		>;
 	};
=20
+	pinctrl_sai3: sai3grp {
+		fsl,pins =3D <
+			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
+			MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
+			MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
+			MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins =3D <
 			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
--=20
2.17.1

