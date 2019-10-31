Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34408CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D72C208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfJaLzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55215 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaLzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92X-0002sy-VS; Thu, 31 Oct 2019 12:54:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 91ACE1C03AD;
        Thu, 31 Oct 2019 12:54:57 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:54:57 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Update descriptions for rcu_future_grace_period
 tracepoint
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252289720.29376.16536457544000412633.tip-bot2@tip-bot2>
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

Commit-ID:     7cc0fffde6e4ff76be20d41a3577012fe584a559
Gitweb:        https://git.kernel.org/tip/7cc0fffde6e4ff76be20d41a3577012fe584a559
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 21 Aug 2019 10:34:25 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 30 Oct 2019 08:34:52 -07:00

rcu: Update descriptions for rcu_future_grace_period tracepoint

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 4609f2e..6612260 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -93,16 +93,16 @@ TRACE_EVENT_RCU(rcu_grace_period,
  * the data from the rcu_node structure, other than rcuname, which comes
  * from the rcu_state structure, and event, which is one of the following:
  *
- * "Startleaf": Request a grace period based on leaf-node data.
+ * "Cleanup": Clean up rcu_node structure after previous GP.
+ * "CleanupMore": Clean up, and another GP is needed.
+ * "EndWait": Complete wait.
+ * "NoGPkthread": The RCU grace-period kthread has not yet started.
  * "Prestarted": Someone beat us to the request
  * "Startedleaf": Leaf node marked for future GP.
  * "Startedleafroot": All nodes from leaf to root marked for future GP.
  * "Startedroot": Requested a nocb grace period based on root-node data.
- * "NoGPkthread": The RCU grace-period kthread has not yet started.
+ * "Startleaf": Request a grace period based on leaf-node data.
  * "StartWait": Start waiting for the requested grace period.
- * "EndWait": Complete wait.
- * "Cleanup": Clean up rcu_node structure after previous GP.
- * "CleanupMore": Clean up, and another GP is needed.
  */
 TRACE_EVENT_RCU(rcu_future_grace_period,
 
