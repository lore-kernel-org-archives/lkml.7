Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9BCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C45220882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554357897;
	bh=etpUK9Al73JuwM038DrXeoI7qA3z329xpKMgk0MezJY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fVXCgaVHlxYhvyakS5Lb5jstSflf62lEZnkvwRj2VuRwckp6LidQTZQTVerXbHWLC
	 xb8Y+0BmT0zxl2bPeFjOd7Fivkj+15+rFf6kwwPWGmd7RaeEIkw0HGnZQSW9kTdpnV
	 cPMma2SpvJczVgGo23F86DydPw3ubSSSJ52T/Q/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfDDGE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:04:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54936 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDGE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2rgDEZsUXdb8YOXSCSRlFdhsiWbtX137iMc55cA08qw=; b=JmGYAopRZysj
        RgbQIjhs8hDIBbPqZlZ4UGgIkAgoeqX6QGMaEhwVsX9CRmjYq+fulZ9+qlQjVD7dHbQPpoSr14y2j
        atsTkd9sOCUsNInSlykx6s6SyP/+HFBN79P74ILGFJc2j1Q6cwZ7ellELyGkNOJssJr01ltDExpJq
        jH7TM=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBvUZ-0004Me-KL; Thu, 04 Apr 2019 06:04:51 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 72973441D3E; Thu,  4 Apr 2019 13:04:48 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: Add missing error handling for CS GPIOs" to the spi tree
In-Reply-To:  <20190403144656.8257-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Message-Id: <20190404060448.72973441D3E@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 13:04:48 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Add missing error handling for CS GPIOs

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

From 1723fdec5fcbc4de3d26bbb23a9e1704ee258955 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 3 Apr 2019 16:46:56 +0200
Subject: [PATCH] spi: Add missing error handling for CS GPIOs

While devm_gpiod_get_index_optional() returns NULL if the GPIO is not
present (i.e. -ENOENT), it may still return other error codes, like
-EPROBE_DEFER.  Currently these are not handled, leading to
unrecoverable failures later in case of probe deferral:

    gpiod_set_consumer_name: invalid GPIO (errorpointer)
    gpiod_direction_output: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)

Detect and propagate errors to fix this.

Fixes: f3186dd876697e69 ("spi: Optionally use GPIO descriptors for CS GPIOs")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2be394d3bc59..7b6494bd8a9b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2197,6 +2197,8 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 		 */
 		cs[i] = devm_gpiod_get_index_optional(dev, "cs", i,
 						      GPIOD_OUT_LOW);
+		if (IS_ERR(cs[i]))
+			return PTR_ERR(cs[i]);
 
 		if (cs[i]) {
 			/*
-- 
2.20.1

