Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D25C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45942087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562772899;
	bh=Gabu5f7Li7fMzVgZAe8wzw6YY9Peb8Q3wy9F/ljfp8c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PeriHbDclYryvcMkvwcUlBvp8mZpIDQ5hfwTq+duH8okGhrQiw5ZyYQD1Ym0vAxNo
	 Ugr5lTFC7ixCJFYJC9zDYAnFtBlFFJPGabpbauPfCHKvkWBI/9wx5pLyRcTpeXQLws
	 BGFDmAjW0/XU55EAy4K0uJc6tLGNUE+LP63/zmq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfGJPe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:34:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGJPez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zEYE/fM+fUJTvgouP0rSljrDT6m2g/ZvpYi2J8zq2LE=; b=I4oKAsPY+oqd
        VXcXW9Fd5O5Vlz4I+Fw2ljqe+xYQ/Tv983hPXypZ6SbOwTqMunupGDIJAsnA5mHq8K+G2y7Spa4d4
        znZh/swdVLUrESDCmBL493UFuhgVHwY9XpZ++QhtqouX7oMfPRZ8qVHXBj5Yq8Ag2HdXjRBYBagDm
        mAn+o=;
Received: from [217.140.106.53] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hlEcL-00083I-Nr; Wed, 10 Jul 2019 15:34:49 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 62FF6D02DA6; Wed, 10 Jul 2019 16:34:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     alsa-devel <alsa-devel@alsa-project.org>,
        alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>,
        Derek Fang <derek.fang@realtek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>
Subject: Applied "ASoC: rt1308: Remove executable attribute from source files" to the asoc tree
In-Reply-To: <d198a3e6ed3a0e9070afeb6aca69903c3e985149.camel@perches.com>
X-Patchwork-Hint: ignore
Message-Id: <20190710153449.62FF6D02DA6@fitzroy.sirena.org.uk>
Date:   Wed, 10 Jul 2019 16:34:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt1308: Remove executable attribute from source files

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

From 72365164cbefe3afa7a146d27d502ed688bf7323 Mon Sep 17 00:00:00 2001
From: Joe Perches <joe@perches.com>
Date: Tue, 9 Jul 2019 10:22:16 -0700
Subject: [PATCH] ASoC: rt1308: Remove executable attribute from source files

These are source files not executable.

Signed-off-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/r/d198a3e6ed3a0e9070afeb6aca69903c3e985149.camel@perches.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1308.c | 0
 sound/soc/codecs/rt1308.h | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 sound/soc/codecs/rt1308.c
 mode change 100755 => 100644 sound/soc/codecs/rt1308.h

diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
old mode 100755
new mode 100644
diff --git a/sound/soc/codecs/rt1308.h b/sound/soc/codecs/rt1308.h
old mode 100755
new mode 100644
-- 
2.20.1

