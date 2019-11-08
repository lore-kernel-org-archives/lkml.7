Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA19C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21627222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfKHM7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:59:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:48417 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfKHM7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:59:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 04:59:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,281,1569308400"; 
   d="scan'208";a="206455536"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2019 04:59:18 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iT3rB-0003xa-F8; Fri, 08 Nov 2019 14:59:17 +0200
Date:   Fri, 8 Nov 2019 14:59:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Update comment about
 simple_strto<foo>() functions
Message-ID: <20191108125917.GG32742@smile.fi.intel.com>
References: <20190801192904.41087-1-andriy.shevchenko@linux.intel.com>
 <CANiq72nGak7da8OVYEeMxQwCmEtoBaeHhF8x26RL77dSg79rUg@mail.gmail.com>
 <20190826134356.GG30120@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826134356.GG30120@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 04:43:56PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 01, 2019 at 09:50:54PM +0200, Miguel Ojeda wrote:
> > On Thu, Aug 1, 2019 at 9:29 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > There were discussions in the past about use cases for
> > > simple_strto<foo>() functions and, in some rare cases,
> > > they have a benefit over kstrto<foo>() ones.
> > >
> > > Update a comment to reduce confusion about special use cases.
> > >
> > > Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > 
> > I don't recall suggesting this, but I have a bad memory :-)
> > 
> > Andrew, should I pick both patches myself or do you want to pick this one?
> 
> It seems you can take both.

Can we proceed with this?

-- 
With Best Regards,
Andy Shevchenko


