Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0132C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B93216C4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z6IdV+yB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfELIv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 04:51:26 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:37700
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726430AbfELIvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 04:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c+4+C/jrbkIsqkKZNzVnwJIHq5ptyUl9AeyHh+a0/I=;
 b=Z6IdV+yBMdeLCz0EcKcLkTPU+FhCn2Ohluh/ydTPqC4sSXXnjDyOcCleCGhLZixIvBZjadQCLM6n8wLLr/Hwuf3GIh+P1onSVjqG+2XQG299PZj54y9wSdZUu4+Fh9B5DCij2T51SeNZUaPC4ODV8O0dOThBVDGiS9vN7l+Telk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Sun, 12 May 2019 08:51:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 08:51:21 +0000
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
Subject: [PATCH V12 RESEND 2/3] ARM: dts: imx7ulp: Add tpm pwm support
Thread-Topic: [PATCH V12 RESEND 2/3] ARM: dts: imx7ulp: Add tpm pwm support
Thread-Index: AQHVCJ/fymja6Fu6mkegJXuLVPBSWg==
Date:   Sun, 12 May 2019 08:51:21 +0000
Message-ID: <1557650772-11973-2-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 3c133d7f-8d98-431f-3b97-08d6d6b70139
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB37393B08BB51E1BE21D99107F50E0@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(966005)(36756003)(186003)(66556008)(476003)(66446008)(66946007)(66476007)(64756008)(486006)(14454004)(2501003)(66066001)(2906002)(446003)(11346002)(2616005)(256004)(14444005)(73956011)(478600001)(4326008)(3846002)(6116002)(25786009)(26005)(102836004)(6436002)(7736002)(305945005)(53936002)(6506007)(386003)(6486002)(6512007)(6306002)(7416002)(2201001)(86362001)(4744005)(316002)(110136005)(68736007)(81156014)(81166006)(8676002)(8936002)(50226002)(71190400001)(71200400001)(52116002)(99286004)(76176011)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /RDFnFuqhIxzQ2rJKm7AriNj9Ze3AZ21SbtKNchc2TBvwgF6ILy7AjABnsPOukA0QG8Kk9askV7tntdX2eejpvBWjBrpkbOTzkxtHTDEyzsu57+g0FbAbpv7JnjstFaVZkex18BijmRNabU11JkK/ffEAt+vWzlEJS0/NXk1Dw2BWevEKmLS6EOGEpXpH2XCoqlWgutY12I/RXuMghHQNk8YN3/+TtIs7mlzgA1iZWAYpF/WfbDaxw5c/JFcirnM3XJ1cz/H4LOuq8pbf73HPS54G7JiBwONbFzlh2B5JiacJyupO6ssRrsECMaWifJLOEAcm4nJZMjFWAOhr6yIVmHD+/cYKY0ATfWLMqKHHWzxxz834lOUOAzH1MBv+6v2oz1/TJN4TqENAC44WrHJO4Urcp5NY/UwS7zuBH1+Z8s=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0549FFB5F6AB5A45A54FC867FA70D6B5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c133d7f-8d98-431f-3b97-08d6d6b70139
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 08:51:21.3805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7ULP EVK board PWM support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change change, just resend the patch with correct encoding for patch ser=
ies:
https://patchwork.kernel.org/patch/10937147/
---
 arch/arm/boot/dts/imx7ulp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index d6b7110..8fb9559 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -124,6 +124,16 @@
 			status =3D "disabled";
 		};
=20
+		tpm4: pwm@40250000 {
+			compatible =3D "fsl,imx7ulp-pwm";
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

