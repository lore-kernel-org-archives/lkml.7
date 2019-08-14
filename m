Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01F1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD6E206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfHNOJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:09:13 -0400
Received: from 8bytes.org ([81.169.241.247]:49504 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfHNOJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:09:12 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 013DD2F9; Wed, 14 Aug 2019 16:09:10 +0200 (CEST)
Date:   Wed, 14 Aug 2019 16:09:09 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.3-rc4
Message-ID: <20190814140902.GA28527@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.3-rc4

for you to fetch changes up to 3a18844dcf89e636b2d0cbf577e3963b0bcb6d23:

  iommu/vt-d: Fix possible use-after-free of private domain (2019-08-09 17:35:25 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.3-rc4

Including:

	- A couple more fixes for the Intel VT-d driver for bugs
	  introduced during the recent conversion of this driver to use
	  IOMMU core default domains.

	- Fix for common dma-iommu code to make sure MSI mappings happen
	  in the correct domain for a device.

	- Fix a corner case in the handling of sg-lists in dma-iommu
	  code that might cause dma_length to be truncated.

	- Mark a switch as fall-through in arm-smmu code.

----------------------------------------------------------------
Anders Roxell (1):
      iommu/arm-smmu: Mark expected switch fall-through

Lu Baolu (4):
      iommu/vt-d: Detach domain when move device out of group
      iommu/vt-d: Correctly check format of page table in debugfs
      iommu/vt-d: Detach domain before using a private one
      iommu/vt-d: Fix possible use-after-free of private domain

Robin Murphy (2):
      iommu/dma: Handle MSI mappings separately
      iommu/dma: Handle SG length overflow better

 drivers/iommu/arm-smmu-v3.c         |  4 ++--
 drivers/iommu/dma-iommu.c           | 19 +++++++++++--------
 drivers/iommu/intel-iommu-debugfs.c |  2 +-
 drivers/iommu/intel-iommu.c         | 11 +++++++++--
 4 files changed, 23 insertions(+), 13 deletions(-)

Please pull.

Thanks,

	Joerg
