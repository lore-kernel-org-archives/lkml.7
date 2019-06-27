Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1980DC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0CC208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lvOAti9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfF0Xmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:42:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0Xmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:42:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNgWIe500839
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:42:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNgWIe500839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678953;
        bh=BE1HEW3k5GX/FfdMHnPQTGObh2G/blSZMM7So1yWJqM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lvOAti9itUPOjptlTazjEoW+vhe4v6PKgFDZU2W+KvMa0ac9Xz4jkBs7w/HAEv62S
         ul0xplv/BfEEsXGDZCyOgkJxX8qBQMfOPd7u8j7Xvl1nX1SrTvqNMIZI6jXEnZvSSG
         cHnKkfheTP5NxWrrGWYio2Uh6sSrETWEQ+L9o3+YeTJcLeyZFDneEHTCoysg+Ds6bj
         JtzA3zsSz1bHXpDY7umu4UHnDRLuzm9UtFWLcnK+Ia/2Uk2LMnhC2F4TEXZ0SN5XNq
         QZd/DqJd9xANRzMvt3YjQ9jurS4+bRry2gRz9MZVT2J9c2CV+lITny+ObmUzSLBVcC
         Lf1xYR9N/Dcsg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNgUwv500833;
        Thu, 27 Jun 2019 16:42:30 -0700
Date:   Thu, 27 Jun 2019 16:42:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-3535aa12f7f26fc755514b13aee8fac15741267e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, eranian@google.com, ravi.v.shankar@intel.com,
        ricardo.neri-calderon@linux.intel.com,
        Suravee.Suthikulpanit@amd.com, andi.kleen@intel.com, hpa@zytor.com,
        ashok.raj@intel.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, ashok.raj@intel.com,
          mingo@kernel.org, Suravee.Suthikulpanit@amd.com,
          andi.kleen@intel.com, ricardo.neri-calderon@linux.intel.com,
          ravi.v.shankar@intel.com, eranian@google.com, tglx@linutronix.de,
          peterz@infradead.org
In-Reply-To: <20190623132435.241032433@linutronix.de>
References: <20190623132435.241032433@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Decapitalize and rename EVT_TO_HPET_DEV
Git-Commit-ID: 3535aa12f7f26fc755514b13aee8fac15741267e
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

Commit-ID:  3535aa12f7f26fc755514b13aee8fac15741267e
Gitweb:     https://git.kernel.org/tip/3535aa12f7f26fc755514b13aee8fac15741267e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:53 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:19 +0200

x86/hpet: Decapitalize and rename EVT_TO_HPET_DEV

It's a function not a macro and the upcoming changes use channel for the
individual hpet timer units to allow a step by step refactoring approach.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132435.241032433@linutronix.de

---
 arch/x86/kernel/hpet.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 74756c0a3a10..4cf93294bacc 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -69,9 +69,10 @@ static bool				hpet_verbose;
 
 static struct clock_event_device	hpet_clockevent;
 
-static inline struct hpet_dev *EVT_TO_HPET_DEV(struct clock_event_device *evtdev)
+static inline
+struct hpet_dev *clockevent_to_channel(struct clock_event_device *evt)
 {
-	return container_of(evtdev, struct hpet_dev, evt);
+	return container_of(evt, struct hpet_dev, evt);
 }
 
 inline unsigned int hpet_readl(unsigned int a)
@@ -458,28 +459,22 @@ void hpet_msi_write(struct hpet_dev *hdev, struct msi_msg *msg)
 
 static int hpet_msi_shutdown(struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-
-	return hpet_shutdown(evt, hdev->num);
+	return hpet_shutdown(evt, clockevent_to_channel(evt)->num);
 }
 
 static int hpet_msi_set_oneshot(struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-
-	return hpet_set_oneshot(evt, hdev->num);
+	return hpet_set_oneshot(evt, clockevent_to_channel(evt)->num);
 }
 
 static int hpet_msi_set_periodic(struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-
-	return hpet_set_periodic(evt, hdev->num);
+	return hpet_set_periodic(evt, clockevent_to_channel(evt)->num);
 }
 
 static int hpet_msi_resume(struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
+	struct hpet_dev *hdev = clockevent_to_channel(evt);
 	struct irq_data *data = irq_get_irq_data(hdev->irq);
 	struct msi_msg msg;
 
@@ -491,16 +486,14 @@ static int hpet_msi_resume(struct clock_event_device *evt)
 }
 
 static int hpet_msi_next_event(unsigned long delta,
-				struct clock_event_device *evt)
+			       struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-
-	return hpet_next_event(delta, hdev->num);
+	return hpet_next_event(delta, clockevent_to_channel(evt)->num);
 }
 
 static irqreturn_t hpet_interrupt_handler(int irq, void *data)
 {
-	struct hpet_dev *dev = (struct hpet_dev *)data;
+	struct hpet_dev *dev = data;
 	struct clock_event_device *hevt = &dev->evt;
 
 	if (!hevt->event_handler) {
