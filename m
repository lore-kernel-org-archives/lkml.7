Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521E2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15138218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="isODRbs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfCUAsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:48:51 -0400
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:53217
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727437AbfCUAss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PGNQ+Y0vEd8a3p0ZQ0SetTGCVAZKP5UMy4C7CdWAVI=;
 b=isODRbs84tV0GNnxszV3pQlcY0NgaExy/ChUik3qn8eVBFqUjXiJoq9T4oLoDsAdLoq0LHZSDxaq5UpsLC04KcnYJ6Cnq5Egz1vC0oYOORr4j2CN5zVSpVbm/HYjccG7QgdofbYUNmDID4H04kdLE4KIRSHx3A4BmE2DaC5t40o=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 00:48:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 00:48:11 +0000
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
Subject: [PATCH V8 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Topic: [PATCH V8 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Index: AQHU33/CTbB64rynq0mdAavKEXHR7g==
Date:   Thu, 21 Mar 2019 00:48:11 +0000
Message-ID: <1553128960-17923-5-git-send-email-Anson.Huang@nxp.com>
References: <1553128960-17923-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1553128960-17923-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:203:72::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd26b445-ff18-4388-77fc-08d6ad96e458
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-microsoft-antispam-prvs: <DB3PR0402MB373840FF51899E1A74EEF6DCF5420@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(199004)(189003)(11346002)(53936002)(2616005)(71200400001)(486006)(3846002)(478600001)(476003)(6486002)(8936002)(6116002)(446003)(36756003)(66066001)(25786009)(102836004)(14454004)(26005)(7736002)(110136005)(186003)(99286004)(6436002)(7416002)(81156014)(4326008)(76176011)(81166006)(305945005)(6512007)(97736004)(2201001)(4744005)(105586002)(14444005)(386003)(256004)(50226002)(2501003)(68736007)(6506007)(8676002)(86362001)(316002)(5660300002)(52116002)(106356001)(71190400001)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7FCo/+ZsA4P9RKzT7/j8Uy451zSa9UaNb2KuGQCgBz0t+Of/MT7to42mXEvPijmI90592uyZzfK4ogWg9QSB3GSy8IrFBN88chzZUi3EGBfLvWs9ft3pj9axKSS8aZTAJV1BcIgWqmZ7jDVoejgb7OefGtzc4K/mATQbfBIt31vRDCjLuTod/sbyTIO9RA9TVDnWFmoU/DNIpGbGOjXsDxzkmRV2jmRWaqNp4Bn8cspj0V7doeXTW2syaO3KIIx8JLJsYmw7FB9HDMtWRU+JMdZOlHC5UplBV4Qb4kysFReCpkrx12Yf4LLMAgY+KEAfHfkEBjsNtaeYItbYmjlEceWvE+3n+e4k/bHQPBVctI0sQQ0chR9U8MbvhESEk54G6CBpq3gHhz9QB98XpYq84QjLpdlvhDXS0Djn7GA32BI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd26b445-ff18-4388-77fc-08d6ad96e458
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 00:48:11.2160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7ULP EVK board PWM0 support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes.
---
 arch/arm/boot/dts/imx7ulp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index eb349fd..15d04fb 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -124,6 +124,16 @@
 			status =3D "disabled";
 		};
=20
+		pwm0: pwm@40250000 {
+			compatible =3D "fsl,imx-tpm";
+			reg =3D <0x40250000 0x1000>;
+			assigned-clocks =3D <&pcc2 IMX7ULP_CLK_LPTPM4>;
+			assigned-clock-parents =3D <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
+			clocks =3D <&pcc2 IMX7ULP_CLK_LPTPM4>;
+			#pwm-cells =3D <3>;
+			status =3D "disabled";
+		};
+
 		tpm5: tpm@40260000 {
 			compatible =3D "fsl,imx7ulp-tpm";
 			reg =3D <0x40260000 0x1000>;
--=20
2.7.4

