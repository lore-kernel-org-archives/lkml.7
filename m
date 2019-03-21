Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD05F218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfCUK4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:56:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47139 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfCUK4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:56:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2LAtidS096143
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 03:55:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2LAtiGM096140;
        Thu, 21 Mar 2019 03:55:44 -0700
Date:   Thu, 21 Mar 2019 03:55:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Xu <tipbot@zytor.com>
Message-ID: <tip-551417af91b163bd697eb50b3601adae2177c28a@git.kernel.org>
Cc:     douliyangs@gmail.com, tglx@linutronix.de, peterx@redhat.com,
        mingo@kernel.org, hpa@zytor.com, marc.zyngier@arm.com,
        julien.thierry@arm.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, peterx@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          julien.thierry@arm.com, marc.zyngier@arm.com, tglx@linutronix.de,
          douliyangs@gmail.com
In-Reply-To: <20190318065123.11862-1-peterx@redhat.com>
References: <20190318065123.11862-1-peterx@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq: Fix typo in comment of IRQD_MOVE_PCNTXT
Git-Commit-ID: 551417af91b163bd697eb50b3601adae2177c28a
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

Commit-ID:  551417af91b163bd697eb50b3601adae2177c28a
Gitweb:     https://git.kernel.org/tip/551417af91b163bd697eb50b3601adae2177c28a
Author:     Peter Xu <peterx@redhat.com>
AuthorDate: Mon, 18 Mar 2019 14:51:23 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 21 Mar 2019 11:52:37 +0100

genirq: Fix typo in comment of IRQD_MOVE_PCNTXT

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Dou Liyang <douliyangs@gmail.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Link: https://lkml.kernel.org/r/20190318065123.11862-1-peterx@redhat.com

---
 include/linux/irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index d6160d479b14..7ae8de5ad0f2 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -195,7 +195,7 @@ struct irq_data {
  * IRQD_LEVEL			- Interrupt is level triggered
  * IRQD_WAKEUP_STATE		- Interrupt is configured for wakeup
  *				  from suspend
- * IRDQ_MOVE_PCNTXT		- Interrupt can be moved in process
+ * IRQD_MOVE_PCNTXT		- Interrupt can be moved in process
  *				  context
  * IRQD_IRQ_DISABLED		- Disabled state of the interrupt
  * IRQD_IRQ_MASKED		- Masked state of the interrupt
