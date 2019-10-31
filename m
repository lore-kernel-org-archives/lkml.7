Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305B7CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBCC21734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfJaL5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:57:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55366 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfJaLzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92n-00030O-LY; Thu, 31 Oct 2019 12:55:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2340C1C0494;
        Thu, 31 Oct 2019 12:55:03 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:02 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] Revert docs from "treewide: Rename
 rcu_dereference_raw_notrace() to _check()"
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290285.29376.11620445328486959685.tip-bot2@tip-bot2>
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

Commit-ID:     c07e6f36bc321d70e8255c30d327e299b8301146
Gitweb:        https://git.kernel.org/tip/c07e6f36bc321d70e8255c30d327e299b8301146
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 01 Aug 2019 17:39:17 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 29 Oct 2019 02:46:55 -07:00

Revert docs from "treewide: Rename rcu_dereference_raw_notrace() to _check()"

This reverts docs from commit 355e9972da81e803bbb825b76106ae9b358caf8e.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Added Joel's SoB per Stephen Rothwell feedback. ]
[ paulmck: Joel approved via private email. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index bdbc84f..5a9238a 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2512,7 +2512,7 @@ disabled across the entire RCU read-side critical section.
 <p>
 It is possible to use tracing on RCU code, but tracing itself
 uses RCU.
-For this reason, <tt>rcu_dereference_raw_check()</tt>
+For this reason, <tt>rcu_dereference_raw_notrace()</tt>
 is provided for use by tracing, which avoids the destructive
 recursion that could otherwise ensue.
 This API is also used by virtualization in some architectures,
