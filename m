Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C8C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 13:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5572075B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 13:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfGFNjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 09:39:15 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:41061
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbfGFNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 09:39:15 -0400
X-IronPort-AV: E=Sophos;i="5.63,458,1557180000"; 
   d="scan'208";a="312640623"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2019 15:39:12 +0200
Date:   Sat, 6 Jul 2019 15:39:11 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Himanshu Jha <himanshujha199640@gmail.com>,
        kernel-janitors@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: api: add devm_platform_ioremap_resource
 script
In-Reply-To: <CAK7LNARTJpxRmQzx+vQGfOC5YFuw8QsRQ=_9=9E=g5p62UUf6g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907061538580.2523@hadrien>
References: <20190406061112.31620-1-himanshujha199640@gmail.com> <alpine.DEB.2.21.1904060831120.4486@hadrien> <alpine.DEB.2.21.1904060833160.4486@hadrien> <CAK7LNARTJpxRmQzx+vQGfOC5YFuw8QsRQ=_9=9E=g5p62UUf6g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jul 2019, Masahiro Yamada wrote:

> On Sat, Apr 6, 2019 at 3:34 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> >
> > On Sat, 6 Apr 2019, Julia Lawall wrote:
> >
> > >
> > >
> > > On Sat, 6 Apr 2019, Himanshu Jha wrote:
> > >
> > > > Use recently introduced devm_platform_ioremap_resource
> > > > helper which wraps platform_get_resource() and
> > > > devm_ioremap_resource() together. This helps produce much
> > > > cleaner code while removing local `struct resource` declaration.
> > > >
> > > > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> > >
> > > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> > >
> > > Thanks for taking up this issue.
> >
> > Maybe this should be
> >
> > Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
> >
> > since I contributed two lines to the script :)
>
> I will apply with Julia's Signed-off-by instead of Acked-by.
> I will also add SPDX tag.
>
> Is this OK?

Yes, thanks.

julia

>
>
>
> > julia
> >
> > >
> > > julia
> > >
> > > > ---
> > > >
> > > > Tree wide changes has been tested through 0-day test service
> > > > with build success.
> > > >
> > > > BUILD SUCCESS 74ebaaca5d14d3d9b03e911f0b4995b78a4d60f0
> > > > tree/branch: https://github.com/himanshujha199640/linux-next  20190401-devm_platform_ioremap_resource-final
> > > > branch HEAD: 74ebaaca5d14d3d9b03e911f0b4995b78a4d60f0  Coccinelle: api: Add devm_platform_ioremap_resource.cocci
> > > >
> > > > elapsed time: 385m
> > > > configs tested: 162
> > > >
> > > >
> > > > Stats:
> > > > 916 files changed, 1028 insertions(+), 2921 deletions(-)
> > > >
> > > > Note: cases where the `struct resource *res` variable is
> > > > used subsequently in the function have been ignored out because
> > > > those cases produce:
> > > >
> > > > eg., drivers/bus/da8xx-mstpri.c
> > > >
> > > > warning: 'res' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > > >
> > > > due to:
> > > >     if (prio_descr->reg + sizeof(u32) > resource_size(res)) {
> > > >
> > > > which seems correct as `res` isn't initialized in the scope of
> > > > the function(da8xx_mstpri_probe) and instead initialized inside:
> > > >
> > > >    void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
> > > >                                                 unsigned int index)
> > > >    {
> > > >            struct resource *res;
> > > >
> > > >            res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> > > >            return devm_ioremap_resource(&pdev->dev, res);
> > > >    }
> > > >    EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> > > >
> > > >
> > > >  .../api/devm_platform_ioremap_resource.cocci  | 63 +++++++++++++++++++
> > > >  1 file changed, 63 insertions(+)
> > > >  create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
> > > >
> > > > diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
> > > > new file mode 100644
> > > > index 000000000000..a28274af14df
> > > > --- /dev/null
> > > > +++ b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
> > > > @@ -0,0 +1,63 @@
> > > > +/// Use devm_platform_ioremap_resource helper which wraps
> > > > +/// platform_get_resource() and devm_ioremap_resource() together.
> > > > +///
> > > > +// Confidence: High
> > > > +// Copyright: (C) 2019 Himanshu Jha GPLv2.
> > > > +// Copyright: (C) 2019 Julia Lawall, Inria/LIP6. GPLv2.
> > > > +// Keywords: platform_get_resource, devm_ioremap_resource,
> > > > +// Keywords: devm_platform_ioremap_resource
> > > > +
> > > > +virtual patch
> > > > +virtual report
> > > > +
> > > > +@r depends on patch && !report@
> > > > +expression e1, e2, arg1, arg2, arg3, arg4;
> > > > +identifier id;
> > > > +@@
> > > > +
> > > > +(
> > > > +- id = platform_get_resource(arg1, arg2, arg3);
> > > > +|
> > > > +- struct resource *id = platform_get_resource(arg1, arg2, arg3);
> > > > +)
> > > > +  ... when != id
> > > > +- e1 = devm_ioremap_resource(arg4, id);
> > > > ++ e1 = devm_platform_ioremap_resource(arg1, arg3);
> > > > +  ... when != id
> > > > +? id = e2
> > > > +
> > > > +@r1 depends on patch && !report@
> > > > +identifier r.id;
> > > > +type T;
> > > > +@@
> > > > +
> > > > +- T *id;
> > > > +  ...when != id
> > > > +
> > > > +// ----------------------------------------------------------------------------
> > > > +
> > > > +@r2 depends on report && !patch@
> > > > +identifier id;
> > > > +expression e1, e2, arg1, arg2, arg3, arg4;
> > > > +position j0;
> > > > +@@
> > > > +
> > > > +(
> > > > +  id = platform_get_resource(arg1, arg2, arg3);
> > > > +|
> > > > +  struct resource *id = platform_get_resource(arg1, arg2, arg3);
> > > > +)
> > > > +  ... when != id
> > > > +  e1@j0 = devm_ioremap_resource(arg4, id);
> > > > +  ... when != id
> > > > +? id = e2
> > > > +
> > > > +// ----------------------------------------------------------------------------
> > > > +
> > > > +@script:python depends on report && !patch@
> > > > +e1 << r2.e1;
> > > > +j0 << r2.j0;
> > > > +@@
> > > > +
> > > > +msg = "WARNING: Use devm_platform_ioremap_resource for %s" % (e1)
> > > > +coccilib.report.print_report(j0[0], msg)
> > > > --
> > > > 2.17.1
> > > >
> > > >
> > >
> > _______________________________________________
> > Cocci mailing list
> > Cocci@systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
>
>
>
> --
> Best Regards
> Masahiro Yamada
>
