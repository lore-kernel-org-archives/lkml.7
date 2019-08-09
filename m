Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E0EC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B88208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407215AbfHIOqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:46:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406127AbfHIOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:46:04 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N79Ey-1iNaIe1kU8-017V2R; Fri, 09 Aug 2019 16:45:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH v2 11/13] serial: lpc32xx: allow compile testing
Date:   Fri,  9 Aug 2019 16:40:37 +0200
Message-Id: <20190809144043.476786-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190809144043.476786-1-arnd@arndb.de>
References: <20190809144043.476786-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QSyZAIrEK0tisvxeshqXx4Yf121VPR+VVNYcnXCO8jzU+Wj3Ush
 I/ukpTsjSD50wlu5mlErjvyyjoC7r5ZaE9gO6Bzq5JQB8kvQN/7/3zM8Bih+zpxqpE1wyo4
 T5ehI8/mM/L7wAgH4tcbxV4iEiOQijuNX2En16g/UAdInN5IC+HSJHS6z7Tyg1No1B2si8l
 19wPbeSZDJ1CNo4wggS2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJCyh49joGQ=:hiDrY4RgZVRXKwVAgZwTaF
 zd/yvwV5BTZewhK51/lohRaZMa4Ns09MbbfjiVlXLr5F+LAzi3ITNBjb79lgUU0Y3zS5zA0Gg
 6fMw1KccRDUHKbZ7nR5vc3++tNjZAY8jtUo8K1uTy7g7c8fU29PKEi1rzwGZofnn7OUmhCK9/
 +SoDdtlr/BCbvIO8lImCdQ6JUpVEhWW2ZW6skW9CBes3Aud4FKEi2N/AEreZqioOOYxOxVVbC
 E7ZXajHg0vvQvFwqJKTMEHyssG8oGufrB2rl2mltwc/9AyeWX5gLPnrgwwGKAYieJgrHBKd90
 2hdrZOhAt6ju6w3H7zepU+DH3gSl8nopfVfESIfOH708xGNuc9p3bDTiq61nsIza3PM7gCmGs
 w44mJQY5PlsPIGTFdlzKnJy+xhElyaG3CbTYGUBn0lngXe6pEAah6teBvuIhbhe9z2KbBoVae
 xL6OnSGYwiKhBS2tq0YmF+AN4Cvv6dq7t68dsK24GOgio4AyGLVg7DLrJhguVowEXjR3qAqSU
 vyvia2c9x7tzYcRE2DvRfP7km8GnHCORRT34OKCUqNiMD5pwREOpwFiU0AO86WFKuZhxzydlG
 uheyaIfuS+5sTAUwai+7fYv+NvzQ5wIxwI/1kz6tLkzmBBAQVrvXoHqxhfqmgJAcwNoa3YLnr
 Ok37nwVz4h+iJIXlt6wzL8C3QHsoOhlH4hXBTMxqosmMvDo5Skz356oB7K+CDQDhQAaVW9Kuu
 C3BZGQW5BFpJC6DTSfIJQyquZnDaMZQUeE0TuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lpc32xx_loopback_set() function in hte lpc32xx_hs driver is the
one thing that relies on platform header files. Move that into the
core platform code so we only need a variable declaration for it,
and enable COMPILE_TEST building.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-lpc32xx/serial.c       | 30 ++++++++++++++++++++++++
 drivers/tty/serial/lpc32xx_hs.c      | 35 ++++------------------------
 include/linux/soc/nxp/lpc32xx-misc.h |  4 ++++
 3 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
index 3f9b30df9f0e..cfb35e5691cd 100644
--- a/arch/arm/mach-lpc32xx/serial.c
+++ b/arch/arm/mach-lpc32xx/serial.c
@@ -60,6 +60,36 @@ static struct uartinit uartinit_data[] __initdata = {
 	},
 };
 
+/* LPC3250 Errata HSUART.1: Hang workaround via loopback mode on inactivity */
+void lpc32xx_loopback_set(resource_size_t mapbase, int state)
+{
+	int bit;
+	u32 tmp;
+
+	switch (mapbase) {
+	case LPC32XX_HS_UART1_BASE:
+		bit = 0;
+		break;
+	case LPC32XX_HS_UART2_BASE:
+		bit = 1;
+		break;
+	case LPC32XX_HS_UART7_BASE:
+		bit = 6;
+		break;
+	default:
+		WARN(1, "lpc32xx_hs: Warning: Unknown port at %08x\n", mapbase);
+		return;
+	}
+
+	tmp = readl(LPC32XX_UARTCTL_CLOOP);
+	if (state)
+		tmp |= (1 << bit);
+	else
+		tmp &= ~(1 << bit);
+	writel(tmp, LPC32XX_UARTCTL_CLOOP);
+}
+EXPORT_SYMBOL_GPL(lpc32xx_loopback_set);
+
 void __init lpc32xx_serial_init(void)
 {
 	u32 tmp, clkmodes = 0;
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 7f14cd8fac47..d3843f722182 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -25,6 +25,8 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
+#include <linux/sizes.h>
+#include <linux/soc/nxp/lpc32xx-misc.h>
 
 /*
  * High Speed UART register offsets
@@ -79,6 +81,8 @@
 #define LPC32XX_HSU_TX_TL8B			(0x2 << 0)
 #define LPC32XX_HSU_TX_TL16B			(0x3 << 0)
 
+#define LPC32XX_MAIN_OSC_FREQ			13000000
+
 #define MODNAME "lpc32xx_hsuart"
 
 struct lpc32xx_hsuart_port {
@@ -149,8 +153,6 @@ static void lpc32xx_hsuart_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
-static void lpc32xx_loopback_set(resource_size_t mapbase, int state);
-
 static int __init lpc32xx_hsuart_console_setup(struct console *co,
 					       char *options)
 {
@@ -437,35 +439,6 @@ static void serial_lpc32xx_break_ctl(struct uart_port *port,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-/* LPC3250 Errata HSUART.1: Hang workaround via loopback mode on inactivity */
-static void lpc32xx_loopback_set(resource_size_t mapbase, int state)
-{
-	int bit;
-	u32 tmp;
-
-	switch (mapbase) {
-	case LPC32XX_HS_UART1_BASE:
-		bit = 0;
-		break;
-	case LPC32XX_HS_UART2_BASE:
-		bit = 1;
-		break;
-	case LPC32XX_HS_UART7_BASE:
-		bit = 6;
-		break;
-	default:
-		WARN(1, "lpc32xx_hs: Warning: Unknown port at %08x\n", mapbase);
-		return;
-	}
-
-	tmp = readl(LPC32XX_UARTCTL_CLOOP);
-	if (state)
-		tmp |= (1 << bit);
-	else
-		tmp &= ~(1 << bit);
-	writel(tmp, LPC32XX_UARTCTL_CLOOP);
-}
-
 /* port->lock is not held.  */
 static int serial_lpc32xx_startup(struct uart_port *port)
 {
diff --git a/include/linux/soc/nxp/lpc32xx-misc.h b/include/linux/soc/nxp/lpc32xx-misc.h
index af4f82f6cf3b..699c6f1e3aab 100644
--- a/include/linux/soc/nxp/lpc32xx-misc.h
+++ b/include/linux/soc/nxp/lpc32xx-misc.h
@@ -14,6 +14,7 @@
 #ifdef CONFIG_ARCH_LPC32XX
 extern u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr);
 extern void lpc32xx_set_phy_interface_mode(phy_interface_t mode);
+extern void lpc32xx_loopback_set(resource_size_t mapbase, int state);
 #else
 static inline u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr)
 {
@@ -24,6 +25,9 @@ static inline u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaadd
 static inline void lpc32xx_set_phy_interface_mode(phy_interface_t mode)
 {
 }
+static inline void lpc32xx_loopback_set(resource_size_t mapbase, int state)
+{
+}
 #endif
 
 #endif  /* __SOC_LPC32XX_MISC_H */
-- 
2.20.0

