Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67C9C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99561206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbfGKUao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:30:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:56638 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfGKUao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:30:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 13:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="189625228"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2019 13:30:42 -0700
From:   thor.thayer@linux.intel.com
To:     mdf@kernel.org, richard.gong@intel.com, agust@denx.de
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 0/3] fpga: altera-cvp: Add Stratix10 Support
Date:   Thu, 11 Jul 2019 15:32:47 -0500
Message-Id: <1562877170-23931-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Newer versions (V2) of Altera/Intel FPGAs CvP have different PCI
Vendor Specific Capability offsets than the older (V1) Altera/FPGAs.

Most of the CvP registers and their bitfields remain the same
between both the older parts and the newer parts.

This patchset implements changes to discover the Vendor Specific
Capability offset and then add Stratix10 CvP support.

Thor Thayer (3):
  fpga: altera-cvp: Discover Vendor Specific offset
  fpga: altera-cvp: Preparation for V2 parts.
  fpga: altera-cvp: Add Stratix10 (V2) Support

 drivers/fpga/altera-cvp.c | 322 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 253 insertions(+), 69 deletions(-)

-- 
2.7.4

