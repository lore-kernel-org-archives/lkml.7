Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457FAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203C520862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfJCMXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:23:01 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35884 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbfJCMXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:23:00 -0400
X-IronPort-AV: E=Sophos;i="5.67,252,1566856800"; 
   d="scan'208";a="404566184"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 14:22:58 +0200
Date:   Thu, 3 Oct 2019 14:22:58 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Yuehaibing <yuehaibing@huawei.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [RFC PATCH] scripts: Fix coccicheck failed
In-Reply-To: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910031422240.2406@hadrien>
References: <20190928094245.45696-1-yuehaibing@huawei.com> <alpine.DEB.2.21.1909280542490.2168@hadrien> <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com> <alpine.DEB.2.21.1909291810300.3346@hadrien> <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
 <alpine.DEB.2.21.1910011500470.13162@hadrien> <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Oct 2019, Masahiro Yamada wrote:

> On Tue, Oct 1, 2019 at 10:01 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > > diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
> > > index c832bb6445a8..99e93a6c2e24 100644
> > > --- a/scripts/coccinelle/misc/add_namespace.cocci
> > > +++ b/scripts/coccinelle/misc/add_namespace.cocci
> > > @@ -6,6 +6,8 @@
> > >  /// add a missing namespace tag to a module source file.
> > >  ///
> > >
> > > +virtual report
> > > +
> > >  @has_ns_import@
> > >  declarer name MODULE_IMPORT_NS;
> > >  identifier virtual.ns;
> > >
> > >
> > >
> > > Adding virtual report make the coccicheck go ahead smoothly.
> >
> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> >
>
>
> Was this patch posted somewhere?

It was probably waiting for moderation in the cocci mailing list.  Do you
have it now (or in a few minutes)?

julia
