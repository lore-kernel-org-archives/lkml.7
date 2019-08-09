Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EFAC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40C32171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436501AbfHIOlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:41:49 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54285 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIOls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:41:48 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mvbr4-1iD4VT2f4w-00saWn; Fri, 09 Aug 2019 16:41:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 02/13] usb: udc: lpc32xx: allow compile-testing
Date:   Fri,  9 Aug 2019 16:40:28 +0200
Message-Id: <20190809144043.476786-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190809144043.476786-1-arnd@arndb.de>
References: <20190809144043.476786-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:imKF8CYOdXNLcMsBRk3mkfe2XaXiYZ/dpgIAJ8vRCoyxvlRyj33
 AVF5BJ04yO+4T850DaBd0tsnYRR8Kr57cnSNT3OeGpKfcEBIX8M9GQMwT1IUYdprcSqX4vO
 EeKrYORhADLbzjwUhXrKNiu9yK1kPe1XBmNsZb+rNlS3zJR9ml4+W8sWjKbu1DGbmJqJCp8
 TP+LwRSu/+D+dPieDgwZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o+P30devlyk=:ZOux45NQXABh307CDaffwC
 eRRPJf8wFJnTFHt8ABbfXpKy4+2KstsbFkVk7tp+8vg4RTNo+M0qNZuHja9WiuljDwDeeHKcR
 JxyOvwefJYugKbJYpqRg2PBrMHB/XvtsyuqQMKg6MW0mGJk+wUbEB88paGrIS/Z4GIMor3210
 qI/jAwzxrydt6db2oU8rWGakd4MF7/PQKoleMWB6eEL683yBW0UqbgyGETizPP/DAsE3BgaaY
 n1GFH9keXNXLp8Xhf+ZE5mBYr2ExNpKkbKCk5RA9MJQF4T0neuwFC91NWpUMkC4fvpBKNYttN
 DlXWhYa5RA59/nEeBjcnTVwhV0UVR+x1laNjs+CvutXhcstOZLZ4DLnirepeO2IjaKjkTB68E
 WPSCJLJS70sOdynJzhit1m7j49KEN77V/Yk0bExKwvI9+6INzhs/cKpqGC8EkE87qhzOfx1Jw
 VxkvqpnmJjGiEUJVi/fVAv4Izr3dwKSZ+Ahn9ePU0N9HLxPwbFcZoAKs3Ec+3zA5lIuQCzta0
 at21vUSECg93O+CzFZY7g0meK28uC1IVZxzI0gQm8lkt0rXQuLIbK+fJekVelMDCWZF8IwghO
 cu0S6TwolJqo0s/Ne+Zpn138n5DzWwUfAxLpaeBExS5sdoIpkvdiiNDMLIql1FUOR+ONQbviM
 ICGimsocRL3e9CqZnT7W2tc+ve+MFAKwCFQ00cgCy+DbaPUGMxRxv4WBMRhZ2IJCB8oDAdLQX
 VyxbDTMn3knDPVcYN44yMWdFlMgOC1wRYKle3g==
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
 drivers/usb/gadget/udc/Kconfig       | 3 ++-
 drivers/usb/gadget/udc/lpc32xx_udc.c | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index ef0259a950ba..d354036ff6c8 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -45,7 +45,8 @@ config USB_AT91
 
 config USB_LPC32XX
 	tristate "LPC32XX USB Peripheral Controller"
-	depends on ARCH_LPC32XX && I2C
+	depends on ARCH_LPC32XX || COMPILE_TEST
+	depends on I2C
 	select USB_ISP1301
 	help
 	   This option selects the USB device controller in the LPC32xx SoC.
diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 5f1b14f3e5a0..defe04d52e6d 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/prefetch.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 #include <linux/usb/ch9.h>
@@ -35,8 +36,6 @@
 #include <linux/seq_file.h>
 #endif
 
-#include <mach/hardware.h>
-
 /*
  * USB device configuration structure
  */
-- 
2.20.0

