Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9161C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B929620866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yvQPdgIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfFNPHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:07:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37509 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNPHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:07:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5EF78rB1747147
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 08:07:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5EF78rB1747147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560524828;
        bh=mVeTUeS+JAxwsiFo6HpV+7i87tYNDODON5MnOXLcNDw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yvQPdgIsBV4wpYGOvN/NnD+DwXclvRbOKlu8cQFKHX8UTvaLSs2va+w0rOT94S98e
         1NGwxEvLKVbdOxNCPfSHl5N+SX7LCT9be2TR418bBWGiGjUFEmiddymt/DbNkoi3td
         L3RDlDB3z4oW9BJ07FhtmlXG5eZLq1igRZzUXaKY6iqnB/PYGh9kocxmfXIPv1j5M8
         jG8+8mBMcHBXwTxRAJ5a2QtjmtD3nkZa9tHPAWoNnjSdP85PAtWM2sMRUb/5D4MD0N
         9HX8Vavbwgx+pxsbG38zSoYDw1M0QXwp0d5GLOeIays1SC3ll0Ra3j4ySZqxJt225I
         QjwyUU7sBV0JQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5EF77Zl1747140;
        Fri, 14 Jun 2019 08:07:07 -0700
Date:   Fri, 14 Jun 2019 08:07:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Malaterre <tipbot@zytor.com>
Message-ID: <tip-83e837269e87436fda1cbf82214a5494fb6b35b1@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, peterz@infradead.org, bp@alien8.de,
        malat@debian.org
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          malat@debian.org, bp@alien8.de
In-Reply-To: <20190524103252.28575-1-malat@debian.org>
References: <20190524103252.28575-1-malat@debian.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/tsc: Move inline keyword to the beginning of
 function declarations
Git-Commit-ID: 83e837269e87436fda1cbf82214a5494fb6b35b1
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

Commit-ID:  83e837269e87436fda1cbf82214a5494fb6b35b1
Gitweb:     https://git.kernel.org/tip/83e837269e87436fda1cbf82214a5494fb6b35b1
Author:     Mathieu Malaterre <malat@debian.org>
AuthorDate: Fri, 24 May 2019 12:32:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Jun 2019 17:02:09 +0200

x86/tsc: Move inline keyword to the beginning of function declarations

The inline keyword was not at the beginning of the function declarations.
Fix the following warnings triggered when using W=1:

  arch/x86/kernel/tsc.c:62:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
  arch/x86/kernel/tsc.c:79:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: trivial@kernel.org
Cc: kernel-janitors@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20190524103252.28575-1-malat@debian.org

---
 arch/x86/kernel/tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 0b29e58f288e..75a41bddbc9d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -59,7 +59,7 @@ struct cyc2ns {
 
 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);
 
-void __always_inline cyc2ns_read_begin(struct cyc2ns_data *data)
+__always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 	int seq, idx;
 
@@ -76,7 +76,7 @@ void __always_inline cyc2ns_read_begin(struct cyc2ns_data *data)
 	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
 }
 
-void __always_inline cyc2ns_read_end(void)
+__always_inline void cyc2ns_read_end(void)
 {
 	preempt_enable_notrace();
 }
