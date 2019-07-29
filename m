Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7754FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5399F2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbfG2OzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:55:23 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfG2OzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:55:21 -0400
Received: from orion.localdomain ([77.4.29.213]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1My2pz-1iabhp0e9H-00zVu0; Mon, 29 Jul 2019 16:53:34 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH] drivers: scsi: Kconfig: minor indention fixes
Date:   Mon, 29 Jul 2019 16:53:33 +0200
Message-Id: <1564412013-30893-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:xzhcNkMu2jW4LChw2xGWTYi+VXMJqg6RPiVceSHF81BcP8GvEQV
 5kFehbIgMnnNUd/B+/9CJbl0OYQq6Ij+6n/cXW4XkkYyFefyam5OvN3iS8MBBXsZ9p0fdqZ
 rvzzkfjt3FLxj0dQDutxFg0a22uce8gJvKpcur3XO+AMYTdqKnx8lMVR9o3hw9Ozc7YInpj
 2qkqe5NELiakT+lT5tdEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BrnYRfFxzhI=:IfTQRqdNFkVhzydFE1ZCLq
 sOSn7jKkqFTmbyIxdekA7IFJyQaqgyEQltJUG4uZBiMMqbEGRbdDrWs2YlQeRtMyXFwD5ZHoE
 V9QetRxtb5xoCO5suH7CpdjiZP+W6FWt6Q9p+ZKnclaJgM6qlMnyQuyIq3SC0dTbhEyP6XKBR
 NcM3Bt3e6TNNDeUmOyNbMr/AawbLaPvbr3fcJr9XBADJxl/38RNd03sbP9aEagwDrE9vI+lI6
 DCkDgMSK9qirhxdLFLLRrFU6wyuaCGph1CaKIo40KnbfIUPl/qlyoDZ0K1Q/Hac1+GH5MW0vT
 HabcuYclAD3C8diZH2sywYVRniPhAl7WqdFCuSx4VwjHgxTzpDSwJN8C0uGTF2m4XMle+Fj6H
 qi5PsQMTA/I2WTK4iMTBt/xKt4HWaS7hhmeoPzKvMepdWrk0Y/z7S+p8F/XdYZXsi25KejkFe
 49WcK31SaAVKOD0+OUPN8qgEKNUgt0KNA3wfpgV4+KpAg7ex3iWWnOK8NfI2edFfsar9lWpou
 ntjfvDqNeEUscJUu6mRUer93Fi2iWQLoLyUynrBmEQ3Cno2iVEZwbyskcfW+u7Y9GAt48xLW6
 7n8LoVv4i5R+8Qi3EOsxpP3noG3iQmAaj399H4sv8zb7PbD2BjsH0rl7tIifGHx9+8Ky5JR3S
 XjPC+f3tqBMZtzOvEsdoXCQoaGjjrJbSlfsL2JfZyiqA1f0cAvmeVEIJZ6Y/TGwDPc9HN91Fu
 T3RggB1/sUKDF7h59lQ+4eue+2idpIuw62l/QQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the indentions to the common practise in Kconfig files,
make it look at little bit prettier. Just whitespace changes.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/scsi/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 1b92f3c..1332671 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -2,9 +2,9 @@
 menu "SCSI device support"
 
 config SCSI_MOD
-       tristate
-       default y if SCSI=n || SCSI=y
-       default m if SCSI=m
+	tristate
+	default y if SCSI=n || SCSI=y
+	default m if SCSI=m
 
 config RAID_ATTRS
 	tristate "RAID Transport Class"
@@ -1480,14 +1480,14 @@ config ZFCP
 	depends on S390 && QDIO && SCSI
 	depends on SCSI_FC_ATTRS
 	help
-          If you want to access SCSI devices attached to your IBM eServer
-          zSeries by means of Fibre Channel interfaces say Y.
-          For details please refer to the documentation provided by IBM at
-          <http://oss.software.ibm.com/developerworks/opensource/linux390>
+	  If you want to access SCSI devices attached to your IBM eServer
+	  zSeries by means of Fibre Channel interfaces say Y.
+	  For details please refer to the documentation provided by IBM at
+	  <http://oss.software.ibm.com/developerworks/opensource/linux390>
 
-          This driver is also available as a module. This module will be
-          called zfcp. If you want to compile it as a module, say M here
-          and read <file:Documentation/kbuild/modules.rst>.
+	  This driver is also available as a module. This module will be
+	  called zfcp. If you want to compile it as a module, say M here
+	  and read <file:Documentation/kbuild/modules.rst>.
 
 config SCSI_PMCRAID
 	tristate "PMC SIERRA Linux MaxRAID adapter support"
@@ -1518,8 +1518,8 @@ config SCSI_VIRTIO
 	tristate "virtio-scsi support"
 	depends on VIRTIO
 	help
-          This is the virtual HBA driver for virtio.  If the kernel will
-          be used in a virtual machine, say Y or M.
+	  This is the virtual HBA driver for virtio. If the kernel will
+	  be used in a virtual machine, say Y or M.
 
 source "drivers/scsi/csiostor/Kconfig"
 
-- 
1.9.1

