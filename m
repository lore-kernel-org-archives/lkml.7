Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F2AC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BAF24658
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfLNHlc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 02:41:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49943 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfLNHlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 02:41:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ig23G-0003Ok-MH; Sat, 14 Dec 2019 08:41:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7D2D01C2989;
        Sat, 14 Dec 2019 08:41:21 +0100 (CET)
Date:   Sat, 14 Dec 2019 07:41:21 -0000
From:   "tip-bot2 for yu kuai" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/process: Remove set but not used variables
 prev and next
Cc:     yu kuai <yukuai3@huawei.com>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, yi.zhang@huawei.com,
        zhengbin13@huawei.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191213121253.10072-1-yukuai3@huawei.com>
References: <20191213121253.10072-1-yukuai3@huawei.com>
MIME-Version: 1.0
Message-ID: <157630928132.30329.4530483129490664469.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     27353d5785bca61bb49cfd7c78e14f1d21e66ec5
Gitweb:        https://git.kernel.org/tip/27353d5785bca61bb49cfd7c78e14f1d21e66ec5
Author:        yu kuai <yukuai3@huawei.com>
AuthorDate:    Fri, 13 Dec 2019 20:12:53 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 14 Dec 2019 08:26:00 +01:00

x86/process: Remove set but not used variables prev and next

Remove two unused variables:

  arch/x86/kernel/process.c: In function ‘__switch_to_xtra’:
  arch/x86/kernel/process.c:618:31: warning: variable ‘next’ set but not used [-Wunused-but-set-variable]
    618 |  struct thread_struct *prev, *next;
        |                               ^~~~
  arch/x86/kernel/process.c:618:24: warning: variable ‘prev’ set but not used [-Wunused-but-set-variable]
    618 |  struct thread_struct *prev, *next;
        |

They are never used and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: yi.zhang@huawei.com
Cc: zhengbin13@huawei.com
Link: https://lkml.kernel.org/r/20191213121253.10072-1-yukuai3@huawei.com
---
 arch/x86/kernel/process.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 61e93a3..839b524 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -615,12 +615,8 @@ void speculation_ctrl_update_current(void)
 
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
-	struct thread_struct *prev, *next;
 	unsigned long tifp, tifn;
 
-	prev = &prev_p->thread;
-	next = &next_p->thread;
-
 	tifn = READ_ONCE(task_thread_info(next_p)->flags);
 	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
 
