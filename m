Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EF8C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471412176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbfDQHft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:35:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:6869 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfDQHfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:35:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 00:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="224243722"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 17 Apr 2019 00:35:45 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 0/3] stm class/intel_th: Fixes for v5.1
Date:   Wed, 17 Apr 2019 10:35:33 +0300
Message-Id: <20190417073536.63014-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are the fixes that I have for 5.1. These are two bugfixes in stm
class code, both stable-worthy and a new PCI ID for Intel TH. Static
checkers approve, as usual. Individual patches follow. Please consider
pulling or applying. Thanks!

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-stm-fixes-for-greg-20190417

for you to fetch changes up to a32bb4a8524253943548f6c3794bfe9af5c99f4b:

  intel_th: pci: Add Comet Lake support (2019-04-17 10:16:04 +0300)

----------------------------------------------------------------
stm class/intel_th: Fixes for v5.1

These are:
 * Fix for a resource leak in stm core
 * Fix for stm on 32-bit systems
 * A new PCI ID for Intel TH

----------------------------------------------------------------
Alexander Shishkin (2):
      stm class: Fix channel bitmap on 32-bit systems
      intel_th: pci: Add Comet Lake support

Tingwei Zhang (1):
      stm class: Fix channel free in stm output free path

 drivers/hwtracing/intel_th/pci.c | 5 +++++
 drivers/hwtracing/stm/core.c     | 9 ++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.20.1

