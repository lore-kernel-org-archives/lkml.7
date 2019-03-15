Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4399EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB072064A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfCOTGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:06:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:47804 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfCOTGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:06:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 12:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,483,1544515200"; 
   d="scan'208";a="307604600"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2019 12:06:15 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h4s9m-00040C-6K; Fri, 15 Mar 2019 21:06:14 +0200
Date:   Fri, 15 Mar 2019 21:06:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrey Abramov <st5pub@yandex.ru>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        George Spelvin <lkml@sdf.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Dave Chinner <dchinner@redhat.com>,
        Don Mullis <don.mullis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove
 MAX_LIST_LENGTH_BITS
Message-ID: <20190315190614.GH9224@smile.fi.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>
 <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>
 <20190314091041.GU9224@smile.fi.intel.com>
 <201903150433.x2F4X9oT024601@sdf.org>
 <CAMuHMdVF6pQ_-vidvtAyacOHw8WsJp4esu7o7o9DoR_GLahnzA@mail.gmail.com>
 <201903151023.x2FANDVY013031@sdf.org>
 <CAMuHMdVgmb8eZ7bD+jye8DG7cQRywvVmwo_XNJ00f198pDcwxQ@mail.gmail.com>
 <201903151659.x2FGxi3R012970@sdf.org>
 <CAMuHMdV_Y8COyhExkf-rj1oC39iDyf3iPrN2FxH8tQnmpi6D3g@mail.gmail.com>
 <23331552675987@myt2-66bcb87429e6.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23331552675987@myt2-66bcb87429e6.qloud-c.yandex.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 09:53:07PM +0300, Andrey Abramov wrote:
> > I'm trying to present the case to spur discussion, but it realy is
> > a *question* I'm asking about whether to do that, not a suggestion
> > phrased as a question.
> 
> > If it's just x86_64, use size_t everywhere, and let them suffer, for not
> > being real 64-bit ;-)
> 
> But what is the problem of local typedef with a good and clear comment?

It makes harder to read and understand the code. One needs spend deciseconds /
seconds to catch instead of santiseconds of time.

-- 
With Best Regards,
Andy Shevchenko


