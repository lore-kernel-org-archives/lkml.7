Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19713C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3DA2146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266556;
	bh=N/Wu+0XUKYs/epqHYYgIi56DlhrnRrtyhAIXbvXTX+Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vMgzzH0nEB3CS8jUeLwVgc29P5k4UF4ueIPGbUI6TVE0EyJjEka55jMGBImbYxg7Z
	 PqUoOSnN+s9Gf7UbGdlinV7TjW6fRagJyY362c+Wr6kkaJUwEZR4B2q18llaGo6XXD
	 JoIx335GarIkPoh2+8TF+zKV+pLb76iv+PVVv8Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfDCEmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:42:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40708 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbfDCEmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=j1hfVsMh7MtbvDj4SYq/BkxydPS+KCDByMA/icr/mrY=; b=T7CBwnMY6+eI
        Et6Ci/yKFZMO8/YQAiX1/RNqoVWMqSQoSE5Bbv964LOMweTB5Ndeiu4w+JyKb/89a6bJLe3wAq+wz
        KREvVk6DaXF1saMWTfl4FZ9pXkFXgt2BHUKBFlKqVDlydy1MqGkF8pwawt9oyfsrbXa9e5vG2GTab
        8GrjA=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXjK-00040n-AC; Wed, 03 Apr 2019 04:42:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6B7EE440083; Wed,  3 Apr 2019 05:42:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: gpio: Simplify SPI_MASTER_NO_TX check in spi_gpio_probe()" to the spi tree
In-Reply-To:  <20190403040133.1459-5-andrew.smirnov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190403044227.6B7EE440083@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:42:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: gpio: Simplify SPI_MASTER_NO_TX check in spi_gpio_probe()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 68cd9dc2cc00b2ab0dbcdbbec446d5bdc56fea4b Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:25 -0700
Subject: [PATCH] spi: gpio: Simplify SPI_MASTER_NO_TX check in
 spi_gpio_probe()

Swap branches of the if statement in order to simplify it's logical
condition being checked. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index ca97b861c625..137f47e271dc 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -440,16 +440,16 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	bb->chipselect = spi_gpio_chipselect;
 	bb->set_line_direction = spi_gpio_set_direction;
 
-	if ((master_flags & SPI_MASTER_NO_TX) == 0) {
-		bb->txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
-		bb->txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
-		bb->txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
-		bb->txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
-	} else {
+	if (master_flags & SPI_MASTER_NO_TX) {
 		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
 		bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
 		bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
 		bb->txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
+	} else {
+		bb->txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
+		bb->txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
+		bb->txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
+		bb->txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
 	}
 	bb->setup_transfer = spi_bitbang_setup_transfer;
 
-- 
2.20.1

