Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4318CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C3B206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKNOBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:01:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:40074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbfKNOBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:01:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06CC0ABCE;
        Thu, 14 Nov 2019 14:01:16 +0000 (UTC)
Date:   Thu, 14 Nov 2019 15:01:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] checkpatch: don't warn about new vsprintf pointer
 extension '%pe'
Message-ID: <20191114140116.ycfbrl7arzoa4e76@pathway.suse.cz>
References: <20191114100416.23928-1-u.kleine-koenig@pengutronix.de>
 <20191114102440.msyuahilbagaz7aw@pathway.suse.cz>
 <20191114103350.z3fe4vzgepsb52y6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191114103350.z3fe4vzgepsb52y6@pengutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-11-14 11:33:50, Uwe Kleine-König wrote:
> On Thu, Nov 14, 2019 at 11:24:40AM +0100, Petr Mladek wrote:
> > On Thu 2019-11-14 11:04:16, Uwe Kleine-König wrote:
> > > This extension was introduced in commit 57f5677e535b ("printf: add
> > > support for printing symbolic error names").
> > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 6fcc66afb088..31cd9b767c1e 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -6022,7 +6022,7 @@ sub process {
> > >  				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
> > >  					$specifier = $1;
> > >  					$extension = $2;
> > > -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
> > > +					if ($extension !~ /[SsBKRraeEhMmIiUDdgVCbGNOxt]/) {
> > 
> > I am going to push it into printk.git. I will just change the ordering
> > "eE" -> "Ee". So that it follows the existing convention.
> 
> Fine for me. Thanks

The patch is committed in printk.git, branch for-5.5.

Best Regards,
Petr
