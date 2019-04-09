Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5A0C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFDA20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDILZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:25:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:47677 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfDILZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:25:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 04:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="290005141"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 09 Apr 2019 04:25:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CBE8CFA; Tue,  9 Apr 2019 14:25:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        junxiao.chang@intel.com, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] platform/x86: intel_pmc_ipc: Apply same width for offset definitions
Date:   Tue,  9 Apr 2019 14:25:13 +0300
Message-Id: <20190409112515.84725-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409112515.84725-1-andriy.shevchenko@linux.intel.com>
References: <20190409112515.84725-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply same width for offset definitions to make code more consistent.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index eb0b342996ca..9007aa717586 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -40,7 +40,7 @@
  * The ARC handles the interrupt and services it, writing optional data to
  * the IPC1 registers, updates the IPC_STS response register with the status.
  */
-#define IPC_CMD			0x0
+#define IPC_CMD			0x00
 #define		IPC_CMD_MSI		BIT(8)
 #define		IPC_CMD_SIZE		16
 #define		IPC_CMD_SUBCMD		12
@@ -101,8 +101,8 @@
 #define TELEM_SSRAM_SIZE		240
 #define TELEM_PMC_SSRAM_OFFSET		0x1B00
 #define TELEM_PUNIT_SSRAM_OFFSET	0x1A00
-#define TCO_PMC_OFFSET			0x8
-#define TCO_PMC_SIZE			0x4
+#define TCO_PMC_OFFSET			0x08
+#define TCO_PMC_SIZE			0x04
 
 /* PMC register bit definitions */
 
-- 
2.20.1

