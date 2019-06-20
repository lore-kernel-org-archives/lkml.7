Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F387C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA4620656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfFTQ7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:59:20 -0400
Received: from foss.arm.com ([217.140.110.172]:49326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfFTQ7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:59:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A70C2B;
        Thu, 20 Jun 2019 09:59:19 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B56013F246;
        Thu, 20 Jun 2019 09:59:18 -0700 (PDT)
Date:   Thu, 20 Jun 2019 17:59:16 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: fixes for -rc6
Message-ID: <20190620165916.GB24650@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc6. It's mainly a couple of email
address updates to MAINTAINERS, but we've also fixed a UAPI build issue
with musl libc and an accidental double-initialisation of our pgd_cache
due to a naming conflict with a weak symbol.

There are a couple of outstanding issues that have been reported, but
it doesn't look like they're new and we're still a long way off from
fully debugging them.

Cheers,

Will

--->8


The following changes since commit 41040cf7c5f0f26c368bc5d3016fed3a9ca6dba4:

  arm64/sve: Fix missing SVE/FPSIMD endianness conversions (2019-06-13 10:07:19 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 615c48ad8f4275b4d39fa57df68d4015078be201:

  arm64/mm: don't initialize pgd_cache twice (2019-06-18 14:37:28 +0100)

----------------------------------------------------------------
arm64 fixes for -rc6

- Fix use of #include in UAPI headers for compatability with musl libc

- Update email addresses in MAINTAINERS

- Fix initialisation of pgd_cache due to name collision with weak symbol

----------------------------------------------------------------
Anisse Astier (2):
      arm64: ssbd: explicitly depend on <linux/prctl.h>
      arm64/sve: <uapi/asm/ptrace.h> should not depend on <uapi/linux/prctl.h>

Hanjun Guo (1):
      MAINTAINERS: Update my email address

Mike Rapoport (1):
      arm64/mm: don't initialize pgd_cache twice

Will Deacon (1):
      MAINTAINERS: Update my email address to use @kernel.org

 .mailmap                             |  2 ++
 MAINTAINERS                          | 18 +++++++++---------
 arch/arm64/include/asm/pgtable.h     |  3 +--
 arch/arm64/include/uapi/asm/ptrace.h |  8 +++-----
 arch/arm64/kernel/ssbd.c             |  1 +
 5 files changed, 16 insertions(+), 16 deletions(-)
