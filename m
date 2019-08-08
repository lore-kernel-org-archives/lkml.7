Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853CBC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFBE2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbfHHQU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:20:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:63601 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfHHQU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:20:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 09:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="374906890"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2019 09:20:26 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvl9O-0004oP-46; Fri, 09 Aug 2019 00:20:26 +0800
Date:   Fri, 9 Aug 2019 00:19:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>
Subject: drivers/gpu/drm/exynos/exynos_drm_fbdev.c:244:26: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <201908090009.K3ubLMtC%lkp@intel.com>
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
head:   ecb095bff5d4b8711a81968625b3b4a235d3e477
commit: 156bdac99061b4013c8e47799c6e574f7f84e9f4 drm/exynos: trigger build of all modules
date:   6 weeks ago
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 156bdac99061b4013c8e47799c6e574f7f84e9f4
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/exynos/exynos_drm_fbdev.c:244:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const *addr @@    got void [noderevoid const *addr @@
>> drivers/gpu/drm/exynos/exynos_drm_fbdev.c:244:26: sparse:    expected void const *addr
>> drivers/gpu/drm/exynos/exynos_drm_fbdev.c:244:26: sparse:    got void [noderef] <asn:2> *kvaddr
--
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:458:39: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void *timing_base @@    got void [noderef] <asvoid *timing_base @@
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:458:39: sparse:    expected void *timing_base
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:458:39: sparse:    got void [noderef] <asn:2> *
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:470:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:470:41: sparse:    expected void volatile [noderef] <asn:2> *addr
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:470:41: sparse:    got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:473:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:473:39: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:473:39: sparse:    got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:519:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:519:53: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:519:53: sparse:    got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:945:39: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void *timing_base @@    got void [noderef] <asvoid *timing_base @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:945:39: sparse:    expected void *timing_base
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:945:39: sparse:    got void [noderef] <asn:2> *
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:958:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:958:33: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:958:33: sparse:    got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:960:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got n:2> *addr @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:960:33: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:960:33: sparse:    got void *
--
>> drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c:527:5: sparse: sparse: symbol 'analogix_dp_start_aux_transaction' was not declared. Should it be static?
>> drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c:571:5: sparse: sparse: symbol 'analogix_dp_write_byte_to_dpcd' was not declared. Should it be static?

vim +244 drivers/gpu/drm/exynos/exynos_drm_fbdev.c

1c248b7d2960fa Inki Dae       2011-10-04  236  
1c248b7d2960fa Inki Dae       2011-10-04  237  static void exynos_drm_fbdev_destroy(struct drm_device *dev,
1c248b7d2960fa Inki Dae       2011-10-04  238  				      struct drm_fb_helper *fb_helper)
1c248b7d2960fa Inki Dae       2011-10-04  239  {
4744ad2414bd89 Inki Dae       2012-12-07  240  	struct exynos_drm_fbdev *exynos_fbd = to_exynos_fbdev(fb_helper);
813fd67b57ffca Joonyoung Shim 2015-10-02  241  	struct exynos_drm_gem *exynos_gem = exynos_fbd->exynos_gem;
1c248b7d2960fa Inki Dae       2011-10-04  242  	struct drm_framebuffer *fb;
1c248b7d2960fa Inki Dae       2011-10-04  243  
813fd67b57ffca Joonyoung Shim 2015-10-02 @244  	vunmap(exynos_gem->kvaddr);
4744ad2414bd89 Inki Dae       2012-12-07  245  
1c248b7d2960fa Inki Dae       2011-10-04  246  	/* release drm framebuffer and real buffer */
1c248b7d2960fa Inki Dae       2011-10-04  247  	if (fb_helper->fb && fb_helper->fb->funcs) {
1c248b7d2960fa Inki Dae       2011-10-04  248  		fb = fb_helper->fb;
328c057ca4def7 Daniel Vetter  2016-12-27  249  		if (fb)
f7eff60ea0e4e3 Rob Clark      2012-09-05  250  			drm_framebuffer_remove(fb);
1c248b7d2960fa Inki Dae       2011-10-04  251  	}
1c248b7d2960fa Inki Dae       2011-10-04  252  
7c7d4507fb04bb Archit Taneja  2015-07-22  253  	drm_fb_helper_unregister_fbi(fb_helper);
1c248b7d2960fa Inki Dae       2011-10-04  254  
1c248b7d2960fa Inki Dae       2011-10-04  255  	drm_fb_helper_fini(fb_helper);
1c248b7d2960fa Inki Dae       2011-10-04  256  }
1c248b7d2960fa Inki Dae       2011-10-04  257  

:::::: The code at line 244 was first introduced by commit
:::::: 813fd67b57ffca0dd19fe1834f894a4558cf5e0b drm/exynos: cleanup name of gem object for exynos_drm

:::::: TO: Joonyoung Shim <jy0922.shim@samsung.com>
:::::: CC: Inki Dae <daeinki@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
