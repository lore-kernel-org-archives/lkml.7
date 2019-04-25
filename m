Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB9C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0571A20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220469;
	bh=H5WCzhbmj2by4Y9S5ogQQPVbCVtMDoUvOjiQqDw54ro=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=srSy/k+LdTT5pGnKkimJ3U28gHVUI7s+ZfERS0cOKSZhbfVvPMD7gG45PrvXJsYhN
	 h44dxqyIPuUSFGYIyMUQ4hJOwPLrt1706llV7a62ohKvUzNSR1ia1murLeX4yppOCM
	 UfjAxIfm3FF5xSmj/33v5z1UfRF5zk4WtM6hY7AY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfDYT1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:27:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52498 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfDYT0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BEpTm4OOklfiV4a5BvaAAc5vHXwdDqEt83iDK9RL0BA=; b=m99ZWqHD2I31
        7fKmZ/S1HM/5CIxO7ocTQYuYVHv+9iGGobKDXFefiTFXlXKpUk3v7OPCS9SJnw0WXJB5pV8oePNNJ
        SSoQzp3wTFH1MgHuiG9QnYJyiVVgS3VnFj18CDxKPGV7gLEFBH7QzMMFvyvnjCxhAbPEaIn/9fB8G
        CwYRw=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJk0u-0004d6-9g; Thu, 25 Apr 2019 19:26:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AC94C441D3D; Thu, 25 Apr 2019 20:26:27 +0100 (BST)
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
Message-Id: <20190425192627.AC94C441D3D@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:26:27 +0100 (BST)
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

