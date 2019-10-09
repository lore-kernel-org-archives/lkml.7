Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C13C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB49206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570641727;
	bh=KSOTLx8CTuW8Jdg4mq9wsG+daHlFu1lL0pXhLDn0msQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sN6jCcSkMZUYNwzCll0KJkuBxZUfusiT1KkpRLYzkHN6FF7ViPiC5dmb+i+eCdgpl
	 nNujz6syxsho9abxAbAXmhjzbQ/iO7BS78SqfAd2FWNZ+omyKx3K4XIRkcnQfUL0Rm
	 Qge3aqkEebtULd91wvnMMlFmZSsza62I4d6be7xA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfJIRWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:22:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44016 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TKg7v6WJnfalf3/eDZyUsArggkC5Wu/TWTDuseQcCOg=; b=iZcejeOlvIs8
        AvpDHdDwFddODe7PpldqSNZhqCbEV0+F2Kc1ttGpzZFn63sOlGhxe1d314M8htdGp0KjV3NE+A1Ja
        ato26IZALx88FURRdVOJBj81FuB99Nx/7FFM+GYZkys4V3arLJg6zw3fFqgbdODaTrXgwjN7YfOqH
        VFlik=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIFer-0005Js-J7; Wed, 09 Oct 2019 17:21:54 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3C7EBD03ED3; Wed,  9 Oct 2019 18:21:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        kuninori.morimoto.gx@renesas.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: simple_card_utils.h: Add missing include" to the asoc tree
In-Reply-To: <20191009153615.32105-2-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20191009172148.3C7EBD03ED3@fitzroy.sirena.org.uk>
Date:   Wed,  9 Oct 2019 18:21:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple_card_utils.h: Add missing include

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 4bbee14d8e5487e3d2662138e3767cf4678cdf57 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 9 Oct 2019 18:36:14 +0300
Subject: [PATCH] ASoC: simple_card_utils.h: Add missing include
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When debug is enabled compiler cannot find the definition of
clk_get_rate resulting in the following error:

./include/sound/simple_card_utils.h:168:40: note: previous implicit
declaration of ‘clk_get_rate’ was here
   dev_dbg(dev, "%s clk %luHz\n", name, clk_get_rate(dai->clk));
./include/sound/simple_card_utils.h:168:3: note: in expansion of macro
‘dev_dbg’
   dev_dbg(dev, "%s clk %luHz\n", name, clk_get_rate(dai->clk));

Fix this by including the appropriate header.

Fixes: 0580dde59438686d ("ASoC: simple-card-utils: add asoc_simple_debug_info()")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20191009153615.32105-2-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 985a5f583de4..293ff8115960 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -8,6 +8,7 @@
 #ifndef __SIMPLE_CARD_UTILS_H
 #define __SIMPLE_CARD_UTILS_H
 
+#include <linux/clk.h>
 #include <sound/soc.h>
 
 #define asoc_simple_init_hp(card, sjack, prefix) \
-- 
2.20.1

