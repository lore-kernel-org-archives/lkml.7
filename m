Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCAEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257B520856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfCZKQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:16:03 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:38371 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbfCZKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:16:03 -0400
X-IronPort-AV: E=Sophos;i="5.60,271,1549926000"; 
   d="scan'208";a="375784174"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 11:16:00 +0100
Date:   Tue, 26 Mar 2019 11:15:59 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Markus Elfring <Markus.Elfring@web.de>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [PATCH] coccinelle: put_device: reduce false positives
In-Reply-To: <20190326101103.GH32613@kadam>
Message-ID: <alpine.DEB.2.20.1903261115300.5021@hadrien>
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn> <179bbdd1-3fcb-bba5-52b3-7f96973c7650@web.de> <alpine.DEB.2.21.1903232104030.5660@hadrien> <20190326084512.GC32590@kadam> <alpine.DEB.2.20.1903261037320.5021@hadrien>
 <20190326101103.GH32613@kadam>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-730138997-1553595359=:5021"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8323329-730138997-1553595359=:5021
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 26 Mar 2019, Dan Carpenter wrote:

> On Tue, Mar 26, 2019 at 10:38:43AM +0100, Julia Lawall wrote:
> >
> >
> > On Tue, 26 Mar 2019, Dan Carpenter wrote:
> >
> > > On Sat, Mar 23, 2019 at 09:06:54PM +0100, Julia Lawall wrote:
> > > >
> > > >
> > > > On Sat, 23 Mar 2019, Markus Elfring wrote:
> > > >
> > > > > > Don't complain about a return when this function returns "&pdev->dev".
> > > > >
> > > > > Would this information qualify to add the tag “Fixes” to the commit message?
> > > >
> > > > Fixes tags relate to stable kernels, so that one can see which stable
> > > > kernels a particular patch should be propagated to.  There is no need to
> > > > propagate patches on semantic patches to stable kernels.  People who run
> > > > stable kernels are interested in their behavior, not the bug finding
> > > > rules that they contain.
> > >
> > > The Fixes tag is not just about stable...  For example, we use them for
> > > statistics to see how quickly bugs get fixed etc.
> >
> > OK.  But still do we need fixes tags for bug finding rules?  Perhaps if
> > the previous version was really broken, and it would be really undesirable
> > to use it.
>
> It's not worth resending a patch for that, but I probably would use the
> fixes tag.  It depends on your definition of "bug" really...  I tell
> people not to use Fixes for spelling mistakes and unused variables.  But
> I do use the Fixes tag for things like "an off by one in a sanity check
> which doesn't affect run time because the index is always correct".

OK, thanks.

julia
--8323329-730138997-1553595359=:5021--
