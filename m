Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B68FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2755F20718
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKOKUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:20:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:22267 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfKOKUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:20:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 02:20:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="217059964"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2019 02:20:52 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iVYih-00039m-Id; Fri, 15 Nov 2019 12:20:51 +0200
Date:   Fri, 15 Nov 2019 12:20:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] mfd: syscon: Switch to use devm_ioremap_resource()
Message-ID: <20191115102051.GP32742@smile.fi.intel.com>
References: <20191115084931.77161-1-andriy.shevchenko@linux.intel.com>
 <20191115084931.77161-2-andriy.shevchenko@linux.intel.com>
 <CAK8P3a2D1eks7dirbX=LrdQy6w0HeA7-x8jb1=qkxfatPuc51w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2D1eks7dirbX=LrdQy6w0HeA7-x8jb1=qkxfatPuc51w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:12:57AM +0100, Arnd Bergmann wrote:
> On Fri, Nov 15, 2019 at 9:49 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Instead of checking resource pointer for being NULL and
> > report some not very standard error codes in this case,
> > switch to devm_ioremap_resource() API.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> IIRC there are some slightly odd uses of syscon that rely on on us not calling
> devm_request_mem_region here, which is implied by devm_ioremap_resource()
> but not devm_ioremap().

Ah, I see.

> A patch to add a comment about this might be helpful though.

I think the comment won't help if there are overlapping regions are in use.
Probably no need to apply this for now.

-- 
With Best Regards,
Andy Shevchenko


