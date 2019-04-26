Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC02C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB6E2067C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556273001;
	bh=K73kZUZgP7QY1o/JqTOvxr4VE5347itELPQLK9XtfIk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=QWqLI0bCb1k7L/UCkinrB4QG5mHCqzZ/jXnlsd587HZf2+eEp4Shlv1HeNHHLNowX
	 cSQomJbWoEPlNGxxxqJrAKJ5JoU+4eBXry8xZaN65CYZ33bq1aZFjhBvZ2jX9XrUtX
	 5IDFUFdFQ4Hx5tFCH4Vu3NIhEX9xj2dLti7TpKVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfDZKDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:03:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56384 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfDZKDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KjNMNb765zI1hYk26q4soQ/GP4v3MHL0WC0oyXFM8os=; b=XakyfLm/3SYe
        dICz3oUJxjnjFV5HSQsNV2cPyqadD9m/cKTzOReIt4wW48T6N1dHyVidB8S7LnWjFvCWyZyNwQp7L
        nm2xaLoZa2B9Tu95bydrKb/PO9lX1ZV2zMhkbpcgKBgjksqzU0BiuruEg4LxEw9tfTjYYKta1djS0
        6cAho=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxhF-0003kh-Dh; Fri, 26 Apr 2019 10:03:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5F504441D3C; Fri, 26 Apr 2019 11:03:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        od@zcrc.me
Subject: Applied "ASoC: simple-card: Read pin switches conf from devicetree" to the asoc tree
In-Reply-To: <20190426022550.31359-2-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Message-Id: <20190426100308.5F504441D3C@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 11:03:08 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-card: Read pin switches conf from devicetree

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

From 552f2d7edd38e29073f8036191320f09b534c480 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 26 Apr 2019 04:25:50 +0200
Subject: [PATCH] ASoC: simple-card: Read pin switches conf from devicetree

When the routing path between a widget (e.g. "Speaker") and the codec
goes through an external amplifier, having a pin switch for this widget
allows the amplifier to be disabled when the widget is not to be used
(e.g. when using headphones).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 335ead0cbb8a..9b568f578bcd 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -464,6 +464,10 @@ static int simple_parse_of(struct asoc_simple_priv *priv)
 	if (ret < 0)
 		return ret;
 
+	ret = asoc_simple_parse_pin_switches(card, PREFIX);
+	if (ret < 0)
+		return ret;
+
 	/* Single/Muti DAI link(s) & New style of DT node */
 	memset(&li, 0, sizeof(li));
 	for (li.cpu = 1; li.cpu >= 0; li.cpu--) {
-- 
2.20.1

