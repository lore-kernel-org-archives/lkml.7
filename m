Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1028C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B072070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FwFs2BZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfCZGxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:53:09 -0400
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]:3076
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730575AbfCZGxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwwyLMgPdoU7iJ7MYb+CHOLr8kh6mI4RWDFLgLJau2M=;
 b=FwFs2BZdyjdsLC0oSR9qffsDll/rDo+/6WZeNeUPysEBrZtCcFNBK6MsTp4qvmZB+iwuckfqomYHU7sQlIWL3X3wzvWeiej5ylhU1c3ZgDdsO2+RSc963yVpP2VUQZ+snr/bfQlLGCrco7PsiPGsY7TcFfs+WBAxd0ChAgCKy8M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 06:53:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 06:53:04 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V10 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Topic: [PATCH V10 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Index: AQHU46CPDjkUM/mAnUS9P5+23yFG+w==
Date:   Tue, 26 Mar 2019 06:53:04 +0000
Message-ID: <1553582817-29519-6-git-send-email-Anson.Huang@nxp.com>
References: <1553582817-29519-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1553582817-29519-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40500256-0735-4187-7d13-08d6b1b7b1ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-antispam-prvs: <DB3PR0402MB3850AA6E51555D4BE3F9B38BF55F0@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(7736002)(110136005)(2501003)(25786009)(476003)(2906002)(14444005)(97736004)(14454004)(256004)(486006)(71200400001)(8936002)(71190400001)(50226002)(6512007)(2616005)(4326008)(6116002)(186003)(5660300002)(7416002)(53936002)(66066001)(3846002)(316002)(6436002)(6486002)(106356001)(68736007)(26005)(11346002)(446003)(102836004)(478600001)(105586002)(305945005)(6506007)(386003)(52116002)(2201001)(76176011)(8676002)(81166006)(86362001)(36756003)(99286004)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qyq4fjekolUO5oVFhpLVqVINCfDztOgKZXhZcO5QyC9jv1ImCbgJg/RdDzWi5JwnynSajhdk8WLGEEvnGnLZ4HL4nkfZAriLv4qhuvG4e7FCjinWGizlYVlnW0VXQIZQ93mdz+vAPgXAf6AIdK9e+HPtAw8aqoA1+GputDGYi4APfirnyFVwFwwkjZm0f6IlV98bsfgg2ov0pxoFzplxeRL3Ed2YYRGMBxn/FaGxImE2WFCoLAB2HMOIUnFVUNHvb6QcYcm4BxrCTIXkUOQWE94bzbifyG693u520EwZmc8GsLp9x91XdKgIXCS6P3Fs/Cm0o7gvd4jZEMGN7jtATiQfNbdsUB5ktfywYyO9IAI6vtCSfq+RJp8pin2XLb/AMb2cfzqSAtILUhNS2qda2JR2Qs+JA+erMPvXTZub9SQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40500256-0735-4187-7d13-08d6b1b7b1ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 06:53:04.1549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds i.MX7ULP EVK board MIPI-DSI backlight support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V9:
	- update pwm label name accordingly.
---
 arch/arm/boot/dts/imx7ulp-evk.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-=
evk.dts
index a09026a..94891c7 100644
--- a/arch/arm/boot/dts/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
=20
 #include "imx7ulp.dtsi"
+#include <dt-bindings/pwm/pwm.h>
=20
 / {
 	model =3D "NXP i.MX7ULP EVK";
@@ -22,6 +23,14 @@
 		reg =3D <0x60000000 0x40000000>;
 	};
=20
+	backlight {
+		compatible =3D "pwm-backlight";
+		pwms =3D <&tpm4 1 50000 0>;
+		brightness-levels =3D <0 20 25 30 35 40 100>;
+		default-brightness-level =3D <6>;
+		status =3D "okay";
+	};
+
 	reg_vsd_3v3: regulator-vsd-3v3 {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "VSD_3V3";
@@ -40,6 +49,12 @@
 	status =3D "okay";
 };
=20
+&tpm4 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_pwm0>;
+	status =3D "okay";
+};
+
 &usdhc0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_usdhc0>;
@@ -57,6 +72,12 @@
 		bias-pull-up;
 	};
=20
+	pinctrl_pwm0: pwm0grp {
+		fsl,pins =3D <
+			IMX7ULP_PAD_PTF2__TPM4_CH1	0x2
+		>;
+	};
+
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins =3D <
 			IMX7ULP_PAD_PTD1__SDHC0_CMD	0x43
--=20
2.7.4

