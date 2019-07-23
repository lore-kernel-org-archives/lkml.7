Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB384C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83DF218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392271AbfGWWDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:03:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:44750 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731354AbfGWWDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:03:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 15:03:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; 
   d="scan'208";a="369056329"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2019 15:03:00 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hq2s8-000Cr4-5I; Wed, 24 Jul 2019 06:03:00 +0800
Date:   Wed, 24 Jul 2019 06:02:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>
Subject: drivers/gpu/drm/exynos/exynos_drm_fbdev.c:244:26: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <201907240639.ccTBnO0H%lkp@intel.com>
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
head:   7b5cf701ea9c395c792e2a7e3b7caf4c68b87721
commit: 156bdac99061b4013c8e47799c6e574f7f84e9f4 drm/exynos: trigger build of all modules
date:   4 weeks ago
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

1c248b7d2960fae Inki Dae       2011-10-04  236  
1c248b7d2960fae Inki Dae       2011-10-04  237  static void exynos_drm_fbdev_destroy(struct drm_device *dev,
1c248b7d2960fae Inki Dae       2011-10-04  238  				      struct drm_fb_helper *fb_helper)
1c248b7d2960fae Inki Dae       2011-10-04  239  {
4744ad2414bd890 Inki Dae       2012-12-07  240  	struct exynos_drm_fbdev *exynos_fbd = to_exynos_fbdev(fb_helper);
813fd67b57ffca0 Joonyoung Shim 2015-10-02  241  	struct exynos_drm_gem *exynos_gem = exynos_fbd->exynos_gem;
1c248b7d2960fae Inki Dae       2011-10-04  242  	struct drm_framebuffer *fb;
1c248b7d2960fae Inki Dae       2011-10-04  243  
813fd67b57ffca0 Joonyoung Shim 2015-10-02 @244  	vunmap(exynos_gem->kvaddr);
4744ad2414bd890 Inki Dae       2012-12-07  245  
1c248b7d2960fae Inki Dae       2011-10-04  246  	/* release drm framebuffer and real buffer */
1c248b7d2960fae Inki Dae       2011-10-04  247  	if (fb_helper->fb && fb_helper->fb->funcs) {
1c248b7d2960fae Inki Dae       2011-10-04  248  		fb = fb_helper->fb;
328c057ca4def70 Daniel Vetter  2016-12-27  249  		if (fb)
f7eff60ea0e4e35 Rob Clark      2012-09-05  250  			drm_framebuffer_remove(fb);
1c248b7d2960fae Inki Dae       2011-10-04  251  	}
1c248b7d2960fae Inki Dae       2011-10-04  252  
7c7d4507fb04bbe Archit Taneja  2015-07-22  253  	drm_fb_helper_unregister_fbi(fb_helper);
1c248b7d2960fae Inki Dae       2011-10-04  254  
1c248b7d2960fae Inki Dae       2011-10-04  255  	drm_fb_helper_fini(fb_helper);
1c248b7d2960fae Inki Dae       2011-10-04  256  }
1c248b7d2960fae Inki Dae       2011-10-04  257  
1c248b7d2960fae Inki Dae       2011-10-04  258  void exynos_drm_fbdev_fini(struct drm_device *dev)
1c248b7d2960fae Inki Dae       2011-10-04  259  {
1c248b7d2960fae Inki Dae       2011-10-04  260  	struct exynos_drm_private *private = dev->dev_private;
1c248b7d2960fae Inki Dae       2011-10-04  261  	struct exynos_drm_fbdev *fbdev;
1c248b7d2960fae Inki Dae       2011-10-04  262  
1c248b7d2960fae Inki Dae       2011-10-04  263  	if (!private || !private->fb_helper)
1c248b7d2960fae Inki Dae       2011-10-04  264  		return;
1c248b7d2960fae Inki Dae       2011-10-04  265  
1c248b7d2960fae Inki Dae       2011-10-04  266  	fbdev = to_exynos_fbdev(private->fb_helper);
1c248b7d2960fae Inki Dae       2011-10-04  267  
1c248b7d2960fae Inki Dae       2011-10-04  268  	exynos_drm_fbdev_destroy(dev, private->fb_helper);
1c248b7d2960fae Inki Dae       2011-10-04  269  	kfree(fbdev);
1c248b7d2960fae Inki Dae       2011-10-04  270  	private->fb_helper = NULL;
1c248b7d2960fae Inki Dae       2011-10-04  271  }
1c248b7d2960fae Inki Dae       2011-10-04  272  

:::::: The code at line 244 was first introduced by commit
:::::: 813fd67b57ffca0dd19fe1834f894a4558cf5e0b drm/exynos: cleanup name of gem object for exynos_drm

:::::: TO: Joonyoung Shim <jy0922.shim@samsung.com>
:::::: CC: Inki Dae <daeinki@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
