Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D356C2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F322A20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfLWORl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:17:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:47069 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfLWORc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="417276281"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Dec 2019 06:17:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C0540BF0; Mon, 23 Dec 2019 16:17:18 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 37/37] MAINTAINERS: Update entry for Intel Broxton PMC driver
Date:   Mon, 23 Dec 2019 17:17:16 +0300
Message-Id: <20191223141716.13727-38-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver lives now under MFD so split the current entry into two parts
and add me as co-maintainer of the Intel Broxton PMC driver. While there
correct formatting of Zha Qipeng's email address.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 MAINTAINERS | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffa3371bc750..939a86db2f34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8277,6 +8277,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel_atomisp2_pm.c
 
+INTEL BROXTON PMC DRIVER
+M:	Mika Westerberg <mika.westerberg@linux.intel.com>
+M:	Zha Qipeng <qipeng.zha@intel.com>
+S:	Maintained
+F:	drivers/mfd/intel_pmc_bxt.c
+F:	include/linux/mfd/intel_pmc_bxt.h
+
 INTEL C600 SERIES SAS CONTROLLER DRIVER
 M:	Intel SCU Linux support <intel-linux-scu@intel.com>
 M:	Artur Paszkiewicz <artur.paszkiewicz@intel.com>
@@ -8485,13 +8492,11 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel_pmc_core*
 
-INTEL PMC/P-Unit IPC DRIVER
-M:	Zha Qipeng<qipeng.zha@intel.com>
+INTEL P-Unit IPC DRIVER
+M:	Zha Qipeng <qipeng.zha@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/intel_pmc_ipc.c
 F:	drivers/platform/x86/intel_punit_ipc.c
-F:	arch/x86/include/asm/intel_pmc_ipc.h
 F:	arch/x86/include/asm/intel_punit_ipc.h
 
 INTEL PMIC GPIO DRIVERS
-- 
2.24.0

