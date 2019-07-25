Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762C2C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0BA22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390128AbfGYNmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:42:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:31390 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389989AbfGYNmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:42:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 06:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,306,1559545200"; 
   d="scan'208";a="170250242"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2019 06:42:50 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hqe1B-0004Xm-0O; Thu, 25 Jul 2019 16:42:49 +0300
Date:   Thu, 25 Jul 2019 16:42:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Remove D3cold delay
Message-ID: <20190725134248.GC9224@smile.fi.intel.com>
References: <20190705045503.13379-1-kai.heng.feng@canonical.com>
 <20190709114647.GX9224@smile.fi.intel.com>
 <20190725120554.GE23883@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725120554.GE23883@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 01:05:54PM +0100, Lee Jones wrote:
> On Tue, 09 Jul 2019, Andy Shevchenko wrote:
> 
> > On Fri, Jul 05, 2019 at 12:55:03PM +0800, Kai-Heng Feng wrote:
> > > Goodix touchpad may drop its first couple input events when
> > > i2c-designware-platdrv and intel-lpss it connects to took too long to
> > > runtime resume from runtime suspended state.
> > > 
> > > This issue happens becuase the touchpad has a rather small buffer to
> > > store up to 13 input events, so if the host doesn't read those events in
> > > time (i.e. runtime resume takes too long), events are dropped from the
> > > touchpad's buffer.
> > > 
> > > The bottleneck is D3cold delay it waits when transitioning from D3cold
> > > to D0, hence remove the delay to make the resume faster. I've tested
> > > some systems with intel-lpss and haven't seen any regression.
> > 
> > Thank you for the patch. I took it to our internal testing and will tell
> > the result within couple of weeks.
> 
> Any news?

No bug reports, no negative feedback, I think we may proceed with it.
Thanks!

-- 
With Best Regards,
Andy Shevchenko


