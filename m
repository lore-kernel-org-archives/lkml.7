Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBB5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A880C208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbfJ1HHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:07:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:19783 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732301AbfJ1HH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:07:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 00:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="205111265"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2019 00:07:24 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        stable@vger.kernel.org
Subject: [GIT PULL 6/7] intel_th: pci: Add Comet Lake PCH support
Date:   Mon, 28 Oct 2019 09:06:50 +0200
Message-Id: <20191028070651.9770-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
References: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for Intel TH on Comet Lake PCH.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 91dfeba62485..4088e1865b07 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -199,6 +199,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x02a6),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Comet Lake PCH */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x06a6),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Ice Lake NNPI */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x45c5),
-- 
2.23.0

