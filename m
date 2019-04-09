Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598D4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F962133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDISh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:37:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:40624 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfDIShY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:37:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 11:37:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,330,1549958400"; 
   d="scan'208";a="141403386"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga007.fm.intel.com with ESMTP; 09 Apr 2019 11:37:23 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 6/6] MAINTAINERS: add maintainer for Intel Stratix10 FW drivers
Date:   Tue,  9 Apr 2019 13:46:02 -0500
Message-Id: <1554835562-25056-7-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554835562-25056-1-git-send-email-richard.gong@linux.intel.com>
References: <1554835562-25056-1-git-send-email-richard.gong@linux.intel.com>
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
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cf3cbf..d7054f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8039,6 +8039,16 @@ S:	Supported
 F:	drivers/infiniband/hw/i40iw/
 F:	include/uapi/rdma/i40iw-abi.h
 
+INTEL STRATIX10 FIRMWARE DRIVERS
+M:	Richard Gong <richard.gong@intel.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/firmware/stratix10*
+F:	include/linux/firmware/intel/
+F:	Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
+F:	Documentation/devicetree/bindings/firmware/intel,stratix10-rsu.txt
+F:	Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
+
 INTEL TELEMETRY DRIVER
 M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
 M:	"David E. Box" <david.e.box@linux.intel.com>
-- 
2.7.4

