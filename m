Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091F4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C410120684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YZxNePbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfCHMCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:02:54 -0500
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:15337
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfCHMCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjG+0k7Qow+0agG3gKHAsujYM4ULaatQT/oqcCPPYoc=;
 b=YZxNePbQEWjWSIpsRwkXYdPF9cR0pI0NWjcXdpbiNDCCfo862Mo3waBjNGtjVIkAvcxYiNBnFZpmBLuWnCNHpT0LGHqrHF/aSZovt5Vj/3EuZMcnqadEUdg3ktNVBl6HIqbTeqaBnVYftf4JtymQ3O++P1AA282lcfYNbXL0+S0=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3776.eurprd04.prod.outlook.com (52.134.15.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 12:02:28 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1686.019; Fri, 8 Mar 2019
 12:02:28 +0000
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
Subject: [PATCH v6 4/4] arm64: dts: imx8mq-evk: Enable audio codec wm8952
Thread-Topic: [PATCH v6 4/4] arm64: dts: imx8mq-evk: Enable audio codec wm8952
Thread-Index: AQHU1abNCvGak2t96k+HL/cDqxo+9Q==
Date:   Fri, 8 Mar 2019 12:02:28 +0000
Message-ID: <20190308120141.3698-5-daniel.baluta@nxp.com>
References: <20190308120141.3698-1-daniel.baluta@nxp.com>
In-Reply-To: <20190308120141.3698-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0074.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::15) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa45062f-dca9-47b5-ec0a-08d6a3bdefa9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3776;
x-ms-traffictypediagnostic: VI1PR0402MB3776:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3776;23:1shrATQmfit/yk0bkkske2T1tH5U2v6eEtH3s?=
 =?iso-8859-1?Q?wVjLIPYGy5++42YVKkLx27yU33v4q4f6PQOSJ8UMZgPmGQO9iTUSde4UUX?=
 =?iso-8859-1?Q?XVGGVhJP3NWCeFhIf5WNP2zuXCOhGRptDAicrWtn5lwTWwNwGJ1k7hb7wi?=
 =?iso-8859-1?Q?ofgSyKgSwWoRw/rcrna370XyoX3VyImKN2DX6WzEOfwr9vyN3jICzc1Png?=
 =?iso-8859-1?Q?Op2Welq23KTo2IYpQvCCFo+hdjxdd+7KWvxZc6IhTtnWbsNiadFO+gECAI?=
 =?iso-8859-1?Q?qaHcBLJor6EZTV1TW09RAaJefSm3ys/60R4VTM9cvVr6H4bEh5sV1Fol+U?=
 =?iso-8859-1?Q?oQpNpRDHV0NWar3TpzsHuxUsAy2uxjYlONasBRolsyWpMvTjPEoczDpob3?=
 =?iso-8859-1?Q?Vc+UviBOQgdFXl5LWJEhMCoBaQJJA8fSXiZXkVkeZKI0HRdFh45sA/qtmS?=
 =?iso-8859-1?Q?b8ifounL0bVxD+PsB4o7hq9wkWICJH/lUe3oYMOftimfF5q6JZRDvIHQ4Z?=
 =?iso-8859-1?Q?p0HHtjlesDZdGxzq1ljBCVp8lNt7WXQxm4DWGdHwhZuVBfU+/iF/ch1q/I?=
 =?iso-8859-1?Q?bdPj1RoMSL8q0x5hMLxE6LmmveMM0mM2/4vh7mMmxpx3wU5/e2Uqmo88QT?=
 =?iso-8859-1?Q?XZ/zLg49RDkGGaMckU/fTwdDKRSKY5++kFCYd5g1dSoHEEWJsC/mNC5cSC?=
 =?iso-8859-1?Q?WbZy/I/pZd2bPVZLUrAC0yt4mBIVmVT6HInWotY+L4SrVyisvWWEWDk6p8?=
 =?iso-8859-1?Q?7ySC3nN32cTukUDzrYczOO0qG2MT416s26+nRdAKcj1rhF0x1nGQ23w0iM?=
 =?iso-8859-1?Q?U3xc8ofKDmIgmKJujpRO1ZW/VqaYOpMWL9bcR90cRYxbVGf4HEl9XdPcVx?=
 =?iso-8859-1?Q?x8cpWl3YIFVeeAwEg6dYNkBxYpQQM8ey251wRFTPlyMZu35LO6V70RJnwm?=
 =?iso-8859-1?Q?lmOHu57TjbAj0Kz898Ttx7AShtp7LOU7AZTPIcgCY8tcsK/GQej9DNuxYI?=
 =?iso-8859-1?Q?hkLIyTwrDSjzXhUD1jX7ezLCTZKr1oGWZppSUq4+2zJpY7YrsThoSt7DJa?=
 =?iso-8859-1?Q?N/5+SZjjrPWFESWsVlrvx+F80vfGuOjYa0PVoNEgwxgn6tNJr7U5WTPctB?=
 =?iso-8859-1?Q?omUKIr7jaJaH/uSeBfZT6j/ERKGZSgoP/gd2Yyoarak1QKwn2AkDywEBrO?=
 =?iso-8859-1?Q?YiZFevWIugPmPMro8wXv1KgR0LJErUYaGJ+noNC4VyNg6GeT6+wW5q9EOl?=
 =?iso-8859-1?Q?YUvYL2+zKc7OMahPmX2ryO69bpAdlQfD4IUNpnAlHc86aJdpK6dN5GxnQ+?=
 =?iso-8859-1?Q?YihTR5Hhp8um9rXwfCmFhktHiCbfKVY4e15cnjuQd1WSivo82QHr6oNIDr?=
 =?iso-8859-1?Q?1dopAy37JZ2LWG/8CZQEkCWss/JtiZ067ZVqT8HNWtBfccF9iAqkw=3D?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3776EE01EF6DC72BBCE50685F94D0@VI1PR0402MB3776.eurprd04.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(36756003)(52116002)(2906002)(68736007)(6436002)(25786009)(7736002)(478600001)(305945005)(105586002)(1076003)(14454004)(2351001)(81166006)(106356001)(256004)(6486002)(8676002)(8936002)(50226002)(6916009)(4326008)(102836004)(54906003)(3846002)(6506007)(26005)(66066001)(386003)(6116002)(316002)(486006)(1730700003)(81156014)(97736004)(44832011)(6512007)(476003)(186003)(446003)(7416002)(86362001)(5640700003)(11346002)(71200400001)(71190400001)(99286004)(2616005)(53936002)(2501003)(5660300002)(76176011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3776;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NZK5lAjCLy8anfQN/ooozBjxlJvLdmUa1kdqQQE8bS1IPwi+RPqRsBQkbxloYhP7uTf6t9QPv3PmC9OiWTcyG7Pe3o02R9hCBir8fk8kvimL8jRSQPO82AYgtGkXN+RCFjNrsB0NF6LwSUy+RQKwOEF4kDEov+9RXrMhZ1ZKdrZimrTh5JGECmr9rwBpAwdNM1itTgWwYaWF9Zzg+6IXdYHSsz1P9HCNV2bMMwGBaVn6cFbPl5xnN3202fhIOMG2b0aVrqk7E4HH8GYHkgTkngTzam3ZvubiXx4OWZFmKjQWM9tG0gSKT5CmV4cQ+G+gBIFAc+QyPVnJqXEuyNzjSYrq46IY+Ga5sKBPoa4v9+OwZdWbqyH0m9EZSSWWXqmE9jkh50tkI/uA8o7SCFChcvUU5RIT49Ejmdis0EZIAcM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa45062f-dca9-47b5-ec0a-08d6a3bdefa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 12:02:28.8023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main Audio DAC used on the EVK board is wm8952.
The EVK provides the MCLK to wm8952.

Digital interface is SAI2 which includes three signals:
SYNC_CLK, BCLK and DACDAT.

This patch sets:
	* SAI2 pinctrl configuration
	* clock hierarchy
	* wm8960 codec

Then uses simple-card machine driver to connect them
into a sound card.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 54737bf1772f..09000ee34757 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -31,6 +31,33 @@
 		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	wm8524: audio-codec {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "wlf,wm8524";
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
@@ -52,6 +79,15 @@
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
@@ -223,6 +259,16 @@
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

