Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A49FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 01:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B66A207E0
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 01:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfL1BY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 20:24:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:41107 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfL1BYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 20:24:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 17:24:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,365,1571727600"; 
   d="scan'208";a="300782392"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2019 17:24:22 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1il0q6-000CXw-9T; Sat, 28 Dec 2019 09:24:22 +0800
Date:   Sat, 28 Dec 2019 09:24:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     kbuild-all@lists.01.org, vkoul@kernel.org,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        Gary.Hook@amd.com, Nehal-bakulchandra.Shah@amd.com,
        Shyam-sundar.S-k@amd.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [RFC PATCH] dmaengine: ptdma: pt_present() can be static
Message-ID: <20191228012413.rinqeaetsufcwdkf@4978f4969bb8>
References: <1577458112-109734-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577458112-109734-1-git-send-email-Sanju.Mehta@amd.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: ea65c60183d6 ("dmaengine: ptdma: Add debugfs entries for PTDMA information")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ptdma-dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index 1cb47bbdbd3e1..6df0d5049aa26 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -136,7 +136,7 @@ static void pt_del_device(struct pt_device *pt)
  *
  * Returns zero if a PTDMA device is present, -ENODEV otherwise.
  */
-int pt_present(void)
+static int pt_present(void)
 {
 	unsigned long flags;
 	int ret;
