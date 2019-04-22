Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63506C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D981218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962340;
	bh=4M/H2Pqbr35Cyfqi7q5RW+FgCH80FxV6EDYCtkObp/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lk37vnKsNiMNY45lNYq1aNJqIQ+mDnzbgv+M5qDN1K7GH6kPq1vt4oquzb+tCjm9m
	 2zLxEOvsvQKuHKBw9HBtwnk/yPzB+fbaHOGb2TD6EgvAXJ92VpD8tBZ7roIbvzIgDV
	 c1QHP2AwWGg1J6FKO6wTt5Mzr1Gq0sK+H3Vc8urI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfDVTpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbfDVTpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 246E9218B0;
        Mon, 22 Apr 2019 19:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962335;
        bh=4M/H2Pqbr35Cyfqi7q5RW+FgCH80FxV6EDYCtkObp/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yknu7F/fJekqXkhZJrjPg9ajDwCHU0/KFMt9zV8UYp/aVSG/ZjvmnzEPpo/6ySrWB
         ymv+8an2CcHNM5N5IspXhXVvyIZe4l5yExeJpkuwuj2+syNwKzKKeAZLwsjyPVW2PC
         gkqMMQz9nK7RTT9KvG5ugYEYuCSD4C3IGi8ztSMA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxim Zhukov <mussitantesmortem@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.19 09/68] staging, mt7621-pci: fix build without pci support
Date:   Mon, 22 Apr 2019 15:44:17 -0400
Message-Id: <20190422194516.11634-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
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

