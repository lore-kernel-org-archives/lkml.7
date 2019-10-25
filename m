Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B59CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3314521872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503790AbfJYQC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:02:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:17338 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbfJYQC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:02:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 09:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="192578392"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 Oct 2019 09:02:43 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iO230-0000lZ-Kr; Fri, 25 Oct 2019 19:02:42 +0300
Date:   Fri, 25 Oct 2019 19:02:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrey Zhizhikin <andrey.z@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] regulator: add support for Intel Cherry Whiskey Cove
 regulator
Message-ID: <20191025160242.GE32742@smile.fi.intel.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-2-andrey.zhizhikin@leica-geosystems.com>
 <20191025121737.GC4568@sirena.org.uk>
 <CAHtQpK60d_GT4JMBBwGc2q1FqVT7NNhK5T7rSY0GL288ukUc1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHtQpK60d_GT4JMBBwGc2q1FqVT7NNhK5T7rSY0GL288ukUc1A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 05:26:56PM +0200, Andrey Zhizhikin wrote:
> On Fri, Oct 25, 2019 at 4:43 PM Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Oct 25, 2019 at 03:55:17PM +0200, Andrey Zhizhikin wrote:
> > > On Fri, Oct 25, 2019 at 2:17 PM Mark Brown <broonie@kernel.org> wrote:
> > > > On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:
> >
> > Please don't take things off-list unless there is a really strong reason
> > to do so.  Sending things to the list ensures that everyone gets a
> > chance to read and comment on things.  (From some of the things
> > in your mail I think this might've been unintentional.)

> Sorry for mess, sometimes it happens but I try not to create it...

Script nodded... :)

> On Fri, Oct 25, 2019 at 2:17 PM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Oct 24, 2019 at 02:29:38PM +0000, Andrey Zhizhikin wrote:

> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * intel-cht-wc-regulator.c - CherryTrail regulator driver
> > > + *
> >
> > Please use C++ style for the entire comment so things look more
> > consistent.
> 
> This is what I'm puzzled about - which style to use for the file
> header since the introduction of SPDX and a rule that it should be
> "C++ style" commented for source files and "C style" for header files.
> After this introduction, should the more-or-less standard header be
> also done in C++ style? I saw different source files are doing
> different things... But all-in-all I would follow you advise here with
> converting entire block to C++.
> 
> [Mark]: The only thing SPDX cares about is the first line, the making
> the rest of the block a C++ one is mostly a preference I have.
> 
> Got it, would be done!

Also remove the file name(s) from file(s). If we would ever rename the file,
its name will be additional churn inside file (or often being forgotten).

> > Is this really a limitation of the *regulator* or is it a
> > limitation of the consumer?  The combination of the way this is
> > written and the register layout makes it look like it's a
> > consumer limitation in which case leave it up to the consumer to
> > figure out what constraints it has.
> 
> This is a tricky point. Since there is no datasheet available from

Key word "publicly".

I may look for it some like in November and perhaps be able to answer to
(some) questions.

> Intel on this IP - I went with a safe option of taking this part from
> original Intel patch, which they did for Aero board as the range was
> described there in exactly this way.

> > This *definitely* appears to be board specific configuration and
> > should be defined for the board.
> 
> Above those two points above: I totally agree this is not the
> regulator configuration but rather a specific board one. The only
> thing I was not able to locate is a correct board file to put this
> into.

See below.

> Maybe you or Hans can guide me here on where to have this code as best?
> 
> [Mark]: I *think* drivers/platform/x86 might be what you're looking
> for but I'm not super familiar with x86.  There's also
> arch/x86/platform but I think they're also trying to push things out
> of arch/.

It's more likely drivers/acpi/acpi_lpss.c.

-- 
With Best Regards,
Andy Shevchenko


