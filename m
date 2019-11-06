Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B630EC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A632075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbfKFTwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:52:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:8750 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbfKFTwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:52:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:52:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="232995592"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2019 11:52:51 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 0/3] mei: me: allow mei to be embedded within another pci device.
Date:   Thu,  7 Nov 2019 00:38:38 +0200
Message-Id: <20191106223841.15802-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow mei to be embedded within another pci device, by detaching
some of the core functions from 'struct pci_dev'

Alexander Usyskin (1):
  mei: me: store irq number in the hw struct.

Tomas Winkler (2):
  mei: me: mei_me_dev_init() use struct device instead of struct
    pci_dev.
  mei: abstract fw status register read.

 drivers/misc/mei/hw-me.c   | 38 +++++++++++++++++++++++---------------
 drivers/misc/mei/hw-me.h   |  8 ++++++--
 drivers/misc/mei/hw-txe.c  | 10 +++++++---
 drivers/misc/mei/init.c    |  6 ++++--
 drivers/misc/mei/mei_dev.h |  8 ++++----
 drivers/misc/mei/pci-me.c  | 11 ++++++++++-
 6 files changed, 54 insertions(+), 27 deletions(-)

-- 
2.21.0

