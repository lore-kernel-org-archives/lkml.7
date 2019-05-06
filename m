Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B009C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08A02053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155047;
	bh=m26YK5my5x5lz8aR0OaOnbldG7fOA+hgpJp0igHKgTw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BFfSR9KO68iK3yBSg0T+M50jNekzA6ut6GA0hqeSzDsXWZAwsaZslY+9II8YBFv2S
	 dd1Nw8F4jN2OV0LI6/ggJhrtZDoHVn6QRgYBTbKOXJybfmUzkSsG5dHfPUD2VTHiUH
	 uP8uybKTB+FfxmPwymQckB/SiFHGJTizbDchwpKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfEFPEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:04:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53958 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfEFPD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EThOkJf9yfd8OraEta4Svn7ZgieF2YDjgBRKFVT/FQw=; b=MhvwmI9YVbGq
        jU7X5GLkHH0FgnuHVyOh4PzjFWehH0HM2DX/3mnybRAlyaxXh6TcJtb/S/Xt+ggZTX6zDUEWLk0Nb
        FoA0yQPZWVqGaVWg3qwWRDZ4GlUfY3+KKZ64MiR+xXz67JwibW9FRLzkshzJB6/oQpW2aTIPGHFpJ
        DTC94=;
Received: from [2001:268:c0e6:658d:8f3d:d90b:c4e4:2fdf] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNf9f-0001uS-CS; Mon, 06 May 2019 15:03:48 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 263A8440034; Mon,  6 May 2019 16:03:44 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: spdifrx: change trace level on iec control" to the asoc tree
In-Reply-To: <1557146646-18150-3-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190506150344.263A8440034@finisterre.ee.mobilebroadband>
Date:   Mon,  6 May 2019 16:03:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: spdifrx: change trace level on iec control

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

From 19e42536b27121bcf6ee841b25054f8bacafd8c7 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 6 May 2019 14:44:05 +0200
Subject: [PATCH] ASoC: stm32: spdifrx: change trace level on iec control

Change trace level to debug to avoid spurious messages.
Return quietly when accessing iec958 control, while no
S/PDIF signal is available.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index aa83b50efabb..3d64200edbb5 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -496,7 +496,7 @@ static int stm32_spdifrx_get_ctrl_data(struct stm32_spdifrx_data *spdifrx)
 	if (wait_for_completion_interruptible_timeout(&spdifrx->cs_completion,
 						      msecs_to_jiffies(100))
 						      <= 0) {
-		dev_err(&spdifrx->pdev->dev, "Failed to get control data\n");
+		dev_dbg(&spdifrx->pdev->dev, "Failed to get control data\n");
 		ret = -EAGAIN;
 	}
 
-- 
2.20.1

