Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41858C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E48206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfHZNoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:44:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:5078 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731297AbfHZNoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:44:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 06:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="380540898"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga006.fm.intel.com with ESMTP; 26 Aug 2019 06:43:58 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i2FHo-0004wG-AZ; Mon, 26 Aug 2019 16:43:56 +0300
Date:   Mon, 26 Aug 2019 16:43:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Update comment about
 simple_strto<foo>() functions
Message-ID: <20190826134356.GG30120@smile.fi.intel.com>
References: <20190801192904.41087-1-andriy.shevchenko@linux.intel.com>
 <CANiq72nGak7da8OVYEeMxQwCmEtoBaeHhF8x26RL77dSg79rUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nGak7da8OVYEeMxQwCmEtoBaeHhF8x26RL77dSg79rUg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 09:50:54PM +0200, Miguel Ojeda wrote:
> On Thu, Aug 1, 2019 at 9:29 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > There were discussions in the past about use cases for
> > simple_strto<foo>() functions and, in some rare cases,
> > they have a benefit over kstrto<foo>() ones.
> >
> > Update a comment to reduce confusion about special use cases.
> >
> > Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 
> I don't recall suggesting this, but I have a bad memory :-)
> 
> Andrew, should I pick both patches myself or do you want to pick this one?

It seems you can take both.

-- 
With Best Regards,
Andy Shevchenko


