Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828CFFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B3E21D82
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfKHWjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:39:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:9337 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfKHWjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:39:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 14:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400"; 
   d="scan'208";a="206137921"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga003.jf.intel.com with ESMTP; 08 Nov 2019 14:39:01 -0800
From:   thor.thayer@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     richard.gong@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 0/2] Enable System Manager on Agilex
Date:   Fri,  8 Nov 2019 16:40:52 -0600
Message-Id: <1573252854-25801-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patchset enables the ARM64 System Manager driver
for Agilex.

Thor Thayer (2):
  arm64: dts: agilex: Add SysMgr compatible
  arm64: dts: agilex: Add SysMgr to Ethernet nodes

 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.7.4

