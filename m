Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9010BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6291321850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfB1K7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:59:39 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:36808 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfB1K7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:59:38 -0500
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id iAzc1z00c3XaVaC06AzcK8; Thu, 28 Feb 2019 11:59:36 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gzJPc-0007Ru-Ci; Thu, 28 Feb 2019 11:59:36 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gzJPc-0000Lc-AQ; Thu, 28 Feb 2019 11:59:36 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] doc: rcu: Suspicious RCU usage is a warning
Date:   Thu, 28 Feb 2019 11:59:32 +0100
Message-Id: <20190228105932.1274-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suspicious RCU usage messages are reported as warnings.

Fixes: a5dd63efda3d07b5 ("lockdep: Use "WARNING" tag on lockdep splats")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
And before that, they were printed as errors, which was also never
reflected in the documentation...
---
 Documentation/RCU/lockdep-splat.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/lockdep-splat.txt b/Documentation/RCU/lockdep-splat.txt
index 9423b633526d14df..9c015976b174123f 100644
--- a/Documentation/RCU/lockdep-splat.txt
+++ b/Documentation/RCU/lockdep-splat.txt
@@ -14,9 +14,9 @@ being the real world and all that.
 So let's look at an example RCU lockdep splat from 3.0-rc5, one that
 has long since been fixed:
 
-===============================
-[ INFO: suspicious RCU usage. ]
--------------------------------
+=============================
+WARNING: suspicious RCU usage
+-----------------------------
 block/cfq-iosched.c:2776 suspicious rcu_dereference_protected() usage!
 
 other info that might help us debug this:
-- 
2.17.1

