Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1468C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D2E2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QJWOjDsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfFQOUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:20:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38145 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:20:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEK6hQ3453226
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:20:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEK6hQ3453226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781207;
        bh=IDpTSBmF5IVhnNoGRkM3wVvvTmliJPDMpWgIU8KyfkY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QJWOjDsECBUKGJtcFs60ylbEABuKmDB7wJ5JzgAUtqAVgDmlXOB7tNkoW5xOMbw/k
         Cnym0uJgJfrP/adyWkENcS/YDaqZvB6qU6C+Upi0jqVL+xLrCEmYx4tEVvl1Qs7iCe
         SkSdWE0B7fM4wW5GpLAqXG9/cLd8vNKM6LS0rnEFZfT+YxbGQyQmWPLYdX87AdtlkO
         rc8xlKmilRoZe66NluufWw9TnagRGhfkgg0k4b0tkXFpllEvPtQAdHFD6nWdXnC+OI
         aa07DqMQfrqf6pjQbJp2Rbu2+uebyKZ5LM0bJ6BvLfDzpulOLqB3yOi8yukULBut3C
         jJvBylQcdteJQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEK5iS3453216;
        Mon, 17 Jun 2019 07:20:05 -0700
Date:   Mon, 17 Jun 2019 07:20:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Gao Xiang <tipbot@zytor.com>
Message-ID: <tip-e3b929b0a184edb35531153c5afcaebb09014f9d@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, koujilong@huawei.com,
        akpm@linux-foundation.org, tj@kernel.org, miaoxie@huawei.com,
        mingo@kernel.org, peterz@infradead.org, gaoxiang25@huawei.com,
        tglx@linutronix.de, torvalds@linux-foundation.org
Reply-To: koujilong@huawei.com, akpm@linux-foundation.org, tj@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          miaoxie@huawei.com, hpa@zytor.com, torvalds@linux-foundation.org,
          peterz@infradead.org, tglx@linutronix.de, gaoxiang25@huawei.com
In-Reply-To: <20190603091338.2695-1-gaoxiang25@huawei.com>
References: <20190603091338.2695-1-gaoxiang25@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Add __sched tag for io_schedule()
Git-Commit-ID: e3b929b0a184edb35531153c5afcaebb09014f9d
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

Commit-ID:  e3b929b0a184edb35531153c5afcaebb09014f9d
Gitweb:     https://git.kernel.org/tip/e3b929b0a184edb35531153c5afcaebb09014f9d
Author:     Gao Xiang <gaoxiang25@huawei.com>
AuthorDate: Mon, 3 Jun 2019 17:13:38 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:15:56 +0200

sched/core: Add __sched tag for io_schedule()

Non-inline io_schedule() was introduced in:

  commit 10ab56434f2f ("sched/core: Separate out io_schedule_prepare() and io_schedule_finish()")

Keep in line with io_schedule_timeout(), otherwise "/proc/<pid>/wchan" will
report io_schedule() rather than its callers when waiting for IO.

Reported-by: Jilong Kou <koujilong@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 10ab56434f2f ("sched/core: Separate out io_schedule_prepare() and io_schedule_finish()")
Link: https://lkml.kernel.org/r/20190603091338.2695-1-gaoxiang25@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 29984d8c41f0..cd047927f707 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5122,7 +5122,7 @@ long __sched io_schedule_timeout(long timeout)
 }
 EXPORT_SYMBOL(io_schedule_timeout);
 
-void io_schedule(void)
+void __sched io_schedule(void)
 {
 	int token;
 
