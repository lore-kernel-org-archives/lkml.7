Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D437620828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NUievyFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfCRHmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:42:06 -0400
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:48967
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726916AbfCRHmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t37iyLPHgGwYpM82Bya5Y4+MbS+pa7fQ9zlk5U0V6R8=;
 b=NUievyFsHMC+LsbscyHZuGuYMz+b9r7skWbFAV0o9tzztRj8ABx+Lrmyi63KJLYXAspBZEIi4/fLSTxeMgD62WgW5l75XcY+105UT9SRj38i4/pZwwkn1kHmInvMHa2ibpb8/ELnEiUP08jg2EHaXuIwCz0UyMZsLqurjRIh5H4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3819.eurprd04.prod.outlook.com (52.134.71.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 07:41:59 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 07:41:59 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Topic: [PATCH V5 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Index: AQHU3V4RXZq8Mgx1q0m22G0uu6mIag==
Date:   Mon, 18 Mar 2019 07:41:59 +0000
Message-ID: <1552894581-3391-5-git-send-email-Anson.Huang@nxp.com>
References: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:202:2::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ab6aac0-9c60-4ca5-434d-08d6ab7533fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3819;
x-ms-traffictypediagnostic: DB3PR0402MB3819:
x-microsoft-antispam-prvs: <DB3PR0402MB3819FDF0127E953FE86090ABF5470@DB3PR0402MB3819.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(2906002)(476003)(7416002)(2201001)(25786009)(446003)(11346002)(3846002)(2616005)(4326008)(14454004)(6512007)(53936002)(2501003)(6486002)(6436002)(81156014)(71190400001)(86362001)(8676002)(71200400001)(305945005)(6116002)(486006)(81166006)(256004)(7736002)(478600001)(5660300002)(14444005)(76176011)(186003)(26005)(68736007)(97736004)(8936002)(50226002)(102836004)(386003)(6506007)(99286004)(52116002)(316002)(110136005)(106356001)(105586002)(36756003)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3819;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wOqb5V0uZBZh3jScNPghYyDNIF/BaY0JCj6U3PZ4bk1U3Zii7Sf3hSnnmUMw4nmjBYhb5PUgvNimvYfqN0ROEUCrCU3C5UYA+wMrivlPO1PojUOxysoq9nUajN6PDiBwCJBB90Qi+27qA61JwiwBMz/uuukjWrrofoFaGyYoH5RUT/Xf+QXFLtKM57H/tSbniBmlhx0p/TXkKqaBVFJedT66FidPJziWWIySa6ySiiRPnrVvtBos8AF6t0cc18Xyob98YsqiNCoOlYIqJiMXRdd8F9DQ59wqvuE68KNwD7SaIQvFgkER+PXacPcAaeup3ReJhKYwWeAJ2Xi9IJt8+Ack4Ji/b8sbdPZPG4acp6/k18emHDOOaIKvFuGHh2LStf2W48i78G9SzBST44iWgOhEdes+hNOdh/XYhMYDNiM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab6aac0-9c60-4ca5-434d-08d6ab7533fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 07:41:59.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3819
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7ULP EVK board PWM0 support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm/boot/dts/imx7ulp-evk.dts | 12 ++++++++++++
 arch/arm/boot/dts/imx7ulp.dtsi    | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-=
evk.dts
index a09026a..3f5ea18 100644
--- a/arch/arm/boot/dts/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -40,6 +40,12 @@
 	status =3D "okay";
 };
=20
+&pwm0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_pwm0>;
+	status =3D "okay";
+};
+
 &usdhc0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_usdhc0>;
@@ -57,6 +63,12 @@
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
diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index eb349fd..49cb16c 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -124,6 +124,16 @@
 			status =3D "disabled";
 		};
=20
+		pwm0: pwm@40250000 {
+			compatible =3D "fsl,imx-tpm-pwm";
+			reg =3D <0x40250000 0x1000>;
+			assigned-clocks =3D <&pcc2 IMX7ULP_CLK_LPTPM4>;
+			assigned-clock-parents =3D <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
+			clocks =3D <&pcc2 IMX7ULP_CLK_LPTPM4>;
+			#pwm-cells =3D <2>;
+			status =3D "disabled";
+		};
+
 		tpm5: tpm@40260000 {
 			compatible =3D "fsl,imx7ulp-tpm";
 			reg =3D <0x40260000 0x1000>;
--=20
2.7.4

