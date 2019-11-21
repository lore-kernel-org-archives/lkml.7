Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A57C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143C22089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfKUItV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:49:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:55310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbfKUItU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:49:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 429FEAFAF;
        Thu, 21 Nov 2019 08:49:19 +0000 (UTC)
Date:   Thu, 21 Nov 2019 09:49:18 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] intel_th: pci: Jasper Lake is not a PCH
Message-ID: <20191121094918.6812d54f@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Intel engineering, the Jasper Lake is a SOC not a PCH.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 9d55499d8da4 ("intel_th: pci: Add Jasper Lake PCH support")
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/hwtracing/intel_th/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-5.4-rc7.orig/drivers/hwtracing/intel_th/pci.c	2019-11-15 12:08:16.487157641 +0100
+++ linux-5.4-rc7/drivers/hwtracing/intel_th/pci.c	2019-11-21 09:40:36.189296044 +0100
@@ -215,7 +215,7 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
-		/* Jasper Lake PCH */
+		/* Jasper Lake */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4da6),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},


-- 
Jean Delvare
SUSE L3 Support
