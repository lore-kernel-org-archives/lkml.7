Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42674C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186D92184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566935904;
	bh=X89OzPhnFg+U31xO9U9Tv+U2FCvuxFUXWI/hNeJPqwg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xCMT5N8DrU36BJgHq3pNL9uFzIEcDslNyU0StqecI64weLJwIAmwnT+kIqyBG62S1
	 OdmHSWLh6FFtzDBidWjA9+iNvDrwJ+TE1kXXKaI3j0N0tg5v5TZtefE5u1t6lOnDu/
	 UpGz2mn7u2c9NuPdxRrRMgxnNCs1O+eH3C3QWGX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbfH0T6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:58:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48330 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfH0T6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eh2Bqn1HU9pG1FKde+0Wh38v6oHDofMbM5lmPpHqqII=; b=sI9cXxqehsaw
        AxbJ9fuuT1Q5bG4SlqBVghaPP6aeJvmfwNQ5MiO9QcyIxYUeXeiVxJehgqBJCHj3WLmr572oEpMh/
        qGTTQMjolQITeQUt+fpPQsr/BaMapvi+hDVw/pxHwhGfPJf1DNjRcIhFgPgNs64Nuc6WhmAU2rRFT
        QQ0OI=;
Received: from 188.28.18.107.threembb.co.uk ([188.28.18.107] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i2hb8-0001BS-PI; Tue, 27 Aug 2019 19:57:47 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 50AB0D02CE9; Tue, 27 Aug 2019 20:57:44 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, brian.austin@cirrus.com,
        broonie@kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Paul.Handrigan@cirrus.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: cs42xx8: Force suspend/resume during system suspend/resume" to the asoc tree
In-Reply-To: <1566944026-18113-1-git-send-email-shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190827195744.50AB0D02CE9@fitzroy.sirena.org.uk>
Date:   Tue, 27 Aug 2019 20:57:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42xx8: Force suspend/resume during system suspend/resume

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

From b429ca49406501e2c48c2a137eab12910c21ad0c Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Tue, 27 Aug 2019 18:13:46 -0400
Subject: [PATCH] ASoC: cs42xx8: Force suspend/resume during system
 suspend/resume

Use force_suspend/resume to make sure clocks are disabled/enabled
accordingly during system suspend/resume.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/1566944026-18113-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42xx8.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index 5b049fcdba20..94b1adb088fd 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -684,6 +684,8 @@ static int cs42xx8_runtime_suspend(struct device *dev)
 #endif
 
 const struct dev_pm_ops cs42xx8_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(cs42xx8_runtime_suspend, cs42xx8_runtime_resume, NULL)
 };
 EXPORT_SYMBOL_GPL(cs42xx8_pm);
-- 
2.20.1

