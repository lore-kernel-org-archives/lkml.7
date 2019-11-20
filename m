Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33B9C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729C322528
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257393;
	bh=7efHtyV3wEVueAoQzTQPrJ546M7CEJGuZVDmGQSNb+o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UiMWcq8B9+6FgZ14zUBfDlxCcsC/hmGUym3nH8r6+MH3QBC1UHq5xd3DusoJcc7UI
	 a0L6NK0EODlBuXimP7cDYwXlaGXFrimXhP26xEciWz4TsyOgvd+2vWsTejrgtpExYA
	 AK6dLGWffetByDLOMtzS4E/g6I2CJqf1L8sjSzlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbfKTNnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbfKTNnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:09 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B75B22529;
        Wed, 20 Nov 2019 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257389;
        bh=7efHtyV3wEVueAoQzTQPrJ546M7CEJGuZVDmGQSNb+o=;
        h=From:To:Cc:Subject:Date:From;
        b=PVGjH7jlB4Ho1DZupPty70X8WqPuLHRp3TLuTnQlWBR9/5d7AyHWQK/G1aBpitwwN
         1nuWvb2puhk3RJjzv/YgENIdSzUKT/5WkJE0YE7LfRCYNFEAl6pNn0p7Qc6M4LShkn
         /k+wh27QakrkQ0znpP912zXTcNHtdmScI6Faf78w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: [PATCH] ata: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:43:05 +0800
Message-Id: <20191120134305.16300-1-krzk@kernel.org>
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
 drivers/ata/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a6beb2c5a692..86e35c9a9ac6 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -695,7 +695,7 @@ config PATA_IMX
 	depends on ARCH_MXC
 	help
 	  This option enables support for the PATA host available on Freescale
-          iMX SoCs.
+	  iMX SoCs.
 
 	  If unsure, say N.
 
@@ -704,7 +704,7 @@ config PATA_IT8213
 	depends on PCI
 	help
 	  This option enables support for the ITE 821 PATA
-          controllers via the new ATA layer.
+	  controllers via the new ATA layer.
 
 	  If unsure, say N.
 
@@ -732,9 +732,9 @@ config PATA_MACIO
 	depends on PPC_PMAC
 	help
 	  Most IDE capable PowerMacs have IDE busses driven by a variant
-          of this controller which is part of the Apple chipset used on
-          most PowerMac models. Some models have multiple busses using
-          different chipsets, though generally, MacIO is one of them.
+	  of this controller which is part of the Apple chipset used on
+	  most PowerMac models. Some models have multiple busses using
+	  different chipsets, though generally, MacIO is one of them.
 
 config PATA_MARVELL
 	tristate "Marvell PATA support via legacy mode"
@@ -915,7 +915,7 @@ config PATA_PXA
 	  This option enables support for harddrive attached to PXA CPU's bus.
 
 	  NOTE: This driver utilizes PXA DMA controller, in case your hardware
-	        is not capable of doing MWDMA, use pata_platform instead.
+	  is not capable of doing MWDMA, use pata_platform instead.
 
 	  If unsure, say N.
 
-- 
2.17.1

