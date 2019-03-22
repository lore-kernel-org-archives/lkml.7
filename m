Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361F521902
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CidsUyLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfCVBsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:48:30 -0400
Received: from mail-eopbgr150057.outbound.protection.outlook.com ([40.107.15.57]:5337
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbfCVBs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVXPzP7KQmQ947uy603ag1TWGDdrV4hItN4yxLswomk=;
 b=CidsUyLO96ym+e63uUDBTIbBCivGCJ+RaeYig8htw09caIAAnwGagOCbJ0PxnFnF8rNK/h3m40gbzytSY5aLCzxaziPxZf5/ncXawcknlRuXWaCEgA6TRb6ofmBgoW9FdVU6p/uPg82hGEfpoxCTRQVBPamskvVmYf+VFR0xp5w=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Fri, 22 Mar 2019 01:48:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 01:48:24 +0000
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
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V9 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Topic: [PATCH V9 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Index: AQHU4FFWnnezNzzxM0OvJm5Y1KVEKA==
Date:   Fri, 22 Mar 2019 01:48:24 +0000
Message-ID: <1553218974-20464-5-git-send-email-Anson.Huang@nxp.com>
References: <1553218974-20464-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1553218974-20464-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69a2742e-5f2b-4469-7a39-08d6ae687852
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
x-microsoft-antispam-prvs: <DB3PR0402MB37543ED98ACAB15CB0C8F52CF5430@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(189003)(199004)(71190400001)(50226002)(99286004)(81156014)(71200400001)(6436002)(81166006)(476003)(2616005)(6486002)(486006)(8936002)(36756003)(66066001)(68736007)(86362001)(5660300002)(11346002)(110136005)(2201001)(4744005)(14454004)(52116002)(446003)(2501003)(7416002)(186003)(26005)(316002)(106356001)(4326008)(2906002)(76176011)(478600001)(105586002)(7736002)(3846002)(6116002)(53936002)(102836004)(305945005)(8676002)(256004)(97736004)(25786009)(14444005)(6346003)(6512007)(6506007)(386003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hHuJN2d8jX+jOnNjxoL/7UbyrOJG2mqNnPFbgODgZ48BE4pUyFsBiJDqixlJWDObF34r9PoOCfTEfgSJOSUFnYUPJ+6XiYeIZJMprirIAt5cmskQb0N3pJTFDKzmPzpQVNf8MWv/2imWzLvv9pilvsitLC3RaspoJYmBmn0ujuoj+wAIITb7xM9Tmx99agRPhlxC2Kuvc2Bn0A0xRtP1Da2mGG2hRn2SjPSJGAW0lnSCJwW4vb3imNxMtMPd/PT74RaT1kBur5Ab3LBisjejXP/6n7HFepcMjoPX5k8XYNbyPfEnaB8KS+H/MdTtuDBi45zK2yanDhBEALcZWopSlWxI31sufSSHxVElRn+Uo9iyZ3HSEl8ee8iTCRFvdNGrZhvFtv4fi+OljeDjFbs8E8Fa8CQ2Rvdvl3REbIL1e6I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a2742e-5f2b-4469-7a39-08d6ae687852
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 01:48:24.2740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7ULP EVK board PWM0 support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes;
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

