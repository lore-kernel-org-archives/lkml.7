Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF06C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB96220880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n14GEp2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDHHoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:44:25 -0400
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:21661
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfDHHoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/2nGpesZJOni/Dr50h1SKPU8Svx/PET4tgCvt+/w9U=;
 b=n14GEp2j+UyVcx/xny2wnMcUlOV3V4gcWafjh1Z1euxp2sRCuxaqY7CgLPvenwFHlTLfu5C8q7twRSbegg+jW8/hQftygcKEc9rF5/0gxvqw1k4Rjwn9JLvLRDPZNQg3qjSIETg+WPtymOf+AguJHvvYTAarkZGJ7JCrBKSlt14=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3851.eurprd04.prod.outlook.com (52.134.73.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 07:44:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 07:44:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] ARM: dts: imx6dl-sabreauto: update opp table for auto part
Thread-Topic: [PATCH] ARM: dts: imx6dl-sabreauto: update opp table for auto
 part
Thread-Index: AQHU7d7haKynv6Ajb0CSZ7OdzGGN1A==
Date:   Mon, 8 Apr 2019 07:44:21 +0000
Message-ID: <1554709166-21952-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd0a1b18-9235-42a7-e104-08d6bbf60358
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3851;
x-ms-traffictypediagnostic: DB3PR0402MB3851:
x-microsoft-antispam-prvs: <DB3PR0402MB385136A376B523693A057C43F52C0@DB3PR0402MB3851.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(199004)(189003)(66066001)(26005)(186003)(52116002)(386003)(6506007)(102836004)(4326008)(6512007)(14454004)(53936002)(2616005)(476003)(486006)(478600001)(256004)(110136005)(14444005)(316002)(36756003)(6436002)(6486002)(68736007)(2906002)(50226002)(8676002)(15650500001)(71190400001)(2201001)(99286004)(305945005)(5660300002)(7736002)(81166006)(97736004)(8936002)(81156014)(106356001)(105586002)(25786009)(6116002)(3846002)(86362001)(2501003)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3851;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: obNgJ0xcZ8rM9cu7cVBzE/WxfdSYPtZxMg8lWuBhtOsHuG2u3SQ3IQ01LQPYDRTAdKMKCXo8c0e0Z+jsCinTajj9XxrF7v/FEojFlFxnU3h53whRPabDV11zRSGVX8qXljgRU+AIzDF7u3y16OJikp1B9rg3wU4o23XUJaJzKJam+cZ4213eKN+XUIAu5k6vY+WNz8g0NJzkGEsmU/XJhcp4lzi4tVGIUUa5Bb+8cNt9lvx5UPWKuMPYO1n33Ey1/xfzaA+0RUZaCpk7FqbEIlOosmen+tgJM/1cgmTfjZF2VY5S9rbeM6DEJOpygmnBFvw0RZszih4L9P0Z/WtFiViaE7ibh8/yTW3WeM8vwb5rAWdlIWUuai5BIdCo+VO4Ao7xFnDYHpimrhbA/X2zZtrS3CRx8PXJKpKJmzC40J4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0a1b18-9235-42a7-e104-08d6bbf60358
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 07:44:21.8073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update i.MX6DL automotive part's opp table according to i.MX6DL
automotive datasheet Rev.9, 11/2018, it adds 996MHz set-point
support as below:

LDO enabled(min value):
996MHz: VDDARM: 1.275V, VDDSOC: 1.175V;
792MHz: VDDARM: 1.150V, VDDSOC: 1.150V;
396MHz: VDDARM: 1.125V, VDDSOC: 1.150V;

Adding 25mV to cover board IR drop, for LDO enabled mode of 996MHz,
as the max value of LDO output can NOT exceed 1.3V, so 25mV is NOT
added for VDDARM.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6dl-sabreauto.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-sabreauto.dts b/arch/arm/boot/dts/imx=
6dl-sabreauto.dts
index 660d52a..ff3283c8 100644
--- a/arch/arm/boot/dts/imx6dl-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6dl-sabreauto.dts
@@ -11,3 +11,18 @@
 	model =3D "Freescale i.MX6 DualLite/Solo SABRE Automotive Board";
 	compatible =3D "fsl,imx6dl-sabreauto", "fsl,imx6dl";
 };
+
+&cpu0 {
+	operating-points =3D <
+		/* kHz    uV */
+		996000  1275000
+		792000  1175000
+		396000  1150000
+	>;
+	fsl,soc-operating-points =3D <
+		/* ARM kHz  SOC-PU uV */
+		996000	1200000
+		792000	1175000
+		396000	1175000
+	>;
+};
--=20
2.7.4

