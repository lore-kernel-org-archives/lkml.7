Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDC6C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410C1206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LQcJcc1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfHUENW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 00:13:22 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:47119 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfHUENV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:13:21 -0400
X-Greylist: delayed 1049 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Aug 2019 00:13:20 EDT
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7L4CeQB002060;
        Wed, 21 Aug 2019 13:12:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7L4CeQB002060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566360761;
        bh=PNOVklVeViw/I1/MmLHYVbub09qIw/pFC2OWA5k3L1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQcJcc1VfN83cd5Um0q55gMG3Nanz759avd9ucEZvv4/Jk69mJPLV24gsAMiZVxaz
         NwkLW+edKS75pYBcLYHaG9GJz4SFjknkDGM7UZtD2JAJy+FhJDJKMrUU/AH56sFjR0
         wliRjaKPifyIn0ASBxmNNNNBZqGDmOpgmA7AlGKCKgPGm0snUF98OgxMsjqCP0GdW1
         3fc5uknRB2/0wuVNWc3/qS7m+N8iOKI3rAzhCg+PVhjsZonuZHWv1/WChDLGB7VNfl
         kJLz++7E0V4DFxu7Fn6/hmk0LwyAkLbRziPZWZ4Ec881DCcHIfmbIn5BRDq2/mN62x
         rlRNLxxaTeYAA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] video/logo: remove unneeded *.o pattern from clean-files
Date:   Wed, 21 Aug 2019 13:12:34 +0900
Message-Id: <20190821041237.23197-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821041237.23197-1-yamada.masahiro@socionext.com>
References: <20190821041237.23197-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern *.o is cleaned up globally by the top Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/video/logo/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 228a89b9bdd1..10b75ce3ce09 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -56,4 +56,4 @@ $(obj)/%_gray256.c: $(src)/%_gray256.pgm $(pnmtologo) FORCE
 	$(call if_changed,logo)
 
 # Files generated that shall be removed upon make clean
-clean-files := *.o *_mono.c *_vga16.c *_clut224.c *_gray256.c
+clean-files := *_mono.c *_vga16.c *_clut224.c *_gray256.c
-- 
2.17.1

