Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3847FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E220820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409434AbfJQPC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:02:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:54702 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731768AbfJQPC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:02:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B3B6B62F;
        Thu, 17 Oct 2019 15:02:24 +0000 (UTC)
Date:   Thu, 17 Oct 2019 17:02:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] printf: add support for printing symbolic error names
Message-ID: <20191017150223.aqvz3skqribze7e4@pathway.suse.cz>
References: <20191011133617.9963-1-linux@rasmusvillemoes.dk>
 <20191015190706.15989-1-linux@rasmusvillemoes.dk>
 <CAHp75Vcw9Wn6a2VEhQ00o1FZq=egtiQGjC1=uX1J71wQ9pf-pw@mail.gmail.com>
 <20191016145208.dqvquyw2m4o5skbz@pathway.suse.cz>
 <CAHp75Vdov2m5hb9ot3A8paPvUCympmktYtW9A5QEZ2TdBX_1Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdov2m5hb9ot3A8paPvUCympmktYtW9A5QEZ2TdBX_1Xw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-10-16 19:31:33, Andy Shevchenko wrote:
> On Wed, Oct 16, 2019 at 5:52 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Wed 2019-10-16 16:49:41, Andy Shevchenko wrote:
> > > On Tue, Oct 15, 2019 at 10:07 PM Rasmus Villemoes
> > > <linux@rasmusvillemoes.dk> wrote:
> > >
> > > > +const char *errname(int err)
> > > > +{
> > > > +       const char *name = __errname(err > 0 ? err : -err);
> > >
> > > Looks like mine comment left unseen.
> > > What about to simple use abs(err) here?
> >
> > Andy, would you want to ack the patch with this change?
> > I could do it when pushing the patch.
> 
> Looks good to me.
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

The patch has been committed into printk.git, branch for-5.5.

Best Regards,
Petr
