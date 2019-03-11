Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2888A222AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfCKN3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:29:55 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:32995 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfCKNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:32 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9WqY-1h6elK3K3Y-005XrD for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:30 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 024/114] s390: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:36 +0100
Message-Id: <1552310346-7629-25-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:iO1oPBgQXtGVYej8XkyOa9OSPgetXlX5t+3Y8r/gNZ44HpvqqyT
 Alfz0SzoVrBDv560RcZxiej2pyPTppObdKYydUNlbjV6oNDnmtIw9nX4Rl+jZugWKKELHnB
 9zo6rjqpU3qKp/crsEvUXkw+chlQZs9v80q77XginIDewwCpTlFLZCeDeEDrTTEyzDZ0c+C
 e27sBM18GbOKSKdSUoSBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nTbxfj3bZyU=:O3myipHdslY4TniT39f95B
 c/Ytj60u9NEvXntwbNtubLUeqJLqfYn/KF9tVT5vFqbacfpsfwistubusYTqaiA3hrj5qKOoW
 w935K18xPYiTmXkBCz43wuch7MQPJoze+YMryPrVWIoX261oVCOU5O4omM+u0suyujoLDIIh1
 kTwVkM9mEu5WzcZC9iurTPyhU1gjWLpl8u0eXmeKqv+mcb1L68LlJLOnHWhGOZphDIUy8wLIs
 s8YZ1d9wqhK98aNOHSDNXBiyA3mnqm1rEd4rywlfgH4BYUy9s+Mw+NiEB9bxyudRC4XwyuJQr
 2ocYceOavdaCueKCW1odFJ+JM1ZMFBGaltP/QdllJD2wNKf9g0TV7hz43V1S2mUC8MS0DqlMB
 GcW9UdhnDtsMSg7zxftlDRH9v0OQTMsB9P3ENgDXmJYFHoQyOsqdj9W2xeTUmNCyC/h/aTGQd
 Vg/jcSi48dqdQjchNVk2yEwdsnWp+n994A1WfHAyXuImo1j1CfgnAAayiINV+2wHwCPimfjog
 f8ZKeu2M/h6UcX7LE5IueR+AusXwkxnnmG4pl1ahB79hJ8lKqYGEybJKhW76VLEHMaz/ZKY2F
 Gdn2kpaOgibNB9woKrduoA3vqquUIirz4AWdqcIiOlrpLNJR3UaBXLhwUj0IqPCdpwR8uYamk
 FgiiFpy081r9MWBfqysgHNJY+dFv9RCq3FNfsrTBow7IqVwc7Sm/pitq/9l23Y7Czkl0bX7t9
 2AO64idKUC0TjGNNE0NJ5JpWKZWGE+BNkgi4Ew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

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

