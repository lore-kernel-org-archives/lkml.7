Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D58C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFB5206D8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfLPNSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:18:50 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:58335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfLPNSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:18:50 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MWAay-1iDpDe1QGw-00XZaa; Mon, 16 Dec 2019 14:18:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: udc: tegra: select USB_ROLE_SWITCH
Date:   Mon, 16 Dec 2019 14:18:18 +0100
Message-Id: <20191216131831.3228566-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iBAyh2aepRVjDzUHSRkhSaityaozSfjOvz/3hlx/Mpqhf8J4AxQ
 Uf/0sG2EYK+Lptc9AmPIDXMpN73RgaDRXkidU3rilcVglu/pDHV+5ky76jM+0vrJIqqZzW7
 CGbOpEEFbwv+sPVmBHdal/QDPJknTz0yj9MYJH2fCaveL0F125KvFOM3QIoa4PbOA3eRYaT
 eDi03mKUD2zI8yZRQ0jgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M9mEog0+Evw=:bvzboCNou9h8w+yMuyev8P
 20f8JCS3mlDXYbRm2afgz4pOSUBwrKMHHRdn9fzm7vPDQomhi3PtyYFpMzN7BhyskSqK8HRjK
 e2H1GUldqWV1W+chnMRCgDBywtC16CRUlMgs0GTMknIAoxuTiZtAh1+GE0VKxGc3RHZMvMFP7
 QOr0sr/FiArcneGcpkdKjUbuAGvTfl3RPOAriA1EWNjHhTe/rOiC5QDUUVP+iz8KTQit88gDa
 KWtQfR5SmV2qDT4gSeuDERzLarljQktcW0LX9e2aMWqUDYJuedZjRorp0zkjCLkVy/6UNmB33
 R0GGEJ8b0XEAN94lcjzRsoMLK/bylMkNtivzSe1B7M4bX2Gf2FgQznBtbDUnFhPzHdHW+5xcZ
 MMbvf4MbD/LREL9eBAGqcPmwMffiCklE0YIZD65OI/75rVGhH6jgvCXYqDzAhmdDwZPZ1PdC3
 HSotZXpjjavhCk2GdTwlCgrTPSN5Amy8mcZA4Sht+2KTOi8EaOMvOoxSXpJRgk7TVF5A69gyA
 iOsXGEqhDtzyNW90H2f2ucbE0RaZDbUc+0NACsmZezu88W2hkRr1FyfUvYjOZ9mrgF/HM7VZC
 cPKn9jyIRv1z3KUmjardhi1zNXnz82I9adYOVENBQk9H0TUjiXV9k2x6dvmuJY2gFcSUAt04D
 pyvqFLPsXSh0x4IF1Ofb1cX3u231XSvjU32yc4mbIy04sZjSGKvGKKrCjJF4ACEk+4hw4Smkl
 lHD6f0tMF7WTY8zQkHk4aIi2BcMVhZj5ulGevegYsE9dgz8I9rIps0ypLD+uMtdlXE3DXINty
 3R9Pp/tXZdNcHx+kN59HZszSFmE2iA+F/wzmsssriJ0Gxm9dwH95xjaP3MzUMYgCegxTYOG+8
 rXr9RGX66hwVaFndPymA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, this new driver fails to link:

drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_remove':
tegra-xudc.c:(.text+0x19d4): undefined reference to `usb_role_switch_unregister'
drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_probe':
tegra-xudc.c:(.text+0x2a34): undefined reference to `usb_role_switch_register'
drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_usb_role_sw_work':
tegra-xudc.c:(.text+0x4b64): undefined reference to `usb_role_switch_get_role'

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index a0ddec0bb7fe..435f3597ff20 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -446,6 +446,7 @@ config USB_TEGRA_XUDC
 	tristate "NVIDIA Tegra Superspeed USB 3.0 Device Controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PHY_TEGRA_XUSB
+	select USB_ROLE_SWITCH
 	help
 	 Enables NVIDIA Tegra USB 3.0 device mode controller driver.
 
-- 
2.20.0

