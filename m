Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C075CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57ADA20679
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbfJ1HHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:07:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:19783 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbfJ1HHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:07:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 00:07:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="205111206"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2019 00:07:14 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/7] intel_th: Fixes for v5.4
Date:   Mon, 28 Oct 2019 09:06:44 +0200
Message-Id: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

These are the fixes I have for the v5.4 cycle. They are 4 fixes for the
buffer management code that went in in the v5.4-rc1 and 2 new PCI IDs.
The IDs are CC'd to stable. All checked with static checkers and Andy
Shevchenko, who was kind enough to look them over. Signed tag at the URL
below. Individual patches follow. Please consider pulling or applying.
Thanks!

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git intel_th-fixes-for-greg-20191028

for you to fetch changes up to 379815d9f34ef62f7f268a25c96b321396a7cbe5:

  intel_th: pci: Add Jasper Lake PCH support (2019-10-28 08:54:27 +0200)

----------------------------------------------------------------
intel_th: Fixes for v5.4

These are:
 * several fixes for buffer management added in v5.4
 * two new PCI IDs

----------------------------------------------------------------
Alexander Shishkin (4):
      intel_th: gth: Fix the window switching sequence
      intel_th: msu: Fix an uninitialized mutex
      intel_th: pci: Add Comet Lake PCH support
      intel_th: pci: Add Jasper Lake PCH support

Colin Ian King (2):
      intel_th: msu: Fix missing allocation failure check on a kstrndup
      intel_th: msu: Fix overflow in shift of an unsigned int

Wei Yongjun (1):
      intel_th: msu: Fix possible memory leak in mode_store()

 drivers/hwtracing/intel_th/gth.c |  3 +++
 drivers/hwtracing/intel_th/msu.c | 11 ++++++++---
 drivers/hwtracing/intel_th/pci.c | 10 ++++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)
The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-fixes-for-greg-20191028

for you to fetch changes up to 379815d9f34ef62f7f268a25c96b321396a7cbe5:

  intel_th: pci: Add Jasper Lake PCH support (2019-10-28 08:54:27 +0200)

----------------------------------------------------------------
intel_th: Fixes for v5.4

These are:
 * several fixes for buffer management added in v5.4
 * two new PCI IDs

----------------------------------------------------------------
Alexander Shishkin (4):
      intel_th: gth: Fix the window switching sequence
      intel_th: msu: Fix an uninitialized mutex
      intel_th: pci: Add Comet Lake PCH support
      intel_th: pci: Add Jasper Lake PCH support

Colin Ian King (2):
      intel_th: msu: Fix missing allocation failure check on a kstrndup
      intel_th: msu: Fix overflow in shift of an unsigned int

Wei Yongjun (1):
      intel_th: msu: Fix possible memory leak in mode_store()

 drivers/hwtracing/intel_th/gth.c |  3 +++
 drivers/hwtracing/intel_th/msu.c | 11 ++++++++---
 drivers/hwtracing/intel_th/pci.c | 10 ++++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.23.0

