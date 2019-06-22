Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CA5C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA992089C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fYHP5aN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFVGfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:35:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFVGfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:35:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6YR342004025
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:34:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6YR342004025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185268;
        bh=pcMGjiiWCf1Ng72/I5EZEfSiHaR7bTWOWx0eqpYmlWs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fYHP5aN4yaOf+2TU3mkqUkCtUDAd/cR7AQyPzwW1IgQrRZJacQPq/XOhU4nVaTc4y
         100471g9h1SV2gKlLz1nd+5V3mmt1Cb3/HlTlefDWVoYGG1W8QtZmn3wFLAKF74DOw
         XRn01yRHMiKgBsi72uG6Aj5IageHwHTIhGg4ThGRFk7tAZf81anAHiEbwK6apsms1Y
         dOy5Q69SYLcR2KqG4ook2mZBBW7AmRKrBFWf5sA2fgylxuJRSNyMdmkhjK0fJlpVD0
         VzlNFF4vV9+pe9feQvDO2mk7VWha1XekfNUssom6lhWhKYW9clM0xnSiL7K7tmr6KN
         bTUTjmdbKvEEw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6YRdx2004017;
        Fri, 21 Jun 2019 23:34:27 -0700
Date:   Fri, 21 Jun 2019 23:34:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Raphael Gault <tipbot@zytor.com>
Message-ID: <tip-010e3e8fc12b1c13ce19821a11d8930226ebb4b6@git.kernel.org>
Cc:     mark.rutland@arm.com, raphael.gault@arm.com, hpa@zytor.com,
        acme@redhat.com, tglx@linutronix.de, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        mingo@kernel.org, peterz@infradead.org
Reply-To: raphael.gault@arm.com, mark.rutland@arm.com, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, catalin.marinas@arm.com,
          peterz@infradead.org, mingo@kernel.org
In-Reply-To: <20190611125315.18736-2-raphael.gault@arm.com>
References: <20190611125315.18736-2-raphael.gault@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests arm64: Compile tests unconditionally
Git-Commit-ID: 010e3e8fc12b1c13ce19821a11d8930226ebb4b6
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

Commit-ID:  010e3e8fc12b1c13ce19821a11d8930226ebb4b6
Gitweb:     https://git.kernel.org/tip/010e3e8fc12b1c13ce19821a11d8930226ebb4b6
Author:     Raphael Gault <raphael.gault@arm.com>
AuthorDate: Tue, 11 Jun 2019 13:53:09 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:16 -0300

perf tests arm64: Compile tests unconditionally

In order to subsequently add more tests for the arm64 architecture we
compile the tests target for arm64 systematically.

Further explanation provided by Mark Rutland:

Given prior questions regarding this commit, it's probably worth
spelling things out more explicitly, e.g.

  Currently we only build the arm64/tests directory if
  CONFIG_DWARF_UNWIND is selected, which is fine as the only test we
  have is arm64/tests/dwarf-unwind.o.

  So that we can add more tests to the test directory, let's
  unconditionally build the directory, but conditionally build
  dwarf-unwind.o depending on CONFIG_DWARF_UNWIND.

  There should be no functional change as a result of this patch.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190611125315.18736-2-raphael.gault@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/Build       | 2 +-
 tools/perf/arch/arm64/tests/Build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/Build b/tools/perf/arch/arm64/Build
index 36222e64bbf7..a7dd46a5b678 100644
--- a/tools/perf/arch/arm64/Build
+++ b/tools/perf/arch/arm64/Build
@@ -1,2 +1,2 @@
 perf-y += util/
-perf-$(CONFIG_DWARF_UNWIND) += tests/
+perf-y += tests/
diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index 41707fea74b3..a61c06bdb757 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -1,4 +1,4 @@
 perf-y += regs_load.o
-perf-y += dwarf-unwind.o
+perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-y += arch-tests.o
