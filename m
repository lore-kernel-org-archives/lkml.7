Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8D5C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0430208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="q+695WZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfF0Xh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:37:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44273 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0Xhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:37:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNbdvM499762
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:37:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNbdvM499762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678660;
        bh=zKjjz2KHt9JIXQHn3Vdzh7UkaWg5Tr1lSGwT0IfHfpo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=q+695WZRlndnID2uOp3wyosxWyO2PDtrO4hA5kxb1gehzsJWMF/UKULP8oETfeWD3
         9hzxNqgSTEKmvqDgUPMXIGwTZElyjes+Gv9tPibiPmX4Qr0xf/Q9rx5BEMR9KjtFCZ
         1b8mc60AcPFqM1TSN+/EYxy95y7tr0vNV6Ocg9nMtX/zZax9qe8DqsWJMCe+bXcxub
         RK9hlNtaUTQL/oYKB9t/U50OPkbaqsJOCRBh5VaEoXmhT3foJqs3JqdjXSMXyZ9XHi
         5L9zoAprbfQLZ1LNZCKwOrQz3orBsz197WzqEg6rmks8AvkdL7fs0kFpnMYxAdM8jO
         5lfHjPem6w3FA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNbdPX499758;
        Thu, 27 Jun 2019 16:37:39 -0700
Date:   Thu, 27 Jun 2019 16:37:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-eb8ec32c45a87efbc6683b771597084c4d904a17@git.kernel.org>
Cc:     eranian@google.com, ravi.v.shankar@intel.com,
        ricardo.neri-calderon@linux.intel.com,
        Suravee.Suthikulpanit@amd.com, ashok.raj@intel.com,
        andi.kleen@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org
Reply-To: peterz@infradead.org, ricardo.neri-calderon@linux.intel.com,
          mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, andi.kleen@intel.com,
          ravi.v.shankar@intel.com, ashok.raj@intel.com,
          eranian@google.com, Suravee.Suthikulpanit@amd.com
In-Reply-To: <20190623132434.553729327@linutronix.de>
References: <20190623132434.553729327@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Remove the unused hpet_msi_read()
 function
Git-Commit-ID: eb8ec32c45a87efbc6683b771597084c4d904a17
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

Commit-ID:  eb8ec32c45a87efbc6683b771597084c4d904a17
Gitweb:     https://git.kernel.org/tip/eb8ec32c45a87efbc6683b771597084c4d904a17
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:46 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:16 +0200

x86/hpet: Remove the unused hpet_msi_read() function

No users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132434.553729327@linutronix.de

---
 arch/x86/include/asm/hpet.h | 1 -
 arch/x86/kernel/hpet.c      | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 67385d56d4f4..e3209f5de65d 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -81,7 +81,6 @@ struct irq_domain;
 extern void hpet_msi_unmask(struct irq_data *data);
 extern void hpet_msi_mask(struct irq_data *data);
 extern void hpet_msi_write(struct hpet_dev *hdev, struct msi_msg *msg);
-extern void hpet_msi_read(struct hpet_dev *hdev, struct msi_msg *msg);
 extern struct irq_domain *hpet_create_irq_domain(int hpet_id);
 extern int hpet_assign_irq(struct irq_domain *domain,
 			   struct hpet_dev *dev, int dev_num);
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index b2ec52a7773d..69cd0829f432 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -462,13 +462,6 @@ void hpet_msi_write(struct hpet_dev *hdev, struct msi_msg *msg)
 	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hdev->num) + 4);
 }
 
-void hpet_msi_read(struct hpet_dev *hdev, struct msi_msg *msg)
-{
-	msg->data = hpet_readl(HPET_Tn_ROUTE(hdev->num));
-	msg->address_lo = hpet_readl(HPET_Tn_ROUTE(hdev->num) + 4);
-	msg->address_hi = 0;
-}
-
 static int hpet_msi_shutdown(struct clock_event_device *evt)
 {
 	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
