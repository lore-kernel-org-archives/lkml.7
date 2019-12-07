Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C976C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 06:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5494121835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 06:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfLGGUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 01:20:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:55242 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfLGGUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 01:20:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 22:20:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,286,1571727600"; 
   d="gz'50?scan'50,208,50";a="263774259"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Dec 2019 22:20:12 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1idTRr-0009qV-Rl; Sat, 07 Dec 2019 14:20:11 +0800
Date:   Sat, 7 Dec 2019 14:19:57 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: undefined reference to `compat_sys_setitimer'
Message-ID: <201912071456.kxVAUCA7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wmtzcl4pnelndvoa"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wmtzcl4pnelndvoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eea2d5da29e396b6cc1fb35e36bcbf5f57731015
commit: 4c22ea2b91203564fdf392b3d3cae249b652a8ae y2038: use compat_{get,set}_itimer on alpha
date:   3 weeks ago
config: alpha-allnoconfig (attached as .config)
compiler: alpha-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4c22ea2b91203564fdf392b3d3cae249b652a8ae
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/alpha/kernel/systbls.o: In function `sys_call_table':
>> (.data+0x298): undefined reference to `compat_sys_setitimer'
>> (.data+0x2b0): undefined reference to `compat_sys_getitimer'

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--wmtzcl4pnelndvoa
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
nXQY1xnk+L91cMwqfUoAAA==

--wmtzcl4pnelndvoa--
