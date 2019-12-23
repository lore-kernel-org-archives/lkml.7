Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9480C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 18:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD15F20643
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 18:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLWSmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:42:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:13784 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfLWSmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 13:42:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 10:42:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,348,1571727600"; 
   d="scan'208";a="268223854"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Dec 2019 10:42:51 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ijSfK-000AEj-IR; Tue, 24 Dec 2019 02:42:50 +0800
Date:   Tue, 24 Dec 2019 02:42:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     kbuild-all@lists.01.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        yixin.zhu@linux.intel.com, qi-ming.wu@intel.com,
        rtanwar <rahul.tanwar@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v2 1/2] clk: intel: Add CGU clock driver for a new SoC
Message-ID: <201912240240.HCfwzN11%lkp@intel.com>
References: <ee8a8a0f0c882e22361895b2663870c8037c422f.1576811332.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee8a8a0f0c882e22361895b2663870c8037c422f.1576811332.git.rahul.tanwar@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on robh/for-next v5.5-rc3 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Rahul-Tanwar/clk-intel-Add-a-new-driver-for-a-new-clock-controller-IP/20191223-110300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/clk/x86/clk-cgu.c:32:32: sparse: sparse: incorrect type in argument 1 (different address spaces)
>> drivers/clk/x86/clk-cgu.c:32:32: sparse:    expected void const volatile [noderef] <asn:2> *addr
>> drivers/clk/x86/clk-cgu.c:32:32: sparse:    got void *
   drivers/clk/x86/clk-cgu.c:34:32: sparse: sparse: incorrect type in argument 2 (different address spaces)
>> drivers/clk/x86/clk-cgu.c:34:32: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/clk/x86/clk-cgu.c:34:32: sparse:    got void *
   drivers/clk/x86/clk-cgu.c:41:29: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:41:29: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/clk/x86/clk-cgu.c:41:29: sparse:    got void *
   drivers/clk/x86/clk-cgu.c:61:36: sparse: sparse: incorrect type in argument 1 (different address spaces)
>> drivers/clk/x86/clk-cgu.c:61:36: sparse:    expected void *membase
>> drivers/clk/x86/clk-cgu.c:61:36: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:78:34: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:78:34: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:78:34: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:91:28: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:91:28: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:91:28: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:155:36: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:155:36: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:155:36: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:170:38: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:170:38: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:170:38: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:202:32: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:202:32: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:202:32: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:260:36: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:260:36: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:260:36: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:282:36: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:282:36: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:282:36: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:307:29: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:307:29: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:307:29: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:333:29: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:333:29: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:333:29: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:354:35: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:354:35: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:354:35: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:409:37: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:409:37: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:409:37: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:466:36: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:466:36: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:466:36: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:468:36: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:468:36: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:468:36: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu.c:470:37: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu.c:470:37: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu.c:470:37: sparse:    got void [noderef] <asn:2> *membase
--
>> drivers/clk/x86/clk-cgu-pll.c:49:42: sparse: sparse: incorrect type in argument 1 (different address spaces)
>> drivers/clk/x86/clk-cgu-pll.c:49:42: sparse:    expected void *membase
>> drivers/clk/x86/clk-cgu-pll.c:49:42: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu-pll.c:69:36: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu-pll.c:69:36: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu-pll.c:69:36: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu-pll.c:70:35: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu-pll.c:70:35: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu-pll.c:70:35: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu-pll.c:71:36: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu-pll.c:71:36: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu-pll.c:71:36: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu-pll.c:94:34: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu-pll.c:94:34: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu-pll.c:94:34: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu-pll.c:106:28: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu-pll.c:106:28: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu-pll.c:106:28: sparse:    got void [noderef] <asn:2> *membase
   drivers/clk/x86/clk-cgu-pll.c:118:28: sparse: sparse: incorrect type in argument 1 (different address spaces)
   drivers/clk/x86/clk-cgu-pll.c:118:28: sparse:    expected void *membase
   drivers/clk/x86/clk-cgu-pll.c:118:28: sparse:    got void [noderef] <asn:2> *membase

vim +32 drivers/clk/x86/clk-cgu.c

    25	
    26	void lgm_set_clk_val(void *membase, u32 reg,
    27			     u8 shift, u8 width, u32 set_val)
    28	{
    29		u32 mask = (GENMASK(width - 1, 0) << shift);
    30		u32 regval;
    31	
  > 32		regval = readl(membase + reg);
    33		regval = (regval & ~mask) | ((set_val << shift) & mask);
  > 34		writel(regval, membase + reg);
    35	}
    36	
    37	u32 lgm_get_clk_val(void *membase, u32 reg, u8 shift, u8 width)
    38	{
    39		u32 val;
    40	
    41		val = readl(membase + reg);
    42		val = (val >> shift) & (BIT(width) - 1);
    43	
    44		return val;
    45	}
    46	
    47	void lgm_clk_add_lookup(struct lgm_clk_provider *ctx,
    48				struct clk_hw *hw, unsigned int id)
    49	{
    50		if (ctx->clk_data.hws)
    51			ctx->clk_data.hws[id] = hw;
    52	}
    53	
    54	static struct clk_hw *lgm_clk_register_fixed(struct lgm_clk_provider *ctx,
    55						     const struct lgm_clk_branch *list)
    56	{
    57		unsigned long flags;
    58	
    59		if (list->div_flags & CLOCK_FLAG_VAL_INIT) {
    60			raw_spin_lock_irqsave(&ctx->lock, flags);
  > 61			lgm_set_clk_val(ctx->membase, list->div_off, list->div_shift,
    62					list->div_width, list->div_val);
    63			raw_spin_unlock_irqrestore(&ctx->lock, flags);
    64		}
    65	
    66		return clk_hw_register_fixed_rate(NULL, list->name,
    67						  list->parent_names[0],
    68						  list->flags, list->mux_flags);
    69	}
    70	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
