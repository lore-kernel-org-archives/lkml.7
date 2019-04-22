Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294FEC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23A9214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962148;
	bh=4M/H2Pqbr35Cyfqi7q5RW+FgCH80FxV6EDYCtkObp/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gyzL+RNkKah/3CC+eETAct+t/esNpMjQwyqdSm3EZrAgpdSnzEIOOgxNpogWzbMbm
	 a2ONA3OXkPv1l6k5fIaGE0rF+4hGvk9rORR/YeKlxBhk1rPnwiUCFDawSTMX+IOd+Q
	 WYAKwTwLg2TRQbNlMFHSviwea6WVUwDKf49G2IpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfDVTm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbfDVTmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 592482075A;
        Mon, 22 Apr 2019 19:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962143;
        bh=4M/H2Pqbr35Cyfqi7q5RW+FgCH80FxV6EDYCtkObp/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvhuLIGFRladxeCjc0clKWHCIJaEEUGKvIAUSz71HXHdpKRBf+Njea6KhYdniJuVC
         EbjoU+GoMBoeui12Y00c8GDeEz9S5R1duvaIH+T24K4jtM4vPfJTSjnDCTosHc1a3F
         hu3gv6xZ+mSmNMvHLfzbKExuXDU29pvB0t+kWUBs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxim Zhukov <mussitantesmortem@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.0 15/98] staging, mt7621-pci: fix build without pci support
Date:   Mon, 22 Apr 2019 15:40:42 -0400
Message-Id: <20190422194205.10404-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Zhukov <mussitantesmortem@gmail.com>

[ Upstream commit 90cd9bed5adb3e3bd4d3ac4cbcecbc4a8028bbaf ]

Add depends on PCI for PCI_MT7621

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/staging/mt7621-pci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/mt7621-pci/Kconfig b/drivers/staging/mt7621-pci/Kconfig
index d33533872a16..c8fa17cfa807 100644
--- a/drivers/staging/mt7621-pci/Kconfig
+++ b/drivers/staging/mt7621-pci/Kconfig
@@ -1,6 +1,7 @@
 config PCI_MT7621
 	tristate "MediaTek MT7621 PCI Controller"
 	depends on RALINK
+	depends on PCI
 	select PCI_DRIVERS_GENERIC
 	help
 	  This selects a driver for the MediaTek MT7621 PCI Controller.
-- 
2.19.1

