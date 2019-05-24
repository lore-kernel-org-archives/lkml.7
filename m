Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D85C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734D821848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfEXSNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:13:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:5504 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfEXSNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:13:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 11:13:46 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2019 11:13:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 74736146; Fri, 24 May 2019 21:13:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: Keep device tables sorted by ID
Date:   Fri, 24 May 2019 21:13:44 +0300
Message-Id: <20190524181344.70653-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Easier to find and maintain if the device tables sorted by ID.
Do it here for intel-lpss MFD driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 417569482481..40490a822c4c 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -186,10 +186,10 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x31bc), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x31be), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x31c0), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x31ee), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x31c2), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x31c4), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x31c6), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x31ee), (kernel_ulong_t)&bxt_uart_info },
 	/* ICL-LP */
 	{ PCI_VDEVICE(INTEL, 0x34a8), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x34a9), (kernel_ulong_t)&spt_uart_info },
@@ -236,7 +236,6 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x9da9), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x9daa), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0x9dab), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0x9dfb), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0x9dc5), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9dc6), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9dc7), (kernel_ulong_t)&spt_uart_info },
@@ -244,6 +243,7 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x9de9), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9dea), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9deb), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9dfb), (kernel_ulong_t)&spt_info },
 	/* SPT-H */
 	{ PCI_VDEVICE(INTEL, 0xa127), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa128), (kernel_ulong_t)&spt_uart_info },
@@ -268,12 +268,12 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa329), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa32a), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0xa32b), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0xa37b), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0xa347), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa368), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa369), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa36a), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa36b), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa37b), (kernel_ulong_t)&spt_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);
-- 
2.20.1

