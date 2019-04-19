Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3388FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED59920645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QFiMZkOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfDSTK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:10:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36901 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfDSTKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:10:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JJA9xR397650
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 12:10:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JJA9xR397650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555701010;
        bh=RIrGWRbwefqiJFM2ze8KE6/58F+GW6btPQE3LN6jzrE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QFiMZkOwinOL8tOXeisvH0zdehP4QkaMKo+HR9VZA9f9doZy9oIuiDjK5D9qExyLT
         cyuzI2sjzNJp1w875RoZgE3ReH2ChXvR4W1GXVkH/RuNfiabiUllqUfIuldkrYD6lW
         MFDFnO2YZTcm3EjQmjAm1gYEZq8OnIKwEwH6bNcy9vCenssaWxp+BV5J94sqwXIJBS
         V2wMph9mdB7USIIF45YwBg3lG/4LdiZUfHi7REV1qn0WJ/jRk4RbJGImCQu4u9l18N
         YJjZ2ZVdTXj6O/ybeuyCREvq57m8KlDt5NW9LtlbLhmasaqs//vJ4W5WpnWcppdDdp
         yMAfxNkNexrXw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JJA9gN397645;
        Fri, 19 Apr 2019 12:10:09 -0700
Date:   Fri, 19 Apr 2019 12:10:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-ad2e379def135ebc079f89a0e0b1d987d243f949@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, colin.king@canonical.com,
        mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, colin.king@canonical.com,
          peterz@infradead.org, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20181128152350.13622-1-colin.king@canonical.com>
References: <20181128152350.13622-1-colin.king@canonical.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/debug: Fix spelling mistake "logaritmic" ->
 "logarithmic"
Git-Commit-ID: ad2e379def135ebc079f89a0e0b1d987d243f949
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

Commit-ID:  ad2e379def135ebc079f89a0e0b1d987d243f949
Gitweb:     https://git.kernel.org/tip/ad2e379def135ebc079f89a0e0b1d987d243f949
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Wed, 28 Nov 2018 15:23:50 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 21:04:49 +0200

sched/debug: Fix spelling mistake "logaritmic" -> "logarithmic"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Link: http://lkml.kernel.org/r/20181128152350.13622-1-colin.king@canonical.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8039d62ae36e..678bfb9bd87f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -702,7 +702,7 @@ do {									\
 
 static const char *sched_tunable_scaling_names[] = {
 	"none",
-	"logaritmic",
+	"logarithmic",
 	"linear"
 };
 
