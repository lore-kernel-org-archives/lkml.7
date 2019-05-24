Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F294CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67B62075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Xvczf2tB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389442AbfEXILK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:11:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59421 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389142AbfEXILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:11:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O8Awv7119070
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:10:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O8Awv7119070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558685459;
        bh=QuzX0rf8B5EgG1b2rUQWn/FFr7x3DA/wf0KS8rFHils=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Xvczf2tBEGd1AbMmp2kv9iSD0MMXMVxBMOxCIQmuJLVosb7FikD5M1lbV6EWMC8uj
         oIHVEXXp/RIpbZ4GPqlmY44u7TH46ZXsSdvCwQ7ceaLWnmDmBVVE4/PgkZZpPO8S0W
         ovCGibhw359p0rHuvMSj3kVRPcwaKoEdHGc2BCW3HVScWUl+NOLG0a0htULE3NdT+a
         ArlR8Z9HVbzzFQnRjJ/fNUwnbPpTFzpyzk1vqx0iYEij/UHUNGzYJw6OFzGbtGTZZF
         gWBG/nZF7GPkQk9skAsAQ22GYISIFBS6iOLcAnIUJz1ZWcaKEd+regO/qGsUYEBxew
         co1JSXatdH+sg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O8AwEn119067;
        Fri, 24 May 2019 01:10:58 -0700
Date:   Fri, 24 May 2019 01:10:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anders Roxell <tipbot@zytor.com>
Message-ID: <tip-c0090c4c85c27d1fa3d785c935501b7207cd2869@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        anders.roxell@linaro.org, hpa@zytor.com
Reply-To: anders.roxell@linaro.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@kernel.org, torvalds@linux-foundation.org,
          tglx@linutronix.de
In-Reply-To: <20190516191326.27003-1-anders.roxell@linaro.org>
References: <20190516191326.27003-1-anders.roxell@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Remove the unused
 print_lock_trace() function
Git-Commit-ID: c0090c4c85c27d1fa3d785c935501b7207cd2869
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

Commit-ID:  c0090c4c85c27d1fa3d785c935501b7207cd2869
Gitweb:     https://git.kernel.org/tip/c0090c4c85c27d1fa3d785c935501b7207cd2869
Author:     Anders Roxell <anders.roxell@linaro.org>
AuthorDate: Thu, 16 May 2019 21:13:26 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 09:05:46 +0200

locking/lockdep: Remove the unused print_lock_trace() function

gcc warns that function print_lock_trace() is unused if
CONFIG_PROVE_LOCKING isn't set:

../kernel/locking/lockdep.c:2820:13: warning: ‘print_lock_trace’ defined but not used [-Wunused-function]

Rework so we remove the function if CONFIG_PROVE_LOCKING isn't set.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: will.deacon@arm.com
Fixes: c120bce78065 ("lockdep: Simplify stack trace handling")
Link: http://lkml.kernel.org/r/20190516191326.27003-1-anders.roxell@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6b283b4f87aa..8d32ae7768a7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2818,10 +2818,6 @@ static inline int validate_chain(struct task_struct *curr,
 {
 	return 1;
 }
-
-static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
-{
-}
 #endif
 
 /*
