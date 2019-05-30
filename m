Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D42C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529AA241ED
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfE3Lx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:53:29 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:42105 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbfE3Lx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:53:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 89010180A8845;
        Thu, 30 May 2019 11:53:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: title56_1e125b3cd2115
X-Filterd-Recvd-Size: 1797
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 May 2019 11:53:26 +0000 (UTC)
Message-ID: <7bd46e20c28f8f0a1b7b4ba49c151860bf6c58f1.camel@perches.com>
Subject: Re: [PATCH 1/2] add typeof_member() macro
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Alexey Dobriyan' <adobriyan@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 30 May 2019 04:53:24 -0700
In-Reply-To: <a32bb1376821422fa3c647c01f3f1a95@AcuMS.aculab.com>
References: <20190529190720.GA5703@avx2>
         <a32bb1376821422fa3c647c01f3f1a95@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-30 at 11:37 +0000, David Laight wrote:
> From: Alexey Dobriyan
> > Sent: 29 May 2019 20:07
> > 
> > Add typeof_member() macro so that types can be exctracted without
> > introducing dummy variables.
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  include/linux/kernel.h |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -88,6 +88,8 @@
> >   */
> >  #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
> > 
> > +#define typeof_member(T, m)	typeof(((T*)0)->m)

>
> Should probably be 't' (not 'T') and upper case ?
> 
> Hmmm.... the #define is longer that what it expands to ...

While I did object to the avoidance in the obvious
misnaming of FIELD_SIZEOF, this could reasonably
be named FIELD_TYPEOF for symmetry.


