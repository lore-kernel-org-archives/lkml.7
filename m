Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88719C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA45214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P7KIDy/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfB1BX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:23:58 -0500
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:56195
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730534AbfB1BXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPr6qhO8Mgxvbuzaxu70e1wRIB+Un/RcdsxWhpPsMpY=;
 b=P7KIDy/PmQL/LwlNqXdQXSqd904yC6h7Krt/LjHO5WocE8X7OTKmviJyrMBRb0QO6pcAe0Qmn9iEOaFcvB9d+aMKZUoGJFLjUlwaUJRNhyAy/Hzu2aNyjeC3q8ZDZaSC4/XE6xLQewe+tyCQxexV3bO/PeHQ9TIUyvorSA98lTM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 01:23:52 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 01:23:52 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 2/3] ARM: dts: imx7ulp: add mmdc support
Thread-Topic: [PATCH V2 2/3] ARM: dts: imx7ulp: add mmdc support
Thread-Index: AQHUzwRDJ7uxcAbsqkmFaMlWuVCzvA==
Date:   Thu, 28 Feb 2019 01:23:52 +0000
Message-ID: <1551316741-7848-2-git-send-email-Anson.Huang@nxp.com>
References: <1551316741-7848-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551316741-7848-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8415a5e0-fd08-43e6-6875-08d69d1b65f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3898;23:jzgwTFvKar0wWQu/ZfnYz3n1f1iLBGGvHHSGK?=
 =?iso-8859-1?Q?a5xIti0BvzuMTeu20tUbJHeX/NFDH7/LnitCHEoAV/fmBsQTo92xgeF3kS?=
 =?iso-8859-1?Q?7PFgeeO1ZpUJJLBQd3BEQBkkWOOkXv/pRwzurK/MY3OZ7dDqFEUizWfwHi?=
 =?iso-8859-1?Q?PU6dus1VX7JJ/bZYhBQt20ApqAVvvjOmd8fGV7LW7SpdsyJ5Hg2pez+wKz?=
 =?iso-8859-1?Q?3nmMSTVt8+qel40NezpC55N2QSHARl0ODpAM4NW2uj0874C+vMnCyiFmIR?=
 =?iso-8859-1?Q?k2T1nEiJi0UUncBlffMuccQ0/TEHJUkoA/c+p/4SjIJJ/lE2pPg5BzJAyK?=
 =?iso-8859-1?Q?UrhetLgFdcA6XUHcenXI3daAThve2Xz/yZieybyAhkHcSV5Xcp3eAme0+J?=
 =?iso-8859-1?Q?c2MMimwQTcGOFOkQDe5+7704/sxLgpmUr5JHLdKulD8xtFOxUGGdEzRra1?=
 =?iso-8859-1?Q?c0b3vq/NCP5Gs5KrS0I2iiu/wDZEiNAeOeC8pANSOOdn7lTSzIIZzdvIwv?=
 =?iso-8859-1?Q?y3vRIDYp4EgyXhOyy0pGTPLwNeQQ5FtVXVsUw0aGbNpXvODT/WJxuVpF/v?=
 =?iso-8859-1?Q?dfadqQFSa5EjF4yfEBQRiW1jR5/htwKuGmjRwwa08dXIb70Zif5F22MoUm?=
 =?iso-8859-1?Q?I2oY9pN0aJnFmp6LvzVwUGwToAY5/OTVXhUsyXTBLUBbyP8i4fjAP1xzw8?=
 =?iso-8859-1?Q?e8qXJaXDgiLR6HuMVZrU62wAhos+9gfGkOYvFHxByBW97aYdGBztLoaZ7g?=
 =?iso-8859-1?Q?UkFK2sQTmP+XMUXV+veGttR4/1B+PVqyD7iBizyxMgHn68dCbxLmD2X0Kk?=
 =?iso-8859-1?Q?fZT1CqW68Bc2DdAZidNvfzCNYXrkdo0cTCV/Xa36GxyKRzmBh/anmKZmfH?=
 =?iso-8859-1?Q?jayZRLKJgk+fFD9dQ6iZg+o/1lZQLIk8ujEwKJhcSGxegTy448xTICMAoZ?=
 =?iso-8859-1?Q?wxzAw5+r5GQ546C4nb7zzT27o3ZqdN514bJVYSsNVYCEIgDwqgYZ/0WjSz?=
 =?iso-8859-1?Q?SmDvtDadgPUnuIajkNz/6etVlCR98axOmd7+HIa2FWwhAp9jn/GMFBixeB?=
 =?iso-8859-1?Q?fOJJH4OiFn8sX8PmzKuqvrshnrdNAG9hxpZrDV3U8o7hhmDTCUNI5fYBrB?=
 =?iso-8859-1?Q?KyI1Luv8w79eR/j7htD9Bz08qEpCxz1ZT40DIWIF64B4BoQxLvT3iqno7k?=
 =?iso-8859-1?Q?XNua53K0QR0wsIM1ozj0P7+Izf8QD52FoV4cSbTiWDbNDraWF/a7ezusjR?=
 =?iso-8859-1?Q?UdAJpNBexiHaOap74SC1NFh+xXahqKQKzislo2pirTBG05doS91YTIKS/q?=
 =?iso-8859-1?Q?4wsU=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB38981D9F2F63EEF662982E53F5750@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(71200400001)(4326008)(71190400001)(4744005)(478600001)(81156014)(81166006)(8676002)(66066001)(7736002)(14454004)(316002)(256004)(446003)(2616005)(2906002)(68736007)(26005)(476003)(97736004)(25786009)(305945005)(5660300002)(11346002)(486006)(14444005)(99286004)(2501003)(6486002)(2201001)(36756003)(53936002)(86362001)(6116002)(3846002)(76176011)(6512007)(52116002)(105586002)(186003)(102836004)(110136005)(8936002)(386003)(6506007)(106356001)(6436002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HGkDjyuDNVsNSTHqJ5hPL+M8nG6a6JOs/VCwf5KqKQyQ0EWiM1jeg8LArEjRAAyZszW/XMGvGv/r76cQWe+W8b9YUbsPYRWMgz7tCsFt3nmkiB9/BePpF0EIInp1+vakRshnC072rhLThbncLwau9ii+Ews9dKcmkNmrTDL18l6wqF0yVJ3qPoBmYI+xtHeqAAWMsXNs+q6M9uSn/2yfWoG1adOkvtffRK4HjWPsL6JLw4g7CjLYt7HRdXCk0yxWi8Mm1hP2RHpEOe5cek0pHwt5IE1AP2VvshkI2MqA3o5b/YWruo6hu7nyqf/VRIHk1jCqM+QbPC0Eq39pQGKnOJwjrPRscro5X8ge8qdUDicvQrmeJd2IvJGTLRRhe3/r1t8qDraCSzEPioLyZXiIZzb3cfhBMjVjM3FIUe1ERK4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8415a5e0-fd08-43e6-6875-08d69d1b65f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 01:23:48.7294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP has a MMDC module to control DDR, it reuses
i.MX6Q's MMDC module, add support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- use "memory-controller" as MMDC node name to make it more generic.
---
 arch/arm/boot/dts/imx7ulp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index fca6e50..78f6117 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -286,6 +286,12 @@
 			status =3D "disabled";
 		};
=20
+		mmdc: memory-controller@40ab0000 {
+			compatible =3D "fsl,imx7ulp-mmdc", "fsl,imx6q-mmdc";
+			reg =3D <0x40ab0000 0x1000>;
+			clocks =3D <&pcc3 IMX7ULP_CLK_MMDC>;
+		};
+
 		iomuxc1: pinctrl@40ac0000 {
 			compatible =3D "fsl,imx7ulp-iomuxc1";
 			reg =3D <0x40ac0000 0x1000>;
--=20
2.7.4

