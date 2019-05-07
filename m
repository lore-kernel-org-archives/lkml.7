Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA69C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5BB20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfEGShV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:37:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:41336 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfEGShT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:37:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 11:37:18 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2019 11:37:18 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv2 4/4] MAINTAINERS: add maintainer for Intel Stratix10 FW drivers
Date:   Tue,  7 May 2019 13:46:39 -0500
Message-Id: <1557254799-7416-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557254799-7416-1-git-send-email-richard.gong@linux.intel.com>
References: <1557254799-7416-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add myself as maintainer for the newly created Intel Stratix10
firmware drivers.

Signed-off-by: Richard Gong <richard.gong@intel.com>
Reviewed-by: Alan Tull <atull@kernel.org>
---
v2: removed RSU binding text file
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4923dfc..07b8106 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8076,6 +8076,17 @@ S:	Supported
 F:	drivers/infiniband/hw/i40iw/
 F:	include/uapi/rdma/i40iw-abi.h
 
+INTEL STRATIX10 FIRMWARE DRIVERS
+M:	Richard Gong <richard.gong@intel.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/firmware/stratix10-rsu.c
+F:	drivers/firmware/stratix10-svc.c
+F:	include/linux/firmware/intel/stratix10-smc.h
+F:	include/linux/firmware/intel/stratix10-svc-client.h
+F:	Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
+F:	Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
+
 INTEL TELEMETRY DRIVER
 M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
 M:	"David E. Box" <david.e.box@linux.intel.com>
-- 
2.7.4

