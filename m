Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9955C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2A0217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bnWK826o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390455AbfGYQ1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:27:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfGYQ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:27:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGRBqF1079094
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:27:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGRBqF1079094
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564072031;
        bh=3+PnTy3mW8VRay5vZBt52B6f35ztPG5/4JlmnZh8uas=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bnWK826oPPwXLpzPX7FvNVMGoQ1FIRLew42zFGIY+Dne99NMumKQ2hX/oEQojznuw
         MygDs9+4J1KuKpB+PgjvsVz1f6g2c7CfDOL9Az5A2hlX5uH4oyMk83vAoDT9082+mG
         fCpBt2/SVp23nUvdPxVsE/4vB72CDi30Rrqe7GVQlMxlZ2JM5qTJOoT319WUIezFkB
         ZhbN81nBirmOrgfGhzl57TxUiS2FBcWjdSiWLd9Y3mut7OaqMAFrfLFOJ683c62P4B
         VuswXMYJ54oh6oyxOlXSVNLYXVYTCOGCcopjcRZcOd0dwc1DFKEgPvZpgTagToWqKx
         Bkt3TN8I5HReQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGRAf71079090;
        Thu, 25 Jul 2019 09:27:10 -0700
Date:   Thu, 25 Jul 2019 09:27:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-289a2d22b5b611d85030795802a710e9f520df29@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        namhyung@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, keescook@chromium.org,
        hpa@zytor.com, bp@alien8.de, tglx@linutronix.de,
        torvalds@linux-foundation.org, acme@kernel.org, mingo@kernel.org,
        gustavo@embeddedor.com
Reply-To: hpa@zytor.com, bp@alien8.de, tglx@linutronix.de,
          mingo@kernel.org, gustavo@embeddedor.com,
          torvalds@linux-foundation.org, acme@kernel.org,
          kan.liang@linux.intel.com, namhyung@kernel.org, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          keescook@chromium.org, peterz@infradead.org
In-Reply-To: <20190624161913.GA32270@embeddedor>
References: <20190624161913.GA32270@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Mark expected switch
 fall-throughs
Git-Commit-ID: 289a2d22b5b611d85030795802a710e9f520df29
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

Commit-ID:  289a2d22b5b611d85030795802a710e9f520df29
Gitweb:     https://git.kernel.org/tip/289a2d22b5b611d85030795802a710e9f520df29
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Mon, 24 Jun 2019 11:19:13 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:57:03 +0200

perf/x86/intel: Mark expected switch fall-throughs

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

  arch/x86/events/intel/core.c: In function ‘intel_pmu_init’:
  arch/x86/events/intel/core.c:4959:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
  arch/x86/events/intel/core.c:5008:8: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable -Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190624161913.GA32270@embeddedor
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c9075fc75cb6..648260b5f367 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4954,6 +4954,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_SKYLAKE_X:
 		pmem = true;
+		/* fall through */
 	case INTEL_FAM6_SKYLAKE_MOBILE:
 	case INTEL_FAM6_SKYLAKE_DESKTOP:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
@@ -5003,6 +5004,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ICELAKE_X:
 	case INTEL_FAM6_ICELAKE_XEON_D:
 		pmem = true;
+		/* fall through */
 	case INTEL_FAM6_ICELAKE_MOBILE:
 	case INTEL_FAM6_ICELAKE_DESKTOP:
 		x86_pmu.late_ack = true;
