Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D1C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE2921E70
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563798191;
	bh=B0QtQkWzNAvdQgEgEdKA1/xfC3AIprRoT9XIFV3M5qg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=QxkcGDqMOOfzbzwSCDtbeb9tJUfgEnRXH7Z2t3dyfm6J3pFPA53+LG19G/BFPFo2z
	 K5bdGWZWcaGl54mGblpH/IaSW5bDXUYFHLQVPjBbZrTJqRENpfgwxrUHXL15tHcDq3
	 zwTa2bWB1lSgSS9+3kkLcgZHhWymfi7k3lTUi7UI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfGVMXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:23:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58694 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfGVMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4UtnoZ0wEoe00mhMN4D6LnL/E12gqPjM+gQnc7h/a4s=; b=JXGwP7Q8U+u5
        6b/RGJNtcpAjLS/l+zf72X7wGbgaRyMp7yEeM4AmLXK5qEAJ2ZPmjNLnYTlt+4zM+Zd+8U4cT6YoE
        9m5B7ZSezIV/qLs63n8nS/WlluHssD8TV1nkfR1J7+MGWOXztELq5cghhrx/6XqSj6oNI4ZV3MRrk
        cT4C8=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKa-0007ff-Ko; Mon, 22 Jul 2019 12:22:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0F0C127416CB; Mon, 22 Jul 2019 13:22:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Milo Kim <milo.kim@ti.com>
Subject: Applied "regulator: lm363x: Fix off-by-one n_voltages for lm3632 ldo_vpos/ldo_vneg" to the regulator tree
In-Reply-To: <20190626132632.32629-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190722122216.0F0C127416CB@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lm363x: Fix off-by-one n_voltages for lm3632 ldo_vpos/ldo_vneg

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From 1e2cc8c5e0745b545d4974788dc606d678b6e564 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 26 Jun 2019 21:26:31 +0800
Subject: [PATCH] regulator: lm363x: Fix off-by-one n_voltages for lm3632
 ldo_vpos/ldo_vneg

According to the datasheet https://www.ti.com/lit/ds/symlink/lm3632a.pdf
Table 20. VPOS Bias Register Field Descriptions VPOS[5:0]
Sets the Positive Display Bias (LDO) Voltage (50 mV per step)
000000: 4 V
000001: 4.05 V
000010: 4.1 V
....................
011101: 5.45 V
011110: 5.5 V (Default)
011111: 5.55 V
....................
100111: 5.95 V
101000: 6 V
Note: Codes 101001 to 111111 map to 6 V

The LM3632_LDO_VSEL_MAX should be 0b101000 (0x28), so the maximum voltage
can match the datasheet.

Fixes: 3a8d1a73a037 ("regulator: add LM363X driver")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20190626132632.32629-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lm363x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index 5647e2f97ff8..e4a27d63bf90 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -30,7 +30,7 @@
 
 /* LM3632 */
 #define LM3632_BOOST_VSEL_MAX		0x26
-#define LM3632_LDO_VSEL_MAX		0x29
+#define LM3632_LDO_VSEL_MAX		0x28
 #define LM3632_VBOOST_MIN		4500000
 #define LM3632_VLDO_MIN			4000000
 
-- 
2.20.1

