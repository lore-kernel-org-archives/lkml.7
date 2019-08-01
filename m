Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE39BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEA1206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iVlMS52g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfHAHkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:40:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56243 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAHkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:40:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x717eKP44031579
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 00:40:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x717eKP44031579
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564645221;
        bh=Diq001o8VuPFpcKXih43hYHjrlgjGA1SfGFlvWTtxvI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iVlMS52g9jgtEAWUdmYA/WWLn0/JwRo4oHgYqHZ+Lxb1Pmg3yylugZoyauhfimLro
         Kdkshpy0GfskUb7EgLbK+5KRL/jekAJkRJQbui3ZHcADUuAksQT9mGEQSq7nINjjmN
         E8ixwFk2HwSo+8C+vBxh+Ft+HCIDDfOJ3RFIuG6zy8vn9sWCcN4p2nw8u2DBnfePzw
         jf0RIXKRoQ3WmPot+rluf8NvlkKiu547emey7N8B5tiHqzIfwMhq/EBhLgW8/mKESo
         I5UIk3Bcy5QxEC4L0zMShaKrdjS+YOVWaPHfiMCSwTaouyqjAuPTP+g1jhaA68+E0z
         GMB8H8wqCauXw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x717eK2N4031576;
        Thu, 1 Aug 2019 00:40:20 -0700
Date:   Thu, 1 Aug 2019 00:40:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephen Rothwell <tipbot@zytor.com>
Message-ID: <tip-a688d2a57b78eed3ff38cc9bbb111603bf22a1f4@git.kernel.org>
Cc:     mingo@kernel.org, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: sfr@canb.auug.org.au, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190801133841.64e69541@canb.auug.org.au>
References: <20190801133841.64e69541@canb.auug.org.au>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] staging/android/vsoc:: Fix typo in
 hrtimer_init_sleeper_on_stack() conversion
Git-Commit-ID: a688d2a57b78eed3ff38cc9bbb111603bf22a1f4
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

Commit-ID:  a688d2a57b78eed3ff38cc9bbb111603bf22a1f4
Gitweb:     https://git.kernel.org/tip/a688d2a57b78eed3ff38cc9bbb111603bf22a1f4
Author:     Stephen Rothwell <sfr@canb.auug.org.au>
AuthorDate: Thu, 1 Aug 2019 13:38:41 +1000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 09:00:40 +0200

staging/android/vsoc:: Fix typo in hrtimer_init_sleeper_on_stack() conversion

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/staging/android/vsoc.c: In function 'handle_vsoc_cond_wait':
drivers/staging/android/vsoc.c:440:33: error: passing argument 1 of 'hrtimer_init_sleeper_on_stack'
				       from incompatible pointer type [-Werror=incompatible-pointer-types]
   hrtimer_init_sleeper_on_stack(&to, CLOCK_MONOTONIC,
                                 ^~~
In file included from include/linux/pm.h:16,
                 from include/linux/device.h:23,
                 from include/linux/dma-mapping.h:7,
                 from drivers/staging/android/vsoc.c:19:
include/linux/hrtimer.h:381:67: note: expected 'struct hrtimer_sleeper *
				' but argument is of type 'struct hrtimer_sleeper **'
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
                                          ~~~~~~~~~~~~~~~~~~~~~~~~^~

Fixes: 82e18bace3dd ("hrtimer: Consolidate hrtimer_init() + hrtimer_init_sleeper() calls")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190801133841.64e69541@canb.auug.org.au

---
 drivers/staging/android/vsoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 4f7e6c1dce42..1240bb0317d9 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -437,7 +437,7 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 			return -EINVAL;
 		wake_time = ktime_set(arg->wake_time_sec, arg->wake_time_nsec);
 
-		hrtimer_init_sleeper_on_stack(&to, CLOCK_MONOTONIC,
+		hrtimer_init_sleeper_on_stack(to, CLOCK_MONOTONIC,
 					      HRTIMER_MODE_ABS);
 		hrtimer_set_expires_range_ns(&to->timer, wake_time,
 					     current->timer_slack_ns);
