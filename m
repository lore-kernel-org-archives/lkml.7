Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A98C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8014F20693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vzOscP5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfDSTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:04:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbfDSTEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:04:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JAP5Rh232387
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 03:25:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JAP5Rh232387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555669505;
        bh=T1HL9rkZIxFSk9BGEatx43le1fJSdWntSCHOuD019RI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vzOscP5F2FvOwAGCfootqB5rHaEuP5D19VPHKrS7cHvF3sdivLjD6ygfCVXQRbB+8
         +tTRbGFeKqgfAQdLoZ2uhCdi8y2x0Is/+5bqEvvSnDHqTqTIbm72uC51hhWOh8JwaW
         e/5Xij3Vyi8aZuSRA6s/KDKnZ13wsCCSlZtOr1YH8W73Fojtdxzt9+YdZFK2YOM+nO
         tRwX0pbYDvjtLNNjykOebMVrVpSmI8x9VP8zyXE++9+AnDQ1V5x9U23e3gQPL0d3DP
         pRZUA/3E6EgUsFp1VnSe7J4v/tId2O7yoHYCadNlgpm4eheGVUpY+LlVbm94+h21vi
         JHUCHj3EueVwA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JAP4lL232378;
        Fri, 19 Apr 2019 03:25:04 -0700
Date:   Fri, 19 Apr 2019 03:25:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joel Savitz <tipbot@zytor.com>
Message-ID: <tip-bee9853932e90ce94bce4276ec6b7b06bc48070b@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        jsavitz@redhat.com, akpm@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Reply-To: akpm@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com, jsavitz@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <1551921213-813-1-git-send-email-jsavitz@redhat.com>
References: <1551921213-813-1-git-send-email-jsavitz@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Fix typo in comment
Git-Commit-ID: bee9853932e90ce94bce4276ec6b7b06bc48070b
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

Commit-ID:  bee9853932e90ce94bce4276ec6b7b06bc48070b
Gitweb:     https://git.kernel.org/tip/bee9853932e90ce94bce4276ec6b7b06bc48070b
Author:     Joel Savitz <jsavitz@redhat.com>
AuthorDate: Wed, 6 Mar 2019 20:13:33 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 12:22:16 +0200

sched/core: Fix typo in comment

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: trivial@kernel.org
Link: http://lkml.kernel.org/r/1551921213-813-1-git-send-email-jsavitz@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8b64ef0d5589..fb09eaad1d3a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -924,7 +924,7 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 }
 
 /*
- * Per-CPU kthreads are allowed to run on !actie && online CPUs, see
+ * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
  */
 static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
