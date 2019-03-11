Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC052C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AA72087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfCKVSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:18:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:30404 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfCKVSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:18:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 14:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="151382925"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2019 14:18:23 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 0/5] mei: spdx and copyright adjustments
Date:   Tue, 12 Mar 2019 00:10:39 +0200
Message-Id: <20190311221044.17623-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace boiler plate licenses texts with the SPDX license
identifiers, and fix minor mistakes in HDCP2.0 code SPDX identifiers.

This includes also code under the NFC subsystem, this can be merged via
char-misc as this code is unlikely to change, so no conflicts are expected.

Use the same format for copyright notice in the all files
and update the copyright notice according file modification date.

Tomas Winkler (5):
  mei: add missing SPDX tag to mei Kconfig
  mei: convert to SPDX license tags
  nfc/mei: convert to SPDX license tags
  mei/hdcp: Fix SPDX identifiers
  mei: adjust the copyright notice in the files.

 drivers/misc/mei/Kconfig         |  2 +
 drivers/misc/mei/Makefile        |  2 +-
 drivers/misc/mei/bus-fixup.c     | 14 +------
 drivers/misc/mei/bus.c           | 13 +-----
 drivers/misc/mei/client.c        | 14 +------
 drivers/misc/mei/client.h        | 14 +------
 drivers/misc/mei/debugfs.c       | 15 ++-----
 drivers/misc/mei/dma-ring.c      |  2 +-
 drivers/misc/mei/hbm.c           | 15 +------
 drivers/misc/mei/hbm.h           | 14 +------
 drivers/misc/mei/hdcp/Makefile   |  2 +-
 drivers/misc/mei/hdcp/mei_hdcp.c |  2 +-
 drivers/misc/mei/hdcp/mei_hdcp.h |  2 +-
 drivers/misc/mei/hw-me-regs.h    | 68 ++------------------------------
 drivers/misc/mei/hw-me.c         | 14 +------
 drivers/misc/mei/hw-me.h         | 16 +-------
 drivers/misc/mei/hw-txe-regs.h   | 63 ++---------------------------
 drivers/misc/mei/hw-txe.c        | 14 +------
 drivers/misc/mei/hw-txe.h        | 14 +------
 drivers/misc/mei/hw.h            | 14 +------
 drivers/misc/mei/init.c          | 14 +------
 drivers/misc/mei/interrupt.c     | 15 +------
 drivers/misc/mei/main.c          | 15 ++-----
 drivers/misc/mei/mei-trace.c     | 14 +------
 drivers/misc/mei/mei-trace.h     | 14 +------
 drivers/misc/mei/mei_dev.h       | 14 +------
 drivers/misc/mei/pci-me.c        | 15 ++-----
 drivers/misc/mei/pci-txe.c       | 14 +------
 drivers/nfc/mei_phy.c            | 18 ++-------
 drivers/nfc/microread/mei.c      | 17 ++------
 drivers/nfc/pn544/mei.c          | 15 +------
 include/linux/mei_cl_bus.h       |  3 ++
 include/uapi/linux/mei.h         | 67 ++-----------------------------
 33 files changed, 72 insertions(+), 477 deletions(-)

-- 
2.20.1

