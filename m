Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171D7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC093222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfIRT5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:57:06 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732061AbfIRT5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:57:05 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mdf3x-1hbcQw3R8z-00Zf3m; Wed, 18 Sep 2019 21:56:55 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kristian Klausen <kristian@klausen.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: asus-wmi: add ACPI_BATTERY dependency
Date:   Wed, 18 Sep 2019 21:56:33 +0200
Message-Id: <20190918195652.2137765-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:O4l6j5E53fiS3NN7w2ynvgGmADBDg09qZ6Ikaebg4TXBbztuYwu
 ZJcxEY8zVsmmdUVpjTv4v71iGFcK0IjfTbmZDhwoWQTxgDRrBhf58rIMM0DP3w0jC6ifpWK
 ZP+2+pZO3r5IsFdJhur9hODjKZncOUkij/TqA5VOR8i8ct7LgtD1ub33RUDb5MJtdmshSt2
 czNXVxTV2wKKtgskuF/vA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:liiCRNrxY+4=:Y1cLuZg1twLvNKlKtXbzw0
 e9P0nXAdcBf63E1+/oCa/5cHEHsgfGbVorYdZypyghDrcRzC9f6S+BtC2EmcpGwiz7au9ih5D
 wDj2euRw2aUDZ5LIggIGXjPl4ra65mr2h9Naacb9GQkokoNnJd6NLnm1xyEzMtF2XDJNDpyBu
 VSqoBgnzF4A/j/QF1ekM3TnDfvVpj8y0WyeXdNcEQIE4Zkye9YnG4ag689NaupbkYAVTBz5sX
 GOzjOPNy4s5KoOYrOwEk2x6JT+i1l1pj/E5/jPFGsqmA7MRJOg4JD3odffxpdG16yI6of3fqy
 FjGMfCFG69UBzpm8G/5c7yGl0TTfWKSJvjeXdp+4UjogmRn6DEsGRr4RDU94nAa9Rz/MiQyoJ
 iddDLi8GgECx0JHwkfpne2nahd5z0ngv0WKjJPRA/UiLuHeudq5ieS+aOx/5rw6d7EsXlqfeH
 eYQ0CxPnOgiKrAASv07Mww4uqRb+Qs5JOtR9KWXZtcfJflPqHU5vqRDGkmeAGGXdpYL+vCFlz
 /+outmFmbTofWGHBDk98ios7oKhcxUMjmlrBLumWOHPF7iCU2NKFI778xUkbv6RAHFn0CsKwj
 iTLk46zpNPN6Bs5JlYjZ8rWI5iQFEp+l1GKRiCZcboVUPf6NUgRVfmZ6aEhL9w1EY3oQ3Nfq2
 DVnkis4LUZAnV8hw1+xiaj31485nH0lhZMOYnpoAHXwyI5PPlGZ9EfreA5GMmE3U9Fple7e+Y
 jLUnLXU3u09QjzNtyad5lfwVmhVxy7Z9Sy/dGgoCG572w0Y2aZ1jwkp19KtlfhpdeViD9qYMd
 r+KLtk9ZnPbdD0rDTNsEn+BIZgbHs0JJMcrVoubONDW90bqhaBROnNPbkGbe6jnEUBVchxdZO
 NLy28pjecwaShHEVvtXg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this dependency, we can run into a link failure:

drivers/platform/x86/asus-wmi.o: In function `asus_wmi_remove':
asus-wmi.c:(.text+0x430): undefined reference to `battery_hook_unregister'
drivers/platform/x86/asus-wmi.o: In function `asus_wmi_probe':
asus-wmi.c:(.text+0x2c6f): undefined reference to `battery_hook_register'

Fixes: 7973353e92ee ("platform/x86: asus-wmi: Refactor charge threshold to use the battery hooking API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1b67bb578f9f..d81de3f4f72e 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -680,6 +680,7 @@ config ASUS_WMI
 	depends on RFKILL || RFKILL = n
 	depends on HOTPLUG_PCI
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on ACPI_BATTERY
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
-- 
2.20.0

