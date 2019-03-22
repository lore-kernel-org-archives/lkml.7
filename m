Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C338520850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfCVJQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:16:54 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45181 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:16:54 -0400
X-Originating-IP: 90.88.33.153
Received: from localhost (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7701E1C000C;
        Fri, 22 Mar 2019 09:16:51 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sun6i-prcm: Allow to compile with COMPILE_TEST
Date:   Fri, 22 Mar 2019 10:16:50 +0100
Message-Id: <20190322091650.5189-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this driver only has a dependency on ARCH_SUNXI just because it
doesn't make any sense to run it on something else, we can definitely
enable it through COMPILE_TEST as well to get some build coverage.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0ce2d8dfc5f1..26ad6468d13a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1246,7 +1246,7 @@ config MFD_STA2X11
 
 config MFD_SUN6I_PRCM
 	bool "Allwinner A31 PRCM controller"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
 	select MFD_CORE
 	help
 	  Support for the PRCM (Power/Reset/Clock Management) unit available
-- 
2.20.1

