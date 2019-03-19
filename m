Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065E9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38CB20863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FwERJQ8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfCSRsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:48:52 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:40659
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbfCSRsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6aSuDmOIyD8TfTuRd5cvoTwOP0X42DCZwY7jDA2Wo0=;
 b=FwERJQ8fc4y3nQYbSEtQbe3El+MTyWAc4QdPNBmTZ/cnh2LEgnE5ppxMTutEI4LemHn16qXZTnqKdBogMKJINqRKWNu8ZTMPNq8tRkGz8YyVXSlWAXxcmv9l7/DCkmIn7K5KgZcSST74+c/n6aLp0AyX7j4qzz+RysLdSOxaSoo=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1SPR01MB025.eurprd04.prod.outlook.com (52.134.2.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 17:48:41 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ddb1:9613:3e6d:eac5]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ddb1:9613:3e6d:eac5%3]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 17:48:41 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
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
Subject: [PATCH v7 4/4] arm64: dts: imx8mq-evk: Enable audio codec wm8524
Thread-Topic: [PATCH v7 4/4] arm64: dts: imx8mq-evk: Enable audio codec wm8524
Thread-Index: AQHU3nv9zNj885nj2EaiynwBXWQ+Ig==
Date:   Tue, 19 Mar 2019 17:48:41 +0000
Message-ID: <20190319174823.29467-5-daniel.baluta@nxp.com>
References: <20190319174823.29467-1-daniel.baluta@nxp.com>
In-Reply-To: <20190319174823.29467-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::16) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f6c66fe-fbb4-4aab-ab5d-08d6ac931fab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1SPR01MB025;
x-ms-traffictypediagnostic: VI1SPR01MB025:
x-microsoft-antispam-prvs: <VI1SPR01MB025E798C9554B3EBB5AC648F9400@VI1SPR01MB025.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(376002)(39860400002)(199004)(189003)(36756003)(8936002)(6506007)(102836004)(305945005)(52116002)(76176011)(6116002)(97736004)(26005)(2501003)(7736002)(68736007)(386003)(3846002)(99286004)(25786009)(476003)(486006)(2616005)(186003)(66066001)(44832011)(1076003)(106356001)(86362001)(50226002)(105586002)(2906002)(81166006)(81156014)(6436002)(11346002)(446003)(14454004)(6486002)(478600001)(6512007)(54906003)(53936002)(71190400001)(110136005)(316002)(256004)(8676002)(4326008)(5660300002)(71200400001)(7416002)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB025;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 00BLqQSLxiqbU+ZVPej2TTqw9l7OWSRuZjdyexopdYYvXHY4ThrwltFMGoYJsdg9HZltuIWR7F4lm/tIpPcRe2cf+su5jbZYq/hx5aW8A4WYy9LLjUdW4t57hHwivmw9XhjoLYZnSG+Go1C/2T9jpd8htdCHaEPJ0aNx4RqgJDyT+KSbV36fGt92zpAeH2379BOhxLlKbJ2q//qmkkw0SlMCS34Dbw1hVyOtX41RELIiYBZGrg0ahoNyxo5GcVGtnkaKNUki3xBiVCmX57AVIt1nSGaJJq4LKpo5xs40+bxxI7G+Y5iX/v0BU9tp92NNFNRI0plIJaAc7AX+DI6r7neniU0ssUTnQy5DXGfFQe/9jXWluDosc0IEHQher1GQEK0k9FSIZ5yo6KET7K2KNCs3kJRokRfIVmLOF7n3DX4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6c66fe-fbb4-4aab-ab5d-08d6ac931fab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 17:48:41.3209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main Audio DAC used on the EVK board is wm8524
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
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 48 ++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index afea110b70a3..304c28034ddf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -43,6 +43,35 @@
 		states =3D <1000000 0x0
 			  900000 0x1>;
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
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai =3D <&sai2>;
+		};
+
+		link_codec: simple-audio-card,codec {
+			sound-dai =3D <&wm8524>;
+			clocks =3D <&clk IMX8MQ_CLK_SAI2_ROOT>;
+		};
+	};
 };
=20
 &A53_0 {
@@ -80,6 +109,15 @@
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
@@ -283,6 +321,16 @@
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
 	pinctrl_uart1: uart1grp {
 		fsl,pins =3D <
 			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
--=20
2.17.1

