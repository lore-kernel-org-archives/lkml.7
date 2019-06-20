Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92320C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BF120673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfFTNme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:42:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:26335 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfFTNmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:42:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 06:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,397,1557212400"; 
   d="scan'208";a="154113089"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2019 06:42:31 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hdxKg-0000fs-6u; Thu, 20 Jun 2019 16:42:30 +0300
Date:   Thu, 20 Jun 2019 16:42:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>
Subject: Re: [PATCH v1 1/2] kernel.h: Update comment about
 simple_strto<foo>() functions
Message-ID: <20190620134230.GA9224@smile.fi.intel.com>
References: <20190619163843.26918-1-andriy.shevchenko@linux.intel.com>
 <CANiq72ko_4cdZOtXxAr3TcorE7Aio3erbNYnUk-JP1aKBpOvuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72ko_4cdZOtXxAr3TcorE7Aio3erbNYnUk-JP1aKBpOvuQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 03:14:20PM +0200, Miguel Ojeda wrote:
> On Wed, Jun 19, 2019 at 6:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > There were discussions in the past about use cases for
> > simple_strto<foo>() functions and in some rare cases they have a benefit
> > on kstrto<foo>() ones.
> >
> > Update a comment to reduce confusing about special use cases.
> 
> I don't recall the discussions anymore... :-) But are we sure
> simple_strtoul() etc. are not obsolete anymore and want to use them
> again?

As I'm explaining there, making them obsolete without providing an alternative
was a not the best move. So, until we have no alternative and, as I pointed
out, we see the patches moving back to simple_strto*() from kstrto*(),
simple_strto*() may be used in some corner cases.

The code in charlcd.c shows a down side of people taking that "obsolete" word
too seriously. Instead of one old good function we have to replicate it many
times.

P.S. Despite the whatever decision will be made on this patch, the second one
makes sense on its own.

-- 
With Best Regards,
Andy Shevchenko


