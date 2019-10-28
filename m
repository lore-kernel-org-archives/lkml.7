Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88F4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B95E20659
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfJ1Duy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 23:50:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:60684 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbfJ1Duy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:50:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 20:50:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; 
   d="scan'208";a="350582691"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2019 20:50:50 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, will@kernel.org, mark.rutland@arm.com,
        atull@kernel.org, gregkh@linuxfoundation.org,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v5 0/2] add performance reporting support to FPGA DFL drivers
Date:   Mon, 28 Oct 2019 11:31:26 +0800
Message-Id: <1572233488-26533-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz and all,

This patchset adds performance reporting support for FPGA DFL drivers. It
introduces one pmu to expose userspace interfaces via standard perf API.
User could use standard perf tool to access perf events exposed via pmu.

This patchset is generated based on fpga/for-next branch.

Main changes from v4:
 - rebase and clean up.
 - update Kconfig for PERF_EVENTS dependency.

Main changes from v3:
 - add more descriptions in doc, including how to use perf tool for these
   hardware counters. (patch #1)
 - use standard perf API instead of sysfs entries. (patch #2)

Wu Hao (1):
  fpga: dfl: fme: add performance reporting support

Xu Yilun (1):
  Documentation: fpga: dfl: add description for performance reporting
    support

 Documentation/fpga/dfl.rst  |  83 +++++
 drivers/fpga/Kconfig        |   2 +-
 drivers/fpga/Makefile       |   1 +
 drivers/fpga/dfl-fme-main.c |   4 +
 drivers/fpga/dfl-fme-perf.c | 869 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl-fme.h      |   2 +
 drivers/fpga/dfl.h          |   2 +
 7 files changed, 962 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fpga/dfl-fme-perf.c

-- 
1.8.3.1

