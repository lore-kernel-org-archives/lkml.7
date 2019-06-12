Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60173C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4282B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfFLF2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 01:28:52 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:16276 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725681AbfFLF2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 01:28:52 -0400
X-IronPort-AV: E=Sophos;i="5.63,363,1557180000"; 
   d="scan'208";a="386977124"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 07:28:48 +0200
Date:   Wed, 12 Jun 2019 07:28:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
cc:     Markus Elfring <Markus.Elfring@web.de>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: Coccinelle: api: add devm_platform_ioremap_resource script
In-Reply-To: <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
Message-ID: <alpine.DEB.2.21.1906120727300.2535@hadrien>
References: <20190406061112.31620-1-himanshujha199640@gmail.com> <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de> <alpine.DEB.2.21.1906081925090.2543@hadrien> <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de> <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-133965833-1560317328=:2535"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-133965833-1560317328=:2535
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 11 Jun 2019, Enrico Weigelt, metux IT consult wrote:

> On 09.06.19 10:55, Markus Elfring wrote:
>
> <snip>
>
> >> But there is not usually any interesting formatting on the left side of an
> >> assignment (ie typically no newlines or comments).
> >
> > Is there any need to trigger additional source code reformatting?
> >
> >> I can see no purpose to factorizing the right parenthesis.
> >
> > These characters at the end of such a function call should be kept unchanged.
>
> Agreed. OTOH, we all know that spatch results still need to be carefully
> checked. I suspect trying to teach it all the formatting rules of the
> kernel isn't an easy task.
>
> > The flag “IORESOURCE_MEM” is passed as the second parameter for the call
> > of the function “platform_get_resource” in this refactoring.
>
> In that particular case, we maybe should consider separate inline
> helpers instead of passing this is a parameter.
>
> Maybe it would even be more efficient to have completely separate
> versions of devm_platform_ioremap_resource(), so we don't even have
> to pass that parameter on stack.

I'm lost as to why this discussion suddenly appeared.  What problem is
actually being discussed?

julia
--8323329-133965833-1560317328=:2535--
