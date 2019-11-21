Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E58C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F5C2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306393;
	bh=iVbwRxenny8n9cGqrqaySjV5UdnMK0fAnGxCLzvVwRo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GJeUli2wt82IDWMCzZQbaKfIbjPUZnQuf6qn0ZNlEoIGBsg9c3jehgZGQ9M00MIab
	 k3p1+XJv1fvX28n8/ADp/FPMbm36rruuzkrrd7txU6HUo4IJ1mxdG485lM8g6QIdOE
	 0vHRxn4TcXI3Ju9K7SSCG7zijZqVeyxZspLEqMb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKUDTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:19:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfKUDTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:51 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB9CC2089D;
        Thu, 21 Nov 2019 03:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306390;
        bh=iVbwRxenny8n9cGqrqaySjV5UdnMK0fAnGxCLzvVwRo=;
        h=From:To:Cc:Subject:Date:From;
        b=BcI2d9GjcmlTwlXaXIxTZk4x5W/94MAC8ozxQbMQ49zFMwcCULTcFiqmVwqeGaluq
         z74AjmhA3C4DCOPBh6FjRkp7p+As2Gb/5TFnQcEyGyd37gCYEBJUFBFy0eud4DJhrv
         lWLaYgZtGh8CL4gq6eZk97qDPuO2Ak8RkNyp3vXE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2] phy: hisilicon: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:47 +0100
Message-Id: <1574306387-8029-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/phy/hisilicon/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 534e393a09b3..1c73053bcc98 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -33,14 +33,14 @@ config PHY_HISTB_COMBPHY
 	  If unsure, say N.
 
 config PHY_HISI_INNO_USB2
-       tristate "HiSilicon INNO USB2 PHY support"
-       depends on (ARCH_HISI && ARM64) || COMPILE_TEST
-       select GENERIC_PHY
-       select MFD_SYSCON
-       help
-         Support for INNO USB2 PHY on HiSilicon SoCs. This Phy supports
-         USB 1.5Mb/s, USB 12Mb/s, USB 480Mb/s speeds. It supports one
-         USB host port to accept one USB device.
+	tristate "HiSilicon INNO USB2 PHY support"
+	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Support for INNO USB2 PHY on HiSilicon SoCs. This Phy supports
+	  USB 1.5Mb/s, USB 12Mb/s, USB 480Mb/s speeds. It supports one
+	  USB host port to accept one USB device.
 
 config PHY_HIX5HD2_SATA
 	tristate "HIX5HD2 SATA PHY Driver"
-- 
2.7.4

