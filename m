Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF00DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E4B2183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfCWREo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:04:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:52349 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfCWREo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:04:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 10:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="155156381"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Mar 2019 10:04:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h7k4X-000H6f-NI; Sun, 24 Mar 2019 01:04:41 +0800
Date:   Sun, 24 Mar 2019 01:04:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH tip] tick: tick_shutdown_broadcast() can be static
Message-ID: <20190323170405.GA45896@lkp-kbuild03>
References: <201903240149.MYxIj3WB%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903240149.MYxIj3WB%lkp@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 973f88ca8b15 ("tick: Remove outgoing CPU from broadcast masks")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 tick-broadcast.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index a470519..7141762 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -438,7 +438,7 @@ void tick_set_periodic_handler(struct clock_event_device *dev, int broadcast)
 /*
  * Remove a CPU from broadcasting
  */
-void tick_shutdown_broadcast(unsigned int cpu)
+static void tick_shutdown_broadcast(unsigned int cpu)
 {
 	struct clock_event_device *bc;
 	unsigned long flags;
