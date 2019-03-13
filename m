Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8D8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8E72087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n/FffX7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfCMHcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:32:14 -0400
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:32878
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726839AbfCMHcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 03:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdO+N5F399yqLgJsCzsqiyJUKW5WO/d3J0FIVT8izSY=;
 b=n/FffX7DYE45vW6Hifhm/+SMds9ycWMdC+xLz4K1hZiC+PAxa6f6yyceKVoGQmHfbAXIu0nKQGUSnBBAoUQkpa3kigUU1lO1vYGIRlIU8NDBa0LtginxCRwCb636Wnsjy1hM765jzglq3BXB22DLyAEB3ytfIim3xFBvLUDM1wY=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3925.eurprd04.prod.outlook.com (52.133.30.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Wed, 13 Mar 2019 07:31:30 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e052:f2d5:93f2:5f52]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e052:f2d5:93f2:5f52%4]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 07:31:30 +0000
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
Subject: [PATCH V2 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Topic: [PATCH V2 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Index: AQHU2W7GjEV5zdP52UykHGJMAxLGiA==
Date:   Wed, 13 Mar 2019 07:31:30 +0000
Message-ID: <1552461970-20813-5-git-send-email-Anson.Huang@nxp.com>
References: <1552461970-20813-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552461970-20813-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0076.apcprd04.prod.outlook.com
 (2603:1096:202:15::20) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 736cd108-b757-4b7c-a745-08d6a785e8c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3925;
x-ms-traffictypediagnostic: AM6PR0402MB3925:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR0402MB3925;23:jtzmOEmEUz7BwRw9+29qhKWSODROZx0HQ1clZ?=
 =?iso-8859-1?Q?NMvTCMLugBT3amqDWqUJfF+gQF8u7jfSj/kKI1fOqI/zpM+bRDdLMLDjsc?=
 =?iso-8859-1?Q?BJaobyHDlcmWZRd8ddsjQgzX2pIQGgGxqUmfonQeBj2g+EVyHMK8qNqv79?=
 =?iso-8859-1?Q?4aj5HB2d/2lwwiPPaifk/Sto4ZN+w0YFkLERq80oL09EaS3SSvAL/+rg+O?=
 =?iso-8859-1?Q?00KNwMjj/ZhxPbLNYiFaEW7oDkZ7jXsyqapAo5Bd6zXpgVpIkz/DkYvez2?=
 =?iso-8859-1?Q?vvEZwN03AbLVv3gKohRdZoitfpHs22EhI0QbsSGzUyMER+MTymS3bcadpe?=
 =?iso-8859-1?Q?+JKQ5Fjx/Igwvc+K0U4IiOLtS0f3BZzRTe8qIQVpYqQ0fQewJP3jYLNGTJ?=
 =?iso-8859-1?Q?OUUOXjQuApct4JIOgfu3MnGWA3rwshNHFGy7jrFnCyTzDZWZe7n+B57YF6?=
 =?iso-8859-1?Q?4FKSkMQbJfaHQN9+i0skHIutwZTV/4JU71SCoR/2iHTDkVnnmdj3mVUa0Q?=
 =?iso-8859-1?Q?hRepr5kCaU93ZPDhqxlr7bKheLMZ2lUvAB5UveD9ef4nzkFf2O5ihthwYp?=
 =?iso-8859-1?Q?giWp0nQQjuzDbm9PFe+L+14SSl+zFYfRPRMFhZZGVhM8m+BTdlzCVwMo8N?=
 =?iso-8859-1?Q?UfuqKM9mn80Pw/L8jQ6uYpoMVcVDjbDFd7Olg8y1+DOxD+Gp2omtpVwgWS?=
 =?iso-8859-1?Q?h6A3DLE5nwmKQWuI68ebLz1BM5xqk2NZPkuvMZBoOD1ZfVzRqw1yS6kA31?=
 =?iso-8859-1?Q?we/wOM6br0PGuVZ2xCGpBPsm4CuocSvyNAIaLV8awBhXNq9wScAPuBnZon?=
 =?iso-8859-1?Q?d/9CaoD8UHxjLD7Sk1rih/AbROUP7zbFkVt1RdFzUbjD/QHjJcKPD9v085?=
 =?iso-8859-1?Q?lQSRWvEv1kljxby1bNOSZ3tSBexhbYliUX6JynMSJAeJ228Y6wrAIA9Mvd?=
 =?iso-8859-1?Q?4DJHuCWS2LKULZScw/sR7kpdOmtRjhYIxXtGxoQB2J++gaHqqfZ9W5X1Er?=
 =?iso-8859-1?Q?h5DYU8gFlxHHnuLjcsclAD7qQrkRuvV/3G0F77lUDEUBB93cUy1bx+hrhd?=
 =?iso-8859-1?Q?uv2Az9qLl58WBNHd+iP5F3OSvxvxfdYgHrJ2WxH/VbAPVX0/CCJwhl1tcI?=
 =?iso-8859-1?Q?stR2lnc7E/Sd68RDL5l3NVGonSq5FgPYOPLVxuVO2rZb2h6E3+TdNp9l95?=
 =?iso-8859-1?Q?cXE435uKS1/D0USCL/ZVwQLiQRLLLDoEBMJw+hOi+L2jxyqVJsrVjvxwjd?=
 =?iso-8859-1?Q?LDhrFAp9ZLj5lnI7GEhm+N5c9xNeA1GKVFuaVgHtWqMSqfvAqVorXU8WQp?=
 =?iso-8859-1?Q?mxOPi3ltGoGmTAzz5vaTyX4LG?=
x-microsoft-antispam-prvs: <AM6PR0402MB392507260636630A25243D8BF54A0@AM6PR0402MB3925.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(2201001)(2906002)(50226002)(8936002)(86362001)(97736004)(110136005)(8676002)(53936002)(2501003)(52116002)(5660300002)(316002)(105586002)(102836004)(6116002)(3846002)(81166006)(386003)(6506007)(76176011)(81156014)(446003)(305945005)(71200400001)(11346002)(71190400001)(66066001)(478600001)(2616005)(476003)(36756003)(186003)(6436002)(26005)(106356001)(6486002)(68736007)(25786009)(4326008)(7736002)(6512007)(99286004)(14454004)(486006)(14444005)(256004)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3925;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L6BEed0wofQXadMQS/QowPKXBqLnIOyXFrf0asRxxqCzGAt3iDJPUgg2oIHgIMGyZuXECJt6TEsgVJnZ6I2A8QFLtdFTa9uUBd/8gXGhIHPP+jwsRNc+/Qu3F/GK3yyvyUhjX9a0/RA/4WHk+RbbBelTnc0CNAOeFLgNWRVBiExQYKvLq+8uN93U/0ug3zE9Mj4MgGliE6EWvbpgKIcPeLL20P7WkTWue8CpUZc3ZvHooNBKtgvVULg76ZxeIRFNd0wqNCaHhigpvM2xDpkO9c5lCrZsRi1OvWNeWX6qKLeYFrsyTfhrYz2lBqwNQ80lwnvEnDbCLIhAe9+aOnzasUDvWypHrG9kjUSm3Q/1dpDz99wQkdHKxZb4e88uOobNgeMYDg04K+x+Ohnn33UhN6Opfz6QiVKMPy+bHxhQNbM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736cd108-b757-4b7c-a745-08d6a785e8c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 07:31:30.0509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7ULP EVK board PWM0 support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- update the pad config to pull down to make sure when TPM counter is disa=
bled, PWM
	  output will be Low.
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

