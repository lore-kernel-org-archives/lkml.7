Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF332C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2437206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKUPOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:14:31 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:60673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKUPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:14:30 -0500
Received: from orion.localdomain ([95.115.120.75]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MG9To-1idHoc0tI4-00GbeK; Thu, 21 Nov 2019 16:14:26 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] drivers: usb: Kconfig: cleanup indentions
Date:   Thu, 21 Nov 2019 16:14:08 +0100
Message-Id: <20191121151408.22401-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:e0kRH53v0W+OvWbKhNygQRuPlIl1lH04eIKBgnWV2/bRi3zzsK+
 Ud+VkMN4dX7d3S5YIynTl17SJr26oj8OyG0VPBtiAeNsE4OOBm0KPHHjE8S0M9aah2bbDyY
 WCGciBf0nNcnxCqxIs5kuXlyYP5g4guPAGqZxSf3KeEKpFMWxAdUOvqdO3jlJt/fTQUP3cj
 yk477NdmjY1B6WuDVR0LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LzmVPn3/Sqw=:3J8CsX7sgEx47rB8SXR1V5
 0ArIgnCtEFl5sq+PoKy67VGNoAAE7GIr98/RBz2Sq0K9DFm8S1WPpZwaO9jFlUZAw63qfuBVY
 WU5Idh4KPRIjc2yfK3beGpZ90TRXKyEaTNawrwHXtz5RssnwGXUPeEL2XIcVpETNo0V+Nx38o
 O6Rdhl1CsAfdMOltFel1ClI6So8fSkWzHopc3k6FcYSvQJQfYH81NQzalTko0Vm5Rvdi0Kbo1
 z/DHh3qx0phtca/YZO8BIpSrPRrTIxP7j6VxGS/RQq9YUVGjV1/agWzMxkCW3y83OXUl6mPFF
 MaP7TADxH2gsZ5ppa4fTDT3x4ANDeCQHx8MgvR2JgurEDDts2lsyXCw+0udDtiO+2IHv6ajnL
 LfZeOkKc2vmZQmCnDzR0U67nATDmBEFlkk/Z6w4xE2fsi9Ol5lgPV+ggTsfsa7wmFPsCHJH/M
 /vaklRW1cjN89qOJNvn7YOBgqLFZYvvJdcWXde27wWXx2CaObqaArFJbIjA9AT831rDQP9sHl
 1bALVfMAvT5cKYbCkveJoxU1xhRRbLTzrjr2xH2McilO84jX3PZ7jyB37fgqpfYUUHx6Sdmhp
 WvDZXz3pv/E3fjq5cPzmEvfCHSmzu7bC4OelP0rRMtJy1ngCxuN/3tZAXRndb/JArRLZ8RSHv
 DLbqxeymoBjS+Jei/cZNOHxEp2C0W0rouXwyqI67DrcnG611AQGBkIeZZRcsQ09jMepz0lTod
 1Ndhih2Pm7beiDrH5ADyOWaT5yfUYnf2U3GqMb0arhRuf5TwWGNT/5YOUH53N8kuiQED//Uqe
 L2s3pxpanZYHK6ORJZftemJTHj+jJLA5b2SfTiBQ7rIJ40gun2SR9W4eJI4Z2GKZyM3Mc1+GF
 juzvFM+2jlbR9zb09TgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code look a little bit nicer.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/usb/dwc3/Kconfig | 30 +++++++++++++++---------------
 drivers/usb/misc/Kconfig | 24 ++++++++++++------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 556a876c7896..7695841a108f 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -97,24 +97,24 @@ config USB_DWC3_KEYSTONE
 	  Say 'Y' or 'M' here if you have one such device
 
 config USB_DWC3_MESON_G12A
-       tristate "Amlogic Meson G12A Platforms"
-       depends on OF && COMMON_CLK
-       depends on ARCH_MESON || COMPILE_TEST
-       default USB_DWC3
-       select USB_ROLE_SWITCH
+	tristate "Amlogic Meson G12A Platforms"
+	depends on OF && COMMON_CLK
+	depends on ARCH_MESON || COMPILE_TEST
+	default USB_DWC3
+	select USB_ROLE_SWITCH
 	select REGMAP_MMIO
-       help
-         Support USB2/3 functionality in Amlogic G12A platforms.
-	 Say 'Y' or 'M' if you have one such device.
+	help
+	  Support USB2/3 functionality in Amlogic G12A platforms.
+	  Say 'Y' or 'M' if you have one such device.
 
 config USB_DWC3_OF_SIMPLE
-       tristate "Generic OF Simple Glue Layer"
-       depends on OF && COMMON_CLK
-       default USB_DWC3
-       help
-         Support USB2/3 functionality in simple SoC integrations.
-	 Currently supports Xilinx and Qualcomm DWC USB3 IP.
-	 Say 'Y' or 'M' if you have one such device.
+	tristate "Generic OF Simple Glue Layer"
+	depends on OF && COMMON_CLK
+	default USB_DWC3
+	help
+	  Support USB2/3 functionality in simple SoC integrations.
+	   Currently supports Xilinx and Qualcomm DWC USB3 IP.
+	   Say 'Y' or 'M' if you have one such device.
 
 config USB_DWC3_ST
 	tristate "STMicroelectronics Platforms"
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 9bce583aada3..4df29c6f7856 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -162,7 +162,7 @@ config USB_IOWARRIOR
 	help
 	  Say Y here if you want to support the IO Warrior devices from Code
 	  Mercenaries.  This includes support for the following devices:
-	  	IO Warrior 40
+		IO Warrior 40
 		IO Warrior 24
 		IO Warrior 56
 		IO Warrior 24 Power Vampire
@@ -181,8 +181,8 @@ config USB_TEST
 	  including sample test device firmware and "how to use it".
 
 config USB_EHSET_TEST_FIXTURE
-        tristate "USB EHSET Test Fixture driver"
-        help
+	tristate "USB EHSET Test Fixture driver"
+	help
 	  Say Y here if you want to support the special test fixture device
 	  used for the USB-IF Embedded Host High-Speed Electrical Test procedure.
 
@@ -233,17 +233,17 @@ config USB_HUB_USB251XB
 	  Say Y or M here if you need to configure such a device via SMBus.
 
 config USB_HSIC_USB3503
-       tristate "USB3503 HSIC to USB20 Driver"
-       depends on I2C
-       select REGMAP_I2C
-       help
-         This option enables support for SMSC USB3503 HSIC to USB 2.0 Driver.
+	tristate "USB3503 HSIC to USB20 Driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This option enables support for SMSC USB3503 HSIC to USB 2.0 Driver.
 
 config USB_HSIC_USB4604
-       tristate "USB4604 HSIC to USB20 Driver"
-       depends on I2C
-       help
-         This option enables support for SMSC USB4604 HSIC to USB 2.0 Driver.
+	tristate "USB4604 HSIC to USB20 Driver"
+	depends on I2C
+	help
+	  This option enables support for SMSC USB4604 HSIC to USB 2.0 Driver.
 
 config USB_LINK_LAYER_TEST
 	tristate "USB Link Layer Test driver"
-- 
2.11.0

