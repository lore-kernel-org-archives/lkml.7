Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFF7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912B1222C1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfCXK3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 06:29:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46005 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfCXK3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 06:29:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2OASR9t1420097
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 24 Mar 2019 03:28:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2OASJxG1420085;
        Sun, 24 Mar 2019 03:28:19 -0700
Date:   Sun, 24 Mar 2019 03:28:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-9308fd4074551f222f30322d1ee8c5aff18e9747@git.kernel.org>
Cc:     yazen.ghannam@amd.com, vishal.l.verma@intel.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        qiuxu.zhuo@intel.com, hpa@zytor.com, puwen@hygon.cn, arnd@arndb.de,
        bp@suse.de, mingo@redhat.com, rafal@milecki.pl, x86@kernel.org,
        clemej@gmail.com, tony.luck@intel.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, vishal.l.verma@intel.com,
          yazen.ghannam@amd.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, qiuxu.zhuo@intel.com,
          mingo@redhat.com, bp@suse.de, rafal@milecki.pl, puwen@hygon.cn,
          arnd@arndb.de, x86@kernel.org, tony.luck@intel.com,
          clemej@gmail.com
In-Reply-To: <20190322202848.20749-3-Yazen.Ghannam@amd.com>
References: <20190322202848.20749-3-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE: Group AMD function prototypes in
 <asm/mce.h>
Git-Commit-ID: 9308fd4074551f222f30322d1ee8c5aff18e9747
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9308fd4074551f222f30322d1ee8c5aff18e9747
Gitweb:     https://git.kernel.org/tip/9308fd4074551f222f30322d1ee8c5aff18e9747
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 22 Mar 2019 20:29:00 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sun, 24 Mar 2019 10:54:13 +0100

x86/MCE: Group AMD function prototypes in <asm/mce.h>

There are two groups of "ifdef CONFIG_X86_MCE_AMD" function prototypes
in <asm/mce.h>. Merge these two groups.

No functional change.

 [ bp: align vertically. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "clemej@gmail.com" <clemej@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: "rafal@milecki.pl" <rafal@milecki.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190322202848.20749-3-Yazen.Ghannam@amd.com
---
 arch/x86/include/asm/mce.h | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 22d05e3835f0..dc2d4b206ab7 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -210,16 +210,6 @@ static inline void cmci_rediscover(void) {}
 static inline void cmci_recheck(void) {}
 #endif
 
-#ifdef CONFIG_X86_MCE_AMD
-void mce_amd_feature_init(struct cpuinfo_x86 *c);
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
-#else
-static inline void mce_amd_feature_init(struct cpuinfo_x86 *c) { }
-static inline int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr) { return -EINVAL; };
-#endif
-
-static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c) { return mce_amd_feature_init(c); }
-
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 bool mce_is_correctable(struct mce *m);
@@ -345,12 +335,19 @@ extern bool amd_mce_is_memory_error(struct mce *m);
 extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
-#else
+void mce_amd_feature_init(struct cpuinfo_x86 *c);
+int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr);
 
-static inline int mce_threshold_create_device(unsigned int cpu) { return 0; };
-static inline int mce_threshold_remove_device(unsigned int cpu) { return 0; };
-static inline bool amd_mce_is_memory_error(struct mce *m) { return false; };
+#else
 
+static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
+static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
+static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
+static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
+static inline int
+umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return -EINVAL; };
 #endif
 
+static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
+
 #endif /* _ASM_X86_MCE_H */
