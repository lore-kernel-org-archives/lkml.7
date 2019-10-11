Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00B5C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878DD20659
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfJKHVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:21:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:3576 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfJKHU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:20:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 00:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,283,1566889200"; 
   d="gz'50?scan'50,208,50";a="198622433"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Oct 2019 00:20:53 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iIpEL-000HTv-7P; Fri, 11 Oct 2019 15:20:53 +0800
Date:   Fri, 11 Oct 2019 15:20:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@01.org, Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] dma-mapping: Move vmap address checks into
 dma_map_single()
Message-ID: <201910111445.5ygljXYD%lkp@intel.com>
References: <201910041420.F6E55D29A@keescook>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6ulkzfufowhnpquo"
Content-Disposition: inline
In-Reply-To: <201910041420.F6E55D29A@keescook>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ulkzfufowhnpquo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kees,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.4-rc2 next-20191010]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Kees-Cook/dma-mapping-Move-vmap-address-checks-into-dma_map_single/20191005-073954
config: sh-magicpanelr2_defconfig (attached as .config)
compiler: sh4-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=sh 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/sh/include/asm/bug.h:112:0,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sh/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from arch/sh/kernel/io.c:8:
   include/linux/dma-mapping.h: In function 'dma_map_single_attrs':
>> include/linux/dma-mapping.h:588:9: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
            "%s %s: driver maps %lu bytes from vmalloc area\n",
            ^
   include/asm-generic/bug.h:92:17: note: in definition of macro '__WARN_printf'
      __warn_printk(arg);     \
                    ^~~
   include/asm-generic/bug.h:155:3: note: in expansion of macro 'WARN'
      WARN(1, format);    \
      ^~~~
   include/linux/dma-mapping.h:587:6: note: in expansion of macro 'WARN_ONCE'
     if (WARN_ONCE(is_vmalloc_addr(ptr),
         ^~~~~~~~~
   cc1: all warnings being treated as errors

vim +588 include/linux/dma-mapping.h

   582	
   583	static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
   584			size_t size, enum dma_data_direction dir, unsigned long attrs)
   585	{
   586		/* DMA must never operate on areas that might be remapped. */
   587		if (WARN_ONCE(is_vmalloc_addr(ptr),
 > 588			      "%s %s: driver maps %lu bytes from vmalloc area\n",
   589			      dev ? dev_driver_string(dev) : "unknown driver",
   590			      dev ? dev_name(dev) : "unknown device", size))
   591			return DMA_MAPPING_ERROR;
   592	
   593		debug_dma_map_single(dev, ptr, size);
   594		return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
   595				size, dir, attrs);
   596	}
   597	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--6ulkzfufowhnpquo
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
P+uxEPVwhFwVQC1n/S8i6LiuFMMAAA==

--6ulkzfufowhnpquo--
