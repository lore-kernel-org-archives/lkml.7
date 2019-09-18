Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA47C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D5721848
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DBUOge4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbfIRU6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:58:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbfIRU6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FCsffJv0OTIjbuwlwaHBy55NBTv30OBNaAD67wgQEWc=; b=DBUOge4e3EwOeL7JVDCagrfyX
        LTy7CyyqmT8rWeuVUN+IK8p+8OSyvPGLmrX503nMSwV2xN0GQoK5zBFxzlBmuv470QOA+iSPR8KAV
        A+vON3OpMX2i0zT05t18ILBdZRW23GINFyQsDRoAehe2hlZAebBA91glXMOwH2ikxCU5bFVep98of
        LAVx7fIp4hVlIBQhW6y6P87or6NjIKnQVZ9puQun/IMexJC0hrOmzodWkZ2ViNw8tD76a9SyMgOMw
        fHGzqKLjqjFDRiWufK1ENnknPXW0/nsNBLt4KgHZE5lBpBvzQmPBhqxXEP/4PBBj/uUEX7ZoSE6SU
        EON5oK1Ww==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAh20-0001Of-OG; Wed, 18 Sep 2019 20:58:32 +0000
To:     LKML <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] NTB: fix IDT Kconfig typos/spellos
Message-ID: <55f2fb85-9d4d-f78d-e6dd-70b09d7667e4@infradead.org>
Date:   Wed, 18 Sep 2019 13:58:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typos in drivers/ntb/hw/idt/Kconfig.
Use consistent spelling and capitalization.

Fixes: bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-ntb@googlegroups.com
---
 drivers/ntb/hw/idt/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- lnx-53.orig/drivers/ntb/hw/idt/Kconfig
+++ lnx-53/drivers/ntb/hw/idt/Kconfig
@@ -4,11 +4,11 @@ config NTB_IDT
 	depends on PCI
 	select HWMON
 	help
-	 This driver supports NTB of cappable IDT PCIe-switches.
+	 This driver supports NTB of capable IDT PCIe-switches.
 
 	 Some of the pre-initializations must be made before IDT PCIe-switch
-	 exposes it NT-functions correctly. It should be done by either proper
-	 initialisation of EEPROM connected to master smbus of the switch or
+	 exposes its NT-functions correctly. It should be done by either proper
+	 initialization of EEPROM connected to master SMbus of the switch or
 	 by BIOS using slave-SMBus interface changing corresponding registers
 	 value. Evidently it must be done before PCI bus enumeration is
 	 finished in Linux kernel.


