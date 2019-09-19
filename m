Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A64AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339C420882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390736AbfISO1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:27:11 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51269 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389418AbfISO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:27:08 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MZSym-1igOhi1TOw-00WWXn; Thu, 19 Sep 2019 16:26:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: aspeed: ast2500 is ARMv6K
Date:   Thu, 19 Sep 2019 16:26:38 +0200
Message-Id: <20190919142654.1578823-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V9tdOUDtuGUe068WcZJL2K9tTtIESlF6Je8IaB76YM9nrgqfI4E
 b9qk+sCm+bba7I2po2I9hVnAaQqWXex61vapONgnrXW5FHiohTQgglQZlibOGxhEKD9qzot
 Yw4hDZaMBz+tIKqYvR3HhRYIKZl74HVupJ+bkdOqekLBPujC2cL0vvyRSjIwpN8aMcyTxXV
 Ql3aJeSt7/5UyABhcXDmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:397q3beN9XA=:4VKlSYyebHNm7oH5pfo2GW
 RK90uXC2JU16rym8ptVvfou00er5+P/BkiNtNHvcAYONDh2EhZLX2FoXiTVkKb2JkFYcFIiHh
 qUednjVO7y4qOgqHtoNal4smFk+IQ4eRbbMvjdfFnIx2XDf8FMd9gMv+IW3in/gKy2FBPgSwl
 7DfSofzWKNr+PgszVAQSFmfpBKsk3JM74ERpM4oUp1Yqjy3IIfPub19sKd6BHthw32kGcAvoR
 RJIzUcvZllbm1UMs2Qh6KhBqME/rC95n0XWbdXhLuWiknut/zYwEoTk5BKBFKGOL0J7pZUZu0
 SfUYCi2fdpgx6kzGs1gjR5vICj92GNHBOtKblVC/rISG8FNXIBZp0Lw0ouowSt7EQYO6SYQwQ
 zUhBeEdELuALvT6msAhbPz/5OFNnWB+M77T/ehGOLdcyi8Ao1dm4iZmWuicdxA7iG1oxku6cl
 v7smnRnMLdz375J8g7T1XwAWpp59yqBZqyHfzr8axFlFCzwk02mtetWeTcMk+Y5Kd5YtSakRX
 li/TFBygn4562hfX8BY8CPuluHBM+hQXsTZ12EmRk5CkFSPdcPwOzhAVuQeFwLDtkQQFTFp2M
 6iuJ065zW7oaH73muIxLm4bmGShC0YS6THGEfGVM6L78RIaVanRycH9JpZpp5I7JTC3jhKl+T
 wxzqW5JAJBrARDosiySjjC8Dw+8XlAOFVg93Mt0WVO0/CH0yrJo+zDblOIvDASFTB/V7r6Uke
 ge6KLztexZEKuOf2k5NXMtvfI1dp2CbfxJ1mjBVtEim7lZrYlhkmQFt0K8ahav+d1Z7omowtn
 hobE7eDMcU4uWbAI8qdPfguXRY5n9rxkmoYuXNk94TYhOWJ6jTQCAlH24gnoCoA4UvkqyTHay
 WVQim93EydDcj6UgeIeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux supports both the original ARMv6 level (early ARM1136) and ARMv6K
(later ARM1136, ARM1176 and ARM11mpcore).

ast2500 falls into the second categoy, being based on arm1176jzf-s.
This is enabled by default when using ARCH_MULTI_V6, so we should
not 'select CPU_V6'.

Removing this will lead to more efficient use of atomic instructions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-aspeed/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index a293137f5814..163931a03136 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -26,7 +26,6 @@ config MACH_ASPEED_G4
 config MACH_ASPEED_G5
 	bool "Aspeed SoC 5th Generation"
 	depends on ARCH_MULTI_V6
-	select CPU_V6
 	select PINCTRL_ASPEED_G5 if !CC_IS_CLANG
 	select FTTMR010_TIMER
 	help
-- 
2.20.0

