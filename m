Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC55C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9FA2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SooABjy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfC1PcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:32:19 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:50085 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfC1PcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:32:19 -0400
X-IronPort-AV: E=Sophos;i="5.60,280,1549954800"; 
   d="scan'208";a="30346664"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 28 Mar 2019 08:32:18 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 28 Mar 2019 08:32:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hleiMnvGaMVfWbPfWwVn16uXFbAZ5IQyouvv9S+Fa18=;
 b=SooABjy16nvpaOmlsQoBOOdJymP4T2e9gFrb+6g362vjWz+2+2GyP0aWPEBFTHnasUbGU08GGPTvOXOY41Pda/DMywcfS+eKfMz7Cpvs30t+doI1kI6IP5Yic6Taki+mGq7YY2qviSJOioh94dm86Tghf0Ij+fym9NhUIpw6yOU=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0076.namprd11.prod.outlook.com (10.164.155.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 28 Mar 2019 15:32:16 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e8b6:2ae9:9b9c:2ca8]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e8b6:2ae9:9b9c:2ca8%3]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 15:32:16 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>
CC:     <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH v3 2/2] media: atmel: atmel-isc: removed ARGB32 added ABGR32
 and XBGR32
Thread-Topic: [PATCH v3 2/2] media: atmel: atmel-isc: removed ARGB32 added
 ABGR32 and XBGR32
Thread-Index: AQHU5XtrYsjZYeedI0q6N+pQVkcx+Q==
Date:   Thu, 28 Mar 2019 15:32:14 +0000
Message-ID: <1553786825-16942-2-git-send-email-eugen.hristev@microchip.com>
References: <1553786825-16942-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1553786825-16942-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0238.eurprd08.prod.outlook.com
 (2603:10a6:802:15::47) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40504d05-9600-4664-f966-08d6b3928dae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB0076;
x-ms-traffictypediagnostic: DM5PR11MB0076:
x-microsoft-antispam-prvs: <DM5PR11MB00760928B5B291C17BB2D281E8590@DM5PR11MB0076.namprd11.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(2501003)(53936002)(2201001)(26005)(6506007)(386003)(5660300002)(86362001)(102836004)(71190400001)(71200400001)(6512007)(52116002)(76176011)(186003)(2616005)(486006)(476003)(99286004)(25786009)(110136005)(68736007)(316002)(446003)(7736002)(54906003)(305945005)(50226002)(8936002)(11346002)(72206003)(81156014)(81166006)(2906002)(8676002)(14454004)(3846002)(478600001)(6116002)(256004)(14444005)(4326008)(66066001)(6486002)(97736004)(6436002)(107886003)(106356001)(36756003)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0076;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /FUYuBUlqzDgm6rbK9sNunkOogXHLX95Xnj266qZ6LmS4T9J/bKEHjql1kmRQqJRJnVeuOFb+2WpDMgVld5O4Fs9+61U/7E/sXfZXyT836bojVvTf5/8QUglUp1PIaI++u8XUS/rNHn2ri1X75TOP21prCJc1OzSiNELdX8dyDgOhpNwwvnwyQV10VMY/OACscwcrxeowskvUukhWu7XE6GdAbnVxyIVjUNNagJS34UrXWevGPRIAOKkPatJzTFLV88UPHQENnS2jXCbV8OXQ4LHNCnqKt7tuSH1fNOTDAStkFz8TjPxowyCadEsK31zCh1+fOqNoqQ5mxxI5TlG9RCj9R99SpnKA0LP/zZ0BNGTHmTJQoEdef6X9sn+f6nYkLJuTIU8QqQ5aibeCwB125QShdEYOC6tJ+4ndOXxBQo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 40504d05-9600-4664-f966-08d6b3928dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 15:32:14.7609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0076
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

ISC will output the "ARGB32" configuration in byte order: B, G, R, Alpha.
This is in fact the format BGRA, aka ABGR32.
If alpha is missing, the same format is equivalent to XBGR32.
Added both formats and removed ARGB32 which is wrong.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-isc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platf=
orm/atmel/atmel-isc.c
index 8c4b6f1..2cab777 100644
--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -228,7 +228,10 @@ static struct isc_format controller_formats[] =3D {
 		.fourcc		=3D V4L2_PIX_FMT_RGB565,
 	},
 	{
-		.fourcc		=3D V4L2_PIX_FMT_ARGB32,
+		.fourcc		=3D V4L2_PIX_FMT_ABGR32,
+	},
+	{
+		.fourcc		=3D V4L2_PIX_FMT_XBGR32,
 	},
 	{
 		.fourcc		=3D V4L2_PIX_FMT_YUV420,
@@ -1099,7 +1102,8 @@ static int isc_try_validate_formats(struct isc_device=
 *isc)
 		break;
=20
 	case V4L2_PIX_FMT_RGB565:
-	case V4L2_PIX_FMT_ARGB32:
+	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_XBGR32:
 	case V4L2_PIX_FMT_ARGB444:
 	case V4L2_PIX_FMT_ARGB555:
 		ret =3D 0;
@@ -1183,7 +1187,8 @@ static int isc_try_configure_rlp_dma(struct isc_devic=
e *isc, bool direct_dump)
 		isc->try_config.dctrl_dview =3D ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp =3D 16;
 		break;
-	case V4L2_PIX_FMT_ARGB32:
+	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_XBGR32:
 		isc->try_config.rlp_cfg_mode =3D ISC_RLP_CFG_MODE_ARGB32;
 		isc->try_config.dcfg_imode =3D ISC_DCFG_IMODE_PACKED32;
 		isc->try_config.dctrl_dview =3D ISC_DCTRL_DVIEW_PACKED;
@@ -1229,7 +1234,8 @@ static int isc_try_configure_pipeline(struct isc_devi=
ce *isc)
 	case V4L2_PIX_FMT_RGB565:
 	case V4L2_PIX_FMT_ARGB555:
 	case V4L2_PIX_FMT_ARGB444:
-	case V4L2_PIX_FMT_ARGB32:
+	case V4L2_PIX_FMT_ABGR32:
+	case V4L2_PIX_FMT_XBGR32:
 		/* if sensor format is RAW, we convert inside ISC */
 		if (ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
 			isc->try_config.bits_pipeline =3D CFA_ENABLE |
--=20
2.7.4

