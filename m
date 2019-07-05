Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA3FC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEBD20828
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGEOOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:14:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:10828 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfGEOOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:14:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 07:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="166547290"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jul 2019 07:14:39 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 0/5] intel_th: The remainder of the updates for v5.3
Date:   Fri,  5 Jul 2019 17:14:20 +0300
Message-Id: <20190705141425.19894-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is an update for the pull request that you commented on previously [1].
These are the 5 remaining patches. I addressed your review comments ([2],
[3]) in patches 1/5 and 2/5. The other 3 patches are only different in
context, because of the first one. Andy helpfully re-reviewed the updated
patch. I hope you find the update satisfactory.

Please consider applying, it's still Friday after all. Thanks!

[1] https://marc.info/?l=linux-kernel&m=156163992400822
[2] https://marc.info/?l=linux-kernel&m=156216936210754
[3] https://marc.info/?l=linux-kernel&m=156216943110766

Alexander Shishkin (5):
  intel_th: msu: Introduce buffer interface
  intel_th: msu-sink: An example msu buffer "sink"
  intel_th: msu: Get rid of the window size limit
  intel_th: msu: Prevent freeing buffers while locked windows exist
  intel_th: msu: Preserve pre-existing buffer configuration

 .../testing/sysfs-bus-intel_th-devices-msc    |   3 +-
 MAINTAINERS                                   |   1 +
 drivers/hwtracing/intel_th/Makefile           |   3 +
 drivers/hwtracing/intel_th/msu-sink.c         | 116 ++++
 drivers/hwtracing/intel_th/msu.c              | 537 +++++++++++++++---
 drivers/hwtracing/intel_th/msu.h              |  20 +-
 include/linux/intel_th.h                      |  79 +++
 7 files changed, 658 insertions(+), 101 deletions(-)
 create mode 100644 drivers/hwtracing/intel_th/msu-sink.c
 create mode 100644 include/linux/intel_th.h

-- 
2.20.1

