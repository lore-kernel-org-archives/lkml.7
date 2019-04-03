Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297D6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041C220830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDCOqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:46:10 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:48734 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDCOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:46:06 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id vqm31z0153XaVaC01qm3B1; Wed, 03 Apr 2019 16:46:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hBh9P-0003aV-S2; Wed, 03 Apr 2019 16:46:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hBh9P-00027L-Pi; Wed, 03 Apr 2019 16:46:03 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: spi-gpio: Remove spi->controller_data comment
Date:   Wed,  3 Apr 2019 16:46:02 +0200
Message-Id: <20190403144602.8098-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion from GPIO numbers to GPIO descriptors removed the use of
spi->controller_data, but forgot to update a comment referring to it.

Fixes: 9b00bc7b901ff672 ("spi: spi-gpio: Rewrite to use GPIO descriptors")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 53b35c56a557ae8a..f22db00b51e453b8 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -35,7 +35,6 @@
  * platform_device->driver_data ... points to spi_gpio
  *
  * spi->controller_state ... reserved for bitbang framework code
- * spi->controller_data ... holds chipselect GPIO
  *
  * spi->master->dev.driver_data ... points to spi_gpio->bitbang
  */
-- 
2.17.1

