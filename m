Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5F3ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A9A21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453428;
	bh=K7LgRNjtfQSvtQ+wJTw1GwINfoQ5fEgtpuDfMLt+ONQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FRunO6B2BYs8ePmGS6+XJyla28gke87DExp0cjT8Gf9DhaTvSkuSuPK5hC910I5s4
	 CretQpW8sM/jsaphN3naxaSRDEn+S5UDl6bOuiHEQfHfzOtA6MvkTnHC4wfJ7lKQBd
	 suOR7oMSsluMyrfsRcw64JWcAauLmjNYwyC/6MxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfJGNDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:03:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49968 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfJGNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+GKNSiDM449B7j26Qri6+MHaUubwgCu58aKPDyjCsX4=; b=vgbv/AXWUC0p
        yKiGRaUI48LhhUO7h6WGJ7Pm3xcSLT7YuynHevPhoX8rnbDFEpIqn5cwH4uVk4VBvJuq7Xv6t8wuf
        HyRrMhsAdz7x7YihiTs9VFfo5Ryv9kZSe4oj/5drHSbwyHlHAisL3Psb8sPJG4cClbqFdFPHCi5A0
        +6+/o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfO-0003Qn-UP; Mon, 07 Oct 2019 13:03:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EAEBE2741EF0; Mon,  7 Oct 2019 14:03:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, andradanciu1997@gmail.com,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        enric.balletbo@collabora.com, Hulk Robot <hulkci@huawei.com>,
        kuninori.morimoto.gx@renesas.com, ladis@linux-mips.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, m.felsch@pengutronix.de,
        mirq-linux@rere.qmqm.pl, paul@crapouillou.net, perex@perex.cz,
        piotrs@opensource.cirrus.com, rf@opensource.wolfsonmicro.com,
        shifu0704@thundersoft.com, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Subject: Applied "ASoc: tas2770: Fix build error without GPIOLIB" to the asoc tree
In-Reply-To: <20191006104631.60608-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191007130309.EAEBE2741EF0@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:09 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoc: tas2770: Fix build error without GPIOLIB

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 03fe492e8346d3da59b6eb7ea306d46ebf22e9d5 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:46:31 +0800
Subject: [PATCH] ASoc: tas2770: Fix build error without GPIOLIB

If GPIOLIB is not set, building fails:

sound/soc/codecs/tas2770.c: In function tas2770_reset:
sound/soc/codecs/tas2770.c:38:3: error: implicit declaration of function gpiod_set_value_cansleep; did you mean gpio_set_value_cansleep? [-Werror=implicit-function-declaration]
   gpiod_set_value_cansleep(tas2770->reset_gpio, 0);
   ^~~~~~~~~~~~~~~~~~~~~~~~
   gpio_set_value_cansleep
sound/soc/codecs/tas2770.c: In function tas2770_i2c_probe:
sound/soc/codecs/tas2770.c:749:24: error: implicit declaration of function devm_gpiod_get_optional; did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]
  tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
                        ^~~~~~~~~~~~~~~~~~~~~~~
                        devm_regulator_get_optional
sound/soc/codecs/tas2770.c:751:13: error: GPIOD_OUT_HIGH undeclared (first use in this function); did you mean GPIOF_INIT_HIGH?
             GPIOD_OUT_HIGH);
             ^~~~~~~~~~~~~~
             GPIOF_INIT_HIGH

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
Suggested-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20191006104631.60608-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2770.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index dbbb21fe0548..15f6fcc6d87e 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -15,6 +15,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/firmware.h>
-- 
2.20.1

