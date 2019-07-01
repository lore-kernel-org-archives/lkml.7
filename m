Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732D2C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF2020663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfGAGz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:55:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:53181 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfGAGz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:55:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2019 23:54:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,437,1557212400"; 
   d="scan'208";a="165254995"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2019 23:54:00 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, atull@kernel.org,
        gregkh@linuxfoundation.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v5 1/3] Documentation: fpga: dfl: add descriptions for thermal/power management interfaces
Date:   Mon,  1 Jul 2019 14:37:05 +0800
Message-Id: <1561963027-4213-2-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561963027-4213-1-git-send-email-hao.wu@intel.com>
References: <1561963027-4213-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Yilun <yilun.xu@intel.com>

This patch add introductions to thermal/power interfaces. They are
implemented as hwmon sysfs interfaces by thermal/power private
feature drivers.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v5: rebase due to dfl.txt -> dfl.rst
---
 Documentation/fpga/dfl.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 6fa483f..094fc8a 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -108,6 +108,16 @@ More functions are exposed through sysfs
      error reporting sysfs interfaces allow user to read errors detected by the
      hardware, and clear the logged errors.
 
+ Power management (dfl_fme_power hwmon)
+     power management hwmon sysfs interfaces allow user to read power management
+     information (power consumption, thresholds, threshold status, limits, etc.)
+     and configure power thresholds for different throttling levels.
+
+ Thermal management (dfl_fme_thermal hwmon)
+     thermal management hwmon sysfs interfaces allow user to read thermal
+     management information (current temperature, thresholds, threshold status,
+     etc.).
+
 
 FIU - PORT
 ==========
-- 
1.8.3.1

