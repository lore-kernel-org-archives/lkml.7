Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A10C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D58207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLQMEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:04:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:27305 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLQMEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:04:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 04:04:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="212346469"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga007.fm.intel.com with ESMTP; 17 Dec 2019 04:04:36 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL 0/4] intel_th: Fixes for v5.5
In-Reply-To: <20191217115527.74383-1-alexander.shishkin@linux.intel.com>
References: <20191217115527.74383-1-alexander.shishkin@linux.intel.com>
Date:   Tue, 17 Dec 2019 14:04:34 +0200
Message-ID: <87tv5zb1kd.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Hi Greg,
>
> These are the fixes I have so far. Both fixes are for commits in v5.2, so
> stable is CC'd: one is incorrect irq freeing and one is a NULL dereference
> from unintended use. Also included 2 new PCI IDs. Signed tag below,
> individual patches follow. Please consider applying or pullyng. Thanks!

The tag is wrong, apologies. Should be:

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-fixes-for-greg-20191216

for you to fetch changes up to 6958619f52e9bc47d7aee0475e9d2c1ae2fcda75:

  intel_th: msu: Fix window switching without windows (2019-12-17 13:36:01 +0200)

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
