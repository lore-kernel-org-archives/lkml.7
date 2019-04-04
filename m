Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42242C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB2A2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfDDOeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:34:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:5070 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfDDOef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:34:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 07:34:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="128612660"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga007.jf.intel.com with ESMTP; 04 Apr 2019 07:34:34 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     mchehab@kernel.org, james.morse@arm.com,
        thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCHv3 0/3] Update Stratix10 EDAC Bindings
Date:   Thu,  4 Apr 2019 09:36:34 -0500
Message-Id: <1554388597-28019-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patch series makes the Stratix10 EDAC Bindings
specific to the Stratix10 ARM64 architecture.

Instead of using the Arria10 (ARM32) EDAC bindings for
Stratix10 (ARM64), create Stratix10 specific EDAC bindings
to capture architecture differences between ARM32 and ARM64.
This requires fixing the previous Stratix10 bindings.
Also add the peripheral bindings for the Stratix10.

V2: Remove Stratix10 compatible check.

V3: Remove patches not related to EDAC bindings so that
    this patchset is targeted toward the bindings.
    Improve the Stratix10 specific binding description by
    adding in descriptions of ARM64 differences.

Resend: Add Reviewed-by and Acked-by from bindings and 
    socfpga device tree maintainers. I'd like this to go
    through the EDAC tree since future patches will have
    a dependency on these bindings and device tree.

Thor Thayer (3):
  Documentation: dt: edac: Fix Stratix10 IRQ bindings
  Documentation: dt: edac: Add Stratix10 Peripheral bindings
  arm64: dts: stratix10: Use new Stratix10 EDAC bindings

 .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 135 +++++++++++++++++++--
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  25 ++--
 2 files changed, 138 insertions(+), 22 deletions(-)

-- 
2.7.4

