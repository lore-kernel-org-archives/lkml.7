Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8F3C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BFE20644
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfFQMeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:34:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58319 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQMeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:34:05 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MMoXC-1htQJR3L4G-00Ihzj; Mon, 17 Jun 2019 14:33:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thierry Reding <treding@nvidia.com>, arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: trusted_foundations: add ARMv7 dependency
Date:   Mon, 17 Jun 2019 14:33:23 +0200
Message-Id: <20190617123352.742876-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lG3EMn7eymquB1lgFAhu0K13XWBEH1PPENGNounZ6Xnzg65KD9H
 K7KGoA6BDfG56L7Ecrfg52/nh0Wkl9GI4JMqNZ522rVXqelHcL5sgosETiLuFSnJaybdatK
 tbzVbKcMFSV5HB4ECOima/g+smwK/Y4eXOe3AZLVnAwxeeNFCzZgJMp+Mrq2TcTDhEVbThS
 MvyiJ2EXg1PGpN8yIODHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cTIULY2r9us=:hIiDtNFP+qCUQBEtaqIitG
 Us5dRrmiNDw0C8YsTQngg1k9y3yPLuoap1c4pB1wKOYDlGH/Z2b16Bk9xZrFp/FQj1Hiu/wD3
 M//QdUVAb2bgRCGUtVDdGnG1sa92uumtSpwYWWKhQgN2YefSeDikjXsdBi+R4xq9j2vQCbqU2
 48xPo/MG1dT0JIlexAXxXnlvnco/uhOGGwkX8zHvQQN1uiNmlKAKRmnt16kzpsoQ9r0nycTSb
 C4una3bkX0IpfkSC/TPpiabqZjrr95g6ITZNtT3vTZTpkldeKlbbxA2JjoLLv+o0hYfhAOlZc
 chciSIdFB3VxMD85YlssJOZ8oWiomVtJA5b2yvI6VkycfpMCZpTaymq9+kUKT8SD4+SF6Oxpd
 pcpExgIinHqr6rvf1yeYL2+e2TNiwdSYd+x5UEcHbQzGSg9eebgF+8O2o9oda5wFQtL00m5o/
 sCf3EGTnr8n3tZoLP9c/cY9FT0abxqDdAUADI5pH+kuAmwD/nMSTPVTZkpeTVpcaetJGs05X5
 k3c2/p7dneTigsuXTqH2zZ6FPxBsaFj3UFzUtrLXsBsPgzCJEBpPMNqWgpJLecJ7+hfmXGN6f
 wYVUJf4iBTxyZ8qxUiIgBOpyr2ZltJ9RPgysB2b+R6xkawQx0dZ19TGLoyhl0yYx1OhlwuJRS
 HTZ4GvuOP6kN27rNAr3OccFx6vWj3oQRgPIiVZVLqwx7fPuRlUCc2Wwed25LofcnhyAvURSwK
 LX6RFXSSMmLOq5noEXwNhKFZiyqJUQXTB03q6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "+sec" extension is invalid for older ARM architectures, but
the code can now be built on any ARM configuration:

/tmp/trusted_foundations-2d0882.s: Assembler messages:
/tmp/trusted_foundations-2d0882.s:194: Error: architectural extension `sec' is not allowed for the current base architecture
/tmp/trusted_foundations-2d0882.s:201: Error: selected processor does not support `smc #0' in ARM mode
/tmp/trusted_foundations-2d0882.s:213: Error: architectural extension `sec' is not allowed for the current base architecture
/tmp/trusted_foundations-2d0882.s:220: Error: selected processor does not support `smc #0' in ARM mode

Add a dependency on ARMv7 for the build.

Fixes: 4cb5d9eca143 ("firmware: Move Trusted Foundations support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 35078c6f334a..53446e39a32c 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -256,7 +256,7 @@ config TI_SCI_PROTOCOL
 
 config TRUSTED_FOUNDATIONS
 	bool "Trusted Foundations secure monitor support"
-	depends on ARM
+	depends on ARM && CPU_V7
 	help
 	  Some devices (including most early Tegra-based consumer devices on
 	  the market) are booted with the Trusted Foundations secure monitor
-- 
2.20.0

