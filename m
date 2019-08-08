Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275EFC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F100C2186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfHHGRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:17:35 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:36025 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728167AbfHHGRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:17:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0DC5D45A6;
        Thu,  8 Aug 2019 06:17:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hand05_7ba727567155
X-Filterd-Recvd-Size: 2020
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 06:17:32 +0000 (UTC)
Message-ID: <2f54e9d0f32dfc66163c3773e93fec14ee1c8c6c.camel@perches.com>
Subject: Re: [PATCH] scripts/checkpatch.pl - fix *_NOTIFIER_HEAD handling
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 07 Aug 2019 23:17:31 -0700
In-Reply-To: <56763.1565244495@turing-police>
References: <33485.1565228181@turing-police>
         <33e3b8748959b2f56b906b0bfd790df322f1ed3c.camel@perches.com>
         <56763.1565244495@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 02:08 -0400, Valdis Klētnieks wrote:
> On Wed, 07 Aug 2019 22:50:47 -0700, Joe Perches said:
> > On Wed, 2019-08-07 at 21:36 -0400, Valdis Kltnieks wrote:
> > >  				^.DEFINE_$Ident\(\Q$name\E\)|
> > >  				^.DECLARE_$Ident\(\Q$name\E\)|
> > >  				^.LIST_HEAD\(\Q$name\E\)|
> > > -				^.{$Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
> > > +				^.${Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
> > 
> > Perhaps also better to convert all the '\Q$name\E' to '\s*\Q$name\E\s*'
> 
> Yes, but that would need to be a separate patch.

Maybe so.

I'm just not a big fan of micro patches.

> The question would be if we
> consider 'DEFINE_foo( barbaz )' and similar with whitespace to be desirable
> style or not.

Oh, it would definitely be an uncomfortable style,
it's just allowing it in the regex.

btw: I'm also fine with it being a separate global patch.

cheers, Joe

> We already have the \s* in one place. Somebody else can decide if it should
> be in the other 5 places or not. :)

Is that supposed to be me? ;)


