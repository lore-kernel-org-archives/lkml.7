Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14E5C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E56208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OdsPj6eZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfFLMZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:25:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53891 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfFLMZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:25:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCPOaE684584
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:25:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCPOaE684584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342324;
        bh=1Ft/NEpHiDfZbobbTni0/RYthf6VUsUQI2TbJTv2erE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OdsPj6eZfLVRKLAYWTN3IyyTluyauXb1OfxjVK9mTxFmVwKWf0fOc8gArwqCFMaaz
         tV0pQ1st6OOC/E60y9lisSRQ/xYUaurD5+rwRe4QenvsQFQdmanzCe5o6BFDmHBShv
         Gozx7vqIYl7Rl1BWRxMklpjoLrIXrx7LXwSlJpNZusGCMC6Wu3iiPrx+qROSBSaTLP
         rTPW6xZ3Mg4qnNrgTJYwlBv/NzSTjPI1F0NzM1BzPCfg4HcQRpmXzTOcghwhFI1LSf
         WCGfyHAL7FLxDEdsjZj672SU5OocH2gsmR3vdTqxtcIkTzC4cUYB726iq1QDVX9m0m
         N2n+ajxRhj/9w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCPNsr684581;
        Wed, 12 Jun 2019 05:25:23 -0700
Date:   Wed, 12 Jun 2019 05:25:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yangtao Li <tipbot@zytor.com>
Message-ID: <tip-0e5aa23282f8e6ee38c18f67ddfdaaa32d3df86b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190607174253.27403-1-tiny.windzz@gmail.com>
References: <20190607174253.27403-1-tiny.windzz@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Remove unused header include
Git-Commit-ID: 0e5aa23282f8e6ee38c18f67ddfdaaa32d3df86b
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

Commit-ID:  0e5aa23282f8e6ee38c18f67ddfdaaa32d3df86b
Gitweb:     https://git.kernel.org/tip/0e5aa23282f8e6ee38c18f67ddfdaaa32d3df86b
Author:     Yangtao Li <tiny.windzz@gmail.com>
AuthorDate: Fri, 7 Jun 2019 13:42:53 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 10:21:17 +0200

hrtimer: Remove unused header include

seq_file.h does not need to be included, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190607174253.27403-1-tiny.windzz@gmail.com

---
 kernel/time/hrtimer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 41dfff23c1f9..edb230aba3d1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -30,7 +30,6 @@
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
 #include <linux/tick.h>
-#include <linux/seq_file.h>
 #include <linux/err.h>
 #include <linux/debugobjects.h>
 #include <linux/sched/signal.h>
