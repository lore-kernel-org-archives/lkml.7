Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25921C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2D82077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfH1PYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:24:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:7637 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfH1PYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:24:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 08:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="356145467"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.57])
  by orsmga005.jf.intel.com with ESMTP; 28 Aug 2019 08:24:38 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL v1 0/4] stm class/intel_th: Fixes for v5.3
In-Reply-To: <20190821074955.3925-1-alexander.shishkin@linux.intel.com>
References: <20190821074955.3925-1-alexander.shishkin@linux.intel.com>
Date:   Wed, 28 Aug 2019 18:24:37 +0300
Message-ID: <87k1ax5n4a.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Hi Greg,
>
> These are the fixes that I have for v5.3. One is an actual bugfix that's
> copied to stable, one SPDX header fix and two new PCI IDs, copied to
> stable as well. Signed tag below, individual patches follow. Please
> consider applying or pulling. Thanks!

I forgot to attach the pull request to this one, but I figured, you'll
take patches anyway. Sorry about that.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/stm-intel_th-fixes-for-greg-20190821

for you to fetch changes up to 9b2b12d5f2ea658c0441c9d066c7faeb4f949ad0:

  intel_th: pci: Add Tiger Lake support (2019-08-21 10:40:48 +0300)

----------------------------------------------------------------
stm class/intel_th: Fixes for v5.3

These are:
  * Double-free fix, going back to v4.4.
  * SPDX license header fix.
  * 2 new PCI IDs.

----------------------------------------------------------------
Alexander Shishkin (2):
      intel_th: pci: Add support for another Lewisburg PCH
      intel_th: pci: Add Tiger Lake support

Ding Xiang (1):
      stm class: Fix a double free of stm_source_device

Nishad Kamdar (1):
      intel_th: Use the correct style for SPDX License Identifier

 drivers/hwtracing/intel_th/msu.h |  2 +-
 drivers/hwtracing/intel_th/pci.c | 10 ++++++++++
 drivers/hwtracing/intel_th/pti.h |  2 +-
 drivers/hwtracing/stm/core.c     |  1 -
 4 files changed, 12 insertions(+), 3 deletions(-)
