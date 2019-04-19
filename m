Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70E4C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735092064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="genz/eBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfDSTDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:03:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbfDSTDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JHS9GQ363152
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 10:28:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JHS9GQ363152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555694889;
        bh=Z29tSFNd8X+iQ731h347aV3Vewp6PQusq3WF5RAa8tg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=genz/eBfRiKAYYGBLnrNbsFGW4Gv5z+yHFtS14NosBDc6sMtv0vzp/MLXkr59jGf4
         +eVnxMbzUmYatrFBHc+1BxisKCEohTbw2dCgMQoCWrqNM1+gAY8XaqXe3fvF9D1bQ2
         /O/FkgLJK4PubGvrT4jJtWQl90cjW9Ld5iKfyVaH6pqt+XbRWB22xKYHTmwiFHIvFV
         heaoSzFDoZ3uxCu2U/Bf4FtrZYW0tuq7nGtbnj0chtyePqOaV3+2r1uVcacUvafDuL
         KUQpiDY4BbRohsiO8x+NnON4taiLri74vnWjXQgnZayd4PeOZHA242sXyb/ILvyuXn
         IMCYIy0i4tSSA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JHS8ib363149;
        Fri, 19 Apr 2019 10:28:08 -0700
Date:   Fri, 19 Apr 2019 10:28:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hans de Goede <tipbot@zytor.com>
Message-ID: <tip-2ee27796f298b710992a677a7e4d35c8c588b17e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, hdegoede@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, bp@alien8.de
Reply-To: torvalds@linux-foundation.org, hdegoede@redhat.com,
          tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          bp@alien8.de, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20181230172715.17469-1-hdegoede@redhat.com>
References: <20181230172715.17469-1-hdegoede@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpu/intel: Lower the "ENERGY_PERF_BIAS: Set to
 normal" message's log priority
Git-Commit-ID: 2ee27796f298b710992a677a7e4d35c8c588b17e
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

Commit-ID:  2ee27796f298b710992a677a7e4d35c8c588b17e
Gitweb:     https://git.kernel.org/tip/2ee27796f298b710992a677a7e4d35c8c588b17e
Author:     Hans de Goede <hdegoede@redhat.com>
AuthorDate: Sun, 30 Dec 2018 18:27:15 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:23:13 +0200

x86/cpu/intel: Lower the "ENERGY_PERF_BIAS: Set to normal" message's log priority

The "ENERGY_PERF_BIAS: Set to 'normal', was 'performance'" message triggers
on pretty much every Intel machine. The purpose of log messages with
a warning level is to notify the user of something which potentially is
a problem, or at least somewhat unexpected.

This message clearly does not match those criteria, so lower its log
priority from warning to info.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181230172715.17469-1-hdegoede@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fc3c07fe7df5..3142fd7a9b32 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -611,8 +611,8 @@ static void init_intel_energy_perf(struct cpuinfo_x86 *c)
 	if ((epb & 0xF) != ENERGY_PERF_BIAS_PERFORMANCE)
 		return;
 
-	pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
-	pr_warn_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
+	pr_info_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
+	pr_info_once("ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)\n");
 	epb = (epb & ~0xF) | ENERGY_PERF_BIAS_NORMAL;
 	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
 }
