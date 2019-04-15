Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE785C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9226E2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfDOT2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:28:46 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbfDOT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:28:42 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MhDEq-1gcueH0N0s-00eLtE; Mon, 15 Apr 2019 21:28:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: ep93xx: keypad: stop using mach/platform.h
Date:   Mon, 15 Apr 2019 21:25:24 +0200
Message-Id: <20190415192734.935387-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190415192734.935387-1-arnd@arndb.de>
References: <20190415192734.935387-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Dz9JsujkkUgk8Frvv9ud7TM/8N/2eXNKu9k/iheacQOv6Lia4mu
 Fhs4U0hadKRMyQ3rmWoXQy/8RCMxp+AawzJ6kyQQPfFJCU6LtCcrtBCaj6P8W5Md4RP2qGd
 JoP6V1JHr4wOsQjFDtEBcFCtM9WHVqyUXKefQeWIsKjrpAtS5y32oay1hWAwS3HB+R3uGf6
 O9Dv2XjPEZjo08N3aLDsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oX+RErlzxHA=:bofT5AK8lN0WLeiMfzF+Td
 +p1V42yb+a4im/yfKUfui6LNgsAYR4hlTsva/ZIPGQ6pLgGsEh17rT3XvPSKeXMh5pCEiINoA
 ogMvXqWbe4HpfDCnJriFsCTJ4us1LM/Nu4mjIJ5pAeGKe8p83Jh4j15Zn7UJulPCnLqwffifF
 OCDEIB22roZhBSu8w/Tqr6e3Q/NdsqSKlcshOlHE4bSkYMPnQB8i7ka/xhoQoqPdYiDyEjXis
 8QI1eOuqnfhTp9T/tgdJZ+lEvzBKQv8G/tnaIRjnpl1+zrbHI3H1c91w6xrWo4wVypVwV7Mn3
 AKBQg3+m8JSWlKMmTtIhL2NHQoD4xlDmpcrhXrOAAHwT/tSibIuXo0hRmyUkTn+15d3t7AuXn
 RmutzCfpdJmAT1gyB8QuV7y9Orcil5bioRFZ6qQccvBBbhfEahXh6EiXhzDCi4K0Jbg7R0IdO
 myv6IQsfZgRSrcAIifIwRXhEf83YTxVqeldpIkef0c5PrI8fwwAsQjbQ7/9gcUxYIFrfERGrP
 Z0n3Sj7ZwMv0TkPVkcUakJA8xPFqkeueCp0fi3MNQCiiX3l3aA12BoudNUjIDF0BPLlB6QOqf
 XnOP2bSUaET4rrdJ55uccAoADnHfLzqJ4cQQvW++7sY61IS5QxP3dyUHG+fDAZVEr9oDHCI5h
 9TczqdpR1oCjqW5+tDbMMJuPL7ZhgVSvWkFDRjZ+B/g+7YflA2ZbPMY29oCfa+h+VZxjDewwz
 otSmwr0mb6oMfCwUqHmnNg4wPGb3rdI0+IBqlg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can communicate the clock rate using platform data rather than setting
a flag to use a particular value in the driver, which is cleaner and
avoids the dependency.

No platform in the kernel currently defines the ep93xx keypad device
structure, so this is a rather pointless excercise.  Any out of tree
users are probably dead now, but if not, they have to change their
platform code to match the new platform_data structure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/Kconfig              | 2 +-
 drivers/input/keyboard/ep93xx_keypad.c      | 5 +----
 include/linux/platform_data/keypad-ep93xx.h | 4 ++--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a878351f1643..b373f3274542 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -194,7 +194,7 @@ config KEYBOARD_LKKBD
 
 config KEYBOARD_EP93XX
 	tristate "EP93xx Matrix Keypad support"
-	depends on ARCH_EP93XX
+	depends on ARCH_EP93XX || COMPILE_TEST
 	select INPUT_MATRIXKMAP
 	help
 	  Say Y here to enable the matrix keypad on the Cirrus EP93XX.
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index f77b295e0123..71472f6257c0 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -137,10 +137,7 @@ static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
 	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
 	unsigned int val = 0;
 
-	if (pdata->flags & EP93XX_KEYPAD_KDIV)
-		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLK_DIV4);
-	else
-		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLK_DIV16);
+	clk_set_rate(keypad->clk, pdata->clk_rate);
 
 	if (pdata->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
 		val |= KEY_INIT_DIS3KY;
diff --git a/include/linux/platform_data/keypad-ep93xx.h b/include/linux/platform_data/keypad-ep93xx.h
index 0e36818e3680..3054fced8509 100644
--- a/include/linux/platform_data/keypad-ep93xx.h
+++ b/include/linux/platform_data/keypad-ep93xx.h
@@ -9,8 +9,7 @@ struct matrix_keymap_data;
 #define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic mode */
 #define EP93XX_KEYPAD_BACK_DRIVE	(1<<2)	/* back driving mode */
 #define EP93XX_KEYPAD_TEST_MODE		(1<<3)	/* scan only column 0 */
-#define EP93XX_KEYPAD_KDIV		(1<<4)	/* 1/4 clock or 1/16 clock */
-#define EP93XX_KEYPAD_AUTOREPEAT	(1<<5)	/* enable key autorepeat */
+#define EP93XX_KEYPAD_AUTOREPEAT	(1<<4)	/* enable key autorepeat */
 
 /**
  * struct ep93xx_keypad_platform_data - platform specific device structure
@@ -24,6 +23,7 @@ struct ep93xx_keypad_platform_data {
 	unsigned int	debounce;
 	unsigned int	prescale;
 	unsigned int	flags;
+	unsigned int	clk_rate;
 };
 
 #define EP93XX_MATRIX_ROWS		(8)
-- 
2.20.0

