Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B571DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963E42063F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfCFSvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:51:50 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:33795 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbfCFSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:51:49 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MMoKq-1hKMwp3rts-00Iomg; Wed, 06 Mar 2019 19:51:47 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH] drivers: uwb: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:51:46 +0100
Message-Id: <1551898306-18997-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:eBnZ8C2zY3vUfZzQxS7z+nS8aWTQPEvRTqxsxThNfY6OQnx99tq
 qYt5V1v3YVFArlwsBcOOPx+K8bp5lafiwDl9E+8AH6Sxtqt+UXCZD1yvAWYjoqOxR9vqoSv
 1usFmwYVtfHjGgzpU5yL7ZGydY9SYsdlRJYMVESKO7FjbpEwWaP1Dg7f/EFS6YlvQs3srNo
 FivsAM4akKcxMaJvyfD2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F5aHGTo7Aow=:veirXrc9p2VsRAEol2rQ3N
 ZjKNeJbzlZ3p+7rgGCcbxUH+MBDu0wVM024EGk9tWFDquRFSinJy80Um8M6Kec2a7Df8tU+D9
 IQyh7rxnFw+kQTR37Bmv5lupD11ewFPvLQzz3K4ZvN198aN9G3B3JzNNlUP8cA52/9hGRswsD
 p9njJ4uY11bn6L8bC7YWqdj9xGc9qvs+jJFYFsIP53U6gRo83ny6FHCmhwyJR56GlGxkCnF/+
 DMoc5eXFqEeYv1ftN9rTlQQfQDhtvhKY3Jxvi0SOfQluq3EUqUIpAF0BF1ifBxr3ryqfxOsKr
 dHjT7BgodiNY00tYAZBVX6mhlYas3Pn6iWqXggm4WxHAxd+STi1s4ay8HQLkyha6Ydmi1NJfq
 rZZ+n0VMAU/I8m6aX0FEUewmsplQPNNS/5SZoFw+gGC/F+vrmoDKeMvKdsprDUHCtJS9FrSWq
 C/yvvbGonMZaQ/HX272BnGiV35SYWCUXJRIoY3s+71/A+umIvlUZCJXXIAFaPTN8p8+4+td9K
 69NXrGrUiHCW1Py0P5pUAy//d8O6K6gtQP9xKeWLpC1n+qF7+i+mJzjw7qX8wnQdqA0HZsEeP
 C7AOX4KG8udx+FhsQX4lZsiYHcMwRsnufmOgM1miiHWW3+bzk+2YU2FzZbIpRAXNqwNhGeGRc
 Q6fPyoXsN5hhdjIDwqEMJbBuXd8ZsTL0cxFUmAjlRq+kOm0v8mK8hAn9NbX+3tR5ljOU+df4F
 YVp/P7qIUZTaox0B6QF8hJQB4qW4BG11xmfJEQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

