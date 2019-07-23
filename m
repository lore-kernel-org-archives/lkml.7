Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE8EC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE321873
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AyXw9ZsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfGWJsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:48:30 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:23442 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfGWJsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:48:30 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x6N9m2fe009018;
        Tue, 23 Jul 2019 18:48:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x6N9m2fe009018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563875283;
        bh=GhMsfcEGMdo7a2JHO9NEXRnzfvlVBKPP4W3vxfX4aPo=;
        h=From:To:Cc:Subject:Date:From;
        b=AyXw9ZsFdwqTHQzzXKMEAEk1i47hd8FA31ANoRJ/n+p1wW5X9oX94dF5QDQ48RjbY
         ct8UKjMIjvjHYKmmVGs7S96+r/d1+aBt0t02OlceDAItDkSzxfTQaiitkdLnTFhYxB
         msMKZKA433x/wX+2iMNJQmtLmbG0cRH0HxgeOc0GiBcpg6BthaBsxqFKbFibgf33nb
         8rbeyAlt+h9s7TNVJkxw1xmD9gSgWIYd8k9R4u2q/38vQgt2Uk/jJpXygs9Z1Psi+o
         CpJyeFb/bJDNKA9HB0rRXT0JBeBPljBFrqMFRXGvC8d+2z4Afsd19VHN8u2yVhvyeO
         yFCm4nLpjHQXw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: rename default_defconfig to defconfig
Date:   Tue, 23 Jul 2019 18:47:51 +0900
Message-Id: <20190723094751.463-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default_defconfig' is an awkward name since 'defconfig' is the default.
Let's simply say 'defconfig' like other architectures. You can drop the
KBUILD_DEFCONFIG define by following the standard naming.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/parisc/Makefile                                 | 2 --
 arch/parisc/configs/{default_defconfig => defconfig} | 0
 2 files changed, 2 deletions(-)
 rename arch/parisc/configs/{default_defconfig => defconfig} (100%)

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 8acb8fa1f8d6..b10a1179291a 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -19,8 +19,6 @@
 
 KBUILD_IMAGE := vmlinuz
 
-KBUILD_DEFCONFIG := default_defconfig
-
 NM		= sh $(srctree)/arch/parisc/nm
 CHECKFLAGS	+= -D__hppa__=1
 LIBGCC		= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
diff --git a/arch/parisc/configs/default_defconfig b/arch/parisc/configs/defconfig
similarity index 100%
rename from arch/parisc/configs/default_defconfig
rename to arch/parisc/configs/defconfig
-- 
2.17.1

