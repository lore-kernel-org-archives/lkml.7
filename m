Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F4C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 17:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E462146E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 17:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfFHR1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 13:27:02 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:64960 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbfFHR1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 13:27:02 -0400
X-IronPort-AV: E=Sophos;i="5.63,568,1557180000"; 
   d="scan'208";a="386580694"
Received: from unknown (HELO hadrien) ([89.191.33.34])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2019 19:26:59 +0200
Date:   Sat, 8 Jun 2019 19:26:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Himanshu Jha <himanshujha199640@gmail.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: Coccinelle: api: add devm_platform_ioremap_resource script
In-Reply-To: <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
Message-ID: <alpine.DEB.2.21.1906081925090.2543@hadrien>
References: <20190406061112.31620-1-himanshujha199640@gmail.com> <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jun 2019, Markus Elfring wrote:

> > +- e1 = devm_ioremap_resource(arg4, id);
> > ++ e1 = devm_platform_ioremap_resource(arg1, arg3);
>
> Can the following specification variant matter for the shown SmPL
> change approach?
>
> + e1 =
> +-     devm_ioremap_resource(arg4, id
> ++     devm_platform_ioremap_resource(arg1, arg3
> +                           );

In the latter case, the original formatting of e1 will be preserved.  But
there is not usually any interesting formatting on the left side of an
assignment (ie typically no newlines or comments).  I can see no purpose
to factorizing the right parenthesis.

julia
