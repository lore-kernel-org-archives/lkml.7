Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FB82075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfCYXeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:34:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:11261 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfCYXeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:34:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 16:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="155123325"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2019 16:34:17 -0700
Date:   Mon, 25 Mar 2019 16:34:17 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-edac@vger.kernel.org, Borislav Petkov <bp@amd64.org>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] MAINTAINERS: Fix file pattern for X86 MCE INFRASTRUCTURE
Message-ID: <20190325233416.GB8869@agluck-desk>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212811.27961-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325212811.27961-1-joe@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code restructuring renamed arch/x86/kernel/cpu/mcheck/ to
be arch/x86/kernel/cpu/mce/

Update the MAINTAINERS file pattern to account for this change.

Fixes: 21afaf181362 ("x86/mce: Streamline MCE subsystem's naming")
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 384a70f01dc4..e5f3230d3f14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16920,7 +16920,7 @@ M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
-F:	arch/x86/kernel/cpu/mcheck/*
+F:	arch/x86/kernel/cpu/mce/*
 
 X86 MICROCODE UPDATE SUPPORT
 M:	Borislav Petkov <bp@alien8.de>
-- 
2.19.1

