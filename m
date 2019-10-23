Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBF3CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A3F21928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571856993;
	bh=5iN7JAj1GaNpD4THyebDvoQurxgjIdpppHN61fJ0wKE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=jRiQHHR10uL7UW7afFnKr0I3qwlSIuZ32N/xnHlKvrDAQIbZHuU2ZCOh3TuANdpAo
	 YwdiBd0+7z8minQxGrX+WGWoi+nBiIpP2F1sIypoggBhadtVQiXmVP/uTNLuI4tixo
	 fxUl9TwoNVaHWxuE1qZQLWwEuQrY6HslIab8Kdg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390620AbfJWS4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:56:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59824 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389598AbfJWS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dQelqA9i8eiR49a+veu9wzvz9nHImAb6RtfEDDfJqQM=; b=lAMx+G3J/j2x
        +0bMuld5ifDF31TRDlySgM6QhPJ5/IiNnitB5WEnwMK0MeTqf6EoPTRWB3+ZTuazZQAqZHegtZUr7
        nYP3L3eREj3a5mAsc1eMANpGTWGYmHrm+7iaSG157xv6Pa0kutPH3scLVI2aGM5jwHzvO0jxFMm+L
        l0hzU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNLnh-0001Ag-H1; Wed, 23 Oct 2019 18:56:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id BB090274326D; Wed, 23 Oct 2019 19:56:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     alsa-devel@alsa-project.org,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        stable@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: Applied "ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif dma address" to the asoc tree
In-Reply-To: <20191022185429.12769-1-erosca@de.adit-jv.com>
X-Patchwork-Hint: ignore
Message-Id: <20191023185604.BB090274326D@ypsilon.sirena.org.uk>
Date:   Wed, 23 Oct 2019 19:56:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif dma address

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

From d10be65f87fc9d98ad3cbdc406e86745fe8c59e2 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Tue, 22 Oct 2019 20:54:29 +0200
Subject: [PATCH] ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif dma address

Currently each SSI unit's busif dma address is calculated by
following calculation formula:
0xec540000 + 0x1000 * id + busif / 4 * 0xA000 + busif % 4 * 0x400

But according to R-Car3 HW manual 41.1.4 Register Configuration,
ssi9 4/5/6/7 busif data register address
(SSI9_4_BUSIF/SSI9_5_BUSIF/SSI9_6_BUSIF/SSI9_7_BUSIF)
are out of this rule.

This patch updates the calculation formula to correct
ssi9 4/5/6/7 busif data register address.

Fixes: 5e45a6fab3b9 ("ASoc: rsnd: dma: Calculate dma address with consider of BUSIF")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[erosca: minor improvements in commit description]
Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20191022185429.12769-1-erosca@de.adit-jv.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 0324a5c39619..28f65eba2bb4 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -508,10 +508,10 @@ static struct rsnd_mod_ops rsnd_dmapp_ops = {
 #define RDMA_SSI_I_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0x8)
 #define RDMA_SSI_O_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0xc)
 
-#define RDMA_SSIU_I_N(addr, i, j) (addr ##_reg - 0x00441000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400))
+#define RDMA_SSIU_I_N(addr, i, j) (addr ##_reg - 0x00441000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
 #define RDMA_SSIU_O_N(addr, i, j) RDMA_SSIU_I_N(addr, i, j)
 
-#define RDMA_SSIU_I_P(addr, i, j) (addr ##_reg - 0x00141000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400))
+#define RDMA_SSIU_I_P(addr, i, j) (addr ##_reg - 0x00141000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
 #define RDMA_SSIU_O_P(addr, i, j) RDMA_SSIU_I_P(addr, i, j)
 
 #define RDMA_SRC_I_N(addr, i)	(addr ##_reg - 0x00500000 + (0x400 * i))
-- 
2.20.1

