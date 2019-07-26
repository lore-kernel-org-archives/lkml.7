Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A0BC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5346722BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbfGZS6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:58:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:48122 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387743AbfGZS6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:58:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 11:58:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="254416434"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga001.jf.intel.com with ESMTP; 26 Jul 2019 11:58:27 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hr5Q9-0006XZ-Lr; Fri, 26 Jul 2019 21:58:25 +0300
Date:   Fri, 26 Jul 2019 21:58:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Shaohua Li <shli@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, Coly Li <colyli@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] md: Convert to use int_pow()
Message-ID: <20190726185825.GC9224@smile.fi.intel.com>
References: <20190723204155.71531-1-andriy.shevchenko@linux.intel.com>
 <20190726164823.GB9224@smile.fi.intel.com>
 <F7CF9393-B366-4810-B127-876C6D5A72A1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7CF9393-B366-4810-B127-876C6D5A72A1@fb.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 05:18:09PM +0000, Song Liu wrote:
> 
> 
> > On Jul 26, 2019, at 9:48 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > On Tue, Jul 23, 2019 at 11:41:55PM +0300, Andy Shevchenko wrote:
> >> Instead of linear approach to calculate power of 10, use generic int_pow()
> >> which does it better.
> > 
> > I took into Cc drivers/dm guys as they might have known something about md raid
> > state of affairs. Sorry if I mistakenly added somebody.
> > 
> > Who is doing this?
> > Should it be orphaned?
> > 
> > (I got a bounce from Shaohua address)
> 
> I process the patch. Sorry for the delay.

Ah, no problem, thanks!

Perhaps someone can update MAINTAINERS data base?

-- 
With Best Regards,
Andy Shevchenko


