Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EC2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0740F2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W2i2VnQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfCVU3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:29:36 -0400
Received: from mail-eopbgr720063.outbound.protection.outlook.com ([40.107.72.63]:51697
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbfCVU3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46/SniMC/GMfqgJNga2Mv3na2F7Htwfzu/o2wgh7fYg=;
 b=W2i2VnQMm5k/sboD/qiqFRqquhN6iXltxfaQuVdgB3Pe5HI9TbHnZWLa4KgW/pnoF2URzkXMM6Cb1mbIE4ra1apSFNSqxX7IN36+sLKiM+JhKnp5mXnjNGmYHXjrhs26f9GSif/ROyJ9gbaKtLkCfH5Xl1ykr1z9ppRnLdoRdEI=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2638.namprd12.prod.outlook.com (52.135.103.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 20:29:00 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 20:29:00 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: [PATCH v3 3/3] x86/MCE: Group AMD function prototypes in <asm/mce.h>
Thread-Topic: [PATCH v3 3/3] x86/MCE: Group AMD function prototypes in
 <asm/mce.h>
Thread-Index: AQHU4O3iFzQvXmePb0Oaq1WkwtWPLg==
Date:   Fri, 22 Mar 2019 20:29:00 +0000
Message-ID: <20190322202848.20749-3-Yazen.Ghannam@amd.com>
References: <20190322202848.20749-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190322202848.20749-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR01CA0017.prod.exchangelabs.com (2603:10b6:805:b6::30)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84a0c104-e439-4aa4-b714-08d6af05045e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2638;
x-ms-traffictypediagnostic: SN6PR12MB2638:
x-microsoft-antispam-prvs: <SN6PR12MB263843099D75EFDA2BA7E6BEF8430@SN6PR12MB2638.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(2906002)(478600001)(71190400001)(26005)(6506007)(4326008)(316002)(102836004)(97736004)(25786009)(99286004)(256004)(486006)(72206003)(446003)(14444005)(2616005)(2501003)(1076003)(14454004)(86362001)(476003)(11346002)(5660300002)(71200400001)(106356001)(186003)(105586002)(8676002)(2351001)(81156014)(53936002)(386003)(68736007)(81166006)(7736002)(6486002)(305945005)(52116002)(36756003)(76176011)(3846002)(54906003)(5640700003)(66066001)(6436002)(6916009)(6116002)(8936002)(6512007)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2638;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CEFSqIAx9xZVRLrfMw8pfiwK0umd79Fq6U8qbkqGC/43XqU4xSI7gYTkjkDjR+qi/KgNhK1o0p7VtYdj/lk+QwmNT3u7KGEfMhw9axI54TBYWlKdEI7A2asQGPN4y6RlEOyNd5Li81xr7fcymiDzfbCW14MCi7DyG5GMSNYl4qkPVdGPjYOF5Zp+2edShSG9E7pirRL8pAJJnQOYfuO2YssaTSsPgRmEMmK2jmNDRjXCoaI5AvSLPrTtVugrOdpdXy5/KhWeF2fOg68Zx6dJ1FAHiss4jC6rknCUF4lJgtBNgFeAL3tSrCxAXagyzg9jH2H6kAeE5AjBPucP7JsTD32dEhE5pPQ5X4qpvNRmPmP3wSA4n7LAa+m26RI/1EMpdO13+iZIjtykCR/g0dV/jL+596W9OKMyGFzK1Ec0ceg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a0c104-e439-4aa4-b714-08d6af05045e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 20:29:00.5559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

There are two groups of "ifdef CONFIG_X86_MCE_AMD" function prototypes
in <asm/mce.h>.

Merge these two groups.

No functional change.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
v2->v3
* This patch is new and unrelated to the other two. I just happened to
  notice this issue when making other changes.

 arch/x86/include/asm/mce.h | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 50f76a7956cc..acb76ca7a23c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -210,16 +210,6 @@ static inline void cmci_rediscover(void) {}
 static inline void cmci_recheck(void) {}
 #endif
=20
-#ifdef CONFIG_X86_MCE_AMD
-void mce_amd_feature_init(struct cpuinfo_x86 *c);
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)=
;
-#else
-static inline void mce_amd_feature_init(struct cpuinfo_x86 *c) { }
-static inline int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, =
u64 *sys_addr) { return -EINVAL; };
-#endif
-
-static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c) { return =
mce_amd_feature_init(c); }
-
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 bool mce_is_correctable(struct mce *m);
@@ -349,13 +339,20 @@ extern bool filter_mce_amd(struct mce *m);
 extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
=20
+void mce_amd_feature_init(struct cpuinfo_x86 *c);
+int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)=
;
+
 #else
=20
 static inline int mce_threshold_create_device(unsigned int cpu) { return 0=
; };
 static inline int mce_threshold_remove_device(unsigned int cpu) { return 0=
; };
 static inline bool amd_mce_is_memory_error(struct mce *m) { return false; =
};
 static inline bool filter_mce_amd(struct mce *m) { return false; };
+static inline void mce_amd_feature_init(struct cpuinfo_x86 *c) { }
+static inline int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, =
u64 *sys_addr) { return -EINVAL; };
=20
 #endif
=20
+static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c) { return =
mce_amd_feature_init(c); }
+
 #endif /* _ASM_X86_MCE_H */
--=20
2.17.1

