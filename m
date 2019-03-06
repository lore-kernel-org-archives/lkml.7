Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67CCC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7DE20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfCFVnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:43:49 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCFVns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:43:48 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N4Qbu-1gufN13i5O-011TJG; Wed, 06 Mar 2019 22:43:46 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2] drivers: uwb: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 22:43:44 +0100
Message-Id: <1551908624-15081-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20190306192608.GB29080@kroah.com>
References: <20190306192608.GB29080@kroah.com>
X-Provags-ID: V03:K1:qU73gaA8lNLc9Gec9xw+RV8MQp1zjVeO3AyYzfaVyawZFdNA+nn
 WBiAx2YzqBgpSvmV0ZjZ3cgi9c1BWZw6L/RuvqVEVqsNeFn4+CkHO9jSrUxCb/p5aL+fCZP
 lCuzkCPHi+PGerSisVeZ+tVcOv1cwdyIKsDB4PmwTZFkTlRq4kxvmoaInYqcLCJ2zm6IHek
 5Nsz1FUYk10+r23JEWQQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mFGRSBAcJWk=:nuC3yrOD9EY6rPmTxhy+3t
 VhnUj7ugtcKKS4n7Ml5twAUuUg9qGN3sTgbb4YxHO+7wbVU4atBCzr4tf95SIRnFbr01sXrA0
 6dvqyJjlOtlgVKnCnFWC+3Dhm8hZUr5kgIHfnl9+62unYww9avmzckx9I/UpryIJCSTqx/zwy
 8Ui3asq9NDNPczfmv3tOTngLGO783oXNNvRk0vNg/jNcBTe1ttgYmZRwhDUm5vhZ8yQGQcBMF
 +WEWqKhrNERRIPD65Qz1tH45HHlXjaQwKygoQEH7ZEHeKumsZckiE5SnMnCyejIhddQXDHd+6
 ltt4R801ExzdJOLBxi3FXAEX2JgRtZVdVW4H1msmCXkS7/YYzpJC9dZvBRuHUhEVBVFu1rSS8
 KKiF7YsHMx1U+sKcCR7IAvb7sspOXqHOlb/bliakKQiVjybjYtdqPL+eElD3rZGaFYFn4HUjY
 GuzvjHIzZyry0bBZ0+4DlAFZkCVCY9BIDRT+xz0eHkpJSGPmTav8NKw+LHhAu8clbPl9AbCJc
 rtdhSF0Uzo16J5S78QzpWwg2h2K+lT+VRALjPa96iVPYlHK5ieZOJf6DE4Q4afS1n8ULOY/OI
 rt9wP/0sKuUJDLWa1ZHPGi3bUbuES8mhaYJjTzoT+CRoqaoP38K35fchbFkIIrkCyPWLS9S8m
 CdZJ2XbMalXwgWSo1D9yzuERFglwJSRQjExi/UJmYUprssgdIy0SzaCY6qo2agYcCAMqiM6o1
 R7BrJBeBViqaj5GpNvZuIYbPyXfWaU/kyG9O6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

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

