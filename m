Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B78C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796782168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="r5wWDFfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFNPQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:16:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48445 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfFNPQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:16:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5EFGBuV1750095
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 08:16:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5EFGBuV1750095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560525372;
        bh=YT9bA0rD0nP9H52nMHHd6hin4ckI1Jlw53UJQXVmC7I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=r5wWDFfNpb+nkM/CxZu1kdGJfi9Mm2es/jg1p4AC3aQd75914SUKsiKNpRnES1TEH
         VSOLpBdHeqOS3KDJ7Np4WNWW4piJnnCiDrdzQX8cKgUmQLEM0pDJT7eNVMSsKsETrb
         kewjXrXS6dYucXTbTmwMoPwkgWWDYqFlUgq9tCCJKdFiMJWL3HhO8+FcR69g4nsRAM
         sdIkuTW+NwJ0e5/QXVlMNETbq3Di+pPBo/k6ZF2JlXh5a96T+HpBzoUhZXFD5lE+lp
         YglsXagaw6ggKJ+NUbW5MZo6hTuKRA4WVmt+zpGDzAgI0950KN+7iqQFveU2gyggmN
         crTqJiLGpop6A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5EFGA9a1750091;
        Fri, 14 Jun 2019 08:16:10 -0700
Date:   Fri, 14 Jun 2019 08:16:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Malaterre <tipbot@zytor.com>
Message-ID: <tip-0f48b41f597e3b62b649abbf796e1e72901f9df3@git.kernel.org>
Cc:     malat@debian.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        john.stultz@linaro.org, mingo@kernel.org, hpa@zytor.com,
        sboyd@kernel.org
Reply-To: hpa@zytor.com, sboyd@kernel.org, tglx@linutronix.de,
          mingo@kernel.org, john.stultz@linaro.org,
          linux-kernel@vger.kernel.org, malat@debian.org
In-Reply-To: <20190524103339.28787-1-malat@debian.org>
References: <20190524103339.28787-1-malat@debian.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] clocksource: Move inline keyword to the beginning
 of function declarations
Git-Commit-ID: 0f48b41f597e3b62b649abbf796e1e72901f9df3
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

Commit-ID:  0f48b41f597e3b62b649abbf796e1e72901f9df3
Gitweb:     https://git.kernel.org/tip/0f48b41f597e3b62b649abbf796e1e72901f9df3
Author:     Mathieu Malaterre <malat@debian.org>
AuthorDate: Fri, 24 May 2019 12:33:39 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Jun 2019 17:04:03 +0200

clocksource: Move inline keyword to the beginning of function declarations

The inline keyword was not at the beginning of the function declarations.
Fix the following warnings triggered when using W=1:

  kernel/time/clocksource.c:108:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
  kernel/time/clocksource.c:113:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: trivial@kernel.org
Cc: kernel-janitors@vger.kernel.org
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Link: https://lkml.kernel.org/r/20190524103339.28787-1-malat@debian.org

---
 kernel/time/clocksource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3bcc19ceb073..fff5f64981c6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -105,12 +105,12 @@ static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
 
-static void inline clocksource_watchdog_lock(unsigned long *flags)
+static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
 	spin_lock_irqsave(&watchdog_lock, *flags);
 }
 
-static void inline clocksource_watchdog_unlock(unsigned long *flags)
+static inline void clocksource_watchdog_unlock(unsigned long *flags)
 {
 	spin_unlock_irqrestore(&watchdog_lock, *flags);
 }
