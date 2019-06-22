Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC9EC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC7B2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LAiBIjB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfFVJfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 05:35:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36289 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfFVJfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 05:35:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M9YkOb2080963
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 02:34:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M9YkOb2080963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561196087;
        bh=Vf3UgCq0IMcC5olFJW/JL1tg7IrJoaDkroh08gJPYRY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LAiBIjB4HzYvUYxmfFmirmC7fEQbpFRJHsXsC92w2o/ldhCCd+cZCexFEep1H7Ua5
         DonMilnmn1/olMuuDw/1/O289s3XCCTkLqZvDnV/1yV97JOtmnQYjJAqLp8NL8PTbw
         CcHh3G35ZmSLWnk5Z1ANxZYQW1ii8miKQDa8mAFH8bR+u99rUWHQm76XXFYBLoYFn4
         iauJ1Ue71sHmsRrtbXkWfuUs1GcKoIPatEkCyAF5epJnvbb3rYqL5Dief3z7wCUyKG
         yRwcr1r5HkFUQKGkaCWbq1of6j4Ll/ENYOcOINvuD9QdSYxi0UhC+dZoQHgjD7WXEb
         uX7qxL6GOZBDw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M9YjxP2080960;
        Sat, 22 Jun 2019 02:34:45 -0700
Date:   Sat, 22 Jun 2019 02:34:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Miroslav Lichvar <tipbot@zytor.com>
Message-ID: <tip-d21e43f2ef32ba3242687dbedb3c4b9a76b3eebc@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        prarit@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, richardcochran@gmail.com, mlichvar@redhat.com,
        stephen.boyd@linaro.org
Reply-To: richardcochran@gmail.com, mingo@kernel.org, tglx@linutronix.de,
          mlichvar@redhat.com, stephen.boyd@linaro.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, prarit@redhat.com,
          john.stultz@linaro.org
In-Reply-To: <20190618160612.21957-1-mlichvar@redhat.com>
References: <20190618160612.21957-1-mlichvar@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] kselftests: timers: freq-step: Update maximum
 acceptable precision and errors
Git-Commit-ID: d21e43f2ef32ba3242687dbedb3c4b9a76b3eebc
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

Commit-ID:  d21e43f2ef32ba3242687dbedb3c4b9a76b3eebc
Gitweb:     https://git.kernel.org/tip/d21e43f2ef32ba3242687dbedb3c4b9a76b3eebc
Author:     Miroslav Lichvar <mlichvar@redhat.com>
AuthorDate: Tue, 18 Jun 2019 18:06:12 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:28:53 +0200

kselftests: timers: freq-step: Update maximum acceptable precision and errors

PTI has a significant impact on precision of the MONOTONIC_RAW clock,
which prevents a lot of computers from running the freq-step test.
Increase the maximum acceptable precision for the test to not be skipped
to 500 nanoseconds.

After commit 78b98e3c5a66 ("timekeeping/ntp: Determine the multiplier
directly from NTP tick length") the frequency and time errors should be
much smaller. Reduce the maximum acceptable values for the test to pass
to 0.02 ppm and 50 nanoseconds respectively.

Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Link: https://lkml.kernel.org/r/20190618160612.21957-1-mlichvar@redhat.com

---
 tools/testing/selftests/timers/freq-step.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/freq-step.c b/tools/testing/selftests/timers/freq-step.c
index 8cd10662ffba..4b76450d78d1 100644
--- a/tools/testing/selftests/timers/freq-step.c
+++ b/tools/testing/selftests/timers/freq-step.c
@@ -21,9 +21,9 @@
 #define SAMPLE_READINGS 10
 #define MEAN_SAMPLE_INTERVAL 0.1
 #define STEP_INTERVAL 1.0
-#define MAX_PRECISION 100e-9
-#define MAX_FREQ_ERROR 10e-6
-#define MAX_STDDEV 1000e-9
+#define MAX_PRECISION 500e-9
+#define MAX_FREQ_ERROR 0.02e-6
+#define MAX_STDDEV 50e-9
 
 #ifndef ADJ_SETOFFSET
   #define ADJ_SETOFFSET 0x0100
