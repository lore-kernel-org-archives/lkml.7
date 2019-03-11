Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A65C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E319222EB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfCKNbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:31:00 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfCKNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:30 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N9dkB-1gyAS53AOL-015aUY for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:28 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 009/114] drivers: ide: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:21 +0100
Message-Id: <1552310346-7629-10-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:cxQFezJFX4NsODF7FIPh2elE4uYdDlg55y/XXkngdNnzfhWel20
 sacx+6/hE9XFwSs2Eq1jthbicJRrSSSCrPla3uR3qbfyWkO0ua/sKkEUemEjevgbj6g0dkP
 S0VXvitUvl4AlQcObq67vAO23W42B7rwFYzFUdU48tm/yjrZ7zv6idScMTJxsC0DzTjEi8Q
 eaccbF5BCrH9fFPlNmyuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z7VDqqE5m/s=:WjWo6CmozBYtaturxNYV0g
 Z5l4Q7eT1X35VbTHCGXW6Eo2Xx1qCyCSl2+6QFijlHwq40tqhAu5q/aXEIjLsnVLWjpY7Hc70
 JPjThybDypJe7mWpF+2gipUxw0EvxTpTPySoDlgWtl2iGXon4aNtIWB7lyDZICbDgyGN2SZsU
 K4vwyh+Y+u87T+wkWlUWFfj86tdv6SN9uIqJsrlZ5Ps4P3emDzsTCZFX1znrM7lsgkUZRvlpP
 kC2EkF9aaYTUhKiPl70vcLfJbN0K3sgGAGAo/3nUNcZvLLjQhY43BE9clRijP046sjwUzGzGW
 V9GqZhzUdLTz2oEpe4sD67hyxiBR4K78+mAbh8kYPsk/uAJobd/eiKKJAaJlK00+Kj+t+tG23
 FCw+GDj+zhbDhzBly8/iXv38WLp7eDg9wMTNbrgcz/nHMSLGm0WhkN+Z9qKf2BuRkB4pDRuUE
 M9cZ5dzvlPqxwb1QU5Wbh4p6sBqgU5RTrOGUwNlyxyEt0Bmo/dJQihgjPe42wt4V1d94bMAZR
 nEQu719iGeifUvSxAXpt1XoLv0vDYic+7s1csEIjmFqlZSmwSvPp5tUByUT1z6ZDjZAOLw7WI
 ehBCVkNxQKvf/kPAqQML7k6lEQBoxDV8UknL7Kny/vgQzDTHuzublLRDo8RB+IfAxcFAihJN/
 7F+RGT+iIn/BT6CmwrKNt4CP3/BeF732YcnKd8zmGJiK1fPQvG9g/EdyZhW/I2bxKqIiGRuAg
 Cbxfm/4c7W/4M3VELyPhxO4paMpEhg8RrXxlhg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ide/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 901b883..19fcd07 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -320,9 +320,9 @@ config BLK_DEV_OFFBOARD
 config BLK_DEV_GENERIC
 	tristate "Generic PCI IDE Chipset Support"
 	select BLK_DEV_IDEPCI
-        help
-          This option provides generic support for various PCI IDE Chipsets
-          which otherwise might not be supported.
+	help
+	  This option provides generic support for various PCI IDE Chipsets
+	  which otherwise might not be supported.
 
 config BLK_DEV_OPTI621
 	tristate "OPTi 82C621 chipset enhanced support"
@@ -516,7 +516,7 @@ config BLK_DEV_IT8213
 	tristate "IT8213 IDE support"
 	select BLK_DEV_IDEDMA_PCI
 	help
-	 This driver adds support for the ITE 8213 IDE controller.
+	  This driver adds support for the ITE 8213 IDE controller.
 
 config BLK_DEV_IT821X
 	tristate "IT821X IDE support"
@@ -671,20 +671,20 @@ config BLK_DEV_IDE_PMAC_ATA100FIRST
 	  hard disk and hdc for CD-ROM.
 
 config BLK_DEV_IDE_AU1XXX
-       bool "IDE for AMD Alchemy Au1200"
-       depends on MIPS_ALCHEMY
-       select IDE_XFER_MODE
+	bool "IDE for AMD Alchemy Au1200"
+	depends on MIPS_ALCHEMY
+	select IDE_XFER_MODE
 choice
-       prompt "IDE Mode for AMD Alchemy Au1200"
-       default BLK_DEV_IDE_AU1XXX_PIO_DBDMA
-       depends on BLK_DEV_IDE_AU1XXX
+	prompt "IDE Mode for AMD Alchemy Au1200"
+	default BLK_DEV_IDE_AU1XXX_PIO_DBDMA
+	depends on BLK_DEV_IDE_AU1XXX
 
 config BLK_DEV_IDE_AU1XXX_PIO_DBDMA
-       bool "PIO+DbDMA IDE for AMD Alchemy Au1200"
+	bool "PIO+DbDMA IDE for AMD Alchemy Au1200"
 
 config BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-       bool "MDMA2+DbDMA IDE for AMD Alchemy Au1200"
-       depends on BLK_DEV_IDE_AU1XXX
+	bool "MDMA2+DbDMA IDE for AMD Alchemy Au1200"
+	depends on BLK_DEV_IDE_AU1XXX
 endchoice
 
 config BLK_DEV_IDE_TX4938
-- 
1.9.1

