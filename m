Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B4C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92B52173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfH2MHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:07:44 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36558 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfH2MHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:07:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D214B1A002D;
        Thu, 29 Aug 2019 14:07:42 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E3C801A015C;
        Thu, 29 Aug 2019 14:07:36 +0200 (CEST)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CB7F9402BE;
        Thu, 29 Aug 2019 20:07:29 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     tudor.ambarus@microchip.com, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Ashish Kumar <Ashish.Kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: [PATCH v4] mtd: spi-nor: Add flash property for mt35xu02g
Date:   Thu, 29 Aug 2019 17:37:24 +0530
Message-Id: <1567080445-32695-1-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt35xu02g is Octal flash supporting Single I/O and QCTAL I/O
and it has been tested on LS1028ARDB

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
v4:
split into seperate patch
v3:
v2:
did not exist

 drivers/mtd/spi-nor/spi-nor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b585f3fee4f0..409e81153525 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1899,6 +1899,9 @@ static const struct flash_info spi_nor_ids[] = {
 			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
 			SPI_NOR_4B_OPCODES)
 	},
+	{ "mt35xu02g",  INFO(0x2c5b1c, 0, 128 * 1024, 2048,
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
+			SPI_NOR_4B_OPCODES) },
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
-- 
2.17.1

