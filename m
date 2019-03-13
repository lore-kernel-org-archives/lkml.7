Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73ADC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65F62184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cgC+GG66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCMJYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:24:47 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:55808
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726719AbfCMJYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb7iJ4TuJTkOfRAQ9vZzMQTDHUIh9K7zztGz/E9t+5Y=;
 b=cgC+GG66tWSY90G/yHDc9bWKzm5zFmUPbQ5WLi4XI3aVyi0vOglqYPJEY9PaKPNr909b0B5cAnlYBE2S22WMx3dNDBnqYE8B5uGlLMDvz5IdKBMrY2p/bK9VroOnbu5pb0XYlnserDZ4f4h0Xa3D0I6fX8/e2RLHYbkdx8QxX0E=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5828.eurprd04.prod.outlook.com (20.178.119.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 09:24:42 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 09:24:42 +0000
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
Subject: [PATCH] arm64: dts: imx8qxp: add lsio_mu2 node
Thread-Topic: [PATCH] arm64: dts: imx8qxp: add lsio_mu2 node
Thread-Index: AQHU2X6XfkrN9ckA80iUx9YseK0a4g==
Date:   Wed, 13 Mar 2019 09:24:42 +0000
Message-ID: <20190313093650.18693-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK2PR02CA0149.apcprd02.prod.outlook.com
 (2603:1096:202:16::33) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d67cfa2-1573-4aa8-7c02-08d6a795b94f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5828;
x-ms-traffictypediagnostic: AM0PR04MB5828:
x-microsoft-antispam-prvs: <AM0PR04MB58281CEBE0761216A174F454884A0@AM0PR04MB5828.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(136003)(396003)(376002)(189003)(199004)(105586002)(25786009)(36756003)(2906002)(305945005)(4326008)(316002)(7736002)(486006)(2501003)(99286004)(256004)(86362001)(14444005)(6506007)(52116002)(386003)(102836004)(3846002)(6116002)(97736004)(2616005)(476003)(26005)(6512007)(14454004)(7416002)(71200400001)(6486002)(186003)(44832011)(6436002)(2201001)(71190400001)(106356001)(68736007)(54906003)(110136005)(8936002)(81156014)(4744005)(66066001)(8676002)(81166006)(53936002)(50226002)(1076003)(478600001)(5660300002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5828;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CfTl/tvh2TT1nmqRKR3zlBIB/5TUzmtQXSd04qOUIHQ+O8N1TZNp0P4iRNUArTx1zjQLylnUY75wdWyMZ13Bm4BR+7HVTiqLfwz4HGhM7E5CMkdKMeW7N2dmh272/XiwzqoJK4JupJrsjBO+IB95hv1ls7iH8HEjHK3/VN4T2QC+5aeCL+5+4yscnQXbTUxWJAOlxWRpNSUYhOKqlAuW/Je01I5egQd/AEbU5eaY7SE51Y6h8DPWn3aNLhQdH5bt6uRGQkSRtz0FQkn3rJPyHE3h+fS+PkMwqrK1uVbSSHROQveJnstNktEvNTK+zgrqFh2EjFUMlybjE3C8bwyUjy25AyBH/wWxr3cAIcnoCO1Cnad1rJR0P+sg96DhqXwq+g5izdTXIERM5k5OUsmRsZdnfU7Y3PUVrS8Ke5oupz4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d67cfa2-1573-4aa8-7c02-08d6a795b94f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 09:24:42.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5828
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lsio_mu2 node which could be used communicate with SCU.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 16766838ac77..64eecd6cb1e9 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -339,6 +339,14 @@
 			#mbox-cells =3D <2>;
 		};
=20
+		lsio_mu2: mailbox@5d1d0000 {
+			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+			reg =3D <0x5d1d0000 0x10000>;
+			interrupts =3D <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells =3D <2>;
+			status =3D "disabled";
+		};
+
 		lsio_mu3: mailbox@5d1e0000 {
 			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
 			reg =3D <0x5d1e0000 0x10000>;
--=20
2.16.4

