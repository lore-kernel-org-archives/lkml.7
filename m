Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F33C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9AB2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCRPNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:13:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:22133 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfCRPNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:13:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 08:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="283673128"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2019 08:12:57 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h5twd-0003Hf-Uo; Mon, 18 Mar 2019 17:12:55 +0200
Date:   Mon, 18 Mar 2019 17:12:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v1] lib/test_printf: Switch to bitmap_zalloc()
Message-ID: <20190318151255.GV9224@smile.fi.intel.com>
References: <20190304100009.65147-1-andriy.shevchenko@linux.intel.com>
 <20190308093729.pkuvwb44zmeyiknb@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308093729.pkuvwb44zmeyiknb@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:37:29AM +0100, Petr Mladek wrote:
> On Mon 2019-03-04 12:00:09, Andy Shevchenko wrote:
> > Switch to bitmap_zalloc() to show clearly what we are allocating.
> > Besides that it returns pointer of bitmap type instead of opaque void *.

> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks!

> I have already sent pull request for 5.1. I could put it into
> printk.git, for-5.2 branch.

It's not in v5.1-rc1, so, feel free to proceed as usual thru your tree.

-- 
With Best Regards,
Andy Shevchenko


