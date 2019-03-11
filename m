Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391CC222C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfCKNaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:30:30 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfCKNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:31 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MpUQk-1giZPa0Qkm-00ppxP for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:30 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 019/114] drivers: uwb: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:31 +0100
Message-Id: <1552310346-7629-20-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:KxnYeBSPKnsEwyjNNcS0xwWst7w71VqINq91mr6YgMmomqCRSs4
 3DKkYCOg62InJT3BbcQwcgnDa7U60MrZOjNBcUSdNIRK2u12pOxYKSyiCl1WsfOJcal+8Qm
 sngfnoxifOkAnma96+YDonB7FUChNSIoZ+HJjwHv24M8xIXhEX+hs7lO+5U0Am3If7u3QEg
 WgQyXLJ+ES/TNhcFuCcsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ScILsAWVfc=:I3/VCUtsAuzCLnH1i51yw3
 Cn/isNODCTOGHpGu+qyKxMRgVeUJ3O1YuoPQSZ7B1mLlauL+TLg4RJOQyv21dhOY97B9l7Kku
 6Ynkf9UA0hbL7D0r/9Tz/lV/0QhFPQ9vsPyk4jtoN9FZehCbbcfwIwj+Cc4jkmxHZT+/4Q9lj
 jdaCFtRifno/77pEGYiBX8xtcFz0v8JofDtSrRC5uth0xb1swr0a4L61Zw1+yjRVd6Ue81WKj
 cClzB1pm0Jwt13P43ZfIzoDC/DyP1TXWjAx+GSv4/e8LT0P9YfLCHHkCPDOrBGHLnR8RIsM/V
 rmjQvt2n6kBnildoACmMt/GKZckhfH9lwVf3a2cL2F+Y6KYMdtS2lk7CPg9S9NjmxlPQS4fAP
 7AluzDLL29vL7+bPeveld75RuxvANhGWbmlFY1nxQ4ZUMpbQaAUOu2Ahlva6KZQCnMgVzkSEl
 tgTRR2mAyQIjXp0ljN8t33JTCoHVQQ2M1KtI1mFJLOep+0atUhp2KUNvzMAaM0/i9dcniPc8A
 0WRC1/T2GkwpcPIwwuaBpc9jUGQBF1RBghJzu7DA/WbJtvaaM0CnMI27qg5M8E/mx5GaV/sYX
 abPdsTkIfvMI/XEkgqxcysVMFtLgQAXT5lDPNg8BA3h/fqrTMKzx+CgP1/qjv7FWcqTgdH+lZ
 SKB9P0PLSHKt5wnBwR84jGxpFluhZ4Ky7BANwrpN08Y5pCuONpHYjpBzSfTMMumedW5dp+vhF
 2+06+AFaiIvZjEGJ34f38RLXLbcNYVWEVlkwqQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/uwb/Kconfig | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/uwb/Kconfig b/drivers/uwb/Kconfig
index afac258..d0e15e1 100644
--- a/drivers/uwb/Kconfig
+++ b/drivers/uwb/Kconfig
@@ -41,31 +41,31 @@ config UWB_HWA
 	  is safe to select any even if you do not have the hardware.
 
 config UWB_WHCI
-        tristate "UWB Radio Control driver for WHCI-compliant cards"
-        depends on PCI
-        help
-          This driver enables the radio controller for WHCI cards.
+	tristate "UWB Radio Control driver for WHCI-compliant cards"
+	depends on PCI
+	help
+	  This driver enables the radio controller for WHCI cards.
 
-          WHCI is a specification developed by Intel
-          (http://www.intel.com/technology/comms/wusb/whci.htm) much
-          in the spirit of USB's EHCI, but for UWB and Wireless USB
-          radio/host controllers connected via memory mapping (eg:
-          PCI). Most of these cards come also with a Wireless USB host
-          controller.
+	  WHCI is a specification developed by Intel
+	  (http://www.intel.com/technology/comms/wusb/whci.htm) much
+	  in the spirit of USB's EHCI, but for UWB and Wireless USB
+	  radio/host controllers connected via memory mapping (eg:
+	  PCI). Most of these cards come also with a Wireless USB host
+	  controller.
 
-          To compile this driver select Y (built in) or M (module). It
-          is safe to select any even if you do not have the hardware.
+	  To compile this driver select Y (built in) or M (module). It
+	  is safe to select any even if you do not have the hardware.
 
 config UWB_I1480U
-        tristate "Support for Intel Wireless UWB Link 1480 HWA"
-        depends on UWB_HWA
-        select FW_LOADER
-        help
-         This driver enables support for the i1480 when connected via
-         USB. It consists of a firmware uploader that will enable it
-         to behave as an HWA device.
+	tristate "Support for Intel Wireless UWB Link 1480 HWA"
+	depends on UWB_HWA
+	select FW_LOADER
+	help
+	  This driver enables support for the i1480 when connected via
+	  USB. It consists of a firmware uploader that will enable it
+	  to behave as an HWA device.
 
-         To compile this driver select Y (built in) or M (module). It
-         is safe to select any even if you do not have the hardware.
+	  To compile this driver select Y (built in) or M (module). It
+	  is safe to select any even if you do not have the hardware.
 
 endif # UWB
-- 
1.9.1

