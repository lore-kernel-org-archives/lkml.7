Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D49C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD70820830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDCLXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:23:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:35479 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDCLXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:23:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 04:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="139767194"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 03 Apr 2019 04:23:42 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hBdzZ-0001e4-2M; Wed, 03 Apr 2019 14:23:41 +0300
Date:   Wed, 3 Apr 2019 14:23:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>, Yury Norov <ynorov@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] lib: rework bitmap_parselist and tests
Message-ID: <20190403112341.GS9224@smile.fi.intel.com>
References: <20190403044540.16322-1-ynorov@marvell.com>
 <20190403045427.GA16444@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403045427.GA16444@yury-thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 07:54:27AM +0300, Yury Norov wrote:
> On Wed, Apr 03, 2019 at 07:45:35AM +0300, Yury Norov wrote:
> > bitmap_parselist has been evolved from a pretty simple idea for long and
> > now lacks for refactoring. It is not structured, has nested loops and a
> > set of opaque-named variables.
> > 
> > Things are more complicated because bitmap_parselist() is a part of user
> > interface, and its behavior should not change.
> > 
> > In this patchset
> >  - bitmap_parselist_user() made a wrapper on bitmap_parselist();
> >  - bitmap_parselist() reworked (patch 2);
> >  - time measurement in test_bitmap_parselist switched to ktime_get
> >    (patch 3);
> >  - new tests introduced (patch 4), and
> >  - bitmap_parselist_user() testing enabled with the same testset as
> >    bitmap_parselist() (patch 5).
> > 
> > v1: https://lkml.org/lkml/2018/12/23/50
> > v2: https://www.spinics.net/lists/kernel/msg3048976.html
> > v3: Implementation of an approach with copying the data to
> >     kernel space in bitmap_parselist_user() instead of parsing
> >     user data byte by byte. For me, it looks better than v2.

> I'm sorry for noise. My mail server works unstable, and it would be
> better to submit patches 4 and 5 a bit later. They are actually the
> same as in v2.

May you send then v4 with my (and others if any) comments being addressed?

-- 
With Best Regards,
Andy Shevchenko


