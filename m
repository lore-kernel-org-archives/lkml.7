Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F1BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208FB20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbfCZPlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:41:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52597 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:41:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2QFeMA92457539
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 26 Mar 2019 08:40:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2QFeILu2457530;
        Tue, 26 Mar 2019 08:40:18 -0700
Date:   Tue, 26 Mar 2019 08:40:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bhupesh Sharma <tipbot@zytor.com>
Message-ID: <tip-db779ef67ffeadbb44e9e818eb64dbe528e2f48f@git.kernel.org>
Cc:     osandov@fb.com, peterz@infradead.org, bhsharma@redhat.com,
        rahul.lakkireddy@chelsio.com, kasong@redhat.com,
        davem@davemloft.net, x86@kernel.org, bp@suse.de,
        linux-kernel@vger.kernel.org, anderson@redhat.com,
        dyoung@redhat.com, hpa@zytor.com, mingo@kernel.org,
        mpe@ellerman.id.au, akpm@linux-foundation.org, tglx@linutronix.de,
        james.morse@arm.com, adrian.hunter@intel.com
Reply-To: bhsharma@redhat.com, osandov@fb.com, peterz@infradead.org,
          rahul.lakkireddy@chelsio.com, kasong@redhat.com,
          davem@davemloft.net, dyoung@redhat.com, anderson@redhat.com,
          x86@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mpe@ellerman.id.au,
          akpm@linux-foundation.org, james.morse@arm.com,
          adrian.hunter@intel.com, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <1553583028-17804-1-git-send-email-bhsharma@redhat.com>
References: <1553583028-17804-1-git-send-email-bhsharma@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] proc/kcore: Remove unused kclist_add_remap()
Git-Commit-ID: db779ef67ffeadbb44e9e818eb64dbe528e2f48f
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

Commit-ID:  db779ef67ffeadbb44e9e818eb64dbe528e2f48f
Gitweb:     https://git.kernel.org/tip/db779ef67ffeadbb44e9e818eb64dbe528e2f48f
Author:     Bhupesh Sharma <bhsharma@redhat.com>
AuthorDate: Tue, 26 Mar 2019 12:20:28 +0530
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 26 Mar 2019 16:36:03 +0100

proc/kcore: Remove unused kclist_add_remap()

Commit

  bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")

removed the sole usage of kclist_add_remap() but it did not remove the
left-over definition from the include file.

Fix the same.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Kairui Song <kasong@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Omar Sandoval <osandov@fb.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1553583028-17804-1-git-send-email-bhsharma@redhat.com
---
 include/linux/kcore.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index 8c3f8c14eeaa..94b561df3877 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -38,22 +38,11 @@ struct vmcoredd_node {
 
 #ifdef CONFIG_PROC_KCORE
 void __init kclist_add(struct kcore_list *, void *, size_t, int type);
-static inline
-void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
-{
-	m->vaddr = (unsigned long)vaddr;
-	kclist_add(m, addr, sz, KCORE_REMAP);
-}
 #else
 static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 {
 }
-
-static inline
-void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
-{
-}
 #endif
 
 #endif /* _LINUX_KCORE_H */
