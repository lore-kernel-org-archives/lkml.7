Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0262133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lFIU/7e9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfB1PgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:36:25 -0500
Received: from mail-eopbgr730088.outbound.protection.outlook.com ([40.107.73.88]:33173
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387568AbfB1PgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12nGnKcwTMJQCGEGk5JIqNHf+6DO/u8MW4Ndrk0/1bQ=;
 b=lFIU/7e9pIOevJCpsMej3tHRER0WMTkKZMtvI+i2FC1Kuu2ehK3HdY8dxdnqHgduWqp9feQoYmkFCcdMmbpozsDw5OQQ0BN+IzrUCfSv8X/cYjVc84Y54K+MCjbqy4TBE16r/PtBvJqYdH3Da3FIu8+re8sGuAE6X+2xjmVLIXA=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2765.namprd12.prod.outlook.com (52.135.107.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 15:36:13 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 15:36:13 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 6/6] EDAC/amd64: Adjust printed Chip Select sizes when
 interleaved
Thread-Topic: [PATCH v3 6/6] EDAC/amd64: Adjust printed Chip Select sizes when
 interleaved
Thread-Index: AQHUz3tVG/TihK9EukmCwU4pr9pqeA==
Date:   Thu, 28 Feb 2019 15:36:12 +0000
Message-ID: <20190228153558.127292-6-Yazen.Ghannam@amd.com>
References: <20190228153558.127292-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190228153558.127292-1-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 266269f7-63b5-425a-5736-08d69d9277f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2765;
x-ms-traffictypediagnostic: SN6PR12MB2765:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2765;20:FpVr3Tu4vbreK/VbzHCfC8qG0kzGti8P6rkh5sGqgYoguLBT48kytY6IAf0TK8rBWTlUq8sa2kekn21ScNKi08EJcNbxyiTyu7DsEGPpO9CD5oEigoFnaH1PT16HV5wvONROkGxJaMfS5XCMYaWeIyJag/eqnvH5D0MtHlg6/AscagQQybRWGn2EFT6HQDjK/OsJeGjBEBh1MgSs5HCvtHOsDpHBU2qLfcLPTUPesbzFnlvwLTFZ69JeJaO3h+zy
x-microsoft-antispam-prvs: <SN6PR12MB2765E39690F36B8EFC5908D7F8750@SN6PR12MB2765.namprd12.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(189003)(3846002)(106356001)(2906002)(102836004)(26005)(25786009)(186003)(446003)(97736004)(316002)(68736007)(105586002)(6116002)(50226002)(4326008)(2351001)(7736002)(2501003)(81166006)(53936002)(81156014)(52116002)(305945005)(256004)(6486002)(99286004)(6436002)(76176011)(5640700003)(66066001)(71200400001)(71190400001)(5660300002)(8936002)(36756003)(2616005)(486006)(14444005)(11346002)(476003)(478600001)(966005)(54906003)(6506007)(6306002)(14454004)(1076003)(72206003)(386003)(8676002)(86362001)(6916009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2765;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N1y6u0t2d+IlkXibR9eKnhJ3fnw0iqZ8Wzk4pv5C2l+ygdfjg13PA28AqRZU3T9ubNxCcSt4dRP0bcYY4RHKjZmy6QI1nVElFBXcbwQ5p/VeArjVryfqNsdsjoX2XQZyksB846Kd0/fUbaCG2Uml1t5eHAvAtcggSH3iyNaQtXU5P5CHSmCnpFfWYc7GBj8fAbBTHrvixMfDiopJwnL7UEgjlT+2vqR8UyaU9Y3u7yo+t14X4K2HSaPL3D9+L2YBv1Smhyhdyq+RGExNbt9bu2CVkn1n/55MgvfYRpAArPzlYwwGSAOrgDxaFTubclbajKZldL3CanXBhSkXk1hbjw/cdB0eb7gpYmBnvtVB/iAy7Ny4wVi677II1KSLR96I4tpEpJhWmJAEY6BJ18wPWkTFjwzsUP02H70Abc5A1lw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266269f7-63b5-425a-5736-08d69d9277f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:36:12.5934
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

AMD systems may support Chip Select interleaving. However, on Family
17h+ this was not taken into account when printing the Chip Select
sizes.

Add support to detect if Chip Selects are interleaved on Family 17h+,
and adjust the sizes accordingly.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190226172532.12924-6-Yazen.Ghannam@amd.com

v2->v3:
* Change Fam17h+ to Family 17h+ in commit message.

v1->v2:
* No change.

 drivers/edac/amd64_edac.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c05995685cfa..1b9cf916b2d0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -784,6 +784,22 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *p=
vt, u32 dclr, int chan)
 		 (dclr & BIT(15)) ?  "yes" : "no");
 }
=20
+/*
+ * The Address Mask should be a contiguous set of bits in the non-interlea=
ved
+ * case. So to check for CS interleaving, find the most- and least-signifi=
cant
+ * bits of the mask, generate a contiguous bitmask, and compare the two.
+ */
+static bool f17_cs_interleaved(struct amd64_pvt *pvt, u8 ctrl, int cs)
+{
+	u32 mask =3D pvt->csels[ctrl].csmasks[cs >> 1];
+	u32 msb =3D fls(mask) - 1, lsb =3D ffs(mask) - 1;
+	u32 test_mask =3D GENMASK(msb, lsb);
+
+	edac_dbg(1, "mask=3D0x%08x test_mask=3D0x%08x\n", mask, test_mask);
+
+	return mask ^ test_mask;
+}
+
 static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 {
 	int dimm, size0, size1, cs0, cs1;
@@ -800,8 +816,19 @@ static void debug_display_dimm_sizes_df(struct amd64_p=
vt *pvt, u8 ctrl)
 		size1 =3D 0;
 		cs1 =3D dimm * 2 + 1;
=20
-		if (csrow_enabled(cs1, ctrl, pvt))
-			size1 =3D pvt->ops->dbam_to_cs(pvt, ctrl, 0, cs1);
+		if (csrow_enabled(cs1, ctrl, pvt)) {
+			/*
+			 * CS interleaving is only supported if both CSes have
+			 * the same amount of memory. Because they are
+			 * interleaved, it will look like both CSes have the
+			 * full amount of memory. Save the size for both as
+			 * half the amount we found on CS0, if interleaved.
+			 */
+			if (f17_cs_interleaved(pvt, ctrl, cs1))
+				size1 =3D size0 =3D (size0 >> 1);
+			else
+				size1 =3D pvt->ops->dbam_to_cs(pvt, ctrl, 0, cs1);
+		}
=20
 		amd64_info(EDAC_MC ": %d: %5dMB %d: %5dMB\n",
 				cs0,	size0,
--=20
2.17.1

