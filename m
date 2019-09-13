Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE6DC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D70020830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390881AbfIMPF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:05:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:58087 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390046AbfIMPF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:05:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 08:05:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="176307356"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 13 Sep 2019 08:05:52 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i8n8w-0005YA-OY; Fri, 13 Sep 2019 18:05:50 +0300
Date:   Fri, 13 Sep 2019 18:05:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-serial@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        John Garry <john.garry@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: 8250_of: Use software emulated RS485 direction
 control
Message-ID: <20190913150550.GS2680@smile.fi.intel.com>
References: <20190913050105.1132080-1-hs@denx.de>
 <20190913102409.GF2680@smile.fi.intel.com>
 <51a21dde-a471-6e8e-8048-50437d740f7f@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a21dde-a471-6e8e-8048-50437d740f7f@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 04:51:30PM +0200, Heiko Schocher wrote:
> Am 13.09.2019 um 12:24 schrieb Andy Shevchenko:
> > On Fri, Sep 13, 2019 at 07:01:05AM +0200, Heiko Schocher wrote:

> > > Patch is based on:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > commit:
> > > 505a8ec7e11a - Revert "drm/i915/userptr: Acquire the page lock around set_page_dirty()"
> > 
> > More reliably is to base on corresponding subsystem tree, i.e. tty-next for
> > this case.
> 
> Ok, should I send a rebased v2 (I tend to wait for other comments)?

I didn't give any comments WRT patch itself, so, I don't see any needs to send
v2 right now.

-- 
With Best Regards,
Andy Shevchenko


