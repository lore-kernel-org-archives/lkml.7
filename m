Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326ADC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0826F20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560785063;
	bh=GIOIZS5NG/Iq/9tqWRegDBfQkb/hacgBx2BrwLFwSow=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=RSJhCRCNcPZQ6HrChMgd/n66fZkXA7gp9bhfr+WahHZW4D4WM3bT9PSmhqufVbQc8
	 hyVveIPfkBJFekRiF4aNpr7lht4riaIF6pjCpL0erQZvvrMLIFYFXeweTRhqwl6Fts
	 b45avoKl3BLAdiXLYqH1oClPd/c/f2eswQCLeCCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfFQPYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:24:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51108 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQPYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=it1kr7G1wlh1P22+SaO0uRfhU0JKkzwSA2wuovs4jF0=; b=jtD/gwDGkvm6
        R6q64Us9xmw21xC57TOxF42gxJkYUXBIC4wudEgmZFXBjePk9E1sWv2dyJvLsPslx7MWstlHX31oy
        eDD0eQQjGXR1JABfOt5TmO4Mvo4Oxa1/bk0EQA0ypCPfzLe12aY+567WK+kbb/DCcVHuU4PHGh6Us
        NOPRQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hctUV-0001wj-KA; Mon, 17 Jun 2019 15:24:15 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 2AD7D440046; Mon, 17 Jun 2019 16:24:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add missing newline at end of file" to the asoc tree
In-Reply-To: <20190617144048.5450-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Message-Id: <20190617152415.2AD7D440046@finisterre.sirena.org.uk>
Date:   Mon, 17 Jun 2019 16:24:15 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Add missing newline at end of file

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

From 501e94b52aeda5841a60ceead5984ff575aeefa0 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 17 Jun 2019 16:40:48 +0200
Subject: [PATCH] ASoC: Add missing newline at end of file

"git diff" says:

    \ No newline at end of file

after modifying the files.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/common/Makefile | 2 +-
 sound/soc/tegra/Makefile           | 2 +-
 sound/usb/bcd2000/Makefile         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/common/Makefile b/sound/soc/mediatek/common/Makefile
index 9ab90433a8d7..acbe01e9e928 100644
--- a/sound/soc/mediatek/common/Makefile
+++ b/sound/soc/mediatek/common/Makefile
@@ -3,4 +3,4 @@
 snd-soc-mtk-common-objs := mtk-afe-platform-driver.o mtk-afe-fe-dai.o
 obj-$(CONFIG_SND_SOC_MEDIATEK) += snd-soc-mtk-common.o
 
-obj-$(CONFIG_SND_SOC_MTK_BTCVSD) += mtk-btcvsd.o
\ No newline at end of file
+obj-$(CONFIG_SND_SOC_MTK_BTCVSD) += mtk-btcvsd.o
diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
index 2329b72c93e3..c84f183919f2 100644
--- a/sound/soc/tegra/Makefile
+++ b/sound/soc/tegra/Makefile
@@ -37,4 +37,4 @@ obj-$(CONFIG_SND_SOC_TEGRA_WM9712) += snd-soc-tegra-wm9712.o
 obj-$(CONFIG_SND_SOC_TEGRA_TRIMSLICE) += snd-soc-tegra-trimslice.o
 obj-$(CONFIG_SND_SOC_TEGRA_ALC5632) += snd-soc-tegra-alc5632.o
 obj-$(CONFIG_SND_SOC_TEGRA_MAX98090) += snd-soc-tegra-max98090.o
-obj-$(CONFIG_SND_SOC_TEGRA_SGTL5000) += snd-soc-tegra-sgtl5000.o
\ No newline at end of file
+obj-$(CONFIG_SND_SOC_TEGRA_SGTL5000) += snd-soc-tegra-sgtl5000.o
diff --git a/sound/usb/bcd2000/Makefile b/sound/usb/bcd2000/Makefile
index f09ccc0af6ff..0a100310a671 100644
--- a/sound/usb/bcd2000/Makefile
+++ b/sound/usb/bcd2000/Makefile
@@ -1,3 +1,3 @@
 snd-bcd2000-y := bcd2000.o
 
-obj-$(CONFIG_SND_BCD2000) += snd-bcd2000.o
\ No newline at end of file
+obj-$(CONFIG_SND_BCD2000) += snd-bcd2000.o
-- 
2.20.1

