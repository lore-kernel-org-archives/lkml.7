Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB591C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8795D208C4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556764844;
	bh=1hfvxyAy45qntQJ8YUrHMobWcwZHq5USXoXB/I4jx9o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bc31TCSA4ue/kTtx8dxt8HnrBeTOxMyA0Kto17R+r4OE72ZoWsuYsLb3hSR9kpFYv
	 ODKdr0nDg7LVyZWw9HeNa/0/DDASzH6o3GohtzMPiV6DzTGzW2sDf3e2ZO+Rp8hj5B
	 PBcdcr+ADN6na7/cg86SpjviB8oz+4Ar4x88wwp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEBCkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:40:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36648 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfEBCkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cXtMjzP8cWAlpfCwO5TSBDzBd4YnAQjIOZyKXqyt03Y=; b=oIhrXmZkvNtb
        yVF1MyjDyQlIfkSEufz4kVndt34EVQ+uj//AdfYBO5YvLsvW5nSx9NJdZunFwsIaqRf/n0LQ9qd+c
        lF4rHkyyWFql12AGVGW3UwGtr8K1foxSldbufC7espm5jnCCijHfVtaan8gc7Vl/p+9/goj2ZBq6Q
        K2we4=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1eA-000604-6W; Thu, 02 May 2019 02:40:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0D700441D3C; Thu,  2 May 2019 03:40:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Akshu Agrawal <Akshu.Agrawal@amd.com>, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: da7219: Use clk_round_rate to handle enabled bclk/wclk case" to the asoc tree
In-Reply-To: <20190429105733.71FB83FBCC@swsrvapps-01.diasemi.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502024027.0D700441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:40:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7219: Use clk_round_rate to handle enabled bclk/wclk case

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From 1cd472d2ac1654f939ae01164b29e81fc76e0a93 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 29 Apr 2019 11:57:33 +0100
Subject: [PATCH] ASoC: da7219: Use clk_round_rate to handle enabled bclk/wclk
 case

For some platforms where DA7219 is the DAI clock master, BCLK/WCLK
will be set and enabled prior to the codec's hw_params() function
being called. It is possible the platform requires a different
BCLK configuration than would be chosen by hw_params(), for
example S16_LE format needed with a 64-bit frame to satisfy certain
devices using the clocks.

To handle those kinds of scenarios, the use of clk_round_rate() is
now employed as part of hw_params(). If BCLK is already enabled
then this function will just return the currently set rate, if it
is valid for the desired frame size, so the subsequent call to
clk_set_rate() will succeed and nothing changes with regards to
clocking. In addition the specific BCLK & WCLK recalc_rate()
implementations needed updating to always give back a real value,
as those functions are called as part of the clk init code and a
real value is needed for the clk_round_rate() call to work as
expected.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 5f5fa3416af3..206d01c6eb7e 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1621,6 +1621,21 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 
 		if (bclk) {
 			bclk_rate = frame_size * sr;
+			/*
+			 * Rounding the rate here avoids failure trying to set a
+			 * new rate on an already enabled bclk. In that
+			 * instance this will just set the same rate as is
+			 * currently in use, and so should continue without
+			 * problem, as long as the BCLK rate is suitable for the
+			 * desired frame size.
+			 */
+			bclk_rate = clk_round_rate(bclk, bclk_rate);
+			if ((bclk_rate / sr) < frame_size) {
+				dev_err(component->dev,
+					"BCLK rate mismatch against frame size");
+				return -EINVAL;
+			}
+
 			ret = clk_set_rate(bclk, bclk_rate);
 			if (ret) {
 				dev_err(component->dev,
@@ -1927,9 +1942,6 @@ static unsigned long da7219_wclk_recalc_rate(struct clk_hw *hw,
 	struct snd_soc_component *component = da7219->component;
 	u8 fs = snd_soc_component_read32(component, DA7219_SR);
 
-	if (!da7219->master)
-		return 0;
-
 	switch (fs & DA7219_SR_MASK) {
 	case DA7219_SR_8000:
 		return 8000;
@@ -2016,9 +2028,6 @@ static unsigned long da7219_bclk_recalc_rate(struct clk_hw *hw,
 	u8 bclks_per_wclk = snd_soc_component_read32(component,
 						     DA7219_DAI_CLK_MODE);
 
-	if (!da7219->master)
-		return 0;
-
 	switch (bclks_per_wclk & DA7219_DAI_BCLKS_PER_WCLK_MASK) {
 	case DA7219_DAI_BCLKS_PER_WCLK_32:
 		return parent_rate * 32;
-- 
2.20.1

