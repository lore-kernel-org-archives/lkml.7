Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B09C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB0320868
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="ooW86/Sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfCIKEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 05:04:07 -0500
Received: from fd.dlink.ru ([178.170.168.18]:52152 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfCIKEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 05:04:06 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 1620E1B21843; Sat,  9 Mar 2019 12:54:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 1620E1B21843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1552125264; bh=49OI/zGOTn/6R7Rf/t3lKzdNKuFCipg59ZieLNkBNdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ooW86/SfzrshznMO85f/TEZjdRP1VAUoSqw+MyGV0sq01oJVAFG3JdHnKOeO/mdTm
         3/RLSQ1ODJw2PpzP7rGZsFgv//azy6LgqhVx9A+VMoEW2Sd3mE1qeftKd+62t2fx1B
         J/5gdV5KcCCM+xOqnATMjSpA/llEvOvCZpKXAl+c=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 3EB2E1B2182A;
        Sat,  9 Mar 2019 12:54:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 3EB2E1B2182A
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id 1B0CA1B20755;
        Sat,  9 Mar 2019 12:54:18 +0300 (MSK)
Received: from localhost (unknown [176.112.142.79])
        by mail.rzn.dlink.ru (Postfix) with ESMTPSA;
        Sat,  9 Mar 2019 12:54:18 +0300 (MSK)
From:   Maxim Zhukov <mussitantesmortem@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH 2/2] staging, mt7621-pci: fix build without pci support
Date:   Sat,  9 Mar 2019 12:54:00 +0300
Message-Id: <20190309095400.26930-3-mussitantesmortem@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190309095400.26930-1-mussitantesmortem@gmail.com>
References: <20190309095400.26930-1-mussitantesmortem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add depends on PCI for PCI_MT7621

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/staging/mt7621-pci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/mt7621-pci/Kconfig b/drivers/staging/mt7621-pci/Kconfig
index d33533872a16..c8fa17cfa807 100644
--- a/drivers/staging/mt7621-pci/Kconfig
+++ b/drivers/staging/mt7621-pci/Kconfig
@@ -1,6 +1,7 @@
 config PCI_MT7621
 	tristate "MediaTek MT7621 PCI Controller"
 	depends on RALINK
+	depends on PCI
 	select PCI_DRIVERS_GENERIC
 	help
 	  This selects a driver for the MediaTek MT7621 PCI Controller.
-- 
2.21.0

