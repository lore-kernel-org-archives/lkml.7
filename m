Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E180C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4B22077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfDOMse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:48:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:9544 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOMse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:48:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 05:48:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,353,1549958400"; 
   d="scan'208";a="143090283"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 15 Apr 2019 05:48:30 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hG12D-0002wi-MH; Mon, 15 Apr 2019 15:48:29 +0300
Date:   Mon, 15 Apr 2019 15:48:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/12] i2c: core: introduce atomic transfers
Message-ID: <20190415124829.GR9224@smile.fi.intel.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403131510.GE9224@smile.fi.intel.com>
 <20190415120611.euidifhshkf5yqns@ninjato>
 <20190415123554.GQ9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415123554.GQ9224@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 03:35:54PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 15, 2019 at 02:06:11PM +0200, Wolfram Sang wrote:
> > On Wed, Apr 03, 2019 at 04:15:10PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 03, 2019 at 02:40:07PM +0200, Wolfram Sang wrote:
> > > 
> > > FWIW,
> > > 
> > > Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > for patches 1-5,12.
> > 
> > Thanks for the review, Andy! May I ask you once more to tag the patches
> > individually so patchwork can pick them up for me?
> 
> It seems I already cleaned up them from my mailbox. I can check if it's
> available in another one.

Done!

-- 
With Best Regards,
Andy Shevchenko


