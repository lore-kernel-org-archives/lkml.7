Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BECFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 18:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F3920715
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 18:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfK1S5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 13:57:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:6691 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfK1S5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 13:57:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 10:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,254,1571727600"; 
   d="gz'50?scan'50,208,50";a="207247634"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2019 10:57:50 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iaOz6-0001Xa-Vn; Fri, 29 Nov 2019 02:57:48 +0800
Date:   Fri, 29 Nov 2019 02:56:38 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:WIP.x86/mm 32/33] percpu.c:undefined reference to
 `is_vmalloc_addr'
Message-ID: <201911290224.2T3sN6OH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4grsm6tn4rgnlum4"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4grsm6tn4rgnlum4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/mm
head:   7ccd25bd603f0d08a967467f8d676e2263382506
commit: 7acc8323e483d980de07ff2e4c4906cc3e77d59c [32/33] mm, x86/mm: Untangle address space layout definitions from basic pgtable type definitions
config: c6x-evmc6678_defconfig (attached as .config)
compiler: c6x-elf-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7acc8323e483d980de07ff2e4c4906cc3e77d59c
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=c6x 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/percpu.o: In function `per_cpu_ptr_to_phys':
>> percpu.c:(.text+0x2760): undefined reference to `is_vmalloc_addr'
   block/bio.o: In function `bio_map_kern':
>> bio.c:(.text+0x2d88): undefined reference to `is_vmalloc_addr'
   kernel/iomem.o: In function `memunmap':
>> iomem.c:(.text+0x14): undefined reference to `is_vmalloc_addr'
   kernel/iomem.o: In function `devm_memremap_release':
   iomem.c:(.text+0x30): undefined reference to `is_vmalloc_addr'
   mm/util.o: In function `kvfree':
>> util.c:(.text+0x774): undefined reference to `is_vmalloc_addr'

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--4grsm6tn4rgnlum4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
uMAIM5RUAAA=

--4grsm6tn4rgnlum4--
