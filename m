Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F1EC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB0620869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfDLQFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:05:22 -0400
Received: from foss.arm.com ([217.140.101.70]:35626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfDLQFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:05:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FE8D15AB;
        Fri, 12 Apr 2019 09:05:18 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A933F557;
        Fri, 12 Apr 2019 09:05:17 -0700 (PDT)
Date:   Fri, 12 Apr 2019 17:05:15 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for -rc5
Message-ID: <20190412160515.GH31037@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these three arm64 fixes for -rc5. The main thing is a fix to
our FUTEX_WAKE_OP implementation which was unbelievably broken, but did
actually work for the one scenario that GLIBC used to use.

Summary in the tag.

Thanks,

Will

--->8

The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 045afc24124d80c6998d9c770844c67912083506:

  arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value (2019-04-12 15:04:33 +0100)

----------------------------------------------------------------
arm64 fixes for -rc5

- Fix stack unwinding so we ignore user stacks

- Fix ftrace module PLT trampoline initialisation checks

- Fix terminally broken implementation of FUTEX_WAKE_OP atomics

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64/ftrace: fix inadvertent BUG() in trampoline check

Will Deacon (2):
      arm64: backtrace: Don't bother trying to unwind the userspace stack
      arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value

 arch/arm64/include/asm/futex.h  | 16 ++++++++--------
 arch/arm64/include/asm/module.h |  5 +++++
 arch/arm64/kernel/ftrace.c      |  3 +--
 arch/arm64/kernel/traps.c       | 15 +++++++++------
 4 files changed, 23 insertions(+), 16 deletions(-)
