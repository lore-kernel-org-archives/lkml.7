Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E45C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3901218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbfCVMhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:37:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59505 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbfCVMhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:37:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MCbCfP577485
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 05:37:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MCbBUI577482;
        Fri, 22 Mar 2019 05:37:11 -0700
Date:   Fri, 22 Mar 2019 05:37:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valdis Kletnieks <tipbot@zytor.com>
Message-ID: <tip-bb2e320565f997273fe04035bb6c17f643da6f8a@git.kernel.org>
Cc:     tglx@linutronix.de, valdis.kletnieks@vt.edu,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          valdis.kletnieks@vt.edu, tglx@linutronix.de
In-Reply-To: <31207.1552378676@turing-police>
References: <31207.1552378676@turing-police>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq/devres: Remove excess parameter from kernel
 doc
Git-Commit-ID: bb2e320565f997273fe04035bb6c17f643da6f8a
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

Commit-ID:  bb2e320565f997273fe04035bb6c17f643da6f8a
Gitweb:     https://git.kernel.org/tip/bb2e320565f997273fe04035bb6c17f643da6f8a
Author:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
AuthorDate: Tue, 12 Mar 2019 04:17:56 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 13:34:12 +0100

genirq/devres: Remove excess parameter from kernel doc

Building with 'make W=1' complains:

  CC      kernel/irq/devres.o
kernel/irq/devres.c:104: warning: Excess function parameter 'thread_fn'
			 description in 'devm_request_any_context_irq'

Remove it.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/31207.1552378676@turing-police


---
 kernel/irq/devres.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index 5d5378ea0afe..f808c6a97dcc 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -84,8 +84,6 @@ EXPORT_SYMBOL(devm_request_threaded_irq);
  *	@dev: device to request interrupt for
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs
- *	@thread_fn: function to be called in a threaded interrupt context. NULL
- *		    for devices which handle everything in @handler
  *	@irqflags: Interrupt type flags
  *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
  *	@dev_id: A cookie passed back to the handler function
