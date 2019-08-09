Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E2C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BD22171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406346AbfHIKUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:20:41 -0400
Received: from foss.arm.com ([217.140.110.172]:44996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfHIKUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:20:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5C341596;
        Fri,  9 Aug 2019 03:20:40 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1BB8B3F575;
        Fri,  9 Aug 2019 03:20:40 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, kbuild test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] htmldocs: device.h: Fix warnings for mismatched parameter names in comments
Date:   Fri,  9 Aug 2019 11:20:33 +0100
Message-Id: <20190809102033.28463-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warnings for parameter named as "driver" instead of the actual "drv"
in the comments as reported by the kbuild robot.

Reported-by:  kbuild test robot <lkp@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Greg,

Sorry about these silly typos. Applies on linux-next.
---
---
 include/linux/device.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 41d7ed091029..76496497e753 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -479,7 +479,7 @@ struct device *driver_find_device(struct device_driver *drv,
 /**
  * driver_find_device_by_name - device iterator for locating a particular device
  * of a specific name.
- * @driver: the driver we're iterating
+ * @drv: the driver we're iterating
  * @name: name of the device to match
  */
 static inline struct device *driver_find_device_by_name(struct device_driver *drv,
@@ -491,7 +491,7 @@ static inline struct device *driver_find_device_by_name(struct device_driver *dr
 /**
  * driver_find_device_by_of_node- device iterator for locating a particular device
  * by of_node pointer.
- * @driver: the driver we're iterating
+ * @drv: the driver we're iterating
  * @np: of_node pointer to match.
  */
 static inline struct device *
@@ -504,7 +504,7 @@ driver_find_device_by_of_node(struct device_driver *drv,
 /**
  * driver_find_device_by_fwnode- device iterator for locating a particular device
  * by fwnode pointer.
- * @driver: the driver we're iterating
+ * @drv: the driver we're iterating
  * @fwnode: fwnode pointer to match.
  */
 static inline struct device *
@@ -536,7 +536,7 @@ static inline struct device *driver_find_next_device(struct device_driver *drv,
 /**
  * driver_find_device_by_acpi_dev : device iterator for locating a particular
  * device matching the ACPI_COMPANION device.
- * @driver: the driver we're iterating
+ * @drv: the driver we're iterating
  * @adev: ACPI_COMPANION device to match.
  */
 static inline struct device *
-- 
2.21.0

