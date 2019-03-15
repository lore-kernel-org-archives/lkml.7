Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E57C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D0121873
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bd4c8Qlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfCOArz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:47:55 -0400
Received: from mail-eopbgr10046.outbound.protection.outlook.com ([40.107.1.46]:57825
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728109AbfCOArt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjgBtODspgIl02Qt+4h5XtGYCSVcV43YL/vsSIbU+/c=;
 b=bd4c8QlkG7nO1Jtz6dWU9sLwWB5/Lq+yy1MkDVshzDkiWD8TF+reD9NGgtYiLHOaKatgRP+BStHm0TchpEca5jgnr3eu9TQ9sDQ3++XY3a5yi8HJUH6Zp4cygd+kV1M1KJfhwp26STrB/5wX+mnvoomO+XKWdjwnP48inBkm6Us=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Fri, 15 Mar 2019 00:47:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 00:47:04 +0000
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
Subject: [PATCH V4 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Topic: [PATCH V4 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Index: AQHU2sibQyWl9Qvuk0u4FHgBC4YMKA==
Date:   Fri, 15 Mar 2019 00:47:04 +0000
Message-ID: <1552610505-13568-5-git-send-email-Anson.Huang@nxp.com>
References: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0045.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::33) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a647e29e-a760-4287-6826-08d6a8dfbe12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3772;23:HRYI8ck90FX6JQENLYnbLmMzdCPnr63FqXXuP?=
 =?iso-8859-1?Q?P1tSHMZIUTEPIKrGUp8qsJIw9jWr10Nb51mjgva+JVnqzI1phVLZEPzs8R?=
 =?iso-8859-1?Q?/j2ulJh4IT3tIEtM2MufzdYEHPNXSLlNCBS/jQqiV14tbEZuiCpuX5Yn57?=
 =?iso-8859-1?Q?P3e4uxmzofSeTQoJPQOfiF+ZVhc529FFH3kVDSJTG5Odf27T6Gkw/PIH8T?=
 =?iso-8859-1?Q?5zjXNrgRgt2YSuP+TfZKpUb1P14A6J0tD+N9UlnnHGli1P43W/s/Ox7kfi?=
 =?iso-8859-1?Q?pxbalUw8GO/XUcS59Oim4DnP/HlZ1NNKnPCsPu/xHTv68v6SVTmMheKvQh?=
 =?iso-8859-1?Q?E1GPs1910Rlqp0CxhXEShvOLD/DC0+MUkYzOa81Z4NhGgUv1/5ADwPdAUu?=
 =?iso-8859-1?Q?tE/aaJnmYiM7fZCF5M0QTwCEWJ8X51g+os1+ExcxNJnBW9kaUUqlpOlAlW?=
 =?iso-8859-1?Q?0Ru3JcCQ3E1Nfy/TFP8CtYTaTAB9VjZnZ/Dbztcyf4eBMARoPD2q9ZMb0f?=
 =?iso-8859-1?Q?1rEoeJKxiy/9H5tIQnNLB74LwtRBQQiZJ+khFqpwFGUxXdOWGiC7LNPk15?=
 =?iso-8859-1?Q?6zymtgluzGC8xa4Ll4NtcsL31WwHaK3vsfzivJLgWuOrQAn+uJoeRX9xQc?=
 =?iso-8859-1?Q?Inn1Sgh4MG677vIDRkEyP3/F3BDp322RnMuEWnG7c7v54h3pGVkHruSnCW?=
 =?iso-8859-1?Q?cSaPPCXLZGX91nYaiVaE3pgpSFJMl/vVTSfCbDqdfzNVMdQQu6JQ51O16l?=
 =?iso-8859-1?Q?7MpfTXp1sxe8aPulGliVBVI99fSFLo+ENlNzVeGK3x9yRAcL46x4EQjmW8?=
 =?iso-8859-1?Q?ktc4aXXAvuW8BU06ohUhKAptkhVUXJBpxr3KMXkg97BpATLSldg+9PwZRf?=
 =?iso-8859-1?Q?7Ql/uuj69Z0tWx/WWMwkUUo95QqA8y3nJOHuh79pSAjWT9jMCALt9b8RnS?=
 =?iso-8859-1?Q?1RlQlKrJpfVuco0HJyYGy0guxq1+5FZQxZbeaym32iJRHucU6bCyRttYFe?=
 =?iso-8859-1?Q?tJBlykpfmoTaC0sxs7voFx5QKXO0MBvgt0C4Sxa7jSBiVLVzlHpNAtd1wB?=
 =?iso-8859-1?Q?algNSU1C83mAYeftvxj0ObD/wrV24EMMLFzbGs9wY0SAiCjLUsxo5jNHv9?=
 =?iso-8859-1?Q?aBNmtlqLmIXG0SIbFFBaOjW6lBI1W0sMwUoY5Yrc0NXobvUw8PLIOzKyIT?=
 =?iso-8859-1?Q?yRGlufmml/zcxU59+Gmb7npxY43zURZ62vNTSQlZA225XuHIgFRskuZ4a8?=
 =?iso-8859-1?Q?G0RGDeoyFM9FBeWE7mnZgo6BlmG41zRhVrRiGo2aHdEJ/+tTCfCI/cNpR1?=
 =?iso-8859-1?Q?UmP8gVFWmXerxHNXu3hJ7Bui2FVeX1sF8CcVkbmNlWdrfvQ=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3772D4DA92C4A543C8133126F5440@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(2616005)(7416002)(66066001)(14444005)(97736004)(186003)(6512007)(11346002)(446003)(2501003)(53936002)(76176011)(7736002)(2906002)(476003)(6346003)(305945005)(106356001)(68736007)(102836004)(81166006)(8676002)(81156014)(386003)(6506007)(105586002)(52116002)(50226002)(316002)(6486002)(110136005)(486006)(36756003)(3846002)(5660300002)(478600001)(6436002)(6116002)(256004)(8936002)(4326008)(25786009)(14454004)(99286004)(71190400001)(86362001)(71200400001)(26005)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 43PfuRxfZIH7MvSTL727wpDQnCn9BU3nAudKN+Y+z+yFrc74XAlDc7rUB0ipsJDUOYNQTaiJjKJE7iN2Sx/AXqihUN83OZGS0OtMu+FCRrORVnCGRaUxAugDvxXwWfOI1nLKorP1JWCBP4seXLp2Lt9SYuJMoUBoYVb52Xs2vXdTvNGTHaEgYSUS/ZNTdHXORJcqJMC4+OXz300xQrlrye9kMSowFfl3IzorKUyAftuDQK3m0fCCeLGdr0p/W3TfvAr3C3w978CK1uHjJeIob3okJSFldLJ049OiCzOkx7kwp6VAU32l8zUGqL5QokEoHflP5S5YX3AHFu305GGZr49YXWzQ0ncfFvxKEauMOAsiaLHsezdZZ7WTAjGg+Xo2Qo7LC58Dl+9knQoq2sZ2kDEtsD73Rd6T7FVqzOItI6k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a647e29e-a760-4287-6826-08d6a8dfbe12
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 00:47:04.2166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
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

