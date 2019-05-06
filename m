Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5BC04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8362321019
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155044;
	bh=/UH6pt+Zq5BWi0+nWWUe6u2gfecSgeyLGMYg4a4hWZs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=KBm7alEuJ+HxehdJq9qR+NpCHMjKOH5D84Hgjw8nXdgdsGI67epOsltOKPD9qXbxy
	 Z/FqaMYoksEZWF2sC6QGEkGVC2aklqMjNYhcucQJisK0NE1G4pozWLbfVvGR9XLhsz
	 vlVzlBWwFyGdHarVVnUiqN6t0bmTyOuF1b45anS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfEFPED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:04:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53962 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfEFPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zISSK7BMRYtIQviKajlbZmcAGpaqp8FrE1fMsg4iIKo=; b=IgXp/W6CoO4P
        BO28c6HBJ90m+XCsFGUw4N6vy5L6hc/Dx4mbWe+GybtKJwztrc2tlCEUjvdQNgvVkp55+a8AYHb+V
        Swobdgpkh3n+5u978/3qASuBEk+SyY6na/dKg+7P2h7SoNEuV4cYwfpQKJbuenq/m3iKb68WRrPw6
        VZz3Q=;
Received: from [2001:268:c0e6:658d:8f3d:d90b:c4e4:2fdf] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNf9i-0001uZ-B8; Mon, 06 May 2019 15:03:50 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C12E7440035; Mon,  6 May 2019 16:03:44 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: spdifrx: update pcm hardware constraints" to the asoc tree
In-Reply-To: <1557146646-18150-2-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190506150344.C12E7440035@finisterre.ee.mobilebroadband>
Date:   Mon,  6 May 2019 16:03:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: spdifrx: update pcm hardware constraints

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

From 863137f0bc5eb2a3a65d1d29778ac65642171b17 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 6 May 2019 14:44:04 +0200
Subject: [PATCH] ASoC: stm32: spdifrx: update pcm hardware constraints

- Set period minimum size. Ensure at least 5ms period
up to 48kHz/16 bits to prevent underrun/overrun.
- Remove MDMA constraints on period maximum size and
set period maximum to half the buffer maximum size.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index b4c3d983e195..aa83b50efabb 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -845,7 +845,8 @@ static struct snd_soc_dai_driver stm32_spdifrx_dai[] = {
 static const struct snd_pcm_hardware stm32_spdifrx_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP,
 	.buffer_bytes_max = 8 * PAGE_SIZE,
-	.period_bytes_max = 2048, /* MDMA constraint */
+	.period_bytes_min = 1024,
+	.period_bytes_max = 4 * PAGE_SIZE,
 	.periods_min = 2,
 	.periods_max = 8,
 };
-- 
2.20.1

