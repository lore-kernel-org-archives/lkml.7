Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB21C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27BD2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306402;
	bh=X0Vkav8AN/Y4ly6J0JOv/ouzlDy9mO5Na/nrav0JajA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xRtZlBxGlAtBvqBi3PHsvxvWNC6SlzNuymPX4blD1RrTXdOekz9m0M/lUdilT9Pf9
	 Wr8vsYtpoFve9tHKT+Ztbu+D1wZvv808u7JRuzUjRJS4WlBUNQ2/1yQNp/MyCJg00W
	 Kfc1FYwK8NAV1l0qk0vIuW6q52YTXCjQENsO7F1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKUDUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfKUDT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:59 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B5220721;
        Thu, 21 Nov 2019 03:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306398;
        bh=X0Vkav8AN/Y4ly6J0JOv/ouzlDy9mO5Na/nrav0JajA=;
        h=From:To:Cc:Subject:Date:From;
        b=YM/oP5LlNOO07WQZHM+AY4YXVDFIs7yu3TVPAUKE7NvZeDCzIg2L2ru5OnR1Fcuy2
         49nzzfKgsOFBt99HlG4mA/FqIFpgCa4lEAMY74dwgEllt6KuPSTaQoqBlAbKKA+QGf
         Cr4MmU3+rKAHitF3cIz3cFllJ2ZJgSmDlAYvyO2s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2] power: reset: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:55 +0100
Message-Id: <1574306395-12906-1-git-send-email-krzk@kernel.org>
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
 drivers/power/reset/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index c721939767eb..0498363203e8 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -141,14 +141,14 @@ config POWER_RESET_LTC2952
 	  down via the LTC2952. Bindings are made in the device tree.
 
 config POWER_RESET_MT6323
-       bool "MediaTek MT6323 power-off driver"
-       depends on MFD_MT6397
-       help
-         The power-off driver is responsible for externally shutdown down
-         the power of a remote MediaTek SoC MT6323 is connected to through
-         controlling a tiny circuit BBPU inside MT6323 RTC.
-
-         Say Y if you have a board where MT6323 could be found.
+	bool "MediaTek MT6323 power-off driver"
+	depends on MFD_MT6397
+	help
+	  The power-off driver is responsible for externally shutdown down
+	  the power of a remote MediaTek SoC MT6323 is connected to through
+	  controlling a tiny circuit BBPU inside MT6323 RTC.
+
+	  Say Y if you have a board where MT6323 could be found.
 
 config POWER_RESET_QNAP
 	bool "QNAP power-off driver"
-- 
2.7.4

