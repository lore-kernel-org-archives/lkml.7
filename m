Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61350C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3271D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BaA/vS70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfENGIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 02:08:36 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:10193
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbfENGIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 02:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTiyz7oOoBnGCYjmw0SOe1q6ZRigsgPAgF6dcT8cwZQ=;
 b=BaA/vS70LAxYBPFEI9hKS4/HQpEkjfUjTBgwQsO6yncLrPvMFqzgHIENUOGku+w1GLMNw77B3RkX43Gcbg6Grf1hhVRGV1nNwl23ainszLMVuAPHOENPMvJiLeSby+x9YCotXUwyps5hV6QmVz2k9bAHxgFS2O70B9ilXbQOXo8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Tue, 14 May 2019 06:08:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Tue, 14 May 2019
 06:08:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] arm64: dts: imx8mq: Remove unnecessary blank lines
Thread-Topic: [PATCH] arm64: dts: imx8mq: Remove unnecessary blank lines
Thread-Index: AQHVChtz7Wi0Kxez2EK8fnK8F+Cmog==
Date:   Tue, 14 May 2019 06:08:29 +0000
Message-ID: <1557813807-3919-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c12eae6-5a6e-4ff5-39a1-08d6d8329569
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-antispam-prvs: <DB3PR0402MB36751B1668481B36EF2CE2A0F5080@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(189003)(14444005)(256004)(6116002)(2201001)(26005)(7416002)(3846002)(2906002)(8936002)(66476007)(5660300002)(66556008)(64756008)(66446008)(102836004)(4744005)(66946007)(73956011)(6512007)(86362001)(71200400001)(6506007)(386003)(71190400001)(99286004)(476003)(2616005)(486006)(186003)(52116002)(110136005)(25786009)(4326008)(305945005)(478600001)(6436002)(14454004)(2501003)(6486002)(7736002)(53936002)(36756003)(68736007)(316002)(50226002)(8676002)(66066001)(81156014)(81166006)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZD2NTU+t/4FgzYsceJzdPLlWZ5opnZIzLc67PeNXndR1dfZR0+iimqAuZA422KnpuQpnr6kda7JRPRpbvfMG8rc+xiQJLDUZoI2+2tLW9cUtpvKMfNrN8YgYszVNjK8D7HemPvfbAhRyCgoQayZ1gL0J2R9g58d+AjzZt+FAUYlKQMdMw4WI86PC6urbgjeCie0CnTaxoKKDTeTaUvmWRGHiMTsz2qStLHSqa/AlLZyte6UHg1Q/1udWEnfFq+JPHzvdJ+G46rpckeLr30gOCFubladv9QPC8U8ZfkBNt4y32gEC+05cBarVaFczBVraxKbFUmPmqqn1pPEP/K+3ZUzlv5QYpwwH5mUNFiVbOx4a6zWcRSK1Mwd2M7lqlYkzaNveMW6W4huRPi1IEbfYMsackaN1L0BTc3jMTXayhdY=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1A0B0733A7F8DB418C08491CEEC218DE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c12eae6-5a6e-4ff5-39a1-08d6d8329569
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 06:08:29.3064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unnecessary blank lines do NOT help readability, so remove them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index df33672..e5f3133 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -439,7 +439,6 @@
 					interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 						<GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
-
 			};
=20
 			clk: clock-controller@30380000 {
@@ -908,7 +907,6 @@
 			status =3D "disabled";
 		};
=20
-
 		pcie0: pcie@33800000 {
 			compatible =3D "fsl,imx8mq-pcie";
 			reg =3D <0x33800000 0x400000>,
--=20
2.7.4

