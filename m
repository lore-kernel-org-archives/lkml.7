Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEFDC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639762146E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfDZRPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:15:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46702 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfDZRM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:12:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01995A78;
        Fri, 26 Apr 2019 10:12:57 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAE1E3F5AF;
        Fri, 26 Apr 2019 10:12:55 -0700 (PDT)
Date:   Fri, 26 Apr 2019 18:12:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.1-rc7
Message-ID: <20190426171251.GA24143@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 4e69ecf4da1ee0b2ac735e1f1bb13935acd5a38d:

  arm64/module: ftrace: deal with place relative nature of PLTs (2019-04-23 13:35:00 +0100)

----------------------------------------------------------------
arm64 fixes:

- keep the tail of an unaligned initrd reserved

- adjust ftrace_make_call() to deal with the relative nature of PLTs

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64/module: ftrace: deal with place relative nature of PLTs

Bjorn Andersson (1):
      arm64: mm: Ensure tail of unaligned initrd is reserved

 arch/arm64/kernel/ftrace.c | 9 +++++++--
 arch/arm64/mm/init.c       | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
Catalin
