Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B6EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349CE20842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403970AbfIFG7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:59:06 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:48530
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391691AbfIFG7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:59:06 -0400
X-IronPort-AV: E=Sophos;i="5.64,472,1559512800"; 
   d="scan'208";a="318476281"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 08:59:02 +0200
Date:   Fri, 6 Sep 2019 08:59:02 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Stephen Boyd <swboyd@chromium.org>,
        YueHaibing <yuehaibing@huawei.com>,
        kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH -next] coccinelle: platform_get_irq: Fix parse error
In-Reply-To: <7818ad20-615c-2ce9-c0d1-3f7a09bedf34@web.de>
Message-ID: <alpine.DEB.2.21.1909060857290.2975@hadrien>
References: <5d71eb6f.1c69fb81.31bc8.da2d@mx.google.com> <7818ad20-615c-2ce9-c0d1-3f7a09bedf34@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Sep 2019, Markus Elfring wrote:

> > > minus: parse error:
> > >   File "./scripts/coccinelle/api/platform_get_irq.cocci", line 24, column 9, charpos = 355
> > >   around = '\(',
> > >   whole content = if ( ret \( < \| <= \) 0 )
> > >
> > > In commit e56476897448 ("fpga: Remove dev_err() usage
> > > after platform_get_irq()") log, I found the semantic patch,
> > > it fix this issue.
> > >
> > > Fixes: 98051ba2b28b ("coccinelle: Add script to check for platform_get_irq() excessive prints")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > ---
> >
> > Hmm I had this earlier but someone asked me to change it.
>
> I proposed something also during the development for this SmPL script.
> https://lkml.org/lkml/2019/7/24/274
> https://lore.kernel.org/r/c98b8f50-1adf-ea95-a91c-ec451e9fefe2@web.de/

Markus,

This is not the first time you have suggested to someone to do something
that was simply incorrect.  Please actually test your suggestions before
proposing them.

> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
> Should disjunctions eventually work in the semantic patch language also together with
> comparison operators?
> https://github.com/coccinelle/coccinelle/issues/40

No.

> Will any additional software adjustments be taken into account?

No.

julia
