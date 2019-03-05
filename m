Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AD02070B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfCEA1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:27:10 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:58077 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfCEA1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:27:09 -0500
Received: from orion.localdomain ([77.2.115.28]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOzjW-1gbcy805ka-00PJZa; Tue, 05 Mar 2019 01:25:00 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, arnd@arndb.de, rdunlap@infradead.org
Subject: [PATCH] drivers: x86: pcengines-apuv2: fix dependencies
Date:   Tue,  5 Mar 2019 01:24:59 +0100
Message-Id: <1551745499-6687-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:kS9/PA4qAmpqFYLbmTT9JWSV3rXs9pvF1f6V934EKkzHTtJWrve
 AOl6GP2jwPkx/4rkbFB/gUhKxd9T2fHFa+ZcdR//xS9OuXuItyfMKKdu2CwTFipUiANwO50
 PuvGT0yGmhqUMy/caFq6qbk/hIjQAmoSqOZ18ujVvBEN8cF2rmpEqZvRjWfEzJFPXP4B96h
 7lY+mIuYjmZn1JGf+gwMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:izXNYNU7u70=:TFHd/U+a+g4jZvca1elGrL
 gRJNj7IualRRGQc5DmL9Q2wo35nHAUQfgNBjeX/x4bio1vP+DRTHq0MTGD+5GZd5mlbw05DzA
 ZBONYj+tMqfeZ4EYDhCXB9k0uedjNtgLtDL7FvYRN0V6RN1tUmSISN1HbJ1rCiFK1NmmBZI6v
 TwUTQWlBIQTx+5LHClUHguWXFPrnJJik+SgytDoLxxRtTpk4QQstOUmGQhbkiV+ak8SdGXlZh
 JT0bKQNceKQ+x11OiaJtb+sIuakEuXvSl8b4VcfLMCbqFwi501zehDw9ISiKglXq/XoycYU+o
 ttdqXUijB+luvIS6bmYXienijypHaZKMyXdwLN5G1l9BaXEsA/8ybrOF1iLOXoxw4fIXIOMiE
 MOmUS2gzgnds/d0Nt6IFc0YTP4JqhbQf99eO0XgqaqLxahkh8tGUgzWxsqbjD3rUtVpsAF8Ro
 ruMfYTSupELxyLo2eSZLhwNMPAbJOVsWhY/97jFaidCzsSx4v6Wd4D4+aEkYvBusNcmo8mNXM
 mZJ3BYLnnTjfgw0Z6RdJZc7TW6Jm1zI69UOx0k12PpzpINGjFRafYuTuMVccCeq7+ITUr/uzk
 AVCzuMhs5NU5rBmGbjDkyR5zCzm8SVeG6TPK89/kwixEiZJI1gcSyZnkyPl+BmSTQb0Xh74iD
 cYGIKyIWYMWQejm0UU1LOOxqKuH87/gaFxya25VKnTfysLHEsomJ1Qws1Ca2EEx9y00CTqWSO
 d/bE4B1MrfIzACgJb+vGAaAv07lUAOSOtI0yGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcengines-apuv2 board driver needs to explicitly select LEDS_CLASS,
INPUT, INPUT_KEYBOARD, so these are automatically defined correctly
(eg. LEDS_CLASS=y if PCENGINES_APU2=y)

Cc: linux-gpio@vger.kernel.org
Cc: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com
Cc: arnd@arndb.de
Cc: rdunlap@infradead.org
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: arnd@arndb.de
Reported-by: rdunlap@infradead.org
Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/platform/x86/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 851ea92..7d53380 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1307,7 +1307,10 @@ config PCENGINES_APU2
 	tristate "PC Engines APUv2/3 front button and LEDs driver"
 	select GPIO_AMD_FCH
 	select KEYBOARD_GPIO_POLLED
+	select LEDS_CLASS
 	select LEDS_GPIO
+	select INPUT
+	select INPUT_KEYBOARD
 	help
 	  This driver provides support for the front button and LEDs on
 	  PC Engines APUv2/APUv3 board.
-- 
1.9.1

