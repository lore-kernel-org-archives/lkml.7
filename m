Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A6C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FEE21743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407007AbfHIOmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:42:50 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIOmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:42:50 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MkW10-1ibFDP1DAM-00m6H3; Fri, 09 Aug 2019 16:42:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH v2 04/13] serial: lpc32xx_hs: allow compile-testing
Date:   Fri,  9 Aug 2019 16:40:30 +0200
Message-Id: <20190809144043.476786-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190809144043.476786-1-arnd@arndb.de>
References: <20190809144043.476786-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SC8nZDGE2BL9UiO9/Fozk5OqQl67V4vDebpaMMEW86kY+4HNvMj
 YKeoq6THCo5lQcI4cDrmklhCT+LWmfdbFN6lCLqNDdUHBRLIJebF4mmnJGvh7mNxIv3ZCwT
 VRRC/RLTDmubB2Xi0BWRSw3kyzrdd4XxldtbAohamPuPtyOMkYMk/BGepJUSdUSyZ8xWeQ/
 KNc6Ys+WF0CLgaVoQH5wA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Hc4IEz+FE8=:Bi1ycoD9jmGxicFoUUXqr5
 9b/29dRCFDWcYEgVD78D6DLLA8oYjJi1HM1kwFtqAW9rJ0UNlrn1TzbQ9jHY9o3Z2zVS/NOkb
 JqK8vcIejal4Piu9/08+X/Nw8SCu87wa05jNNtjOqbR/YqHPLSKvJ1S3AsnT5xNke/viiMiM0
 FhC2pDBEnDvz2FH+LmvyZLQrjExv9w+hh6KrINZe2YCSIJqPIjz+90LR2WZePDsZVMvvIZVY3
 AofLb7Y85aBRVeQ5SqHLtQwmF+Wdrk/6sNqiOUm44Eo6oUmJLJURRmO9KmiNZYeWF8tE1+8Fg
 2hU2uS0MJuE6ztejja1tqp7zlMck0fN4puh+1AeDr9/h+JAR8FnRGwBiHfVOKXmZRy+WuZkYd
 0WdEdfDDydRMZqM1RM9wkoSx+4l2f6bQsuPe52787AdY6XNEumOIJYB884hCm0zFkxczbXKgh
 VaJ9be149nYemxn0IGfZcdtR52mA1GE9LaiBcCyLWYI2jewdF+Iulw86wDRAt4sUkOEY3gKrm
 2K/0jBKfJ3oDH0hKOJ2W6OKBX6J9NGuhiLgMMf8P79Utgi5f/E2PXnwhO3hAjtrqVVTyh7td9
 80eTZhPkz9J6xoMjACEo+WsPBu4mk0neKFetIC7rib1R82Y/41wT86pbHoE1la6xROckMdSNF
 dZvNS2PHw0GDMRxSFCC5kbRqbD6/wZXPpELBuyE3X0Ot9gCtoP2vjaW1urOioW7W9aaCtQXKy
 NWMoDJ45quKlhemjbD/l8qhcV2xrgjPMTROlJw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only thing that prevents building this driver on other
platforms is the mach/hardware.h include, which is not actually
used here at all, so remove the line and allow CONFIG_COMPILE_TEST.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/Kconfig      | 3 ++-
 drivers/tty/serial/lpc32xx_hs.c | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3083dbae35f7..518aac902e4b 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -739,7 +739,8 @@ config SERIAL_PNX8XXX_CONSOLE
 
 config SERIAL_HS_LPC32XX
 	tristate "LPC32XX high speed serial port support"
-	depends on ARCH_LPC32XX && OF
+	depends on ARCH_LPC32XX || COMPILE_TEST
+	depends on OF
 	select SERIAL_CORE
 	help
 	  Support for the LPC32XX high speed serial ports (up to 900kbps).
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index f4e27d0ad947..7f14cd8fac47 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -25,8 +25,6 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
-#include <mach/platform.h>
-#include <mach/hardware.h>
 
 /*
  * High Speed UART register offsets
-- 
2.20.0

