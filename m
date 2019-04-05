Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49E3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C76217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554434799;
	bh=hISdXM4ch+2fykgMGeTwLcdfvzSLbojSpn1PoRQFtX4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ojsK6a8DyVKjl1i2mI6r4DA/tpSHIieAqp6r/mrALLgpeWPsMeBQwcZe+Kr/7LW5I
	 4pfAnzvyY5s4FA6m/VtM+sAUhBIgI+RjKyjPq7dxCzSdkBAxmj0KiBNVeTAkXuJD3O
	 0AUmElxSG9k7DNb2s1OsUgqPJm4TkWNPhKZqIA7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfDED0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:26:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33344 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfDED0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ii7LGS/+Jq+L28mX8GKrZLN7me2uvsEabd/9uCIhDbY=; b=FUw0s0jkwByF
        h61E8nk9iSFVKQi50pqb11W1CHAjEWMGBIo0tdE2TTvAixtB8gm1bmTvwSrkxjgf7fNK3jCnhTuXP
        pY8M8ubRbgNG945AjPBt0i0XqAdaaBMcKjK/J/WV6Vsx0/LssjVEig6IpJnc1JLw7/6IvGN2bsJUr
        d3Hjg=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCFUw-0005fi-UA; Fri, 05 Apr 2019 03:26:35 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AAA1C441D3B; Fri,  5 Apr 2019 10:26:31 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: gpio: Drop unused pdev field in struct spi_gpio" to the spi tree
In-Reply-To:  <20190403040133.1459-10-andrew.smirnov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405032631.AAA1C441D3B@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 10:26:31 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: gpio: Drop unused pdev field in struct spi_gpio

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

From 45f7718ae713e52def029c071cdba19a8045ac52 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:30 -0700
Subject: [PATCH] spi: gpio: Drop unused pdev field in struct spi_gpio

There's no code using 'pdev' field in struct spi_gpio. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 4b2a80abf36e..5ac9ae192ddf 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -41,7 +41,6 @@
 
 struct spi_gpio {
 	struct spi_bitbang		bitbang;
-	struct platform_device		*pdev;
 	struct gpio_desc		*sck;
 	struct gpio_desc		*miso;
 	struct gpio_desc		*mosi;
@@ -390,8 +389,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spi_gpio);
 
-	spi_gpio->pdev = pdev;
-
 	status = spi_gpio_request(dev, spi_gpio);
 	if (status)
 		return status;
-- 
2.20.1

