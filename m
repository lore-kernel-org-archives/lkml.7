Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE62C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBF02072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgAIM2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:28:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54142 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbgAIM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:28:34 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipWvN-0001Is-RW; Thu, 09 Jan 2020 13:28:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7196A1C2CDA;
        Thu,  9 Jan 2020 13:28:29 +0100 (CET)
Date:   Thu, 09 Jan 2020 12:28:29 -0000
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Fix kernel-doc notation warning
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <223be78c-f3c8-52df-836d-c5fb8e7907e9@infradead.org>
References: <223be78c-f3c8-52df-836d-c5fb8e7907e9@infradead.org>
MIME-Version: 1.0
Message-ID: <157857290920.30329.4383548737653158496.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     51bfb1d11d6daf095addf9fe8471c20992caae0b
Gitweb:        https://git.kernel.org/tip/51bfb1d11d6daf095addf9fe8471c20992caae0b
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 08 Dec 2019 20:26:55 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Jan 2020 13:23:40 +01:00

futex: Fix kernel-doc notation warning

Fix a kernel-doc warning in kernel/futex.c by adding notation
for @ret.

../kernel/futex.c:1187: warning: Function parameter or member 'ret' not described in 'wait_for_owner_exiting'

Fixes: 3ef240eaff36 ("futex: Prevent exit livelock")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/223be78c-f3c8-52df-836d-c5fb8e7907e9@infradead.org

---
 kernel/futex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 03c518e..0cf84c8 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1178,6 +1178,7 @@ out_error:
 
 /**
  * wait_for_owner_exiting - Block until the owner has exited
+ * @ret: owner's current futex lock status
  * @exiting:	Pointer to the exiting task
  *
  * Caller must hold a refcount on @exiting.
