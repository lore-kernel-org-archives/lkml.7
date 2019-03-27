Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D16C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F62A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qa09548L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbfC0J4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:56:54 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33869 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbfC0J4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:56:54 -0400
X-IronPort-AV: E=Sophos;i="5.60,276,1549954800"; 
   d="scan'208";a="30232346"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Mar 2019 02:56:53 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 27 Mar 2019 02:56:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa9T/E3LUu3VwP18ps+ewM0D4BvAjPnYx1Mnhp7lsSA=;
 b=qa09548LurxudHyerVewfXAWqvirHgc8MaSfgLFkEA3b/TaNLFK2+f+whCwlSnIhX6DOMwqqGujOnAbfvaFAvJwRB5WBtIM1dy8Zty9WEoXFKxNfwTkhdepIoYSz+gtdnd0K9/XRNWnHe+jHxuBgqz/gyyTAug6P4JKj98EcGZA=
Received: from BY5PR11MB4119.namprd11.prod.outlook.com (10.255.162.219) by
 BY5PR11MB4054.namprd11.prod.outlook.com (10.255.162.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Wed, 27 Mar 2019 09:56:49 +0000
Received: from BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9]) by BY5PR11MB4119.namprd11.prod.outlook.com
 ([fe80::4454:7962:5f5a:72e9%2]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 09:56:49 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v1 2/2] net: phy: vitesse: Remove support for VSC8514
Thread-Topic: [PATCH v1 2/2] net: phy: vitesse: Remove support for VSC8514
Thread-Index: AQHU5INlST6I8Jev0keUG+1fjUZLHA==
Date:   Wed, 27 Mar 2019 09:56:49 +0000
Message-ID: <20190327095620.6287-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0057.namprd08.prod.outlook.com
 (2603:10b6:a03:117::34) To BY5PR11MB4119.namprd11.prod.outlook.com
 (2603:10b6:a03:18f::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kavyasree.Kotagiri@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [182.72.246.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59dd8d81-2390-446d-446b-08d6b29a87c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BY5PR11MB4054;
x-ms-traffictypediagnostic: BY5PR11MB4054:
x-microsoft-antispam-prvs: <BY5PR11MB40540C504010A916D6AEED1192580@BY5PR11MB4054.namprd11.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(66066001)(26005)(6116002)(3846002)(97736004)(72206003)(6486002)(476003)(6506007)(486006)(52116002)(386003)(78486014)(2616005)(6436002)(14454004)(55236004)(6512007)(102836004)(256004)(305945005)(106356001)(2501003)(68736007)(186003)(81156014)(316002)(105586002)(54906003)(81166006)(110136005)(71190400001)(5660300002)(50226002)(8676002)(71200400001)(25786009)(99286004)(107886003)(2201001)(1076003)(86362001)(478600001)(36756003)(7736002)(8936002)(2906002)(4326008)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4054;H:BY5PR11MB4119.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yQPR37GyCsOSmzMiMnhbsb1OCo0Caec4YxtxiC9zIEC6d+FVJgcl5T0/AYwdihp89JM0uCFjcT2rG2CwZ7PH+5IJNrTrHYAruJX9JZ6fPuqw6VTk93lAn95x/0YweB3EVDoltKtMVyJGJT7YAupjFg5XLdhsT7W+aGLE00UU+0FQmLByyAQ+r1M0CBRfq/1q7wbZYp8AlfuYKWq9WS9NqsZ2hhUcmPWDwM4XGMNxtIWwDiFWo1d/JlJUup7bB1AfRzjmp9h2CVZj63b3+/ucsj/irEMe960scYGIDXj3FmtCl0Y2rPbQBjAkIzRrtAFgpad4rACwyOZOulPFxRsVL4zotMUFAeqAtITZx1Z1hkpj2EXCN/s24WB1zDRHu5+hYFbTJVynEGTUJI+DCWt77ZSQ6bf3qns/niIqznCz/uw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dd8d81-2390-446d-446b-08d6b29a87c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 09:56:49.6915
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

From: Kavya Sree <kavyasree.kotagiri@microchip.com>

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

