Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5069C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986E9206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfJKPgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:36:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:34142 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfJKPgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:36:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 08:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="184797061"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 11 Oct 2019 08:36:38 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iIwy6-00012Z-2G; Fri, 11 Oct 2019 18:36:38 +0300
Date:   Fri, 11 Oct 2019 18:36:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ipmi: use %*ph to print small buffer
Message-ID: <20191011153638.GF32742@smile.fi.intel.com>
References: <20191011145213.65082-1-andriy.shevchenko@linux.intel.com>
 <4eaca9a1bcbf9d87c1fb3c9135876c3ecb72a91b.camel@perches.com>
 <20191011151220.GB32742@smile.fi.intel.com>
 <e0b24ff49eb69a216b11f97db1fc26c5d3b971b4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b24ff49eb69a216b11f97db1fc26c5d3b971b4.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:18:41AM -0700, Joe Perches wrote:
> On Fri, 2019-10-11 at 18:12 +0300, Andy Shevchenko wrote:
> > On Fri, Oct 11, 2019 at 07:58:14AM -0700, Joe Perches wrote:
> > > On Fri, 2019-10-11 at 17:52 +0300, Andy Shevchenko wrote:

> > > >  static void ipmi_debug_msg(const char *title, unsigned char *data,
...
> > > > +	pr_debug("%s: %*ph\n", title, len, buf);
...
> > > >  #else
> > > >  static void ipmi_debug_msg(const char *title, unsigned char *data,

> > > Now you might as well remove the #ifdef DEBUG above this
> > > and the empty function in the #else too.
> > 
> > It's up to maintainer.
> 
> That's like suggesting any function with a single pr_debug
> should have another duplicative empty function without.
> 
> Using code like the below is not good form as it's prone
> to defects when the arguments in one block is changed but
> not the other.
> 
> Also the first form doesn't work with dynamic debug.

I'm surprised to see my name in To:. I guess you intended to explain this to
Corey. I'm fine with either, since I have no idea what is in the IPMI going on.

-- 
With Best Regards,
Andy Shevchenko


