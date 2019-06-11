Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2D3C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1252145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfFKMxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:53:37 -0400
Received: from foss.arm.com ([217.140.110.172]:60668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbfFKMxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:53:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53550C0A;
        Tue, 11 Jun 2019 05:53:35 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (unknown [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19AD93F557;
        Tue, 11 Jun 2019 05:53:33 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, mark.rutland@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH 1/7] perf: arm64: Compile tests unconditionally
Date:   Tue, 11 Jun 2019 13:53:09 +0100
Message-Id: <20190611125315.18736-2-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611125315.18736-1-raphael.gault@arm.com>
References: <20190611125315.18736-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to subsequently add more tests for the arm64 architecture
we compile the tests target for arm64 systematically.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
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
-- 
2.17.1

