Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AD3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE9A217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UjpHcGqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfCNG2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:28:10 -0400
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:6118
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727076AbfCNG2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXkT/kkQ0EdtKoEgxYvQratI8JUciNaFVgbdQOQoYhY=;
 b=UjpHcGqqB2hnvOzFsBB7NYHh0Vg892DQj3J512Va4uTHYtVX6BuTaBC6wDNM+yF0wEFHCgVPvWVaRdLOdgLrOpOf6hQeIOdE/uuDh5Ws3da+qwYrUY9Afm7KeWjRbreoLdJ3LdvjmgJN6G24tjWLvTsW/xthmVRGQE8xFPP8dpg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 14 Mar 2019 06:27:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 06:27:32 +0000
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
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Topic: [PATCH V3 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Index: AQHU2i8BvaANijVcvUeuH38EuLemKg==
Date:   Thu, 14 Mar 2019 06:27:32 +0000
Message-ID: <1552544534-5295-5-git-send-email-Anson.Huang@nxp.com>
References: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0031.apcprd03.prod.outlook.com
 (2603:1096:203:2f::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 380e14c2-9a6c-41d0-4509-08d6a846240c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:73tsYu31i8/r/MUNitvPEVNEKpXRLT+iDqt1/?=
 =?iso-8859-1?Q?c4NqgrlC1W5qcB7kanpx052zoZBqKT4+U+/T2VQGkmhlrLryCZFfjCLvIw?=
 =?iso-8859-1?Q?GiChcsotWlADqDrrf/LF3r1oQE71/Ja/L74LZFQOYIBJzuq+3ZsBmeMfe7?=
 =?iso-8859-1?Q?egx6nPoOfujTxxE0iLinewL/hTdvYW2Sj/FUDG6mKdoY6tEZG3G8PZO4sq?=
 =?iso-8859-1?Q?ArLlHlgzsmg71IegY7/BxnWpUvZiQKrS8ZsZZvYmTIzT5gmnb+LCkL6UAo?=
 =?iso-8859-1?Q?t8Ml58KKQV9czT+yCVd4DZACV3uv/8ZAT7kALD8daeDgIF+lHM2n7ctemE?=
 =?iso-8859-1?Q?64NzzcaF6XWvxC0vGXEXxsZk79r5PhfRKmOKgTnU1qroCpxQJRh0zu9bFg?=
 =?iso-8859-1?Q?vCdYhKYk88KyycuU0XcwE6O46l+Noo93afEXteXoctGNoPyuf9LYa2j7ir?=
 =?iso-8859-1?Q?4vDWauhrExdhCmr06NfvIDejhdFSNWlJD4dLwwT/Z4I2p9pT9vXuvFoT2j?=
 =?iso-8859-1?Q?+sT8Yi5uXy+mfo4xrDDclJ6zKWjyNPuYq00ccCLO2cROccf9qk01r2Wri/?=
 =?iso-8859-1?Q?xJOUAiT3TMUj3UPtz4vajvRPhrTPVtL7yBMfrT11I3hEjeUfiAoGQyHdNk?=
 =?iso-8859-1?Q?o5zgYvrc1v1I9aIm0ZhGxImwjhriW26oqv2ZtwqOM/Z03soauxNRD+3un0?=
 =?iso-8859-1?Q?DlTMtUT2kZOTMSiQ2FOMMa4P6Gbripe+ic3vfgq03mdUAddDU+yeGGuHIs?=
 =?iso-8859-1?Q?NRfbdqQ6dvu5BgvEA0xKH+1GGn1d7dt8vZSl6BaEZ/vxco1obcaH45XbgT?=
 =?iso-8859-1?Q?oDoXu/scuLhNG87rclsGkanHXrZ7ioox15pXAjVlYTgIvR6+qUchixcr8E?=
 =?iso-8859-1?Q?PpFJgz84JhECEqIA9WBUFnyPueNq9WOgmUx7hcrun8gmpyzoCkoUkE85tg?=
 =?iso-8859-1?Q?sCs3l9DFaGQGQ+DY0e6jeGLck2NTtN0gKazLTTa/3B5vpvF0EzJKcq4x7r?=
 =?iso-8859-1?Q?CIfPXEkJ9u59NW13YlmWjILwFMCXlbN0nMoomkRn9vmJqrMgGE8FwdHu/j?=
 =?iso-8859-1?Q?G+FomCyr1ldFx1WpvFElEDqQ/rbkbdE/BfXYJDLPIvPLtqS5Kip9xQ3p+X?=
 =?iso-8859-1?Q?kYsmzDpqCaMHY96TiIL8zjF0rDLf7mON4U3ds8rIMsRrcGJQfu1BQMTcOQ?=
 =?iso-8859-1?Q?75pmcNDglLFcvujqF/4fq0bEoYeu/hgSRsdk4gGFZMJ1OjjyQ1riPydd+A?=
 =?iso-8859-1?Q?G+WjSU7hMVB8Ujno3mlZt0iGhn4ZhmTfgo61POcBWuAAuDDgF2XboBLaWf?=
 =?iso-8859-1?Q?jWVHSIUCVOY3LCYY2mtN9WHrf?=
x-microsoft-antispam-prvs: <DB3PR0402MB37070B06EF03D0CFEC93345FF54B0@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(189003)(76176011)(478600001)(6436002)(26005)(97736004)(6506007)(476003)(7416002)(68736007)(8676002)(102836004)(386003)(446003)(81166006)(11346002)(81156014)(305945005)(486006)(14454004)(186003)(110136005)(2906002)(2616005)(106356001)(105586002)(7736002)(71190400001)(71200400001)(52116002)(316002)(2501003)(6116002)(3846002)(66066001)(14444005)(50226002)(4326008)(5660300002)(256004)(36756003)(99286004)(86362001)(8936002)(6486002)(2201001)(25786009)(6512007)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3iwbZnNh1BN2Grm9+6CuD02RWm9jhFZs139FuwMORFQxfUCo7OrB4OS4Qt7bBI0UQqoAanZ+ZGipyenyRwM7jVKTPBKC29doOD/1GkmiUq7+VCmJf2BTCsPVDS/6tcViynKyprArPv+v/mXrBNvFCZilBle7y0Acy0tOO1dMoBb7lj2lPn39J13P/+Ibi/LqtG/vHWCZXPQdtEHsasgpv3YUiLTFAy6qzPKhV0vLS87sLwXBj4BhPvemE/cRmENE08TOHdZ6sDTfLWMYPJVkk4kyqhIduHGxuoucJG4l6L3UrdppoNCUo0UhwInnf8Gd9j7NRVY09AsQE310d65NgB9A8+PmG4Q8qsBGPWiow2HLLMFdlXan/8eEQlkIYMaMo7YjxZFuHhVxrGIcgwp9egcN1kVTfnTfCJEgd0yrxdU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380e14c2-9a6c-41d0-4509-08d6a846240c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 06:27:32.7796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7ULP EVK board PWM0 support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes since V2.
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
index fca6e50..6361c4e 100644
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

