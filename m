Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA7DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A892820449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fFLqmtkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfDSSfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:35:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34437 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbfDSSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:35:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIZ6kl384298
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:35:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIZ6kl384298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555698907;
        bh=7MjFG3QUXv0LHu6g2igBo7gKxAHXiNkNlQwkrcZRKEc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fFLqmtkA35jrRmE5Tpileu8Q/xYcBFiQyq1kZgG4sLuNfwJw5xvdCIdPw5+RICCTI
         rKwndckGraTj179tHYcbCR3WjtBtNB38y2YtDqs++H8j179Lm10ej8wuXc1gKqquEU
         1QGxk1fTPsQYcwGjoySuWxRlNe4LWIbKPunVEYPQdIqYWMQEXGPgWrbChDp1bVtCO2
         bOGP+V+R33eqKnS2GyaryU1PqhK5biBgWIoDhPd3d/MICIh0MP1RQEYA+Zp00v++pG
         Q5ib4bwLSq2+cbGlwkVTc3VXWOolObnRRcDM9011qXPWTh5jMHV93RHgXLLi3W01E3
         IGh2LJ5jg2NJg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIZ55K384293;
        Fri, 19 Apr 2019 11:35:05 -0700
Date:   Fri, 19 Apr 2019 11:35:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sean Christopherson <tipbot@zytor.com>
Message-ID: <tip-f28b11a2abd9cf5535baa03e28fc63ad0e14f52a@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, riel@surriel.com,
        torvalds@linux-foundation.org, sean.j.christopherson@intel.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, yu-cheng.yu@intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@kernel.org
Reply-To: bp@alien8.de, mingo@kernel.org, tglx@linutronix.de,
          yu-cheng.yu@intel.com, hpa@zytor.com, peterz@infradead.org,
          luto@kernel.org, linux-kernel@vger.kernel.org,
          sean.j.christopherson@intel.com, torvalds@linux-foundation.org,
          riel@surriel.com, dave.hansen@linux.intel.com
In-Reply-To: <20181221213657.27628-2-sean.j.christopherson@intel.com>
References: <20181221213657.27628-2-sean.j.christopherson@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Reword initial BUG message for unhandled
 page faults
Git-Commit-ID: f28b11a2abd9cf5535baa03e28fc63ad0e14f52a
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

Commit-ID:  f28b11a2abd9cf5535baa03e28fc63ad0e14f52a
Gitweb:     https://git.kernel.org/tip/f28b11a2abd9cf5535baa03e28fc63ad0e14f52a
Author:     Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate: Fri, 21 Dec 2018 13:36:56 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:31:15 +0200

x86/fault: Reword initial BUG message for unhandled page faults

Reword the NULL pointer dereference case to simply state that a NULL
pointer was dereferenced, i.e. drop "unable to handle" as that implies
that there are instances where the kernel actual does handle NULL
pointer dereferences, which is not true barring funky exception fixup.

For the non-NULL case, replace "kernel paging request" with "page fault"
as the kernel can technically oops on faults that originated in user
code.  Dropping "kernel" also allows future patches to provide detailed
information on where the fault occurred, e.g. user vs. kernel, without
conflicting with the initial BUG message.

In both cases, replace "at address=" with wording more appropriate to
the oops, as "at" may be interpreted as stating that the address is the
RIP of the instruction that faulted.

Last, and probably least, further qualify the NULL-pointer path by
checking that the fault actually originated in kernel code.  It's
technically possible for userspace to map address 0, and not printing
a super specific message is the least of our worries if the kernel does
manage to oops on an actual NULL pointer dereference from userspace.

Before:
    BUG: unable to handle kernel NULL pointer dereference at ffffbeef00000000
    BUG: unable to handle kernel paging request at ffffbeef00000000

After:
    BUG: kernel NULL pointer dereference, address = 0000000000000008
    BUG: unable to handle page fault for address = ffffbeef00000000

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/20181221213657.27628-2-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 667f1da36208..df2c5cdef5c4 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -644,9 +644,12 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 				from_kuid(&init_user_ns, current_uid()));
 	}
 
-	pr_alert("BUG: unable to handle kernel %s at %px\n",
-		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
-		 (void *)address);
+	if (address < PAGE_SIZE && !user_mode(regs))
+		pr_alert("BUG: kernel NULL pointer dereference, address = %px\n",
+			(void *)address);
+	else
+		pr_alert("BUG: unable to handle page fault for address = %px\n",
+			(void *)address);
 
 	err_txt[0] = 0;
 
