Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0162FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7E420748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577726697;
	bh=EsQA2oBlxFfBaNY5mvtk/CPk5uxnzq/ckqNlGd4sN4M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xA1Y/X5gUYZCfdtcohylDNqy095t92S03v2OEmzhbRUCcY2GjjYDfpvqgwugNauDQ
	 g+6WALbihpNoZPIHytj9mq/5AoaRfeILtnYL1wnKViGqOQjvjgEIIL+7283n/6l2oj
	 7NYuBXVAvbQBV3fuyk54FFu3TOJb76Zuv7CkTz6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfL3RY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfL3RY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:24:56 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C22206DB;
        Mon, 30 Dec 2019 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726696;
        bh=EsQA2oBlxFfBaNY5mvtk/CPk5uxnzq/ckqNlGd4sN4M=;
        h=From:To:Cc:Subject:Date:From;
        b=HeHKm9YNBsTFVLr7oG0enmKL6DHvH1S6zKL+u/h948o9zCkmlkpOqJBw7+Yu2Rsew
         hreH/Bn13Ww9iOLvUv3hN49bXTNMMfQD9PEC9Ulj5F4bXiajxtNFGYrv1aczgNEdAH
         sTSVttvwlXrI4jS631zOrYtC4U67O6FIme8R9f+4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] phy: mediatek: Fix Kconfig indentation
Date:   Mon, 30 Dec 2019 18:24:48 +0100
Message-Id: <20191230172449.17648-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/phy/mediatek/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 376f5d189da0..7d19134c6b7c 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -3,12 +3,12 @@
 # Phy drivers for Mediatek devices
 #
 config PHY_MTK_TPHY
-    tristate "MediaTek T-PHY Driver"
-    depends on ARCH_MEDIATEK && OF
-    select GENERIC_PHY
-    help
-      Say 'Y' here to add support for MediaTek T-PHY driver,
-      it supports multiple usb2.0, usb3.0 ports, PCIe and
+	tristate "MediaTek T-PHY Driver"
+	depends on ARCH_MEDIATEK && OF
+	select GENERIC_PHY
+	help
+	  Say 'Y' here to add support for MediaTek T-PHY driver,
+	  it supports multiple usb2.0, usb3.0 ports, PCIe and
 	  SATA, and meanwhile supports two version T-PHY which have
 	  different banks layout, the T-PHY with shared banks between
 	  multi-ports is first version, otherwise is second veriosn,
@@ -25,10 +25,10 @@ config PHY_MTK_UFS
 	  specified M-PHYs.
 
 config PHY_MTK_XSPHY
-    tristate "MediaTek XS-PHY Driver"
-    depends on ARCH_MEDIATEK && OF
-    select GENERIC_PHY
-    help
+	tristate "MediaTek XS-PHY Driver"
+	depends on ARCH_MEDIATEK && OF
+	select GENERIC_PHY
+	help
 	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
 	  USB3.1 GEN2 controllers on MediaTek chips. The driver supports
 	  multiple USB2.0, USB3.1 GEN2 ports.
-- 
2.17.1

