Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB3EC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3832054F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568023652;
	bh=LyMIqf8DZ4Voh8p0BChOHJm0xq1jH/pIZlXIcC3mz14=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dSNai+QxJOB8DN0TsykmGATnBhFq37Q0iPATid3S5rQWhYpdSelZ6Lx37Hkxh2Aj2
	 L/WnYltgofzmDyBcs6YpejL8FnTvpjJ5FfeOhe4+52mt+KhEyxmLl4QiRLL7zV5Hqf
	 5gZLX5Gixb8zI7AjiaFpOI5FgtlUz4gCQtOsbdSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbfIIKHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:07:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56220 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390173AbfIIKHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9uQmw9sjvz89Eru9ZYv1A879KgTMUISbQLDP31z5hNY=; b=cvRrHwcTIAil
        qKhcsM7ViyOJjdeKbiNmL53VA81hSIvPIPB1bynw5WGz62uRAKR5GIxKLuajpx/oCapN3N9Ibgya1
        ml6E+3dhJFSdrOR2g/kaQ45hHnozCucnZmh52VURKw0ETmOwLCKJclva3AzU026q2xE8frw9FD+Ai
        HfOJU=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7GZp-0001s2-Uf; Mon, 09 Sep 2019 10:07:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 42504D02D7F; Mon,  9 Sep 2019 11:07:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: codecs: ad193x: make two arrays static const, makes object smaller" to the asoc tree
In-Reply-To: <20190906161404.1440-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190909100717.42504D02D7F@fitzroy.sirena.org.uk>
Date:   Mon,  9 Sep 2019 11:07:17 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: ad193x: make two arrays static const, makes object smaller

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 78b93b04771bdbefe94b84222506ba992f579c98 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 6 Sep 2019 17:14:04 +0100
Subject: [PATCH] ASoC: codecs: ad193x: make two arrays static const, makes
 object smaller

Don't populate the arrays on the stack but instead make them
static const. Makes the object code smaller by 37 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  16253	   7200	      0	  23453	   5b9d	sound/soc/codecs/ad193x.o

After:
   text	   data	    bss	    dec	    hex	filename
  16056	   7360	      0	  23416	   5b78	sound/soc/codecs/ad193x.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190906161404.1440-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index fb04c9379b71..980e024a5720 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -416,7 +416,7 @@ static struct snd_soc_dai_driver ad193x_no_adc_dai = {
 /* codec register values to set after reset */
 static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
 {
-	const struct reg_sequence reg_init[] = {
+	static const struct reg_sequence reg_init[] = {
 		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
 		{  1, 0x04 },	/* PLL_CLK_CTRL1: no on-chip Vref */
 		{  2, 0x40 },	/* DAC_CTRL0: TDM mode */
@@ -432,7 +432,7 @@ static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
 		{ 12, 0x00 },	/* DAC_L4_VOL: no attenuation */
 		{ 13, 0x00 },	/* DAC_R4_VOL: no attenuation */
 	};
-	const struct reg_sequence reg_adc_init[] = {
+	static const struct reg_sequence reg_adc_init[] = {
 		{ 14, 0x03 },	/* ADC_CTRL0: high-pass filter enable */
 		{ 15, 0x43 },	/* ADC_CTRL1: sata delay=1, adc aux mode */
 		{ 16, 0x00 },	/* ADC_CTRL2: reset */
-- 
2.20.1

