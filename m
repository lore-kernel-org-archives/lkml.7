Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6DBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D8B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfLQLzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:55:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:39120 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfLQLzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:55:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 03:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="205451576"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2019 03:55:44 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/4] intel_th: Fixes for v5.5
Date:   Tue, 17 Dec 2019 13:55:23 +0200
Message-Id: <20191217115527.74383-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

These are the fixes I have so far. Both fixes are for commits in v5.2, so
stable is CC'd: one is incorrect irq freeing and one is a NULL dereference
from unintended use. Also included 2 new PCI IDs. Signed tag below,
individual patches follow. Please consider applying or pullyng. Thanks!

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-fixes-for-greg-20191216

for you to fetch changes up to 43420a735c271925c74fea8e75c4d6b89fc83bbf:

  intel_th: msu: Fix window switching without windows (2019-12-16 19:50:26 +0200)

----------------------------------------------------------------
intel_th: Fixes for v5.5

These are:
 * 2 new PCI IDs
 * 2 bugfixes for bugs added in v5.2

----------------------------------------------------------------

Alexander Shishkin (4):
  intel_th: pci: Add Comet Lake PCH-V support
  intel_th: pci: Add Elkhart Lake SOC support
  intel_th: Fix freeing IRQs
  intel_th: msu: Fix window switching without windows

 drivers/hwtracing/intel_th/core.c     |  7 ++++---
 drivers/hwtracing/intel_th/intel_th.h |  2 ++
 drivers/hwtracing/intel_th/msu.c      | 14 +++++++++-----
 drivers/hwtracing/intel_th/pci.c      | 10 ++++++++++
 4 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.24.0

