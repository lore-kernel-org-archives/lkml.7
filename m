Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815D5C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C6721775
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLWOSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:18:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:47078 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbfLWORa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="223029914"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2019 06:17:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3CC89DE3; Mon, 23 Dec 2019 16:17:18 +0200 (EET)
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
Subject: [PATCH 23/37] platform/x86: intel_pmc_ipc: Get rid of unnecessary includes
Date:   Mon, 23 Dec 2019 17:17:02 +0300
Message-Id: <20191223141716.13727-24-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point including headers that are not needed in the driver so
drop them.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 83b106f66fa6..8527327d88c7 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -12,23 +12,13 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/atomic.h>
-#include <linux/bitops.h>
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
-#include <linux/pm.h>
-#include <linux/pm_qos.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/suspend.h>
 
 #include <asm/intel_pmc_ipc.h>
 
-- 
2.24.0

