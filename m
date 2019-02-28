Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC52DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901352133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GcvOzswG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbfB1PgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:36:14 -0500
Received: from mail-eopbgr730088.outbound.protection.outlook.com ([40.107.73.88]:33173
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727789AbfB1PgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70JoHTxRteKo2W6Jn/tQSdvyV+geVjxmdWToeIs3GPo=;
 b=GcvOzswG/tNnrZZ/7DaBm2T3BcWMZCFAk/sV3XegeLitDUabbTHKBaXMFE9BkO+SGEEEPiM68TiKuzBvuihX1n8oLZ407wbbxcRS0LSR7e4GofDqx3m2ROrAWiGc9nFPRWJf0CB7mQTiecGpGT/N6Nas5pG20H7czhhN1aKEoY0=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2765.namprd12.prod.outlook.com (52.135.107.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 15:36:10 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 15:36:10 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 1/6] EDAC/amd64: Add Family 17h Model 30h PCI IDs
Thread-Topic: [PATCH v3 1/6] EDAC/amd64: Add Family 17h Model 30h PCI IDs
Thread-Index: AQHUz3tUM9ZrTnXDwUK+nakLJj6Q4g==
Date:   Thu, 28 Feb 2019 15:36:09 +0000
Message-ID: <20190228153558.127292-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:805:8e::41) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ceeab61-97ab-4bd8-11f3-08d69d927658
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2765;
x-ms-traffictypediagnostic: SN6PR12MB2765:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2765;20:79Hby6VePnqH5ZvnLolGRvG2GdKjIXgK2Ivi7aZ0bBS85Ej5gFlTi9lhzLtoxwDEneGc/Btsp2Bpc16FLDFIrukEX5p78akz+C4sdCpGhWqmWWMf3om1wK2H+XWZkZ3Nk1Y6hxH3CMsDOemNvzr8+S2alAzoGB6kJnCr8uT/PbJeWXMRBbLkijduevl8/+6+IOo6L504ukoGI07cv88oym2A2+rNyLXZZGl/wYDFlZfKei5C6qRGWZLnxKoVsfIV
x-microsoft-antispam-prvs: <SN6PR12MB276549BF8AE5C3D2C4E8A3CDF8750@SN6PR12MB2765.namprd12.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(189003)(3846002)(106356001)(2906002)(102836004)(26005)(25786009)(186003)(97736004)(316002)(68736007)(105586002)(6116002)(50226002)(4326008)(2351001)(7736002)(2501003)(81166006)(53936002)(81156014)(52116002)(305945005)(256004)(6486002)(99286004)(6436002)(5640700003)(66066001)(71200400001)(71190400001)(5660300002)(8936002)(36756003)(2616005)(486006)(14444005)(476003)(478600001)(966005)(54906003)(6506007)(6306002)(14454004)(1076003)(72206003)(386003)(8676002)(86362001)(6916009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2765;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 09oq9hYtFem3LiN1yAyEoa3iC+eOglQfxepcTyTTM+V1/qJlVfUiYrWLNl936MFRCknbrGZqXuoRrQhkuRwF3VYwMgbA1b3sMdrTj8Ovfrqmqj914IyeTQYLIZgHzTOvwqkTNRw/1+766Y1jpQYg93jPVL2VWK52wOYD1xmIIgPej/NEGWbOujz0HXaRgXLbG557HbCqXmNVSeW3B4HPa/13UgETLZPyBdgilkkwFQ3kh5yMYgDGo5zrA+SIj09m7hnbenpNcsX66faJBTyXdVv+ODw+6kAB+Nyd8v4RdMfS5zM6knAl9z8PN5cFX/H8rHdNUCzH0pxHbmEgkWcrRo8j6fhwpt9GTooWsE9U59SP3wofEtRDVAzQmNa+jVs5nA2U7eaQGJM+zpsLvxvpK6pvGlFLUuk/o6JGL0K6p/k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ceeab61-97ab-4bd8-11f3-08d69d927658
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:36:10.0026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Add the new Family 17h Model 30h PCI IDs to the AMD64 EDAC module.

This also fixes a probe failure that appeared when some other PCI IDs
for Family 17h Model 30h were added to the AMD NB code.

Fixes: be3518a16ef2 (x86/amd_nb: Add PCI device IDs for family 17h, model 3=
0h)
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190226172532.12924-1-Yazen.Ghannam@amd.com

v2->v3:
* No change.

v1->v2:
* Write out "Family" and "Model" in commit message.
* Sort model checks in increasing order.

 drivers/edac/amd64_edac.c | 13 +++++++++++++
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 6ea98575a402..98e8da9d9f5b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2211,6 +2211,15 @@ static struct amd64_family_type family_types[] =3D {
 			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
 		}
 	},
+	[F17_M30H_CPUS] =3D {
+		.ctl_name =3D "F17h_M30h",
+		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
+		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
+		.ops =3D {
+			.early_channel_count	=3D f17_early_channel_count,
+			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
+		}
+	},
 };
=20
 /*
@@ -3203,6 +3212,10 @@ static struct amd64_family_type *per_family_init(str=
uct amd64_pvt *pvt)
 			fam_type =3D &family_types[F17_M10H_CPUS];
 			pvt->ops =3D &family_types[F17_M10H_CPUS].ops;
 			break;
+		} else if (pvt->model >=3D 0x30 && pvt->model <=3D 0x3f) {
+			fam_type =3D &family_types[F17_M30H_CPUS];
+			pvt->ops =3D &family_types[F17_M30H_CPUS].ops;
+			break;
 		}
 		/* fall through */
 	case 0x18:
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 4242f8e39c18..de8dbb0b42b5 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -117,6 +117,8 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F0 0x15e8
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
=20
 /*
  * Function 1 - Address Map
@@ -284,6 +286,7 @@ enum amd_families {
 	F16_M30H_CPUS,
 	F17_CPUS,
 	F17_M10H_CPUS,
+	F17_M30H_CPUS,
 	NUM_FAMILIES,
 };
=20
--=20
2.17.1

