Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDE9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774D322529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257258;
	bh=j7hjYLBTiYgP/Olh2gqSk1QwqVMqLpIv7BMtU43hpCQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=I0X5EOYp8ml2JRYCDOEKZ8qRmq4Om+YDLUcY6ADYKsQN6oyUECzEAxF/+wKusnW/l
	 uPKBSW8VqENQioPC9P2lVKitO0ZxPod2A3IDyjCzECY8O+Uk37jjgMVFeqFYvk9vch
	 Es2hWqwLUrdCDyz8ea8ZwQxwlocgn3843tzsVF58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfKTNk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbfKTNk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:56 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F1A224FC;
        Wed, 20 Nov 2019 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257255;
        bh=j7hjYLBTiYgP/Olh2gqSk1QwqVMqLpIv7BMtU43hpCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=x+mRt77lQ9fqi8mkNJMT9rElA1N/nukHqksY5peXRRvflwYCUqMufXeXou/wt4puT
         0MbgdHrpPg0NtHIDNgwdAVhC8m54UYG+kgliMH2d3Q/kT/q1yJPyvzyNgfc3fiI9+d
         qVljYvCxntZD87SySXaLwdeePCakBnx4k1ftWdnY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: onenand: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:40:50 +0800
Message-Id: <20191120134050.14622-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mtd/nand/onenand/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
index ae0b8fe5b990..ea382fc48432 100644
--- a/drivers/mtd/nand/onenand/Kconfig
+++ b/drivers/mtd/nand/onenand/Kconfig
@@ -33,12 +33,12 @@ config MTD_ONENAND_OMAP2
 	  Enable dmaengine and gpiolib for better performance.
 
 config MTD_ONENAND_SAMSUNG
-        tristate "OneNAND on Samsung SOC controller support"
-        depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS4
-        help
-          Support for a OneNAND flash device connected to an Samsung SOC.
-          S3C64XX uses command mapping method.
-          S5PC110/S5PC210 use generic OneNAND method.
+	tristate "OneNAND on Samsung SOC controller support"
+	depends on ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS4
+	help
+	  Support for a OneNAND flash device connected to an Samsung SOC.
+	  S3C64XX uses command mapping method.
+	  S5PC110/S5PC210 use generic OneNAND method.
 
 config MTD_ONENAND_OTP
 	bool "OneNAND OTP Support"
-- 
2.17.1

