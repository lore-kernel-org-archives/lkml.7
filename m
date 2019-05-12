Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4685C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2BF2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wd83byaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfELIvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 04:51:33 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:9437
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726430AbfELIvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 04:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGslpQFdmzOYZRuc+QNNiZRY7s/vagV8QZ1N93vi+F8=;
 b=Wd83byaOuHYsunzn68kIiML666zRsA+LY+mRL6/Aornym5vzZXS9AR7NBTItYzp2lMGZg2I+MVi1qHWR+f2I3uFZM2QSLntgLWUEnc+P+j/d4N9zIO538OakhC3eeWdvIfDc7oZlBd2KUAEhB3367RpbrDtPx4D0yDOydsE/4CI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Sun, 12 May 2019 08:51:27 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 08:51:26 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V12 RESEND 3/3] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Topic: [PATCH V12 RESEND 3/3] ARM: dts: imx7ulp-evk: Add backlight
 support
Thread-Index: AQHVCJ/ifLY3OCW5U06j5yvB8ikP1A==
Date:   Sun, 12 May 2019 08:51:26 +0000
Message-ID: <1557650772-11973-3-git-send-email-Anson.Huang@nxp.com>
References: <1557650772-11973-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557650772-11973-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c3c56eb-55dc-4af4-7d0c-08d6d6b70499
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB37398F6CA3EB3708DDFBD30BF50E0@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(966005)(36756003)(186003)(66556008)(476003)(66446008)(66946007)(66476007)(64756008)(486006)(14454004)(2501003)(66066001)(2906002)(446003)(11346002)(2616005)(256004)(73956011)(478600001)(4326008)(3846002)(6116002)(25786009)(26005)(102836004)(6436002)(7736002)(305945005)(53936002)(6506007)(386003)(6486002)(6512007)(6306002)(7416002)(2201001)(86362001)(316002)(110136005)(68736007)(81156014)(81166006)(8676002)(8936002)(50226002)(71190400001)(71200400001)(52116002)(99286004)(76176011)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dhiESdXTu8Ftw+LsE+GsZ1laEoSS7gKEptq5uv7jdt92rqinb0L+oqUWnnIRsQVeNIxCeON3nKh136rT9fjrGGdznKjLCnpM2wDsZ+L/DvVG1Kiv8wJdwMJGYKtGHzCpqepgaSkPeDIZlfeyiKxKWtxyfmXBr62X3QtcO+u5rtGT4s2ZgeXCRe5jPefwVHa26WV6t2UDBzDH61grdPuyxnxMaDPrLlnxHI5cRQ5EL9f9jims34QZB8zyQzzt8DFGS78iV4zDPjZC8kBq9ABkthTFXjsnU+dh1BiKyPuNgJr284f+Wr1C4VKZinilr2CFgXYTfZlXdm+xjPX12/nIooTECDrb8RJslyzCWpMQ/XGMRzDXN0nOtOWsLTx2/eDAENNK6WM2jAu8CiIgPZxouANERICpLt+tCbFR91i9byA=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <46EA10C9A2A34249BA4FC94771FDA5F5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3c56eb-55dc-4af4-7d0c-08d6d6b70499
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 08:51:26.8914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds i.MX7ULP EVK board MIPI-DSI backlight support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change change, just resend the patch with correct encoding for patch ser=
ies:
https://patchwork.kernel.org/patch/10937147/
---
 arch/arm/boot/dts/imx7ulp-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-=
evk.dts
index a09026a..59f094e 100644
--- a/arch/arm/boot/dts/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -22,6 +22,14 @@
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
@@ -40,6 +48,12 @@
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
@@ -57,6 +71,12 @@
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

