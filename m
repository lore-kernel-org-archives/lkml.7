Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7439C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93550206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfEPLWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:22:46 -0400
Received: from securetransport.cubewerk.de ([178.254.23.77]:38850 "EHLO
        securetransport.cubewerk.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbfEPLWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:22:46 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 07:22:45 EDT
Received: from DHPLMX01.DH-ELECTRONICS.ORG (ipbcc19eae.dynamic.kabel-deutschland.de [188.193.158.174])
        (using TLSv1.2 with cipher DHE-RSA-CAMELLIA128-SHA256 (128/128 bits))
        (No client certificate requested)
        by securetransport.cubewerk.de (Postfix) with ESMTPSA id 465C78045B;
        Thu, 16 May 2019 13:14:51 +0200 (CEST)
Received: from Stretch.dh-electronics.org (unknown [10.64.6.184])
        by DHPLMX01.DH-ELECTRONICS.ORG (Postfix) with ESMTPS id 062B52145A82;
        Thu, 16 May 2019 13:14:51 +0200 (CEST)
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cniedermaier@dh-electronics.com
Subject: [PATCH] spi: spidev: Add dhcom-board to compatibility list [Klartext]
Date:   Thu, 16 May 2019 13:14:50 +0200
Message-Id: <20190516111450.6730-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to use devices on the external SPI interface
on a DH electronics Development Board.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index b0c76e2626ce..61ec1dce557f 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -670,6 +670,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "ge,achc" },
 	{ .compatible = "semtech,sx1301" },
 	{ .compatible = "lwn,bk4" },
+	{ .compatible = "dh,dhcom-board" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.11.0

