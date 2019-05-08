Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF8DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91052216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557306144;
	bh=US/4S6k20FYbn64fpfcjeRwGd9AG5MaCcLeTCebK0UE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bqU0QFfrOMOFL4/yW9j/wUKHgY3HO+jzu0C+oUi76urMgA8n/a6uNn0o7vphPakGd
	 u2C1JnqpBkEFiSk0V1R4/eAgrk2dN1XTLLC/ZfiRw+vS44tHo2eWB/Bq+IL7LdTIyG
	 3CQqsUJx3wReWlFpkQC4XpfTRt9zi0ZK/8MJHo84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfEHJCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:02:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46004 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfEHJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/1N9JZp2JQsf9CYYNCJzOBAG67m4fbIhB/j22kK9mlU=; b=PMUHRco9ZAMJ
        38hTtA/ioeQf5v4aZJ/dE3UGilVQgss3i5QRQwZwIYgUfSCb7Drtnv/0acH33nuYndnBHSQeN811R
        Ov2FHO86pAeBRnnNvgGjK5Qci4MJlHdRdfd6r0oyduBsctknWhT2R29R5PywS5Quf3r7ErPNOC5jV
        CfovM=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOISN-0007dj-1b; Wed, 08 May 2019 09:01:43 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 165F0440039; Wed,  8 May 2019 10:01:30 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: i2s: update pcm hardware constraints" to the asoc tree
In-Reply-To: <1557147252-18679-2-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190508090130.165F0440039@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:01:30 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: i2s: update pcm hardware constraints

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

From 4fc19fffaaf87335aafaeb059a561ef91aa6031c Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 6 May 2019 14:54:11 +0200
Subject: [PATCH] ASoC: stm32: i2s: update pcm hardware constraints

- Set period minimum size. Ensure at least 5ms period
up to 48kHz/16 bits to prevent underrun/overrun.
- Remove MDMA constraints on period maximum size and
set period maximum to half the buffer maximum size.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 97d5e9901a0e..8ee697ff1f86 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -731,7 +731,8 @@ static const struct snd_soc_dai_ops stm32_i2s_pcm_dai_ops = {
 static const struct snd_pcm_hardware stm32_i2s_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP,
 	.buffer_bytes_max = 8 * PAGE_SIZE,
-	.period_bytes_max = 2048,
+	.period_bytes_min = 1024,
+	.period_bytes_max = 4 * PAGE_SIZE,
 	.periods_min = 2,
 	.periods_max = 8,
 };
-- 
2.20.1

