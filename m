Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9DCCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02C52087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfJ2JoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:44:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:24181 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfJ2JoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:44:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="211071508"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2019 02:44:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 09E5BF3; Tue, 29 Oct 2019 11:44:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: Add Intel Comet Lake PCH-H PCI IDs
Date:   Tue, 29 Oct 2019 11:44:09 +0200
Message-Id: <20191029094409.43741-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Comet Lake PCH-H has the same LPSS than Intel Cannon Lake.
Add the new IDs to the list of supported devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 9355db29d2f9..6a7bfa2ab06d 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -128,7 +128,7 @@ static const struct intel_lpss_platform_info cnl_i2c_info = {
 };
 
 static const struct pci_device_id intel_lpss_pci_ids[] = {
-	/* CML */
+	/* CML-LP */
 	{ PCI_VDEVICE(INTEL, 0x02a8), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x02a9), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x02aa), (kernel_ulong_t)&spt_info },
@@ -141,6 +141,17 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x02ea), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x02eb), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x02fb), (kernel_ulong_t)&spt_info },
+	/* CML-H */
+	{ PCI_VDEVICE(INTEL, 0x06a8), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x06a9), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x06aa), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x06ab), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x06c7), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x06e8), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x06e9), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x06ea), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x06eb), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x06fb), (kernel_ulong_t)&spt_info },
 	/* BXT A-Step */
 	{ PCI_VDEVICE(INTEL, 0x0aac), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x0aae), (kernel_ulong_t)&bxt_i2c_info },
-- 
2.23.0

