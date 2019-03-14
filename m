Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7265A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfCNMSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:18:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:8576 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbfCNMSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:18:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 05:18:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="131599582"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 14 Mar 2019 05:18:13 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h4PJM-0004j0-04; Thu, 14 Mar 2019 14:18:12 +0200
Date:   Thu, 14 Mar 2019 14:18:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Spelvin <lkml@sdf.org>
Cc:     geert@linux-m68k.org, 13@sdf.org, akpm@linux-foundation.org,
        daniel.wagner@siemens.com, dchinner@redhat.com,
        don.mullis@gmail.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, st5pub@yandex.ru
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
Message-ID: <20190314121811.GY9224@smile.fi.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>
 <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>
 <20190309140653.GO9224@smile.fi.intel.com>
 <201903091553.x29FrfMR018600@sdf.org>
 <20190314092958.GV9224@smile.fi.intel.com>
 <201903141009.x2EA9q1Z025888@sdf.org>
 <CAMuHMdW0jd-oNtgBf=aHfzVoBbVh0OJYC6ELhDv3VrcGwUECwA@mail.gmail.com>
 <201903141153.x2EBrtKi000133@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903141153.x2EBrtKi000133@sdf.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:53:55AM +0000, George Spelvin wrote:
> On Thu, 14 Mar 2019 at 11:41:26 +0100, Geert Uytterhoeven wrote:
> > On Thu, Mar 14, 2019 at 11:10 AM George Spelvin <lkml@sdf.org> wrote:
> >> On Sat, 09 Mar 2019 at 23:19:49 +0300, Andrey Abramov wrote:
> >>>> How about one of:
> >>>> swap_bytes / swap_ints / swap_longs
> >>>> swap_1 / swap_4 / swap_8
> >>>
> >>> longs are ambiguous, so I would prefer bit-sized types.
> >>
> >> I already implemented Andrey's suggestions, which were the exact
> >> opposite of yours.
> >>
> >> Pistols at dawn?

> I just want to pick some names and move on.  Since nothing so far seems
> satsify everyone, I'll go with the ponderous but utterly unambiguous:

> swap_bytes
> swap_4byte_words
> swap_8byte_words

Works for me, or if someone insists it might be also bits there.

-- 
With Best Regards,
Andy Shevchenko


