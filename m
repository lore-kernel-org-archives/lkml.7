Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AFECA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AB520650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503303AbfJXPcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:32:35 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:55384 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503293AbfJXPce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:32:34 -0400
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id HTYX2100t5USYZQ01TYXEg; Thu, 24 Oct 2019 17:32:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf6F-0007A6-SN; Thu, 24 Oct 2019 17:32:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf6F-00088m-QP; Thu, 24 Oct 2019 17:32:31 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] mtd: spi-nor: Spelling s/Configuraiton/Configuration/
Date:   Thu, 24 Oct 2019 17:32:30 +0200
Message-Id: <20191024153230.31251-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspelling of "Configuration".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 7acf4a93b5923116..9703e8725f41b158 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1735,7 +1735,7 @@ static int macronix_quad_enable(struct spi_nor *nor)
 }
 
 /**
- * spansion_quad_enable() - set QE bit in Configuraiton Register.
+ * spansion_quad_enable() - set QE bit in Configuration Register.
  * @nor:	pointer to a 'struct spi_nor'
  *
  * Set the Quad Enable (QE) bit in the Configuration Register.
-- 
2.17.1

