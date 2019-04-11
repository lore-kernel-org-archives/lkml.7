Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86062C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E50420873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfDKB67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:58:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:56291 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDKB6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:58:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 18:58:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,335,1549958400"; 
   d="scan'208";a="222426055"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2019 18:58:52 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hEOzL-0001RZ-S3; Thu, 11 Apr 2019 09:58:51 +0800
Date:   Thu, 11 Apr 2019 09:58:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     kbuild-all@01.org, Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH hubcap] orangefs: orangefs_file_open() can be static
Message-ID: <20190411015850.GA10504@lkp-wsm-ep1>
References: <201904110915.9jPFP0Co%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904110915.9jPFP0Co%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 9a959aaffd70 ("orangefs: remember count when reading.")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index d198af9..01d0db6 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -571,7 +571,7 @@ static int orangefs_lock(struct file *filp, int cmd, struct file_lock *fl)
 	return rc;
 }
 
-int orangefs_file_open(struct inode * inode, struct file *file)
+static int orangefs_file_open(struct inode * inode, struct file *file)
 {
 	file->private_data = NULL;
 	return generic_file_open(inode, file);
