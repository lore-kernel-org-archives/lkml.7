Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066EFECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB73B20842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbfJAOAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:00:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:31666 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfJAOAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:00:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 07:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="191468774"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2019 07:00:42 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iFIhl-00016Z-Gs; Tue, 01 Oct 2019 17:00:41 +0300
Date:   Tue, 1 Oct 2019 17:00:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: ERROR: "__aeabi_uldivmod"
 [drivers/iio/common/hid-sensors/hid-sensor-iio-common.ko] undefined!
Message-ID: <20191001140041.GQ32742@smile.fi.intel.com>
References: <201910012128.Ouz6DJXL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910012128.Ouz6DJXL%lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 09:26:33PM +0800, kbuild test robot wrote:
> Hi Andy,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c
> commit: 473d12f7638c93acbd9296a8cd455b203d5eb528 iio: hid-sensor-attributes: Convert to use int_pow()
> date:   6 weeks ago
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 473d12f7638c93acbd9296a8cd455b203d5eb528
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "__aeabi_uldivmod" [drivers/iio/common/hid-sensors/hid-sensor-iio-common.ko] undefined!

It has f6897deef4fc.

-- 
With Best Regards,
Andy Shevchenko


