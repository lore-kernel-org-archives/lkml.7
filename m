Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13710CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18AF208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfJaPJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:09:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:49684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfJaPJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:09:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C1D0DB6A3;
        Thu, 31 Oct 2019 15:09:53 +0000 (UTC)
Date:   Thu, 31 Oct 2019 16:09:52 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Joe Perches <joe@perches.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add VSPRINTF
Message-ID: <20191031150952.3ag6qa5y4wvikd76@pathway.suse.cz>
References: <20191031133337.9306-1-pmladek@suse.com>
 <975eccc7-897c-fd14-ef4f-2486729eb67c@rasmusvillemoes.dk>
 <20191031145112.thphlpnjvnykbzyy@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031145112.thphlpnjvnykbzyy@pathway.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-10-31 15:51:12, Petr Mladek wrote:
> On Thu 2019-10-31 14:51:24, Rasmus Villemoes wrote:
> > On 31/10/2019 14.33, Petr Mladek wrote:
> > > printk maintainers have been reviewing patches against vsprintf code last
> > > few years. Most changes have been committed via printk.git last two years.
> > > 
> > > New group is used because printk() is not the only vsprintf() user.
> > > Also the group of interested people is not the same.
> > 
> > Can you add
> > 
> > R: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Sure. The more reviewers the better :-)

I acutally wanted to add also

R: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Best Regards,
Petr
