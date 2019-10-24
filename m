Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C79CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDCE205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408285AbfJXCmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:42:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:26800 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392431AbfJXCmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:42:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 19:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="281801153"
Received: from unknown (HELO ubuntu.localdomain) ([10.226.250.76])
  by orsmga001.jf.intel.com with ESMTP; 23 Oct 2019 19:42:35 -0700
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        Ong Hean Loong <hean.loong.ong@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>
Subject: [PATCHv3] arm64: defconfig: add JFFS FS support in defconfig
Date:   Wed, 23 Oct 2019 19:42:21 -0700
Message-Id: <1571884941-6132-1-git-send-email-joyce.ooi@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds JFFS2 FS support and remove QSPI Sector 4K size force in
the default defconfig. Removing QSPI Sector 4K size will fix the following 
error:
	"Magic bitmask 0x1985 not found at ..."

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
v2: disable CONFIG_MTD_SPI_NOR_USE_4K_SECTORS using the correct syntax
v3: add more explantion in commit message
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9adae4..6080c6e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -860,3 +860,5 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_MEMTEST=y
+CONFIG_JFFS2_FS=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
-- 
1.9.1

