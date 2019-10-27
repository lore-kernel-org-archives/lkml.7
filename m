Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 08:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF5021928
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 08:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfJ0IFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 04:05:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41132 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfJ0IFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 04:05:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iOdYA-0003g2-V6; Sun, 27 Oct 2019 09:05:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 912301C0082;
        Sun, 27 Oct 2019 09:05:22 +0100 (CET)
Date:   Sun, 27 Oct 2019 08:05:22 -0000
From:   "tip-bot2 for Yi Wang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/apic, x86/uprobes: Correct parameter names in
 kernel-doc comments
Cc:     Yi Wang <wang.yi59@zte.com.cn>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1571816442-22494-1-git-send-email-wang.yi59@zte.com.cn>
References: <1571816442-22494-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Message-ID: <157216352223.29376.4881710179306669523.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     44eb5a7e5dc6f23d04c05c15f91bc279e0dc700d
Gitweb:        https://git.kernel.org/tip/44eb5a7e5dc6f23d04c05c15f91bc279e0dc700d
Author:        Yi Wang <wang.yi59@zte.com.cn>
AuthorDate:    Sun, 27 Oct 2019 08:55:39 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 27 Oct 2019 09:00:28 +01:00

x86/apic, x86/uprobes: Correct parameter names in kernel-doc comments

Rename parameter names to the correct ones used in the function. No
functional changes.

 [ bp: Merge two patches into a single one. ]

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1571816442-22494-1-git-send-email-wang.yi59@zte.com.cn
---
 arch/x86/kernel/apic/apic.c | 2 +-
 arch/x86/kernel/uprobes.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 9e2dd2b..8147106 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2335,7 +2335,7 @@ static int cpuid_to_apicid[] = {
 #ifdef CONFIG_SMP
 /**
  * apic_id_is_primary_thread - Check whether APIC ID belongs to a primary thread
- * @id:	APIC ID to check
+ * @apicid: APIC ID to check
  */
 bool apic_id_is_primary_thread(unsigned int apicid)
 {
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 8cd745e..15e5aad 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -842,8 +842,8 @@ static int push_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 
 /**
  * arch_uprobe_analyze_insn - instruction analysis including validity and fixups.
+ * @auprobe: the probepoint information.
  * @mm: the probed address space.
- * @arch_uprobe: the probepoint information.
  * @addr: virtual address at which to install the probepoint
  * Return 0 on success or a -ve number on error.
  */
