Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A7C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F432089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bPxfmijn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbfG3JpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:45:02 -0400
Received: from mout.web.de ([212.227.17.11]:43495 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfG3JpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564479878;
        bh=MY54GGbC141du76k5DNyzhowvZ4ieKymVNXH6luDQVs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bPxfmijnrVSQ/qVxRleJUN1DF2vfAQ26bNSDs7xGlnO71dF5UiLUVVoSJXzAx02TF
         gH5W78RxtGYEOYRu0uQL5u/9AoUV6YgwtBdtjx2UYspykbYy6DgtwFx6yyC26AGPwI
         ME9hWQbY77P9tC57BKZAbmsjEeaTwJ31EmQbDH6U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.24.141]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LilNJ-1iVJns47u1-00cyuH; Tue, 30
 Jul 2019 11:44:38 +0200
Subject: Re: [PATCH v5 1/3] driver core: platform: Add an error message to
 platform_get_irq*()
To:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190730053845.126834-1-swboyd@chromium.org>
 <20190730053845.126834-2-swboyd@chromium.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <314f06fe-fbc9-c2f5-72bf-657c04cce4b0@web.de>
Date:   Tue, 30 Jul 2019 11:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730053845.126834-2-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GXxzrWFDRkIgIlgPCpsNHWvg1H+x1iJD1iZGZnDI6XEdgOrC6HW
 ACnzPbsYyx8CuNQyxlVU649mny8ZpaJ1/HMcInaGsgb3WwJfuYIlRUSCxZvwqjL8dWdiT/S
 Pz1rxVy484lxXnhSzTZyMOu68VwsjrnUtG+5e3Vpz/hOMtqwIeuKXOH3GL6WwIFmQKrIfDM
 lboJBq8YPHQIBQPSiVjgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V0D0W2HJBto=:qe56jn5ZjC+qAozNfflu0F
 sfbXSjqc0XLO4m76wJxFlg5rck3QHPy8nr+1ym0EIoqQ/AUKOqJgVuKd88KT4HR1OIgI5k4xt
 bS8pDnlvIf9DflbXQUsAahk3CLO30l5yEevMsKTk96snr2IB1QIEfMaOuYmfh7pF3CEQ90rg4
 rcdhw/KJ785XA8jrxrG2qFAbJy8LzwAp2d4DyRjcIRW6iawRGQ99M6zy43F7LXmA9TP23lM2Y
 SV4Es0kXd70kB20HmglpBD18bD5/jefye95v6yMjz+AwwVC0vsgx+uMnpEVsna2iQCEJsZNbY
 Z1oSDO80jOSff16yvg0m2IYwa28iiZClbHaYRNiiqtR10xfpFrJGLwPU9B4JTU/3N2aQT5WUW
 xm17NvjnnlLsG2EJi0iiHbDBRZleW+ps65pZEg9J+oJuVwT80BEVzaSea2lDMyJCfjN8ELbxe
 cmxfln5qXKkPwc60ALqmPcb3QyzVI3m62+H/u+L/zErDrKKX2E02tmgC/d5GjOsopZ7H5/bnY
 xX70FoFoGxb2LVUGVS7YNiy4b8ZHI+OPAIjEBrR9tHqqVC8wlVcBwl+a9KtdYcZl0PFuUzIQ9
 K40uJbheGLueCZIXI+BMER+y576UJjDa7TZzl3gWdJpysi/Z97RP6m1795pCY03ZmWBNPjzdd
 V9E+4wHWZIQ1gAZMNUMtOc6JRvAZvWnQui6JWBz7Gl3s1GjZhsoJ18reevpLNfFsfq5RGRfvy
 5PlejcCkZTMr7lOp3Wt67v0K3xr4PqrbUeTuK/h4+Fzsax7BBevbaULCE1KqmuIPsr/wrt6/3
 bL65h6kXvEDdhMk/UEbPGz/sm7LmETYfWxSvRB8xSbwzlnnMzIh+4Ho+/5h501A7y8PE4ULwe
 RNKJrtQhPdiHyK9DTzM4xL9uOM7ify540JnW1FWs1A37LkbITqN35raV5bXv4yFVAJg1fI529
 1Os3+hjK4bK4BaTMdiLfDY3JDVAH+AIQ4b7XVUJYEVDxFC6yML78VHdCCv19W+qff1M9Zlip4
 iiDBfqRomsX574EOS7WLw4nSpUMY3KaBq9YGCneciMARWpZZhF43s2BY3d+T4iCfd6dBSf/o1
 FBUIetLQpZhBCPRDsUVXNZQBI0U8yEWRru0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/drivers/base/platform.c
> @@ -99,12 +99,7 @@ void __iomem *devm_platform_ioremap_resource(struct p=
latform_device *pdev,
=E2=80=A6
> -int platform_get_irq(struct platform_device *dev, unsigned int num)
> +static int __platform_get_irq(struct platform_device *dev, unsigned int=
 num)
>  {
=E2=80=A6

I suggest to avoid the usage of double underscores in such identifiers.
Will an other function name be more appropriate here?

Regards,
Markus
