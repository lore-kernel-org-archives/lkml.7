Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D79C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C762184D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K9//sOP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfCMJYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:24:22 -0400
Received: from mail-eopbgr40075.outbound.protection.outlook.com ([40.107.4.75]:47837
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726719AbfCMJYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfMRFaoATgwB/Edrs6s1tgMWtlrTzRoXyQSooMJb5Rw=;
 b=K9//sOP4j36HWwOJS+HJpn7hY3RCk5wEh6HTBSmWKJEsqFetX0KYHRKKASAPCth6dFzGOQxcB8RMhaU2qTkR2K4rZ3GhqPzEWIUf0a4My8ORuxbTiB3aXYCQW6Ejry7Me1Edz5hK+216awPilnJrIaZW50LTfJFthz/3K0vYigw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5971.eurprd04.prod.outlook.com (20.178.113.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 09:24:19 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 09:24:19 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8qxp: fix mbox-cells
Thread-Topic: [PATCH] arm64: dts: imx8qxp: fix mbox-cells
Thread-Index: AQHU2X6JXRYV9xh9YkiIRxWD43fsCQ==
Date:   Wed, 13 Mar 2019 09:24:19 +0000
Message-ID: <20190313093626.18589-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:202:16::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 494cb744-af7d-43e2-dfba-08d6a795ab67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5971;
x-ms-traffictypediagnostic: AM0PR04MB5971:
x-microsoft-antispam-prvs: <AM0PR04MB5971588ABA6841E6ADA80DD4884A0@AM0PR04MB5971.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(136003)(376002)(189003)(199004)(2906002)(105586002)(6346003)(36756003)(71190400001)(71200400001)(25786009)(2501003)(106356001)(66066001)(68736007)(50226002)(6512007)(99286004)(2616005)(476003)(8936002)(97736004)(81166006)(81156014)(6486002)(8676002)(486006)(316002)(478600001)(7416002)(186003)(4326008)(6436002)(5660300002)(26005)(7736002)(1076003)(6116002)(3846002)(53936002)(14444005)(256004)(86362001)(305945005)(6506007)(386003)(2201001)(52116002)(110136005)(54906003)(102836004)(44832011)(14454004)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5971;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5TO85yDc239XzyBZ2z1e9teg0/n6iAkoRLDpXPLhTdDuGP1YO/K1MpVN6tqnaH5evuz4bTHv4/QTvde7Ls41+/xHjMS39CwP6SjgP3a8pwZsGynBtap56DU4H/OXkjqFitYlMB3+nfkoe9K4+7PZS5RUHsifiuXRJUbuLTLUuVqxpIsSLtzHW5o7xV+7erEGpScSLZl1y3ttGLFlJs89ZMrLwok6xL0lqMrF0GIrEeEkdFfz7jg1PQC7a5y9/D5/J/7b+rqXIdkbZX+ey14kKrCEBztYkbzLHmUBE8NcZ7CU0g4cNF5sXuTyGuK7euc0tOmJ0mhOgIJmaOD7odygeSfv0F4CO/a1ie2anaxMGMICLzaaQW8KpZuijUiUMPBxTEZRWuVAQrtoeuyFrez+WaZMlTwCAzOt7MAPVMMOMy0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494cb744-af7d-43e2-dfba-08d6a795ab67
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 09:24:19.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5971
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently lsio_mu1 is used by Linux Kernel with mbox-cells as 2, but
actually mu0-4 could be used to communicate with SCU. So fix the
mbox-cells.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 4c3dd95ed488..16766838ac77 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -328,7 +328,7 @@
 			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
 			reg =3D <0x5d1b0000 0x10000>;
 			interrupts =3D <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells =3D <0>;
+			#mbox-cells =3D <2>;
 			status =3D "disabled";
 		};
=20
@@ -343,7 +343,7 @@
 			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
 			reg =3D <0x5d1e0000 0x10000>;
 			interrupts =3D <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells =3D <0>;
+			#mbox-cells =3D <2>;
 			status =3D "disabled";
 		};
=20
@@ -351,7 +351,7 @@
 			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
 			reg =3D <0x5d1f0000 0x10000>;
 			interrupts =3D <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells =3D <0>;
+			#mbox-cells =3D <2>;
 			status =3D "disabled";
 		};
=20
--=20
2.16.4

