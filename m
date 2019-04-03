Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E99C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D6E20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266553;
	bh=KClv/qLSq37fJQn9YzcKBcnkiJTMz+OIuadpUf41jw8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=TxzPpSgeFB7H7u0PhUd57lCdoRtRvLgkY1gW+RwaE47xYqlA+8B55mpeewPW7YwV1
	 bli95x7rjN+/ugHN3LYAxmgOjmqx0f/9FhEw/Gpn+mDFY6Z+eSTH0CcGqagqdqbwqP
	 a0ZDQ7GIBUlKvWRZsPlgN6ck2aTMzjHy1cpTPzyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfDCEmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:42:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40646 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfDCEma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=go7ph3JnU9PONBzlMM8im0yKe6VYBcKsU+9wWKNXBo4=; b=R5HWLfhya1oJ
        Ez4Mm+oXdQx7ZrzsdserZsrqwnmhxAjxpueV9wUfiwUjR7k4E3WWxwVdVKbU/y+Wq7Z6g8dyM+B9I
        /OsEKl6xtKuASTNCEk1Rzx9SssFoWWdH12RWbwvbzAFljtSD8a0/j/oUoT0vJFma9sJTiLUmEvvb2
        qV8rY=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXjH-00040e-Ch; Wed, 03 Apr 2019 04:42:27 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6EE43440082; Wed,  3 Apr 2019 05:42:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: gpio: Drop unused pdata copy in struct spi_gpio" to the spi tree
In-Reply-To:  <20190403040133.1459-6-andrew.smirnov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190403044224.6EE43440082@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:42:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: gpio: Drop unused pdata copy in struct spi_gpio

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

From 703b476695237dda54233d2dadb37d2d49de23cf Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:26 -0700
Subject: [PATCH] spi: gpio: Drop unused pdata copy in struct spi_gpio

Drop unused pdata copy in struct spi_gpio. No functional change
intended.

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
index 137f47e271dc..1cff30adc836 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -42,7 +42,6 @@
 
 struct spi_gpio {
 	struct spi_bitbang		bitbang;
-	struct spi_gpio_platform_data	pdata;
 	struct platform_device		*pdev;
 	struct gpio_desc		*sck;
 	struct gpio_desc		*miso;
@@ -415,8 +414,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	spi_gpio->has_cs = !!pdata->num_chipselect;
 
 	spi_gpio->pdev = pdev;
-	if (pdata)
-		spi_gpio->pdata = *pdata;
 
 	status = spi_gpio_request(dev, spi_gpio,
 				  pdata->num_chipselect, &master_flags);
-- 
2.20.1

