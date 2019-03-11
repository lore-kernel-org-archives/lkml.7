Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FC2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385662087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfCKVSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:18:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:30404 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbfCKVSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:18:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 14:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="151382954"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2019 14:18:30 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>
Subject: [char-misc 4/5] mei/hdcp: Fix SPDX identifiers
Date:   Tue, 12 Mar 2019 00:10:43 +0200
Message-Id: <20190311221044.17623-5-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311221044.17623-1-tomas.winkler@intel.com>
References: <20190311221044.17623-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Remove redundant parentheses around single license
2. Fix the license to GPL-2.0 and not GPL-2.0+ in mei_hdcp.h

Cc: Ramalingam C <ramalingam.c@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
 drivers/misc/mei/hdcp/mei_hdcp.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index 90b6ae8e9dae..b07000202d4a 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0)
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright © 2019 Intel Corporation
  *
diff --git a/drivers/misc/mei/hdcp/mei_hdcp.h b/drivers/misc/mei/hdcp/mei_hdcp.h
index 5f74b908e486..e4b1cd54c853 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.h
+++ b/drivers/misc/mei/hdcp/mei_hdcp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+) */
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright © 2019 Intel Corporation
  *
-- 
2.20.1

