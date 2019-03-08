Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D519C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F2020661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfCHNIU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:08:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:15979 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfCHNIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:08:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 05:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,455,1544515200"; 
   d="scan'208";a="132370980"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.249.68.204])
  by orsmga003.jf.intel.com with SMTP; 08 Mar 2019 05:08:15 -0800
Received: by ubuntu (sSMTP sendmail emulation); Sat, 09 Mar 2019 01:53:43 +0800
Message-ID: <1552067623.5582.8.camel@intel.com>
Subject: [GIT PULL] arch/nios2 updates for v5.1
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "; lftan.linux"@gmail.com
Date:   Sat, 09 Mar 2019 01:53:43 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Please pull the arch/nios2 updates below.
Most of updates are MMU related.

Thanks.

Regards
Ley Foon

The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-v5.1-rc1

for you to fetch changes up to 21e6bff5e0ef0033d776e64c40e6873d7c75e74b:

  nios2: Fix update_mmu_cache preload the TLB with the new PTE (2019-03-07 06:00:48 +0800)

----------------------------------------------------------------
nios2 update for v5.1-rc1

nios2: Fix update_mmu_cache preload the TLB with the new PTE
nios2: update_mmu_cache preload the TLB with the new PTE
nios2: User address TLB flush break after finding the matching entry
nios2: flush_tlb_all use TLBMISC way auto-increment feature
nios2: improve readability of tlb functions
nios2: flush_tlb_mm flush only the pid
nios2: flush_tlb_pid can just restore TLBMISC once
nios2: TLBMISC writes do not require PID bits to be set
nios2: Use an invalid TLB entry address helper function
nios2: pte_clear does not need to flush TLB
nios2: flush_tlb_page use PID based flush
nios2: update_mmu_cache clear the old entry from the TLB
nios2: remove redundant 'default n' from Kconfig-s
nios2: ksyms: Add missing symbol exports

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      nios2: remove redundant 'default n' from Kconfig-s

Guenter Roeck (1):
      nios2: ksyms: Add missing symbol exports

Nicholas Piggin (12):
      nios2: update_mmu_cache clear the old entry from the TLB
      nios2: flush_tlb_page use PID based flush
      nios2: pte_clear does not need to flush TLB
      nios2: Use an invalid TLB entry address helper function
      nios2: TLBMISC writes do not require PID bits to be set
      nios2: flush_tlb_pid can just restore TLBMISC once
      nios2: flush_tlb_mm flush only the pid
      nios2: improve readability of tlb functions
      nios2: flush_tlb_all use TLBMISC way auto-increment feature
      nios2: User address TLB flush break after finding the matching entry
      nios2: update_mmu_cache preload the TLB with the new PTE
      nios2: Fix update_mmu_cache preload the TLB with the new PTE

 arch/nios2/Kconfig                   |   1 -
 arch/nios2/include/asm/pgtable.h     |   1 -
 arch/nios2/include/asm/tlbflush.h    |  19 +++-
 arch/nios2/kernel/nios2_ksyms.c      |  12 +++
 arch/nios2/mm/cacheflush.c           |   7 +-
 arch/nios2/mm/fault.c                |   2 +-
 arch/nios2/mm/tlb.c                  | 192 ++++++++++++++++++++---------------
 arch/nios2/platform/Kconfig.platform |   9 --
 8 files changed, 142 insertions(+), 101 deletions(-)
