Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C220C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095DD206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfCYX43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:56:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:43326 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfCYX43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:56:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 16:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="285848205"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga004.jf.intel.com with ESMTP; 25 Mar 2019 16:56:28 -0700
Date:   Mon, 25 Mar 2019 16:56:27 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH] MAINTAINERS: Add entry for EDAC-I10NM
Message-ID: <20190325235627.GA11938@agluck-desk>
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

We forgot to update the MAINTAINERS file when adding this
new driver.

Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server processors")
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5f3230d3f14..86c4a5d95cca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5596,6 +5596,12 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/ghes_edac.c
 
+EDAC-I10NM
+M:	Tony Luck <tony.luck@intel.com>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	drivers/edac/i10nm_base.c
+
 EDAC-I3000
 L:	linux-edac@vger.kernel.org
 S:	Orphan
-- 
2.19.1

