Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC73EC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA41120878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220293;
	bh=H5WCzhbmj2by4Y9S5ogQQPVbCVtMDoUvOjiQqDw54ro=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=AzW7e3wPDQz1HU8OrRZZgPpssVEAp8kjZOCuOtYZWOO3B6rUYwiSAOxkp+FTel8J1
	 LJkhC6S16Y1XWmU3e+rqGazC2IE54mHJdd3INdmwfqNzEd9iXFApClGLhuC/ojXR2e
	 TSsp0db6eY3/iUV5dGOHv6ugZz0U5qFICQPX0AKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfDYTYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:24:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49232 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfDYTYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BEpTm4OOklfiV4a5BvaAAc5vHXwdDqEt83iDK9RL0BA=; b=VUcB/dc/VWur
        4hUBUefQ7x6/Il5B9ODhIN9mSLUaynb4Fo6+UQ+VUGbjnskTEAUzw5k3cjNG8LeGbo1X8Zyj88Z2c
        wziby9YCHgKJ3+MxTfHuUeSwYZX4vcdqLLX6Oy5N0Z9WDO0zxb1IGZnodvjKErbugMue9H1uV96YN
        oq25k=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJjz5-0004Yg-2d; Thu, 25 Apr 2019 19:24:39 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 19363441D3D; Thu, 25 Apr 2019 20:24:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "ASoC: doc: simple-card: Add pin-switches property" to the asoc tree
In-Reply-To: <20190420104553.5071-1-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Message-Id: <20190425192433.19363441D3D@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:24:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: doc: simple-card: Add pin-switches property

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

From 6b903f9bdd98093a2c1ea79df07e86decfda3b04 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Sat, 20 Apr 2019 12:45:51 +0200
Subject: [PATCH] ASoC: doc: simple-card: Add pin-switches property

The simple-audio-card,pin-switches property can contain the list of
widget names for which pin switches must be created.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 4629c8f8a6b6..79954cd6e37b 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -24,6 +24,8 @@ Optional properties:
 					  a microphone is attached.
 - simple-audio-card,aux-devs		: List of phandles pointing to auxiliary devices, such
 					  as amplifiers, to be added to the sound card.
+- simple-audio-card,pin-switches	: List of strings containing the widget names for
+					  which pin switches must be created.
 
 Optional subnodes:
 
-- 
2.20.1

