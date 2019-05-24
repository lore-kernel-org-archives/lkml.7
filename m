Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059EAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD96320815
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403953AbfEXOAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:00:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:30820 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403896AbfEXOAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:00:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 07:00:21 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2019 07:00:20 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hUAk6-0004m4-7M; Fri, 24 May 2019 22:00:18 +0800
Date:   Fri, 24 May 2019 21:59:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     kbuild-all@01.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] video: fbdev: atmel_lcdfb: add COMPILE_TEST support
Message-ID: <201905242155.D1bXuUk9%lkp@intel.com>
References: <f9d56fc1-3e02-9716-b764-82e9600e5919@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d56fc1-3e02-9716-b764-82e9600e5919@samsung.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.2-rc1 next-20190524]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartlomiej-Zolnierkiewicz/video-fbdev-atmel_lcdfb-add-COMPILE_TEST-support/20190524-184331
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected char [noderef] <asn:2> *screen_base @@    got n:2> *screen_base @@
>> drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse:    expected char [noderef] <asn:2> *screen_base
>> drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse:    got void *
>> drivers/video/fbdev/atmel_lcdfb.c:362:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *s @@    got char [noderef] <asvoid *s @@
>> drivers/video/fbdev/atmel_lcdfb.c:362:9: sparse:    expected void *s
>> drivers/video/fbdev/atmel_lcdfb.c:362:9: sparse:    got char [noderef] <asn:2> *screen_base
>> drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@    expected void *cpu_addr @@    got char [noderef] <asvoid *cpu_addr @@
>> drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:    expected void *cpu_addr
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:    got char [noderef] <asn:2> *screen_base
>> drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@    expected void *cpu_addr @@    got char [noderef] <asvoid *cpu_addr @@
>> drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:    expected void *cpu_addr
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:    got char [noderef] <asn:2> *screen_base

vim +354 drivers/video/fbdev/atmel_lcdfb.c

14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  328  
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  329  static inline void atmel_lcdfb_free_video_memory(struct atmel_lcdfb_info *sinfo)
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  330  {
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  331  	struct fb_info *info = sinfo->info;
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  332  
f6e45661 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22 @333  	dma_free_wc(info->device, info->fix.smem_len, info->screen_base,
f6e45661 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  334  		    info->fix.smem_start);
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  335  }
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  336  
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  337  /**
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  338   *	atmel_lcdfb_alloc_video_memory - Allocate framebuffer memory
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  339   *	@sinfo: the frame buffer to allocate memory for
1d01e835 drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  340   * 	
1d01e835 drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  341   * 	This function is called only from the atmel_lcdfb_probe()
1d01e835 drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  342   * 	so no locking by fb_info->mm_lock around smem_len setting is needed.
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  343   */
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  344  static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  345  {
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  346  	struct fb_info *info = sinfo->info;
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  347  	struct fb_var_screeninfo *var = &info->var;
ea757aca drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  348  	unsigned int smem_len;
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  349  
ea757aca drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  350  	smem_len = (var->xres_virtual * var->yres_virtual
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  351  		    * ((var->bits_per_pixel + 7) / 8));
ea757aca drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  352  	info->fix.smem_len = max(smem_len, sinfo->smem_len);
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  353  
f6e45661 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22 @354  	info->screen_base = dma_alloc_wc(info->device, info->fix.smem_len,
f6e45661 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  355  					 (dma_addr_t *)&info->fix.smem_start,
f6e45661 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  356  					 GFP_KERNEL);
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  357  
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  358  	if (!info->screen_base) {
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  359  		return -ENOMEM;
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  360  	}
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  361  
01d3a5e7 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28 @362  	memset(info->screen_base, 0, info->fix.smem_len);
01d3a5e7 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28  363  
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  364  	return 0;
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  365  }
14340586 drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  366  

:::::: The code at line 354 was first introduced by commit
:::::: f6e45661f9be546811b62b2b01f32f4bf0c436c0 dma, mm/pat: Rename dma_*_writecombine() to dma_*_wc()

:::::: TO: Luis R. Rodriguez <mcgrof@suse.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
