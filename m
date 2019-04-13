Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58983C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27046206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfDMUyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:54:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35973 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfDMUyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:54:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKqq3Y2265935
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:52:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKqq1n2265932;
        Sat, 13 Apr 2019 13:52:52 -0700
Date:   Sat, 13 Apr 2019 13:52:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-07baeb04f37c952981d63359ff840118ce8f5434@git.kernel.org>
Cc:     riel@surriel.com, hpa@zytor.com, dave.hansen@intel.com,
        tglx@linutronix.de, pbonzini@redhat.com, mingo@kernel.org,
        x86@kernel.org, rkrcmar@redhat.com, Jason@zx2c4.com,
        sergey.senozhatsky@gmail.com, bigeasy@linutronix.de, bp@suse.de,
        kvm@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org
Reply-To: riel@surriel.com, dave.hansen@intel.com, hpa@zytor.com,
          tglx@linutronix.de, pbonzini@redhat.com, x86@kernel.org,
          mingo@kernel.org, rkrcmar@redhat.com, Jason@zx2c4.com,
          sergey.senozhatsky@gmail.com, bigeasy@linutronix.de, bp@suse.de,
          luto@kernel.org, linux-kernel@vger.kernel.org,
          kvm@vger.kernel.org, mingo@redhat.com
In-Reply-To: <20190403164156.19645-11-bigeasy@linutronix.de>
References: <20190403164156.19645-11-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Make __raw_xsave_addr() use a feature number
 instead of mask
Git-Commit-ID: 07baeb04f37c952981d63359ff840118ce8f5434
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

Commit-ID:  07baeb04f37c952981d63359ff840118ce8f5434
Gitweb:     https://git.kernel.org/tip/07baeb04f37c952981d63359ff840118ce8f5434
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:39 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 10 Apr 2019 16:33:45 +0200

x86/fpu: Make __raw_xsave_addr() use a feature number instead of mask

Most users of __raw_xsave_addr() use a feature number, shift it to a
mask and then __raw_xsave_addr() shifts it back to the feature number.

Make __raw_xsave_addr() use the feature number as an argument.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-11-bigeasy@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 8bfcc5b9e04b..4f7f3c5d0d0c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -805,20 +805,18 @@ void fpu__resume_cpu(void)
 }
 
 /*
- * Given an xstate feature mask, calculate where in the xsave
+ * Given an xstate feature nr, calculate where in the xsave
  * buffer the state is.  Callers should ensure that the buffer
  * is valid.
  */
-static void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
+static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
-	int feature_nr = fls64(xstate_feature_mask) - 1;
-
-	if (!xfeature_enabled(feature_nr)) {
+	if (!xfeature_enabled(xfeature_nr)) {
 		WARN_ON_FPU(1);
 		return NULL;
 	}
 
-	return (void *)xsave + xstate_comp_offsets[feature_nr];
+	return (void *)xsave + xstate_comp_offsets[xfeature_nr];
 }
 /*
  * Given the xsave area and a state inside, this function returns the
@@ -840,6 +838,7 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask
  */
 void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 {
+	int xfeature_nr;
 	/*
 	 * Do we even *have* xsave state?
 	 */
@@ -867,7 +866,8 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 	if (!(xsave->header.xfeatures & xstate_feature))
 		return NULL;
 
-	return __raw_xsave_addr(xsave, xstate_feature);
+	xfeature_nr = fls64(xstate_feature) - 1;
+	return __raw_xsave_addr(xsave, xfeature_nr);
 }
 EXPORT_SYMBOL_GPL(get_xsave_addr);
 
@@ -1014,7 +1014,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 		 * Copy only in-use xstates:
 		 */
 		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, 1 << i);
+			void *src = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1100,7 +1100,7 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 		 * Copy only in-use xstates:
 		 */
 		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, 1 << i);
+			void *src = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1157,7 +1157,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 		u64 mask = ((u64)1 << i);
 
 		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, 1 << i);
+			void *dst = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1211,7 +1211,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 		u64 mask = ((u64)1 << i);
 
 		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, 1 << i);
+			void *dst = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
