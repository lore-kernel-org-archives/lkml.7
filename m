Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF98C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AF0208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763591;
	bh=K8scgsR7nK/HFMN8JtdCXzwpbEYVh4J+o+BOM2s9okk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zmQBDbQMt5BrkX35NeoHQQ3fjMhu2+oz3MIGM1e8xueutq4FN66OCMEzjMJ8et0dk
	 9kituzYNJmZMINQn5XaUEb4oA3OY+PoS02sRnqvwYQWlzls1sfnWFnvJf8iC9RcePy
	 d3l+cDoZHd0ALfaIO/LQDhqCe+rvn0ZRC+38qWmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEBCTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:19:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57950 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfEBCTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1PItEW2u0htZ2Dr52BH6AmRKT6du/eMXVYsUd1FUuoY=; b=Fsv0WVHf7s/A
        UkdR6WQPriRoSo64X227WZJIgjdSOIQ97Hk9Gye1hO+CA2qGfRoL6Zi//TUD3i965lLy/UnO+vMcl
        ks5BonoAnHqwt5fohxQFaHTEUjpuwDAinDDqhG5SezskWvWwT70QZ3BgGmXnDgh4i4gx7D9+9dVNR
        tE7Yg=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1Jl-0005xV-R3; Thu, 02 May 2019 02:19:26 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 725C7441D3C; Thu,  2 May 2019 03:19:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Applied "spi: pxa2xx: use a module softdep for dw_dmac" to the spi tree
In-Reply-To:  <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
X-Patchwork-Hint: ignore
Message-Id: <20190502021922.725C7441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:19:22 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: pxa2xx: use a module softdep for dw_dmac

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 51ebf6acb00fa6f965e600f848bee5bddddd2054 Mon Sep 17 00:00:00 2001
From: Flavio Suligoi <f.suligoi@asem.it>
Date: Wed, 10 Apr 2019 14:51:36 +0200
Subject: [PATCH] spi: pxa2xx: use a module softdep for dw_dmac

With dw_dmac, sometimes the request of a DMA channel fails because
the DMA driver is not ready, so an explicit dependency request
is necessary.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f7068ccfe7d2..3e6811ef37e8 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1957,3 +1957,5 @@ static void __exit pxa2xx_spi_exit(void)
 	platform_driver_unregister(&driver);
 }
 module_exit(pxa2xx_spi_exit);
+
+MODULE_SOFTDEP("pre: dw_dmac");
-- 
2.20.1

