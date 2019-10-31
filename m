Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D6ECA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A082208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfJaL41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:56:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55467 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfJaLza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92z-00037v-JF; Thu, 31 Oct 2019 12:55:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0B1291C04DF;
        Thu, 31 Oct 2019 12:55:10 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:09 -0000
From:   "tip-bot2 for Ethan Hansen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove unused function rcutorture_record_progress()
Cc:     Ethan Hansen <1ethanhansen@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290965.29376.6655434346207795815.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ac5f636130c2014eb535f30951460b75db6cbe04
Gitweb:        https://git.kernel.org/tip/ac5f636130c2014eb535f30951460b75db6cbe04
Author:        Ethan Hansen <1ethanhansen@gmail.com>
AuthorDate:    Thu, 01 Aug 2019 14:00:40 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 11:48:13 -07:00

rcu: Remove unused function rcutorture_record_progress()

The function rcutorture_record_progress() is declared in rcu.h, but is
never used.  This commit therefore removes rcutorture_record_progress()
to clean code.

Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 8fd4f82..aeec70f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -455,7 +455,6 @@ enum rcutorture_type {
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 			    unsigned long *gp_seq);
-void rcutorture_record_progress(unsigned long vernum);
 void do_trace_rcu_torture_read(const char *rcutorturename,
 			       struct rcu_head *rhp,
 			       unsigned long secs,
@@ -468,7 +467,6 @@ static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
 	*flags = 0;
 	*gp_seq = 0;
 }
-static inline void rcutorture_record_progress(unsigned long vernum) { }
 #ifdef CONFIG_RCU_TRACE
 void do_trace_rcu_torture_read(const char *rcutorturename,
 			       struct rcu_head *rhp,
