Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E4C31E40
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 01:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3523A20644
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 01:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfGNBjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 21:39:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:7026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbfGNBjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 21:39:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 18:38:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,488,1557212400"; 
   d="scan'208";a="160755606"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2019 18:38:58 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hmTTd-000Hn6-Jc; Sun, 14 Jul 2019 09:38:57 +0800
Date:   Sun, 14 Jul 2019 09:38:28 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: net/netfilter/nf_tables_offload.c:135:24: sparse: sparse: incorrect
 type in initializer (different base types)
Message-ID: <201907140924.FU3ZJx4p%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a2d79c7174aeb43b13020dd53d85a7aefdd9f3e5
commit: c9626a2cbdb20e26587b3fad99960520a023432b netfilter: nf_tables: add hardware offload support
date:   4 days ago
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout c9626a2cbdb20e26587b3fad99960520a023432b
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> net/netfilter/nf_tables_offload.c:135:24: sparse: sparse: incorrect type in initializer (different base types) @@    expected restricted __be16 [usertype] proto @@    got e] proto @@
>> net/netfilter/nf_tables_offload.c:135:24: sparse:    expected restricted __be16 [usertype] proto
>> net/netfilter/nf_tables_offload.c:135:24: sparse:    got int

vim +135 net/netfilter/nf_tables_offload.c

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
