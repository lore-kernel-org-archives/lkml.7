Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B8DC4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195A120650
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfIPInS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:43:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:55326 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731218AbfIPInR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:43:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 01:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="gz'50?scan'50,208,50";a="211085290"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2019 01:43:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i9mbI-000DXj-VE; Mon, 16 Sep 2019 16:43:12 +0800
Date:   Mon, 16 Sep 2019 16:43:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     kbuild-all@01.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        x86@vger.kernel.org, linux@rasmusvillemoes.dk,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] x86_64: new and improved memset()
Message-ID: <201909161637.hjotmWPv%lkp@intel.com>
References: <20190914103345.GA5856@avx2>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6npewlc4hyjrxtgx"
Content-Disposition: inline
In-Reply-To: <20190914103345.GA5856@avx2>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6npewlc4hyjrxtgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexey,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3 next-20190915]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexey-Dobriyan/x86_64-new-and-improved-memset/20190916-140315
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/um/kernel/mem.o: in function `pgd_alloc':
>> mem.c:(.text+0x4a): undefined reference to `memset0_mov'
   /usr/bin/ld: arch/um/kernel/mem.o: in function `pmd_alloc_one':
>> mem.c:(.text+0xd1): undefined reference to `_memset0_mov'
   /usr/bin/ld: arch/um/kernel/mem.o: in function `mem_init':
>> mem.c:(.init.text+0x20): undefined reference to `_memset0_mov'
>> /usr/bin/ld: arch/um/kernel/mem.o:(.altinstr_replacement+0x1): undefined reference to `_memset0_rep_stosq'
>> /usr/bin/ld: arch/um/kernel/mem.o:(.altinstr_replacement+0x6): undefined reference to `memset0_rep_stosb'
>> /usr/bin/ld: arch/um/kernel/mem.o:(.altinstr_replacement+0xb): undefined reference to `memset0_rep_stosq'
   /usr/bin/ld: arch/um/kernel/mem.o:(.altinstr_replacement+0x10): undefined reference to `memset0_rep_stosb'
   /usr/bin/ld: arch/um/kernel/mem.o:(.altinstr_replacement+0x15): undefined reference to `_memset0_rep_stosq'
   /usr/bin/ld: arch/um/kernel/mem.o:(.altinstr_replacement+0x1a): undefined reference to `memset0_rep_stosb'
   /usr/bin/ld: arch/um/kernel/process.o: in function `copy_from_user_proc':
>> process.c:(.text+0x665): undefined reference to `memset0_mov'
   /usr/bin/ld: arch/um/kernel/process.o: in function `sysemu_proc_write':
   process.c:(.text+0x76a): undefined reference to `memset0_mov'
>> /usr/bin/ld: arch/um/kernel/process.o:(.altinstr_replacement+0x1): undefined reference to `memset0_rep_stosq'
>> /usr/bin/ld: arch/um/kernel/process.o:(.altinstr_replacement+0x6): undefined reference to `memset0_rep_stosb'
   /usr/bin/ld: arch/um/kernel/process.o:(.altinstr_replacement+0xb): undefined reference to `memset0_rep_stosq'
   /usr/bin/ld: arch/um/kernel/process.o:(.altinstr_replacement+0x10): undefined reference to `memset0_rep_stosb'
   /usr/bin/ld: arch/um/drivers/net_kern.o: in function `eth_configure':
>> net_kern.c:(.text+0xbd0): undefined reference to `memset0_mov'
>> /usr/bin/ld: arch/um/drivers/net_kern.o:(.altinstr_replacement+0x1): undefined reference to `memset0_rep_stosq'
>> /usr/bin/ld: arch/um/drivers/net_kern.o:(.altinstr_replacement+0x6): undefined reference to `memset0_rep_stosb'
   /usr/bin/ld: arch/um/drivers/ubd_kern.o: in function `ubd_ioctl':
>> ubd_kern.c:(.text+0x984): undefined reference to `_memset0_mov'
>> /usr/bin/ld: ubd_kern.c:(.text+0xa5a): undefined reference to `memset0_mov'
   /usr/bin/ld: arch/um/drivers/ubd_kern.o: in function `io_thread':
>> ubd_kern.c:(.text+0x211f): undefined reference to `memset0_mov'
>> /usr/bin/ld: arch/um/drivers/ubd_kern.o:(.altinstr_replacement+0x1): undefined reference to `_memset0_rep_stosq'
>> /usr/bin/ld: arch/um/drivers/ubd_kern.o:(.altinstr_replacement+0x6): undefined reference to `memset0_rep_stosb'
>> /usr/bin/ld: arch/um/drivers/ubd_kern.o:(.altinstr_replacement+0xb): undefined reference to `memset0_rep_stosq'
   /usr/bin/ld: arch/um/drivers/ubd_kern.o:(.altinstr_replacement+0x10): undefined reference to `memset0_rep_stosb'
   /usr/bin/ld: arch/um/drivers/ubd_kern.o:(.altinstr_replacement+0x15): undefined reference to `memset0_rep_stosq'
   /usr/bin/ld: arch/um/drivers/ubd_kern.o:(.altinstr_replacement+0x1a): undefined reference to `memset0_rep_stosb'
   /usr/bin/ld: kernel/fork.o: in function `copy_clone_args_from_user':
>> fork.c:(.text+0x5c4): undefined reference to `memset0_mov'
   /usr/bin/ld: kernel/fork.o: in function `mm_init.isra.5':
>> fork.c:(.text+0x75c): undefined reference to `_memset0_mov'
   /usr/bin/ld: kernel/fork.o: in function `vm_area_alloc':
   fork.c:(.text+0xaa4): undefined reference to `_memset0_mov'
   /usr/bin/ld: kernel/fork.o: in function `mm_alloc':
   fork.c:(.text+0xb9f): undefined reference to `_memset0_mov'
   /usr/bin/ld: kernel/fork.o: in function `copy_process':
   fork.c:(.text+0x1e0c): undefined reference to `_memset0_mov'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--6npewlc4hyjrxtgx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6npewlc4hyjrxtgx--
