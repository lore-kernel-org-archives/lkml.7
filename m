Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD1ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073A1207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfJUOTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:19:02 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60327 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfJUOTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:19:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MPp0l-1iisbC1bz1-00Msup; Mon, 21 Oct 2019 16:18:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>,
        Lee Jones <lee.jones@linaro.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: select CONFIG_REGMAP_MMIO
Date:   Mon, 21 Oct 2019 16:18:36 +0200
Message-Id: <20191021141847.2214613-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1XpQkbe8LJ1fW5M/Z38m2vIyWeR3kstO+tNSWu9lrKtuEFaceBk
 uLGFWVDx9RikWXnyd+QM2LgkG2XUG5uVKcSkCkRwDFNzgG2Nbdt8rEqMXqwzUFxjCIVarIq
 tpSuJJPTmitdJdqzQAbXG66T+dS+L2t0MHJPJ59qrlKWFIFqsj+FwfvLmNCv5ZAKrmrczdb
 hehdaoQqYQybesxosl+zA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AvdgeXJsHMo=:RY+zftnZfxose2d0vzyNrN
 YD0NqDJq6QTs4Az6wctQFCiLd1L/KWwSUWau1JrwAmBcSHWO7NhIY5sLnrG3sKPDOxWat2HcG
 Qlopehre0YeWu/IuT0BvVJygNB+VTc9E+k22ACNjgOKIjQ1/qVuW0BxJpsJS04+9+0S0XJI6u
 IpHyScQDy4CAkaps5V86EOcwg1TPsbJWbX6ef1muOeRZFVLjQI0sb8D2afHhK8C0dAwqH/ceQ
 Ec84iZCBQOUJuM7MOhqh5JrMR8Q2tFnwq4E5s6qZRaGfCWW/L38zF413UbJ+bSeTq+OrLd9+o
 O+1T8qQ5SjWkA9LNIOjItdFY2SywR2KRbjLZof570FbayJUnesRvwWxjHqU+Z04TwKPpUNqFZ
 NzRCpU5BAYup2B7Cn5yQmdWNM527SyfMfOxnd9ZLF4yAOBpEDgOlH5pte6f/wMrrFnMg9m41f
 j8rMl+6tCek2PoRcGlrSRb9xrxz1YB+8G0MnlLsYwFB459Fuke5jT2yECCBzoO6Hqg6yMehSR
 AgAUiEUxN30k9m32p6pTDuEHLOleJlw6LiUrjeQi6ct2X3b0djH49Mu44wzU8qVllXtmCNTpH
 TXIhbRpuSfJDbHnTKjZn51+/bACcOLKhKsfdIFpqz8RYObB7DP4hJ5nTWlmyxr5x7vsDI885T
 nTuV5dk245MLjkRpQB09mCKUlcNjCcbSmW1hNvSaSNr9RqgTSwYVnx+DIE8Lk3n5FpKsdzKvW
 kZ+iFYy83Cd1zzGi+apc61qQUr+9Jal0ixNsbUTWcNJkNiliaizsIhksj8pIv6bxmoQfZbc8/
 yN2AomU1N3cm93sqiiqDrBZaBCrE4ZBW0ztYvZBAZ3gfHHnCzz6Aq7C+NBXDubiyLAtLd0KE8
 ZLCzExAV91BwnXCPDr8w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After many randconfig builds, one configuration caused a link
error with dwc3-meson-g12a lacking the regmap-mmio code:

drivers/usb/dwc3/dwc3-meson-g12a.o: In function `dwc3_meson_g12a_probe':
dwc3-meson-g12a.c:(.text+0x9f): undefined reference to `__devm_regmap_init_mmio_clk'

Add the select statement that we have for all other users
of that dependency.

Fixes: c99993376f72 ("usb: dwc3: Add Amlogic G12A DWC3 glue")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/dwc3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 89abc6078703..556a876c7896 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -102,6 +102,7 @@ config USB_DWC3_MESON_G12A
        depends on ARCH_MESON || COMPILE_TEST
        default USB_DWC3
        select USB_ROLE_SWITCH
+	select REGMAP_MMIO
        help
          Support USB2/3 functionality in Amlogic G12A platforms.
 	 Say 'Y' or 'M' if you have one such device.
-- 
2.20.0

