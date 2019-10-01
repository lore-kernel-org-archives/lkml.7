Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AD5C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2107521906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfJALrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:47:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60632 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfJALrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:47:46 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iFGd5-00077f-QM; Tue, 01 Oct 2019 11:47:43 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/2] fork: add kernel-doc for clone3
Date:   Tue,  1 Oct 2019 13:47:01 +0200
Message-Id: <20191001114701.24661-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001114701.24661-1-christian.brauner@ubuntu.com>
References: <20191001114701.24661-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel-doc for the clone3() syscall.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/fork.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5a0fd518e04e..c819cce9bdd0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2590,6 +2590,17 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
 	return true;
 }
 
+/**
+ * clone3 - create a new process with specific properties
+ * @uargs: argument structure
+ * @size:  size of @uargs
+ *
+ * clone3() is the extensible successor to clone()/clone2().
+ * It takes a struct as argument that is versioned by its size.
+ *
+ * Return: On success, a positive PID for the child process.
+ *         On error, a negative errno number.
+ */
 SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
 {
 	int err;
-- 
2.23.0

