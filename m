Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBC720857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfCKN2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:28:30 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfCKNTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:34 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N9dkB-1gyAS027vR-015aUY for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 045/114] drivers: char: tpm: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:57 +0100
Message-Id: <1552310346-7629-46-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:oGN288Uxq7UXkGr5LBx/txM3ynupmfd8V0LaWC5u+uraFExOUfr
 YKcSCt2CunrU/Lbqfe5GcgoMNJCSCcTpDVqS2eZiTQcF3nPrdFp+hXnGow0zzqan10IbPbu
 ld5SK30J+hIZQ28FGtuTgCpUN2r6oRWb8a4qKviUppg6slTOY4gusElSMk7rifMZDKt+ZYl
 HzVAIBA1MFRTBOBagof6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WzWkbBoUmgA=:uFqUyEf1X1CbnrwI2VG1mO
 269KpfIWj0gOethJ7L9YcC26As7pXDMwSeXDrLg61Hf23Vg3KrmFND81ZIuhPr2pn4bthSOzw
 vJZzOagdOvKHFvO4q7qMSr1fH5XwqTKVjObbEiRTi65YohhcvEvKrjiCphHx3l1FNjOaq/JyW
 s8YqZ1dbl9sYzRGjJCBACSem/O/4Yu+AQ/UnUtMHux2UNcDZiIpa7nyhzZM/4FBBSK8vofe3O
 oc44dc5b9jqB5FONN1x3Q+EeFTzUkmYeUlqSz2CJVZsIYFgetGThT/cUyS86p/3zLFRjjAJYf
 yAdDC+AA5i2v3ydD8OUESlHZqorJIB2d4uE8UNpL5+HIeEsgEQ7f9KljA9aC4zRhihSzWsyy/
 FdGCLh0WmfEb5sHHeaIbH/4mnbXHpOWOWImbiwPusPU3anurMDRSuHwXs4q6MvHf3gMd0a6Pb
 XW3iI1KD+ItAXejo/kRGPwgQ4A8uR9Yv+35mE1p8iPZKE2SkyJpZxTjC3Gdy2fVytetEh4QF9
 UesjjilANkjigrl8qJSwcnss2z5F6s4EqNGTH0jVauGtgqA85/wGKJSpP3D//pK9Zrznj0wwy
 DfTo00ebMQA8/14Ai2n1hvJV8NbLHd8Rdyac1eTT/b1XfPmZrRiO0s2J4uDBFclr9Fkkn69BT
 W758a2hHjlrTwrKK+l9riGa+rO9exADVazRZJFTJlt9wv6W58OrZgQfXB9fB++0ExqZabu8tM
 PDbh9SDnW7RCoVBpFqHj9aP9hNxSLDvlKin4Fg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/char/tpm/Kconfig | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 536e55d..df478ef 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -12,11 +12,11 @@ menuconfig TCG_TPM
 	  If you have a TPM security chip in your system, which
 	  implements the Trusted Computing Group's specification,
 	  say Yes and it will be accessible from within Linux.  For
-	  more information see <http://www.trustedcomputinggroup.org>. 
-	  An implementation of the Trusted Software Stack (TSS), the 
-	  userspace enablement piece of the specification, can be 
-	  obtained at: <http://sourceforge.net/projects/trousers>.  To 
-	  compile this driver as a module, choose M here; the module 
+	  more information see <http://www.trustedcomputinggroup.org>.
+	  An implementation of the Trusted Software Stack (TSS), the
+	  userspace enablement piece of the specification, can be
+	  obtained at: <http://sourceforge.net/projects/trousers>.  To
+	  compile this driver as a module, choose M here; the module
 	  will be called tpm. If unsure, say N.
 	  Notes:
 	  1) For more TPM drivers enable CONFIG_PNP, CONFIG_ACPI
@@ -100,17 +100,17 @@ config TCG_NSC
 	tristate "National Semiconductor TPM Interface"
 	depends on X86
 	---help---
-	  If you have a TPM security chip from National Semiconductor 
-	  say Yes and it will be accessible from within Linux.  To 
-	  compile this driver as a module, choose M here; the module 
+	  If you have a TPM security chip from National Semiconductor
+	  say Yes and it will be accessible from within Linux.  To
+	  compile this driver as a module, choose M here; the module
 	  will be called tpm_nsc.
 
 config TCG_ATMEL
 	tristate "Atmel TPM Interface"
 	depends on PPC64 || HAS_IOPORT_MAP
 	---help---
-	  If you have a TPM security chip from Atmel say Yes and it 
-	  will be accessible from within Linux.  To compile this driver 
+	  If you have a TPM security chip from Atmel say Yes and it
+	  will be accessible from within Linux.  To compile this driver
 	  as a module, choose M here; the module will be called tpm_atmel.
 
 config TCG_INFINEON
@@ -123,7 +123,8 @@ config TCG_INFINEON
 	  To compile this driver as a module, choose M here; the module
 	  will be called tpm_infineon.
 	  Further information on this driver and the supported hardware
-	  can be found at http://www.trust.rub.de/projects/linux-device-driver-infineon-tpm/ 
+	  can be found at:
+	  <http://www.trust.rub.de/projects/linux-device-driver-infineon-tpm/>
 
 config TCG_IBMVTPM
 	tristate "IBM VTPM Interface"
-- 
1.9.1

