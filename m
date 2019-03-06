Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C109C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AAA20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfCFUcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:32:04 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:50419 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfCFUcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:32:04 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MrPVJ-1ghfoD2hnz-00oTkL; Wed, 06 Mar 2019 21:32:02 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org
Subject: [PATCH] s390: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 21:32:01 +0100
Message-Id: <1551904321-23099-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:762t8LrN0WequNgdKmPJL8OdTTlK4hPFr/xLkRJKOX2yEH147Od
 zPHBIxlXGVFHY5uBnp+OAZNxJfrJefi7c15eW9G1FwvJBBi4LVH0i6Iyk0iZpZDVVAuKmaI
 qIO/5ywcJve8ral3miF/JyEG5d8XW7sWmxcS/4Zt5lW2r7FQ/H+F1eBx6bH1SuvltyH4K/B
 QRQ2ubMPtP3c2NdUWQ74w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m4wWmf4twHQ=:rVBfBROKbIAIpsuN6kfGmp
 IMPjwdmOA5FT10aZ7fPWA8irb5DkUocTd23K3Omr1UnixZ5/SRRCbOIBui5R+c/er1ssiE4BI
 Lx4YRGM06OoPRr2p0I1hkRFT4094u3Krayos4tYCvRzsevQjRg3THYE4kw1G0Dm62hM2sokk+
 /NOtCA40pZOqvWXsZzipw4H1si/xtsPHQw+O2MVSRTMh4FiN7PvAATm/J5StM8S9iS377HevW
 ykvB0rood4wXSKIjxHDALNiy+FGnD3eAJAXQwdz2ABq8/P7eSJ1CEiuICDmYGGuPhxQSmmvZQ
 2pNiRtxRo6G0QDRxu+O2dpFMTjEChLyxjpqjdSViQ+PJM+ajDLFHA8i/1++8l19xhwAf/ZWrW
 D1oUaphgNud2gKqxhgdJTKtoTM9l66qPyuoDQZN1XfmI50alrb4PPKH9mG9V+d0//AONLaDE7
 OTgI4DQ+j7gP7DHhEgvLgchhjuxgVQ4ilQ6vj1V1C2Wx/dEbQOXvRSVMpPNInfGgPXngUQhZ/
 kXz4Sf0SDBAHPWZcTdMGXEip6BxXgsvflIXDlmMK/HQ2VjKcVLAHKax9gYVAxs/G33vZvUtgO
 l9AmeXL9wjfzlGF1/j00yrH8dM0et+M7/c2z+oLNvatrjj4b4FVZAoR4oYNEzZInrYDeUH/H0
 TT6u/PdDi25mgLCd6B5y3Obb+8mQMCeXMJ0PVgQfZyZIeIi03UMSkzpBkTxJH5F0kgWLOU3kq
 OwCvzJu55HBc4Emh+hf92KULmrWrXsJ55121tg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/s390/Kconfig          |  2 +-
 drivers/s390/block/Kconfig |  2 +-
 drivers/s390/char/Kconfig  | 15 +++++++--------
 drivers/s390/net/Kconfig   |  8 ++++----
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b6e3d06..8e7d632 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -723,7 +723,7 @@ config PCI_NR_FUNCTIONS
 	  This allows you to specify the maximum number of PCI functions which
 	  this kernel will support.
 
-endif	# PCI
+endif # PCI
 
 config HAS_IOMEM
 	def_bool PCI
diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index 9ac7574..a8682f6 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -38,7 +38,7 @@ config DASD_PROFILE
 	depends on DASD
 	help
 	  Enable this option if you want to see profiling information
-          in /proc/dasd/statistics.
+	  in /proc/dasd/statistics.
 
 config DASD_ECKD
 	def_tristate y
diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
index ab0b243..e2c0c60 100644
--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -91,14 +91,14 @@ config SCLP_ASYNC
 	  need this feature and intend to run your kernel in LPAR.
 
 config SCLP_ASYNC_ID
-       string "Component ID for Call Home"
-       depends on SCLP_ASYNC
-       default "000000000"
-       help
-	 The Component ID for Call Home is used to identify the correct
-	 problem reporting queue the call home records should be sent to.
+	string "Component ID for Call Home"
+	depends on SCLP_ASYNC
+	default "000000000"
+	help
+	  The Component ID for Call Home is used to identify the correct
+	  problem reporting queue the call home records should be sent to.
 
-	 If your are unsure, please use the default value "000000000".
+	  If your are unsure, please use the default value "000000000".
 
 config HMC_DRV
 	def_tristate m
@@ -205,4 +205,3 @@ config S390_VMUR
 	depends on S390
 	help
 	  Character device driver for z/VM reader, puncher and printer.
-
diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 7c5a25d..ced896d 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -7,10 +7,10 @@ config LCS
 	prompt "Lan Channel Station Interface"
 	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
 	help
-	   Select this option if you want to use LCS networking on IBM System z.
-	   This device driver supports FDDI (IEEE 802.7) and Ethernet.
-	   To compile as a module, choose M. The module name is lcs.
-	   If you do not know what it is, it's safe to choose Y.
+	  Select this option if you want to use LCS networking on IBM System z.
+	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
+	  To compile as a module, choose M. The module name is lcs.
+	  If you do not know what it is, it's safe to choose Y.
 
 config CTCM
 	def_tristate m
-- 
1.9.1

