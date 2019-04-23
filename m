Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B92321738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfDWOeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:34:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:54833 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDWOeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:34:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP; 23 Apr 2019 07:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="136653867"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga008.jf.intel.com with ESMTP; 23 Apr 2019 07:34:12 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add Stratix10 OCRAM & SDMMC EDAC Support
Date:   Tue, 23 Apr 2019 09:36:33 -0500
Message-Id: <1556030197-24534-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

This patch series adds EDAC support for the Stratix10 OCRAM
and SDMMC peripherals.

Thor Thayer (4):
  EDAC, altera: Add Stratix10 OCRAM ECC support
  arm64: dts: stratix10: Add OCRAM EDAC node
  EDAC, altera: Add Stratix10 SDMMC support
  arm64: dts: stratix10: Add SDMMC EDAC node

 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  8 ++++
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 11 ++++++
 drivers/edac/altera_edac.c                         | 43 ++++++++++++++++++++--
 3 files changed, 59 insertions(+), 3 deletions(-)

-- 
2.7.4

