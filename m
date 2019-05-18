Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA0FC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F9020872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="m+Wf3D5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfERIt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:49:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:49:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8nlAe1731953
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:49:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8nlAe1731953
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169388;
        bh=/x0sSXksm0HqYWIx0vxNbTR0DQ5MH5Bkh0PbkZNzugw=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=m+Wf3D5dn1GFKob0NzwewH2K8fTiw7lS/dS7ahAfC3lZbHg5ykjvujw117aB/4hs0
         zJh2ScxeYznzkZSCqde8DQHg0D21fe0AKDaJTSRDp0ZPJzBQlLRXWv1nmSb4Ep3wNU
         69GYA3687bSRsn6X5UIYWFu05L3PTC9WUNi/pjFenKiSeJfWrj0Su7KLB5XQCcprVz
         dp+bC69v9R/OUdFhoF/U8K84HIe2ye3bN9etywjeI8vx0R5ikGSS2FU13OQqMwkdeu
         fmJZFDma9HfnVOdtcgQWmHZBtm0c73mx/6WolfR4Jla/EpJxOwiFuhhwcgXb0gOgBw
         oTBXqA3VdqAog==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8nlqJ1731950;
        Sat, 18 May 2019 01:49:47 -0700
Date:   Sat, 18 May 2019 01:49:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-j0mxgqkuibhw5qid9saaspdu@git.kernel.org>
Cc:     jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        acme@redhat.com, peterz@infradead.org, hpa@zytor.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: acme@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
          jolsa@kernel.org, peterz@infradead.org, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools arch: Update arch/x86/lib/memcpy_64.S copy
 used in 'perf bench mem memcpy'
Git-Commit-ID: a021b54001114473333b41100f64ec1b649f5c24
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

Commit-ID:  a021b54001114473333b41100f64ec1b649f5c24
Gitweb:     https://git.kernel.org/tip/a021b54001114473333b41100f64ec1b649f5c24
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 13 May 2019 13:23:42 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:46 -0300

tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'

To bring in the change made in this cset:

  b69656fa7ea2 ("x86/uaccess: Fix up the fixup")

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
  diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S

No changes in the tooling using this, that was just to ease some objtool
return checking.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-j0mxgqkuibhw5qid9saaspdu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/lib/memcpy_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 3b24dc05251c..9d05572370ed 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -257,6 +257,7 @@ ENTRY(__memcpy_mcsafe)
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
 	xorl %eax, %eax
+.L_done:
 	ret
 ENDPROC(__memcpy_mcsafe)
 EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
@@ -273,7 +274,7 @@ EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 	addl	%edx, %ecx
 .E_trailing_bytes:
 	mov	%ecx, %eax
-	ret
+	jmp	.L_done
 
 	/*
 	 * For write fault handling, given the destination is unaligned,
