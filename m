Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9DEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EAE206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559056025;
	bh=U9lcYNkfR6mnJWS24ZktueSlXe3gHjtA3HYE5O63nOA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vpOdvRtg+wa3hNcqMaUS3RI3szjRREextZF5zQ7uMrWHevrdok3cXBd35lKE52juF
	 RotQ/dDvrmuup5kE2EcQiXb7tagTtIA2HsqZ6yuuuzM/DXXF5Jvo9KNydkGwWvWKI6
	 n3VF0nNB0DieAYGWlYNJnD1sX1UQP4j0n0EZfE3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfE1PHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:07:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42668 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfE1PHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JM3qRMN//XQkEzha8BwkptVAMHDC1JT9yLpWp/WNy+Q=; b=alBfWdH97QFV
        rl5ebffxdYAcNUb/YC9augb8ux5i+vgh/20QjOn2IdXaim4tA89L54nS21hil5bhv9m1UL0AnjeDV
        Ilig5WHdZGFegIjM/luJ6vZ37ZXlnrOz/pzZtYtQmitU8cZSnwDsz4oJ5EDBgG+SGyfC75Xe9x4/7
        wSxLY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hVdgp-0002o5-7z; Tue, 28 May 2019 15:06:59 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 8B8C7440049; Tue, 28 May 2019 16:06:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98357a: Show KConfig entry" to the asoc tree
In-Reply-To: <20190527163809.28104-1-mjourdan@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190528150658.8B8C7440049@finisterre.sirena.org.uk>
Date:   Tue, 28 May 2019 16:06:58 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98357a: Show KConfig entry

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

From 99afc8df8b6f2d039b1ab20d879e4721068a6c34 Mon Sep 17 00:00:00 2001
From: Maxime Jourdan <mjourdan@baylibre.com>
Date: Mon, 27 May 2019 18:38:09 +0200
Subject: [PATCH] ASoC: max98357a: Show KConfig entry

The SEI510 board features a standalone MAX98357A codec.
Add a tristate prompt to allow selecting the codec.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 472bde124ebe..0835d4b0d8c3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -714,7 +714,8 @@ config SND_SOC_MAX98095
        tristate
 
 config SND_SOC_MAX98357A
-       tristate
+	tristate "Maxim MAX98357A CODEC"
+	depends on GPIOLIB
 
 config SND_SOC_MAX98371
        tristate
-- 
2.20.1

