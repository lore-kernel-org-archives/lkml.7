Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121CDECE587
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22F42086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfJOHoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:44:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:10823 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbfJOHoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:44:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 00:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,298,1566889200"; 
   d="scan'208";a="207471820"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 15 Oct 2019 00:44:35 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKHVS-0002nQ-Q9; Tue, 15 Oct 2019 10:44:34 +0300
Date:   Tue, 15 Oct 2019 10:44:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        AceLan Kao <acelan.kao@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 1/2] lib: devres: add a helper function for ioremap_uc
Message-ID: <20191015074434.GU32742@smile.fi.intel.com>
References: <20191014153344.8996-1-ztuowen@gmail.com>
 <201910150232.F7RTW83B%lkp@intel.com>
 <c4bcdf14e0a60a679429eebd439b2380d97dafe9.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4bcdf14e0a60a679429eebd439b2380d97dafe9.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 01:15:53PM -0600, Tuowen Zhao wrote:
> On Tue, 2019-10-15 at 02:46 +0800, kbuild test robot wrote:
> > -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.4.0 make.cross ARCH=sparc64 
> 
> Oops, I'm not sure how would we best fix this. Clearly the patch is not
> intended for sparc64. Maybe adding devm_ioremap_uc is rather not safe
> right now.

It seems you need a preparatory patch to satisfy sparc64.

> Although, We could declare dummies for these architectures like it has
> been for powerpc.
> 
> I just noticed another driver having this issue, and fixed with direct
> calls to ioremap_uc().
> 
> 3cc2dac5be3f2: drivers/video/fbdev/atyfb: Replace MTRR UC hole with
> strong UC

That's why I asked Luis to have a look at this :)

-- 
With Best Regards,
Andy Shevchenko


