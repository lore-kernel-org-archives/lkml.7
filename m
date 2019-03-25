Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB03C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EEC2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfCYX3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:29:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:56887 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfCYX3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:29:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 16:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="155733199"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2019 16:29:33 -0700
Date:   Mon, 25 Mar 2019 16:29:33 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH] MAINTAINERS: Update entry for EDAC-SKYLAKE
Message-ID: <20190325232932.GA8869@agluck-desk>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212506.26282-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325212506.26282-1-joe@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code refactoring to share some source code with a new
EDAC driver resulted in renaming one file (skx_edac.c
became skx_base.c) and adding a new file (skx_common.c).

Update the file pattern in MAINTAINERS to take account of
this change.

Reported-by: Joe Perches <joe@perches.com>
Fixes: 98f2fc829e3b ("EDAC, skx_edac: Delete duplicated code")
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..384a70f01dc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5677,7 +5677,7 @@ EDAC-SKYLAKE
 M:	Tony Luck <tony.luck@intel.com>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
-F:	drivers/edac/skx_edac.c
+F:	drivers/edac/skx_*.c
 
 EDAC-TI
 M:	Tero Kristo <t-kristo@ti.com>
-- 
2.19.1

