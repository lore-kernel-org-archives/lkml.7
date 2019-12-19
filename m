Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B1824672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLSOaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:30:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:35948 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfLSOaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:30:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 06:30:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,332,1571727600"; 
   d="scan'208";a="248336325"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga002.fm.intel.com with ESMTP; 19 Dec 2019 06:30:09 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2] turbostat: add support for Icelake server
Date:   Thu, 19 Dec 2019 22:29:18 +0800
Message-Id: <20191219142918.10021-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the code of Skylake server for Icelake server.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 520cd486e5a4..6876305f9e19 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4620,6 +4620,9 @@ unsigned int intel_model_duplicates(unsigned int model)
 
 	case INTEL_FAM6_ATOM_TREMONT_D:
 		return INTEL_FAM6_ATOM_GOLDMONT_D;
+
+	case INTEL_FAM6_ICELAKE_X:
+		return INTEL_FAM6_SKYLAKE_X;
 	}
 	return model;
 }
-- 
2.17.1

