Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96466C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7C2217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDKB6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:58:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:21883 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfDKB6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:58:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 18:58:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,335,1549958400"; 
   d="scan'208";a="160133957"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2019 18:58:52 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hEOzL-0001S3-Tt; Thu, 11 Apr 2019 09:58:51 +0800
Date:   Thu, 11 Apr 2019 09:58:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     kbuild-all@01.org, Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Subject: [hubcap:for-next 20/22] fs/orangefs/file.c:574:5: sparse: symbol
 'orangefs_file_open' was not declared. Should it be static?
Message-ID: <201904110915.9jPFP0Co%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux for-next
head:   6055a739910e69f8f76120d48e7ae74a13b1fdda
commit: 9a959aaffd7090810eade53e4d960614405f57c6 [20/22] orangefs: remember count when reading.
reproduce:
        # apt-get install sparse
        git checkout 9a959aaffd7090810eade53e4d960614405f57c6
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> fs/orangefs/file.c:574:5: sparse: symbol 'orangefs_file_open' was not declared. Should it be static?
   fs/orangefs/file.c:580:5: sparse: symbol 'orangefs_flush' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
