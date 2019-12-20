Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBD4C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802082082E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLTSPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:15:02 -0500
Received: from foss.arm.com ([217.140.110.172]:53954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbfLTSPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:15:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AE721FB;
        Fri, 20 Dec 2019 10:15:01 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDD5F3F67D;
        Fri, 20 Dec 2019 10:15:00 -0800 (PST)
Date:   Fri, 20 Dec 2019 18:14:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.5-rc3
Message-ID: <20191220181456.GA13898@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks and Merry Christmas!

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to aa638cfe3e7358122a15cb1d295b622aae69e006:

  arm64: cpu_errata: Add Hisilicon TSV110 to spectre-v2 safe list (2019-12-20 17:57:22 +0000)

----------------------------------------------------------------
arm64 fixes:

- Leftover put_cpu() in the perf/smmuv3 error path.

- Add Hisilicon TSV110 to spectre-v2 safe list

----------------------------------------------------------------
Hanjun Guo (1):
      perf/smmuv3: Remove the leftover put_cpu() in error path

Wei Li (1):
      arm64: cpu_errata: Add Hisilicon TSV110 to spectre-v2 safe list

 arch/arm64/kernel/cpu_errata.c | 1 +
 drivers/perf/arm_smmuv3_pmu.c  | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
Catalin
