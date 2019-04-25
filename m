Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA7CC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3745A20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220412;
	bh=QzyhD7N9W9+3Rkpw4KW13ZoZa7onjnWNrb8Pk/Z/3Wc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UyMl0Fws/ZQpmdfQuSPQupYqrsedh0kW56UsRu4lFMwQzV8JmojL7su5PXKSKzp+B
	 fyTBUcCHEn7iAI29xyT+5ZBaCLXGT80pwfq4WufuiSJMnz1C1VVKSY9VcyMlQ1imgT
	 Xw6ff8gnzhzm4V8f+mrHiHlebIo5h5ngRu3AaBbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfDYT0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:26:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52928 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfDYT0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UnN0noVs09U+oC8IHwNuhp93wJJtR3MSoJVYguNN22o=; b=JOyeSbj8wBYI
        sOE9P5NYs6sXQ5uCXGGULMAIGnjYPffBgnZsbGyf6FhcuPkIcDrMKS69LZ8hs3+TvwOQ/CW8347nV
        5K1DEeq/v0i4Xk5y3XiWTLBAW+6TYnFCCraPZc0BuEqGTOhRASTJtUMPwWA5Hc2kVIjIkn1sGz9Hg
        Kbqp0=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJk12-0004f9-I9; Thu, 25 Apr 2019 19:26:40 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AD9F3441D3C; Thu, 25 Apr 2019 20:26:39 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     alexandre.belloni@bootlin.com, broonie@kernel.org,
        Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Ludovic.Desroches@microchip.com, Mark Brown <broonie@kernel.org>,
        Nicolas.Ferre@microchip.com
Subject: Applied "spi: atmel-quadspi: fix crash while suspending" to the spi tree
In-Reply-To: <1556097463-29672-1-git-send-email-claudiu.beznea@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190425192639.AD9F3441D3C@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:26:39 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: atmel-quadspi: fix crash while suspending

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.1

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

From 12eede5fccc06e422b2de869a3675ee57737bf48 Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea@microchip.com>
Date: Wed, 24 Apr 2019 09:17:59 +0000
Subject: [PATCH] spi: atmel-quadspi: fix crash while suspending

atmel_qspi objects are kept in spi_controller objects, so, first get
pointer to spi_controller object and then get atmel_qspi object from
spi_controller object.

Fixes: 2d30ac5ed633 ("mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index fffc21cd5f79..b3173ebddade 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -570,7 +570,8 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 
 static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 {
-	struct atmel_qspi *aq = dev_get_drvdata(dev);
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 
 	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
@@ -580,7 +581,8 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 
 static int __maybe_unused atmel_qspi_resume(struct device *dev)
 {
-	struct atmel_qspi *aq = dev_get_drvdata(dev);
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 
 	clk_prepare_enable(aq->pclk);
 	clk_prepare_enable(aq->qspick);
-- 
2.20.1

