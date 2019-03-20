Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7644C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928C12186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfCTOiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:38:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:35040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfCTOiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:38:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE399ABD5;
        Wed, 20 Mar 2019 14:38:00 +0000 (UTC)
Date:   Wed, 20 Mar 2019 15:38:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v1] lib/test_printf: Switch to bitmap_zalloc()
Message-ID: <20190320143800.trp2nnb4rd2fhwap@pathway.suse.cz>
References: <20190304100009.65147-1-andriy.shevchenko@linux.intel.com>
 <20190308093729.pkuvwb44zmeyiknb@pathway.suse.cz>
 <20190318151255.GV9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318151255.GV9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-03-18 17:12:55, Andy Shevchenko wrote:
> On Fri, Mar 08, 2019 at 10:37:29AM +0100, Petr Mladek wrote:
> > On Mon 2019-03-04 12:00:09, Andy Shevchenko wrote:
> > > Switch to bitmap_zalloc() to show clearly what we are allocating.
> > > Besides that it returns pointer of bitmap type instead of opaque void *.
> 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Thanks!
> 
> > I have already sent pull request for 5.1. I could put it into
> > printk.git, for-5.2 branch.
> 
> It's not in v5.1-rc1, so, feel free to proceed as usual thru your tree.

I have commited the patch into printk.git, branch for-5.2.

Best Regards,
Petr
