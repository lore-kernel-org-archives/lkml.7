Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE548C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C703423BC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559144752;
	bh=ipsnDTfFyarbZMkm5rwujBY5joli970lBIr5pHZNaYU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UjObBhi2yhKPoyq+0kRCuSKs+7K85ZlTrZTN3AqlYK5FNjqG8TcvJXyXmZHGwZCpL
	 6YEGPcNLxXHI9vO8KRvfPQ+KXSBdlv4L124jHzZLj31mdfCQyE0UGNtxq9AlRf4jNN
	 v7RTkfT4Iuc5anZTF2LmMe9YwU8cX3wLBYZ0cXOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfE2Ppv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:45:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42018 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2Ppv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MbU9KTY7lRDIVaXn8e0mtzlZsMKjQlL1HDMtTrGcWVU=; b=RpxO9O0fZlZc
        SlD3qDONZ4mfn9y7+lab4VuQdISTMB2Fh66MCYFDjfDo48bOHj4vzbfJF8uZEA5c+adurrrwii8cx
        ozEhbLsRiGTKQhUHyuXzi4CgrzUalLqria5uKMVljkwNG9f1HNaBiHkQZKuLJT/TAJWfErdISVyac
        q544U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hW0lh-00051h-5v; Wed, 29 May 2019 15:45:33 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 8B003440049; Wed, 29 May 2019 16:45:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, brian.austin@cirrus.com,
        broonie@kernel.org, kbuild test robot <lkp@intel.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Paul.Handrigan@cirrus.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: cs42xx8: Fix build error with CONFIG_GPIOLIB is not set" to the asoc tree
In-Reply-To: <20190529033002.16606-1-shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190529154527.8B003440049@finisterre.sirena.org.uk>
Date:   Wed, 29 May 2019 16:45:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42xx8: Fix build error with CONFIG_GPIOLIB is not set

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 7cda6223503d592f980a222811355ab07611b821 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Wed, 29 May 2019 11:30:02 +0800
Subject: [PATCH] ASoC: cs42xx8: Fix build error with CONFIG_GPIOLIB is not set
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

config: x86_64-randconfig-x000201921-201921
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        make ARCH=x86_64

sound/soc/codecs/cs42xx8.c: In function ‘cs42xx8_probe’:
sound/soc/codecs/cs42xx8.c:472:25: error: implicit declaration of function ‘devm_gpiod_get_optional’; did you mean ‘devm_clk_get_optional’? [-Werror=implicit-function-declaration]
  cs42xx8->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
                         ^~~~~~~~~~~~~~~~~~~~~~~
                         devm_clk_get_optional
sound/soc/codecs/cs42xx8.c:473:8: error: ‘GPIOD_OUT_HIGH’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_HIGH’?
        GPIOD_OUT_HIGH);
        ^~~~~~~~~~~~~~
        GPIOF_INIT_HIGH
sound/soc/codecs/cs42xx8.c:473:8: note: each undeclared identifier is reported only once for each function it appears in
sound/soc/codecs/cs42xx8.c:477:2: error: implicit declaration of function ‘gpiod_set_value_cansleep’; did you mean ‘gpio_set_value_cansleep’? [-Werror=implicit-function-declaration]
  gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 0);
  ^~~~~~~~~~~~~~~~~~~~~~~~
  gpio_set_value_cansleep

Fixes: bfe95dfa4dac ("ASoC: cs42xx8: Add reset gpio handling")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42xx8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index b377cddaf2e6..6203f54d9f25 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <sound/pcm_params.h>
-- 
2.20.1

