Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA6ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0B8222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408885AbfJRPmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:42:24 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57303 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405905AbfJRPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:23 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MEmEf-1iFAs82Qix-00GEsw; Fri, 18 Oct 2019 17:42:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/46] ARM: pxa: make mach/regs-uart.h private
Date:   Fri, 18 Oct 2019 17:41:18 +0200
Message-Id: <20191018154201.1276638-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VWwIzXDORj0a17r+gbKmSAymG/HQiOvLGrDQVrBqqaWyL+kaOFg
 kz/BJmNkZLMkdXDKomnkUST9RFEVbMmw6Eueu5P+bdIyhmsH0wU6iN0HDnZJnnUUQ+CulUt
 cr9pOSXAqqpiwZVxzmTr09E0aSD/9to7NowPy3VMmmzQYJr6fKEAh49hfq2lNpA5IE72OEh
 ac2JWwNOlJTux1MJ4zDZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/9qNABDzT9Q=:/tbjJ7gi4/f1W3oXPMyS65
 t2hHmsMewJ1IVUSpoCtphMBiTAfDZ5k6gRVR7IEp9xJKuUZBACPp6kJdUhqLqh88JQD/a2gtg
 iz1qnCzCXWtRnbb+qDkp/QeXI6JcZfCpQpdj9P/5JeMSghhR8faRhlm8R63L3iasM4I/sV3FZ
 ZlQOG/ushFXRsWFFTlQlMl/QHfQYaUVFndu9gGGoOXZwTXyGxGr1KGGBIh6rw3g8iwvy897ar
 oPGsZOwKoPl/JHwGAVyyYH3fQnhEEQQ+sv0EUARnv2NzQ0ouafuzb5LZfSBwmGQp3p0MvERXm
 EgE6olH+Hw3smPyjR9Uf32YAg1v9W+JpAAHu6vkIb2DB8J9Zq+B18dQuBG92Mc3N3o3ekDzJf
 r/jvQu97uAeniUDlMwYAc48KbAq91fyjyizPo37FhMvXb4zFIKN7iab6eEOJY6NFaQxgwzZex
 nkTJ8dnUvJszqUF9gxUadvFEsa/XE+6FZDPsLRtLg1BEeXxNQ65/bV7J7KCZstM4OrkNO249Q
 ILOiKPYADMqu8UeTCSeWXKbuOScVVA0YDYUXZo9j1YNfmH1IWmJ5kwYPZtGDotdf+rtn+6k2G
 tix2SNmbuVnrrdWN9HSFVDdCMNGOPuqHu7iVd0BUWYk90uk0YyKs9bt1inwPi2DAy84y4lmJB
 dJCqWR89UrPxF2LD2SZGT8KipgcqMJFA0CW0vnNX7LWYYhPVQvmmVjRYfpdppqSPxJq8C5mPO
 MMfyKDCdIHggXOXafhxAja4preDaRQH0t9+ZItblLfGeIROXMtwfNxbCiPRth6zfLqZdpDiZg
 U9HQ0aoRePdmEHETkgA0aHmLwSq6A+wxCeejah1G1lm5fZ557Tv49Xb2h8T7tb9LrV+aVfN2I
 GokFR5JCL4Z6vWXFvfTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not used by any drivers, so make it private to the
platform.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/{include/mach => }/regs-uart.h | 0
 arch/arm/mach-pxa/viper.c                        | 2 +-
 arch/arm/mach-pxa/zeus.c                         | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-pxa/{include/mach => }/regs-uart.h (100%)

diff --git a/arch/arm/mach-pxa/include/mach/regs-uart.h b/arch/arm/mach-pxa/regs-uart.h
similarity index 100%
rename from arch/arm/mach-pxa/include/mach/regs-uart.h
rename to arch/arm/mach-pxa/regs-uart.h
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index c06031da6676..16f33e576902 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -48,7 +48,7 @@
 #include "pxa25x.h"
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <mach/regs-uart.h>
+#include "regs-uart.h"
 #include <linux/platform_data/pcmcia-pxa2xx_viper.h>
 #include "viper.h"
 
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index da113c8eefbf..239faff71a1f 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -39,7 +39,7 @@
 
 #include "pxa27x.h"
 #include "devices.h"
-#include <mach/regs-uart.h>
+#include "regs-uart.h"
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include "pxa27x-udc.h"
-- 
2.20.0

