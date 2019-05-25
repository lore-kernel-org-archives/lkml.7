Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DC7C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7747B21848
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfEYFHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:07:00 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:40968 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfEYFHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:07:00 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x4P56m4K020716;
        Sat, 25 May 2019 07:06:48 +0200
Date:   Sat, 25 May 2019 07:06:48 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [A General Question] What should I do after getting Reviewed-by
 from a maintainer?
Message-ID: <20190525050648.GA20705@1wt.eu>
References: <20190523011723.GA15242@zhanggen-UX430UQ>
 <7510e8a7-3567-fc22-d8e3-6d6142c06ff3@infradead.org>
 <20190525021241.GA11472@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525021241.GA11472@zhanggen-UX430UQ>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 10:12:41AM +0800, Gen Zhang wrote:
> On Fri, May 24, 2019 at 04:21:36PM -0700, Randy Dunlap wrote:
> > On 5/22/19 6:17 PM, Gen Zhang wrote:
> > > Hi Andrew,
> > > I am starting submitting patches these days and got some patches 
> > > "Reviewed-by" from maintainers. After checking the 
> > > submitting-patches.html, I figured out what "Reviewed-by" means. But I
> > > didn't get the guidance on what to do after getting "Reviewed-by".
> > > Am I supposed to send this patch to more maintainers? Or something else?
> > > Thanks
> > > Gen
> > > 
> > 
> > [Yes, I am not Andrew. ;]
> > 
> > Patches should be sent to a maintainer who is responsible for merging
> > changes for the driver or $arch or subsystem.
> > And they should also be Cc-ed to the appropriate mailing list(s) and
> > source code author(s), usually [unless they are no longer active].
> > 
> > Some source files have author email addresses in them.
> > Or in a kernel git tree, you can use "git log path/to/source/file.c" to see
> > who has been making & merging patches to that file.c.
> > Probably the easiest thing to do is run ./scripts/get_maintainer.pl and
> > it will try to tell you who to send the patch to.
> > 
> > HTH.
> > -- 
> > ~Randy
> Thanks for your patient instructions, Randy! I alrady figured it out.

Then if your question is what to do with these "Reviewed-by", you should
edit your patches and place these fields next to your Signed-off-by line
to indicate that these persons have reviewed this code (and didn't have
anything particular to say about it). From this point you should not
modify the patches with this tag.

When you'll resend your final series to the maintainer, it will include
all these reviewed-by tags and will generally save the maintainer some
review time by skipping some of them.

Willy
