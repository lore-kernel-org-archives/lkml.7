Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDD7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD85C2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfEVX0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 19:26:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:26137 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbfEVX03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 19:26:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 16:26:25 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 16:26:23 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hTacp-000C1k-0h; Thu, 23 May 2019 07:26:23 +0800
Date:   Thu, 23 May 2019 07:25:45 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: sound/soc/intel/skylake/skl-ssp-clk.c:18:25: note: in expansion of
 macro 'container_of'
Message-ID: <201905230743.eZYM5EBi%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   54dee406374ce8adb352c48e175176247cb8db7c
commit: 164a263bf8d003e4cbb197d52b74d26df72604d7 ASoC: Intel: Make boards more available for compile test
date:   3 weeks ago
config: ia64-allyesconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 164a263bf8d003e4cbb197d52b74d26df72604d7
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/intel/skylake/skl-ssp-clk.c:26:16: error: field 'hw' has incomplete type
     struct clk_hw hw;
                   ^~
   In file included from include/linux/kernel.h:11:0,
                    from sound/soc/intel/skylake/skl-ssp-clk.c:8:
   sound/soc/intel/skylake/skl-ssp-clk.c: In function 'skl_clk_prepare':
   include/linux/kernel.h:979:32: error: dereferencing pointer to incomplete type 'struct clk_hw'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                   ^~~~~~
   include/linux/compiler.h:324:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler.h:344:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:979:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:979:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
>> sound/soc/intel/skylake/skl-ssp-clk.c:18:25: note: in expansion of macro 'container_of'
    #define to_skl_clk(_hw) container_of(_hw, struct skl_clk, hw)
                            ^~~~~~~~~~~~
>> sound/soc/intel/skylake/skl-ssp-clk.c:201:27: note: in expansion of macro 'to_skl_clk'
     struct skl_clk *clkdev = to_skl_clk(hw);
                              ^~~~~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c: At top level:
   sound/soc/intel/skylake/skl-ssp-clk.c:260:21: error: variable 'skl_clk_ops' has initializer but incomplete type
    static const struct clk_ops skl_clk_ops = {
                        ^~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:261:3: error: 'const struct clk_ops' has no member named 'prepare'
     .prepare = skl_clk_prepare,
      ^~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:261:13: warning: excess elements in struct initializer
     .prepare = skl_clk_prepare,
                ^~~~~~~~~~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:261:13: note: (near initialization for 'skl_clk_ops')
   sound/soc/intel/skylake/skl-ssp-clk.c:262:3: error: 'const struct clk_ops' has no member named 'unprepare'
     .unprepare = skl_clk_unprepare,
      ^~~~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:262:15: warning: excess elements in struct initializer
     .unprepare = skl_clk_unprepare,
                  ^~~~~~~~~~~~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:262:15: note: (near initialization for 'skl_clk_ops')
   sound/soc/intel/skylake/skl-ssp-clk.c:263:3: error: 'const struct clk_ops' has no member named 'set_rate'
     .set_rate = skl_clk_set_rate,
      ^~~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:263:14: warning: excess elements in struct initializer
     .set_rate = skl_clk_set_rate,
                 ^~~~~~~~~~~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:263:14: note: (near initialization for 'skl_clk_ops')
   sound/soc/intel/skylake/skl-ssp-clk.c:264:3: error: 'const struct clk_ops' has no member named 'round_rate'
     .round_rate = skl_clk_round_rate,
      ^~~~~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:264:16: warning: excess elements in struct initializer
     .round_rate = skl_clk_round_rate,
                   ^~~~~~~~~~~~~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:264:16: note: (near initialization for 'skl_clk_ops')
   sound/soc/intel/skylake/skl-ssp-clk.c:265:3: error: 'const struct clk_ops' has no member named 'recalc_rate'
     .recalc_rate = skl_clk_recalc_rate,
      ^~~~~~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:265:17: warning: excess elements in struct initializer
     .recalc_rate = skl_clk_recalc_rate,
                    ^~~~~~~~~~~~~~~~~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:265:17: note: (near initialization for 'skl_clk_ops')
   sound/soc/intel/skylake/skl-ssp-clk.c: In function 'unregister_parent_src_clk':
   sound/soc/intel/skylake/skl-ssp-clk.c:273:3: error: implicit declaration of function 'clk_hw_unregister_fixed_rate'; did you mean 'clk_hw_register_clkdev'? [-Werror=implicit-function-declaration]
      clk_hw_unregister_fixed_rate(pclk[id].hw);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      clk_hw_register_clkdev
   sound/soc/intel/skylake/skl-ssp-clk.c: In function 'skl_register_parent_clks':
   sound/soc/intel/skylake/skl-ssp-clk.c:294:18: error: implicit declaration of function 'clk_hw_register_fixed_rate'; did you mean 'clk_hw_register_clkdev'? [-Werror=implicit-function-declaration]
      parent[i].hw = clk_hw_register_fixed_rate(dev, pclk[i].name,
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
                     clk_hw_register_clkdev
>> sound/soc/intel/skylake/skl-ssp-clk.c:294:16: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      parent[i].hw = clk_hw_register_fixed_rate(dev, pclk[i].name,
                   ^
   sound/soc/intel/skylake/skl-ssp-clk.c: In function 'register_skl_clk':
   sound/soc/intel/skylake/skl-ssp-clk.c:321:23: error: storage size of 'init' isn't known
     struct clk_init_data init;
                          ^~~~
   sound/soc/intel/skylake/skl-ssp-clk.c:331:15: error: 'CLK_SET_RATE_GATE' undeclared (first use in this function); did you mean 'DL_STATE_NONE'?
     init.flags = CLK_SET_RATE_GATE;
                  ^~~~~~~~~~~~~~~~~
                  DL_STATE_NONE
   sound/soc/intel/skylake/skl-ssp-clk.c:331:15: note: each undeclared identifier is reported only once for each function it appears in
   sound/soc/intel/skylake/skl-ssp-clk.c:338:8: error: implicit declaration of function 'devm_clk_hw_register'; did you mean 'devm_clk_hw_register_clkdev'? [-Werror=implicit-function-declaration]
     ret = devm_clk_hw_register(dev, &clkdev->hw);
           ^~~~~~~~~~~~~~~~~~~~
           devm_clk_hw_register_clkdev
   sound/soc/intel/skylake/skl-ssp-clk.c:321:23: warning: unused variable 'init' [-Wunused-variable]
     struct clk_init_data init;
                          ^~~~
   sound/soc/intel/skylake/skl-ssp-clk.c: At top level:
   sound/soc/intel/skylake/skl-ssp-clk.c:260:29: error: storage size of 'skl_clk_ops' isn't known
    static const struct clk_ops skl_clk_ops = {
                                ^~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/container_of +18 sound/soc/intel/skylake/skl-ssp-clk.c

01f50d69 Sriram Periyasamy 2018-01-04   17  
01f50d69 Sriram Periyasamy 2018-01-04  @18  #define to_skl_clk(_hw)	container_of(_hw, struct skl_clk, hw)
01f50d69 Sriram Periyasamy 2018-01-04   19  
01f50d69 Sriram Periyasamy 2018-01-04   20  struct skl_clk_parent {
01f50d69 Sriram Periyasamy 2018-01-04   21  	struct clk_hw *hw;
01f50d69 Sriram Periyasamy 2018-01-04   22  	struct clk_lookup *lookup;
01f50d69 Sriram Periyasamy 2018-01-04   23  };
01f50d69 Sriram Periyasamy 2018-01-04   24  
01f50d69 Sriram Periyasamy 2018-01-04   25  struct skl_clk {
01f50d69 Sriram Periyasamy 2018-01-04   26  	struct clk_hw hw;
01f50d69 Sriram Periyasamy 2018-01-04   27  	struct clk_lookup *lookup;
01f50d69 Sriram Periyasamy 2018-01-04   28  	unsigned long rate;
01f50d69 Sriram Periyasamy 2018-01-04   29  	struct skl_clk_pdata *pdata;
01f50d69 Sriram Periyasamy 2018-01-04   30  	u32 id;
01f50d69 Sriram Periyasamy 2018-01-04   31  };
01f50d69 Sriram Periyasamy 2018-01-04   32  
01f50d69 Sriram Periyasamy 2018-01-04   33  struct skl_clk_data {
01f50d69 Sriram Periyasamy 2018-01-04   34  	struct skl_clk_parent parent[SKL_MAX_CLK_SRC];
01f50d69 Sriram Periyasamy 2018-01-04   35  	struct skl_clk *clk[SKL_MAX_CLK_CNT];
01f50d69 Sriram Periyasamy 2018-01-04   36  	u8 avail_clk_cnt;
01f50d69 Sriram Periyasamy 2018-01-04   37  };
01f50d69 Sriram Periyasamy 2018-01-04   38  
01f50d69 Sriram Periyasamy 2018-01-04   39  static int skl_get_clk_type(u32 index)
01f50d69 Sriram Periyasamy 2018-01-04   40  {
01f50d69 Sriram Periyasamy 2018-01-04   41  	switch (index) {
01f50d69 Sriram Periyasamy 2018-01-04   42  	case 0 ... (SKL_SCLK_OFS - 1):
01f50d69 Sriram Periyasamy 2018-01-04   43  		return SKL_MCLK;
01f50d69 Sriram Periyasamy 2018-01-04   44  
01f50d69 Sriram Periyasamy 2018-01-04   45  	case SKL_SCLK_OFS ... (SKL_SCLKFS_OFS - 1):
01f50d69 Sriram Periyasamy 2018-01-04   46  		return SKL_SCLK;
01f50d69 Sriram Periyasamy 2018-01-04   47  
01f50d69 Sriram Periyasamy 2018-01-04   48  	case SKL_SCLKFS_OFS ... (SKL_MAX_CLK_CNT - 1):
01f50d69 Sriram Periyasamy 2018-01-04   49  		return SKL_SCLK_FS;
01f50d69 Sriram Periyasamy 2018-01-04   50  
01f50d69 Sriram Periyasamy 2018-01-04   51  	default:
01f50d69 Sriram Periyasamy 2018-01-04   52  		return -EINVAL;
01f50d69 Sriram Periyasamy 2018-01-04   53  	}
01f50d69 Sriram Periyasamy 2018-01-04   54  }
01f50d69 Sriram Periyasamy 2018-01-04   55  
01f50d69 Sriram Periyasamy 2018-01-04   56  static int skl_get_vbus_id(u32 index, u8 clk_type)
01f50d69 Sriram Periyasamy 2018-01-04   57  {
01f50d69 Sriram Periyasamy 2018-01-04   58  	switch (clk_type) {
01f50d69 Sriram Periyasamy 2018-01-04   59  	case SKL_MCLK:
01f50d69 Sriram Periyasamy 2018-01-04   60  		return index;
01f50d69 Sriram Periyasamy 2018-01-04   61  
01f50d69 Sriram Periyasamy 2018-01-04   62  	case SKL_SCLK:
01f50d69 Sriram Periyasamy 2018-01-04   63  		return index - SKL_SCLK_OFS;
01f50d69 Sriram Periyasamy 2018-01-04   64  
01f50d69 Sriram Periyasamy 2018-01-04   65  	case SKL_SCLK_FS:
01f50d69 Sriram Periyasamy 2018-01-04   66  		return index - SKL_SCLKFS_OFS;
01f50d69 Sriram Periyasamy 2018-01-04   67  
01f50d69 Sriram Periyasamy 2018-01-04   68  	default:
01f50d69 Sriram Periyasamy 2018-01-04   69  		return -EINVAL;
01f50d69 Sriram Periyasamy 2018-01-04   70  	}
01f50d69 Sriram Periyasamy 2018-01-04   71  }
01f50d69 Sriram Periyasamy 2018-01-04   72  
01f50d69 Sriram Periyasamy 2018-01-04   73  static void skl_fill_clk_ipc(struct skl_clk_rate_cfg_table *rcfg, u8 clk_type)
01f50d69 Sriram Periyasamy 2018-01-04   74  {
01f50d69 Sriram Periyasamy 2018-01-04   75  	struct nhlt_fmt_cfg *fmt_cfg;
01f50d69 Sriram Periyasamy 2018-01-04   76  	union skl_clk_ctrl_ipc *ipc;
01f50d69 Sriram Periyasamy 2018-01-04   77  	struct wav_fmt *wfmt;
01f50d69 Sriram Periyasamy 2018-01-04   78  
01f50d69 Sriram Periyasamy 2018-01-04   79  	if (!rcfg)
01f50d69 Sriram Periyasamy 2018-01-04   80  		return;
01f50d69 Sriram Periyasamy 2018-01-04   81  
01f50d69 Sriram Periyasamy 2018-01-04   82  	ipc = &rcfg->dma_ctl_ipc;
01f50d69 Sriram Periyasamy 2018-01-04   83  	if (clk_type == SKL_SCLK_FS) {
01f50d69 Sriram Periyasamy 2018-01-04   84  		fmt_cfg = (struct nhlt_fmt_cfg *)rcfg->config;
01f50d69 Sriram Periyasamy 2018-01-04   85  		wfmt = &fmt_cfg->fmt_ext.fmt;
01f50d69 Sriram Periyasamy 2018-01-04   86  
01f50d69 Sriram Periyasamy 2018-01-04   87  		/* Remove TLV Header size */
01f50d69 Sriram Periyasamy 2018-01-04   88  		ipc->sclk_fs.hdr.size = sizeof(struct skl_dmactrl_sclkfs_cfg) -
01f50d69 Sriram Periyasamy 2018-01-04   89  						sizeof(struct skl_tlv_hdr);
01f50d69 Sriram Periyasamy 2018-01-04   90  		ipc->sclk_fs.sampling_frequency = wfmt->samples_per_sec;
01f50d69 Sriram Periyasamy 2018-01-04   91  		ipc->sclk_fs.bit_depth = wfmt->bits_per_sample;
01f50d69 Sriram Periyasamy 2018-01-04   92  		ipc->sclk_fs.valid_bit_depth =
01f50d69 Sriram Periyasamy 2018-01-04   93  			fmt_cfg->fmt_ext.sample.valid_bits_per_sample;
01f50d69 Sriram Periyasamy 2018-01-04   94  		ipc->sclk_fs.number_of_channels = wfmt->channels;
01f50d69 Sriram Periyasamy 2018-01-04   95  	} else {
01f50d69 Sriram Periyasamy 2018-01-04   96  		ipc->mclk.hdr.type = DMA_CLK_CONTROLS;
01f50d69 Sriram Periyasamy 2018-01-04   97  		/* Remove TLV Header size */
01f50d69 Sriram Periyasamy 2018-01-04   98  		ipc->mclk.hdr.size = sizeof(struct skl_dmactrl_mclk_cfg) -
01f50d69 Sriram Periyasamy 2018-01-04   99  						sizeof(struct skl_tlv_hdr);
01f50d69 Sriram Periyasamy 2018-01-04  100  	}
01f50d69 Sriram Periyasamy 2018-01-04  101  }
01f50d69 Sriram Periyasamy 2018-01-04  102  
01f50d69 Sriram Periyasamy 2018-01-04  103  /* Sends dma control IPC to turn the clock ON/OFF */
01f50d69 Sriram Periyasamy 2018-01-04  104  static int skl_send_clk_dma_control(struct skl *skl,
01f50d69 Sriram Periyasamy 2018-01-04  105  				struct skl_clk_rate_cfg_table *rcfg,
01f50d69 Sriram Periyasamy 2018-01-04  106  				u32 vbus_id, u8 clk_type,
01f50d69 Sriram Periyasamy 2018-01-04  107  				bool enable)
01f50d69 Sriram Periyasamy 2018-01-04  108  {
01f50d69 Sriram Periyasamy 2018-01-04  109  	struct nhlt_specific_cfg *sp_cfg;
01f50d69 Sriram Periyasamy 2018-01-04  110  	u32 i2s_config_size, node_id = 0;
01f50d69 Sriram Periyasamy 2018-01-04  111  	struct nhlt_fmt_cfg *fmt_cfg;
01f50d69 Sriram Periyasamy 2018-01-04  112  	union skl_clk_ctrl_ipc *ipc;
01f50d69 Sriram Periyasamy 2018-01-04  113  	void *i2s_config = NULL;
01f50d69 Sriram Periyasamy 2018-01-04  114  	u8 *data, size;
01f50d69 Sriram Periyasamy 2018-01-04  115  	int ret;
01f50d69 Sriram Periyasamy 2018-01-04  116  
01f50d69 Sriram Periyasamy 2018-01-04  117  	if (!rcfg)
01f50d69 Sriram Periyasamy 2018-01-04  118  		return -EIO;
01f50d69 Sriram Periyasamy 2018-01-04  119  
01f50d69 Sriram Periyasamy 2018-01-04  120  	ipc = &rcfg->dma_ctl_ipc;
01f50d69 Sriram Periyasamy 2018-01-04  121  	fmt_cfg = (struct nhlt_fmt_cfg *)rcfg->config;
01f50d69 Sriram Periyasamy 2018-01-04  122  	sp_cfg = &fmt_cfg->config;
01f50d69 Sriram Periyasamy 2018-01-04  123  
01f50d69 Sriram Periyasamy 2018-01-04  124  	if (clk_type == SKL_SCLK_FS) {
01f50d69 Sriram Periyasamy 2018-01-04  125  		ipc->sclk_fs.hdr.type =
01f50d69 Sriram Periyasamy 2018-01-04  126  			enable ? DMA_TRANSMITION_START : DMA_TRANSMITION_STOP;
01f50d69 Sriram Periyasamy 2018-01-04  127  		data = (u8 *)&ipc->sclk_fs;
01f50d69 Sriram Periyasamy 2018-01-04  128  		size = sizeof(struct skl_dmactrl_sclkfs_cfg);
01f50d69 Sriram Periyasamy 2018-01-04  129  	} else {
01f50d69 Sriram Periyasamy 2018-01-04  130  		/* 1 to enable mclk, 0 to enable sclk */
01f50d69 Sriram Periyasamy 2018-01-04  131  		if (clk_type == SKL_SCLK)
01f50d69 Sriram Periyasamy 2018-01-04  132  			ipc->mclk.mclk = 0;
01f50d69 Sriram Periyasamy 2018-01-04  133  		else
01f50d69 Sriram Periyasamy 2018-01-04  134  			ipc->mclk.mclk = 1;
01f50d69 Sriram Periyasamy 2018-01-04  135  
01f50d69 Sriram Periyasamy 2018-01-04  136  		ipc->mclk.keep_running = enable;
01f50d69 Sriram Periyasamy 2018-01-04  137  		ipc->mclk.warm_up_over = enable;
01f50d69 Sriram Periyasamy 2018-01-04  138  		ipc->mclk.clk_stop_over = !enable;
01f50d69 Sriram Periyasamy 2018-01-04  139  		data = (u8 *)&ipc->mclk;
01f50d69 Sriram Periyasamy 2018-01-04  140  		size = sizeof(struct skl_dmactrl_mclk_cfg);
01f50d69 Sriram Periyasamy 2018-01-04  141  	}
01f50d69 Sriram Periyasamy 2018-01-04  142  
01f50d69 Sriram Periyasamy 2018-01-04  143  	i2s_config_size = sp_cfg->size + size;
01f50d69 Sriram Periyasamy 2018-01-04  144  	i2s_config = kzalloc(i2s_config_size, GFP_KERNEL);
01f50d69 Sriram Periyasamy 2018-01-04  145  	if (!i2s_config)
01f50d69 Sriram Periyasamy 2018-01-04  146  		return -ENOMEM;
01f50d69 Sriram Periyasamy 2018-01-04  147  
01f50d69 Sriram Periyasamy 2018-01-04  148  	/* copy blob */
01f50d69 Sriram Periyasamy 2018-01-04  149  	memcpy(i2s_config, sp_cfg->caps, sp_cfg->size);
01f50d69 Sriram Periyasamy 2018-01-04  150  
01f50d69 Sriram Periyasamy 2018-01-04  151  	/* copy additional dma controls information */
01f50d69 Sriram Periyasamy 2018-01-04  152  	memcpy(i2s_config + sp_cfg->size, data, size);
01f50d69 Sriram Periyasamy 2018-01-04  153  
01f50d69 Sriram Periyasamy 2018-01-04  154  	node_id = ((SKL_DMA_I2S_LINK_INPUT_CLASS << 8) | (vbus_id << 4));
01f50d69 Sriram Periyasamy 2018-01-04  155  	ret = skl_dsp_set_dma_control(skl->skl_sst, (u32 *)i2s_config,
01f50d69 Sriram Periyasamy 2018-01-04  156  					i2s_config_size, node_id);
01f50d69 Sriram Periyasamy 2018-01-04  157  	kfree(i2s_config);
01f50d69 Sriram Periyasamy 2018-01-04  158  
01f50d69 Sriram Periyasamy 2018-01-04  159  	return ret;
01f50d69 Sriram Periyasamy 2018-01-04  160  }
01f50d69 Sriram Periyasamy 2018-01-04  161  
01f50d69 Sriram Periyasamy 2018-01-04  162  static struct skl_clk_rate_cfg_table *skl_get_rate_cfg(
01f50d69 Sriram Periyasamy 2018-01-04  163  		struct skl_clk_rate_cfg_table *rcfg,
01f50d69 Sriram Periyasamy 2018-01-04  164  				unsigned long rate)
01f50d69 Sriram Periyasamy 2018-01-04  165  {
01f50d69 Sriram Periyasamy 2018-01-04  166  	int i;
01f50d69 Sriram Periyasamy 2018-01-04  167  
01f50d69 Sriram Periyasamy 2018-01-04  168  	for (i = 0; (i < SKL_MAX_CLK_RATES) && rcfg[i].rate; i++) {
01f50d69 Sriram Periyasamy 2018-01-04  169  		if (rcfg[i].rate == rate)
01f50d69 Sriram Periyasamy 2018-01-04  170  			return &rcfg[i];
01f50d69 Sriram Periyasamy 2018-01-04  171  	}
01f50d69 Sriram Periyasamy 2018-01-04  172  
01f50d69 Sriram Periyasamy 2018-01-04  173  	return NULL;
01f50d69 Sriram Periyasamy 2018-01-04  174  }
01f50d69 Sriram Periyasamy 2018-01-04  175  
01f50d69 Sriram Periyasamy 2018-01-04  176  static int skl_clk_change_status(struct skl_clk *clkdev,
01f50d69 Sriram Periyasamy 2018-01-04  177  				bool enable)
01f50d69 Sriram Periyasamy 2018-01-04  178  {
01f50d69 Sriram Periyasamy 2018-01-04  179  	struct skl_clk_rate_cfg_table *rcfg;
01f50d69 Sriram Periyasamy 2018-01-04  180  	int vbus_id, clk_type;
01f50d69 Sriram Periyasamy 2018-01-04  181  
01f50d69 Sriram Periyasamy 2018-01-04  182  	clk_type = skl_get_clk_type(clkdev->id);
01f50d69 Sriram Periyasamy 2018-01-04  183  	if (clk_type < 0)
01f50d69 Sriram Periyasamy 2018-01-04  184  		return clk_type;
01f50d69 Sriram Periyasamy 2018-01-04  185  
01f50d69 Sriram Periyasamy 2018-01-04  186  	vbus_id = skl_get_vbus_id(clkdev->id, clk_type);
01f50d69 Sriram Periyasamy 2018-01-04  187  	if (vbus_id < 0)
01f50d69 Sriram Periyasamy 2018-01-04  188  		return vbus_id;
01f50d69 Sriram Periyasamy 2018-01-04  189  
01f50d69 Sriram Periyasamy 2018-01-04  190  	rcfg = skl_get_rate_cfg(clkdev->pdata->ssp_clks[clkdev->id].rate_cfg,
01f50d69 Sriram Periyasamy 2018-01-04  191  						clkdev->rate);
01f50d69 Sriram Periyasamy 2018-01-04  192  	if (!rcfg)
01f50d69 Sriram Periyasamy 2018-01-04  193  		return -EINVAL;
01f50d69 Sriram Periyasamy 2018-01-04  194  
01f50d69 Sriram Periyasamy 2018-01-04  195  	return skl_send_clk_dma_control(clkdev->pdata->pvt_data, rcfg,
01f50d69 Sriram Periyasamy 2018-01-04  196  					vbus_id, clk_type, enable);
01f50d69 Sriram Periyasamy 2018-01-04  197  }
01f50d69 Sriram Periyasamy 2018-01-04  198  
01f50d69 Sriram Periyasamy 2018-01-04  199  static int skl_clk_prepare(struct clk_hw *hw)
01f50d69 Sriram Periyasamy 2018-01-04  200  {
01f50d69 Sriram Periyasamy 2018-01-04 @201  	struct skl_clk *clkdev = to_skl_clk(hw);
01f50d69 Sriram Periyasamy 2018-01-04  202  
01f50d69 Sriram Periyasamy 2018-01-04  203  	return skl_clk_change_status(clkdev, true);
01f50d69 Sriram Periyasamy 2018-01-04  204  }
01f50d69 Sriram Periyasamy 2018-01-04  205  

:::::: The code at line 18 was first introduced by commit
:::::: 01f50d69bebe1bb0b30bba1eba3cdaf1f02dd7c4 ASoC: Intel: Skylake: Add ssp clock driver

:::::: TO: Sriram Periyasamy <sriramx.periyasamy@intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--wRRV7LY7NUeQGEoC
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
XfMrdnqjk0DMnZRKM/uB/wOCU9LjmokDAA==

--wRRV7LY7NUeQGEoC--
