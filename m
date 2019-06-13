Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8C4C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5512173C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560452777;
	bh=+h8Qcm3LMeVJYiEj5KsKSppuaONZydDUlh3kBTjIEMc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=IiWXzEfYbKTgFmilC+uCJPxzoBNhWNgLEhEWXMyKnLrxh0Mp3JxQQ7+TvbGAPybpm
	 xnhKiIjGJmLSE4nKBkgIMXiZgOKXtUuxfRf1bxPaZdo2EkiaFlVzc5HOxXyUIercyr
	 ZIL3AHYHF50oJP5ioUZi7c3cX0Bk8gcoybyLdEHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfFMTGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:06:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37734 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfFMTGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8jJl8VZ4I6jak2R3cVTa4dr3b/FXaZA6ihC8BpRzKRI=; b=jbeeXD19yNAO
        99Uqe88Riw+/sN6QGMXYe9sO1xy1AbKd6vLsFeLg+XMx6VWL6OpLz5jJ3tVysFmK/NHJ1Rg+4aZWi
        iErxXjc2O7MG/ZS5n01C8UpjuvPzIuPLeajbpFxvfZRQ/HY2T50lX+ludpNCNsFJLRSVYYE7jZb20
        jvNwE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hbV34-0005SU-HS; Thu, 13 Jun 2019 19:06:10 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 10949440046; Thu, 13 Jun 2019 20:06:10 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-tdm: consistently use SND_SOC_DAIFMT defines" to the asoc tree
In-Reply-To: <20190613114233.21130-5-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190613190610.10949440046@finisterre.sirena.org.uk>
Date:   Thu, 13 Jun 2019 20:06:09 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-tdm: consistently use SND_SOC_DAIFMT defines

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

From 05113483fd300d7a4605a726770e7255e29f1ac7 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 13 Jun 2019 13:42:33 +0200
Subject: [PATCH] ASoC: meson: axg-tdm: consistently use SND_SOC_DAIFMT defines

There a mix of SND_SOC_DAIFMT_ and SND_SOC_DAI_FORMAT_ in
axg-tdm-interface.c. Even, if this is currently the same thing, lets use
the same group consistently.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-tdm-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 585ce030b79b..d51f3344be7c 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -306,8 +306,8 @@ static int axg_tdm_iface_hw_params(struct snd_pcm_substream *substream,
 		}
 		break;
 
-	case SND_SOC_DAI_FORMAT_DSP_A:
-	case SND_SOC_DAI_FORMAT_DSP_B:
+	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
 		break;
 
 	default:
-- 
2.20.1

