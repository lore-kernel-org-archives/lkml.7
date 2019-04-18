Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C96FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3203D2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Phj1la5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbfDRMKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:10:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57973 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388850AbfDRMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:10:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3ICAAYN180919
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 05:10:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3ICAAYN180919
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555589410;
        bh=OeD8d1Pjv2uvdTP/jDfK2i9EmaIfwKYMkGIjRNW5R+Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Phj1la5TxQOysRh6kLVAmdKztpzpC2XrCP9hAqCv1deDz/eYkiQmyl4gM4mIEDgN+
         IkN/k+vzW+3887d8ME9TdOXqkymy5U3mlqvaiB2p2CR9Mk+NG5E8YStdM99ProIRME
         xIjSThg0P/dIrzKqrVRzrtQqV6SAX4+sL8WO0ojQZM24f4Fhfoy8Yte152tk4qRcG/
         YXs/0RWexJ32ji0EM6Am/1a16bRMfoxMg0ALoDyK9DFDaBPOLtYwkqwf/Ft4r92JT0
         8MzBkx0Y7kzoP1X8fCQFEsiGdkljnf6BcQ6P77+G15y5ea8yzd+50vdUlHuvlt/mH1
         CUTnPpzOF4nOw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3ICA8CV180906;
        Thu, 18 Apr 2019 05:10:08 -0700
Date:   Thu, 18 Apr 2019 05:10:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arash Fotouhi <tipbot@zytor.com>
Message-ID: <tip-76e1552466ff2da8b909df0fff3600ec1c27edcc@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, arash@arashfotouhi.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, arash@arashfotouhi.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          torvalds@linux-foundation.org
In-Reply-To: <1553308112-3513-1-git-send-email-arash@arashfotouhi.com>
References: <1553308112-3513-1-git-send-email-arash@arashfotouhi.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] watchdog: Fix typo in comment
Git-Commit-ID: 76e1552466ff2da8b909df0fff3600ec1c27edcc
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

Commit-ID:  76e1552466ff2da8b909df0fff3600ec1c27edcc
Gitweb:     https://git.kernel.org/tip/76e1552466ff2da8b909df0fff3600ec1c27edcc
Author:     Arash Fotouhi <arash@arashfotouhi.com>
AuthorDate: Fri, 22 Mar 2019 19:28:32 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Apr 2019 14:05:51 +0200

watchdog: Fix typo in comment

Signed-off-by: Arash Fotouhi <arash@arashfotouhi.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: loberman@redhat.com
Cc: vincent.whitchurch@axis.com
Link: http://lkml.kernel.org/r/1553308112-3513-1-git-send-email-arash@arashfotouhi.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 6a5787233113..7f9e7b9306fe 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -590,7 +590,7 @@ static void lockup_detector_reconfigure(void)
  * Create the watchdog thread infrastructure and configure the detector(s).
  *
  * The threads are not unparked as watchdog_allowed_mask is empty.  When
- * the threads are sucessfully initialized, take the proper locks and
+ * the threads are successfully initialized, take the proper locks and
  * unpark the threads in the watchdog_cpumask if the watchdog is enabled.
  */
 static __init void lockup_detector_setup(void)
