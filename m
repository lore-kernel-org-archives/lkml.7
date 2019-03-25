Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578B0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6D220863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="htcAa9qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfCYLVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:21:04 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:30676 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYLVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:21:04 -0400
X-IronPort-AV: E=Sophos;i="5.60,256,1549954800"; 
   d="scan'208";a="26912912"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Mar 2019 04:21:04 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 25 Mar 2019 04:21:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMFYnZuVo8grDJs99H64rFAjxU16Hoyp8ekzzewuYWE=;
 b=htcAa9qosD7i8N5nm/FA/eWLZ+AvDUneuceG3Z7FrhQyErpPdVyeg2zYVSbvYt6cY0mnSoaJ71RLKSc+hnOBfDmPitEgP5frYanMz9VrlNTaHbLmFkiN8q9qFVnpLTIax/YlT5a4+bHze7GWb28AY7oTfdyVyjhWqrrESKD2U1Y=
Received: from BY5PR11MB4119.namprd11.prod.outlook.com (10.255.162.219) by
 BY5PR11MB4054.namprd11.prod.outlook.com (10.255.162.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 11:21:00 +0000
Received: from BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9]) by BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9%2]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 11:20:59 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>
CC:     <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH 1/1] net: phy: vitesse: Remove support for VSC8514
Thread-Topic: [PATCH 1/1] net: phy: vitesse: Remove support for VSC8514
Thread-Index: AQHU4vzSZvb7w8rM6E2oKUED/dt6kQ==
Date:   Mon, 25 Mar 2019 11:20:59 +0000
Message-ID: <20190325112040.1599-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:a03:54::21) To BY5PR11MB4119.namprd11.prod.outlook.com
 (2603:10b6:a03:18f::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kavyasree.Kotagiri@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [182.72.246.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 019f941a-3236-49ce-04e7-08d6b113f50f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BY5PR11MB4054;
x-ms-traffictypediagnostic: BY5PR11MB4054:
x-microsoft-antispam-prvs: <BY5PR11MB4054A3972273B04A6DE3F59D925E0@BY5PR11MB4054.namprd11.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(6512007)(102836004)(6116002)(66066001)(3846002)(486006)(97736004)(72206003)(6486002)(14454004)(6506007)(386003)(26005)(78486014)(2616005)(52116002)(476003)(6436002)(55236004)(106356001)(305945005)(256004)(2501003)(68736007)(36756003)(186003)(316002)(8936002)(71190400001)(54906003)(81156014)(81166006)(105586002)(110136005)(8676002)(5660300002)(50226002)(1076003)(71200400001)(99286004)(25786009)(107886003)(86362001)(478600001)(7736002)(2906002)(4326008)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4054;H:BY5PR11MB4119.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WKeXF1ISV0IuADUrCAmhO3lGlcDKPkbD0vhO/k6cKjEaFPJ4tbnK9af1gtzAFIXpHUPiW0E3KocaGmm92hwW8b1kKDEqWnfoBEpv9ggYR0k1EQaw/3QkLQ5ZEDFsN3TlADsD1QcPKtjmL5yenIH4ThTqglYGsB3aPyeb2Am6GrIyoB3Jg4ppesmfMLyhmtIo+QV0N2ln8Cr8iIfZUBsHVFPnenP6ncF2tfLQmOs6IWrpqYGR85aVXG0AWP39o/J+TRdu1NeXkbiRNHRDBacD8ZGTj7yMit572TSkLym1QheD9PIdlz2/IrxIALSRLToaaWTrK3Uak6agBTlYVmP0D06rTuoSV2qPvBssVEIeGi0zzo1lx2KYysnk6a8lPJetOt3nRz8cMSxH4pOj46Sau+UKAvfm3Dx8w3iW+vCZZT4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 019f941a-3236-49ce-04e7-08d6b113f50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 11:20:59.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4054
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>

Add support for VSC8514 in Microsemi driver (mscc.c)
with more features.

Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 drivers/net/phy/vitesse.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index dc0dd87a6694..e5eb98e94b02 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -61,7 +61,6 @@
=20
 #define PHY_ID_VSC8234			0x000fc620
 #define PHY_ID_VSC8244			0x000fc6c0
-#define PHY_ID_VSC8514			0x00070670
 #define PHY_ID_VSC8572			0x000704d0
 #define PHY_ID_VSC8601			0x00070420
 #define PHY_ID_VSC7385			0x00070450
@@ -293,7 +292,6 @@ static int vsc82xx_config_intr(struct phy_device *phyde=
v)
 		err =3D phy_write(phydev, MII_VSC8244_IMASK,
 			(phydev->drv->phy_id =3D=3D PHY_ID_VSC8234 ||
 			 phydev->drv->phy_id =3D=3D PHY_ID_VSC8244 ||
-			 phydev->drv->phy_id =3D=3D PHY_ID_VSC8514 ||
 			 phydev->drv->phy_id =3D=3D PHY_ID_VSC8572 ||
 			 phydev->drv->phy_id =3D=3D PHY_ID_VSC8601) ?
 				MII_VSC8244_IMASK_MASK :
@@ -403,15 +401,6 @@ static struct phy_driver vsc82xx_driver[] =3D {
 	.config_aneg	=3D &vsc82x4_config_aneg,
 	.ack_interrupt	=3D &vsc824x_ack_interrupt,
 	.config_intr	=3D &vsc82xx_config_intr,
-}, {
-	.phy_id		=3D PHY_ID_VSC8514,
-	.name		=3D "Vitesse VSC8514",
-	.phy_id_mask	=3D 0x000ffff0,
-	.features	=3D PHY_GBIT_FEATURES,
-	.config_init	=3D &vsc824x_config_init,
-	.config_aneg	=3D &vsc82x4_config_aneg,
-	.ack_interrupt	=3D &vsc824x_ack_interrupt,
-	.config_intr	=3D &vsc82xx_config_intr,
 }, {
 	.phy_id         =3D PHY_ID_VSC8572,
 	.name           =3D "Vitesse VSC8572",
@@ -499,7 +488,6 @@ module_phy_driver(vsc82xx_driver);
 static struct mdio_device_id __maybe_unused vitesse_tbl[] =3D {
 	{ PHY_ID_VSC8234, 0x000ffff0 },
 	{ PHY_ID_VSC8244, 0x000fffc0 },
-	{ PHY_ID_VSC8514, 0x000ffff0 },
 	{ PHY_ID_VSC8572, 0x000ffff0 },
 	{ PHY_ID_VSC7385, 0x000ffff0 },
 	{ PHY_ID_VSC7388, 0x000ffff0 },
--=20
2.17.1

