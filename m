Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C80C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22552133F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566498804;
	bh=sHxdlIv3sBia/oJJQivQkRnoM0mkrTSMSKQMwTk0Kbc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=SBljbELRzLrgf6+On8EJJXeRcRJYoyO/JddqOlQnzfLN4Lw7VcllmHmKtc13Q+FrH
	 UWoZ1estALegeF81uST7NMr8vy0cgsgIa74ooThc3w1+XKwNGT9HYOA96gdW65Pdai
	 4d6VMW7JAfxZaa8IIHRaSKfmpHq5ZrNbOgeAmUBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390842AbfHVSdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:33:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38010 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbfHVSdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3IOPSPIClE7HKnjr7s1UzzzM1kSkGao1Q9bHE/f9ZwY=; b=l5414VFfiXDs
        k5q6qVfdY2jeQ1WQWuRTLjkheqgKJRNrL3T8swK0w+wwQES9FwXn1WueukqFeSWhQs/1v2S4COyxj
        XbuVP+2/9V4loc8FZkN7kbwwbULRixeXu3wZM2ZVcP211e1glmn3lUlPe8tWu+3KOOTNHCRwXV4DM
        2yFww=;
Received: from 92.40.26.78.threembb.co.uk ([92.40.26.78] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i0rtS-0007ft-Ez; Thu, 22 Aug 2019 18:33:06 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 9C0E4D02CEB; Thu, 22 Aug 2019 19:32:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, maruthi.bayyavarapu@amd.com,
        perex@perex.cz, tglx@linutronix.de, tiwai@suse.com,
        Vijendar.Mukunda@amd.com, yuehaibing@huawei.com
Subject: Applied "ASoC: AMD: Fix Kconfig warning without GPIOLIB" to the asoc tree
In-Reply-To: <20190822143007.73644-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190822183257.9C0E4D02CEB@fitzroy.sirena.org.uk>
Date:   Thu, 22 Aug 2019 19:32:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Fix Kconfig warning without GPIOLIB

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

From 0ce6a624473e7e5752a84416f85f73d082308edd Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 22 Aug 2019 22:30:07 +0800
Subject: [PATCH] ASoC: AMD: Fix Kconfig warning without GPIOLIB

While do rand build without GPIOLIB, we get Kconfig warning:\

WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
  Depends on [n]: SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && GPIOLIB [=n]
  Selected by [m]:
  - SND_SOC_AMD_CZ_DA7219MX98357_MACH [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_AMD_ACP [=m] && I2C [=y]

Add GPIOLIB dependency to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190822143007.73644-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 9ca9214cb7fb..5f40517717c4 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -10,7 +10,7 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
 	select SND_SOC_MAX98357A
 	select SND_SOC_ADAU7002
 	select REGULATOR
-	depends on SND_SOC_AMD_ACP && I2C
+	depends on SND_SOC_AMD_ACP && I2C && GPIOLIB
 	help
 	 This option enables machine driver for DA7219 and MAX9835.
 
-- 
2.20.1

