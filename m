Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF9AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80184222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 21:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfIZVnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 17:43:55 -0400
Received: from foss.arm.com ([217.140.110.172]:60738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfIZVnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 17:43:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F21AA337;
        Thu, 26 Sep 2019 14:43:54 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D28023F739;
        Thu, 26 Sep 2019 14:43:53 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, ard.biesheuvel@linaro.org,
        ndesaulniers@google.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de
Subject: [PATCH v3 0/5]arm64: vdso32: Address various issues
Date:   Thu, 26 Sep 2019 22:43:37 +0100
Message-Id: <20190926214342.34608-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

this patch series is meant to address the various compilation issues you
reported about arm64 vdso32.

Please let me know if there is still something missing.

Thanks,
Vincenzo

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>

---

v3:
   - Exposed COMPATCC
   - Addressed Review Comments

v2:
   - Fixed binutils detection
   - Addressed review comments

Vincenzo Frascino (5):
  arm64: vdso32: Introduce COMPAT_CC_IS_GCC
  arm64: vdso32: Detect binutils support for dmb ishld
  arm64: vdso32: Fix compilation warning
  arm64: Remove gettimeofday.S
  arm64: vdso32: Remove jump label config option in Makefile

 arch/arm64/Kconfig                           |  5 ++++-
 arch/arm64/Makefile                          | 18 +++++-------------
 arch/arm64/include/asm/memory.h              |  3 +++
 arch/arm64/include/asm/vdso/compat_barrier.h |  2 +-
 arch/arm64/kernel/vdso/gettimeofday.S        |  0
 arch/arm64/kernel/vdso32/Makefile            | 14 +++++++++-----
 6 files changed, 22 insertions(+), 20 deletions(-)
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S

-- 
2.23.0

