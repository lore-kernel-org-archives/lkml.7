Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED08BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEB42077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbgAINlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:41:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54343 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgAINlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:41:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipY4D-0002uw-9l; Thu, 09 Jan 2020 14:41:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B22C31C2CDE;
        Thu,  9 Jan 2020 14:41:40 +0100 (CET)
Date:   Thu, 09 Jan 2020 13:41:40 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cpu: Add a missing prototype for arch_smt_update()
Cc:     Benjamin Thiel <b.thiel@posteo.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200109121723.8151-1-b.thiel@posteo.de>
References: <20200109121723.8151-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <157857730052.30329.4376004076938160494.tip-bot2@tip-bot2>
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

Commit-ID:     b47a36982dbdcd9d96fdce5169af984ef5bdd110
Gitweb:        https://git.kernel.org/tip/b47a36982dbdcd9d96fdce5169af984ef5bdd110
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Thu, 09 Jan 2020 13:17:23 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 09 Jan 2020 14:31:53 +01:00

x86/cpu: Add a missing prototype for arch_smt_update()

.. in order to fix a -Wmissing-prototype warning.

No functional change.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200109121723.8151-1-b.thiel@posteo.de
---
 arch/x86/kernel/cpu/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2e4d902..6b95f18 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -14,6 +14,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/task.h>
+#include <linux/sched/smt.h>
 #include <linux/init.h>
 #include <linux/kprobes.h>
 #include <linux/kgdb.h>
