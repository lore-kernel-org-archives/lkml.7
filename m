Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B950C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3F6217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GrB3IVz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbfISHWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:22:20 -0400
Received: from mout.web.de ([212.227.15.4]:34853 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731332AbfISHWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568877726;
        bh=7dGKxNg1lmQXT8lGJndJckUV18hrnw5+dgPKGe14doo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GrB3IVz9qeQ0vqLDL2UfhQAe1dGg1NiTY8gLPwxVNC4RMWGb+8w7CGSf3+I3ZFX9O
         WoMuHcxloi5ftp3c0UB/UJaBUJyKhi9+BngqQ52+srUDbLQRoA94UJFZrtb6dyGKpq
         eN3i4cUY0qIFzREJuzhZBIHfiAyUY6JDBhKZe13k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.191.36]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MD8RQ-1iRJpq39Tg-00GX4M; Thu, 19
 Sep 2019 09:22:06 +0200
Subject: Re: Coccinelle: api: add devm_platform_ioremap_resource script
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Enrico Weigelt <lkml@metux.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <alpine.DEB.2.21.1907061538580.2523@hadrien>
 <de953581-7ae6-952c-3922-3d5b25f48e17@web.de>
 <CAK7LNAT0kxA53k894sfRXOjcbyjj_mmY60JbKy5Lhi2qHJcC9g@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2cacd712-a8b8-6471-a9b4-23ba54434c02@web.de>
Date:   Thu, 19 Sep 2019 09:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT0kxA53k894sfRXOjcbyjj_mmY60JbKy5Lhi2qHJcC9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0LmJoyNAlb/AJ85ryhxw17ZkpmIe5sWs1JjSRHJRh3ikTTvsHs6
 jI9Kwx8lvB+A8UHQJALEKRKl1XeXjclQ3Rbe4lEt8DMyaRfQfvMA1IJ9E5vDGyZimkuSrMl
 Bl3AJOP6m25zPdYHpZrokbT/fS++ZyQG1xy+Hj5FIlTNF0KExfKVKKJOh8vz+XYAql9yiKM
 lRnZDKF279I8WVLkYEIdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9yA0HZ7SvJU=:Sjj9PEzIyzwPbg8xxTZI7J
 fTnxdJ+BczECGuQtdYvUl7lsLzoUt2KciMRzyUB28jC8xhYBUqc0dVxf3tP29HSB9OYIJc2Or
 b5nwTcyETFia+aH+Tapcr5mAQ0A1OcVmEL/F2CPPc/Csm/lXWnq5gQPj42A5NmaOnDcW/Qb6+
 SZkANfZYYl3+Oe9vs5ZRZQkxOliPUL6uoL9NsONL1nQ1nLH7Cnf7pEnlIpZfr4yL5lCqHISb7
 akdMuWCZACuz/XeQ/NJvJuP8f94cPdaVuas1sS9VKwKX0n3RzB0PRx+b1RTb4dbSiegBzkI1l
 wmewjM3krsWIYcP/8S7Hejf7BeN5XnjBaV7jk+CMhjIzwTsNbRuBEODrDZFIyMWfd58ZJgaDf
 opMhEjvC/dOn0ZN5ZCDecXzXssWOydfvRcpdJ2K9X6n10JIZZlHw4XKrDliwpi2q5GbIrmOtA
 z50sGI7mwY0XPgCUYXPt9FKs/hkvJaS/rTcbCCMeRbUhU3UOhXC4CAIA4lxPNL/wzYfpvbmgb
 Nw88mspl+Km0ya6622b5iTR536zterU6ypYet2NvKAaQFydiaYGEtmpa8NF6LFOEM/vAgIL41
 YPzeGIi+fTsJaqyZ7m2AO9NRvNlrf4QHOKfEfYg4/Toaf1a5rf9mBpaNBtGiMyuVCQURR2VDZ
 C2RBEMbEGBREpG1GNnRkJGy50l9nWYW/jjiYpBKJVfRAMbjpSY0cQLo6FJE9Vwhyv2+DI5QdI
 m+E4HUrbI5ym1fpt9epPRs4pqlNQXlVUWErTptO07Ouz1shqORcMbC/hsp4DhrL8/GpCeMeRr
 1r2JByEw8x27TvDIJ85+q3XWsTbbMblXt8Z7kQ1ad3KNAF6OFjEnQZnoJoyf6AOMnpMJTj/t7
 hUCqV1BC2SrLiEwWLtyPQ5oAew/fyjks3L1nV78ylH/vvJrOtakFnWo/b5q31zFTdldSkGdLj
 WjkhoP1ltL54mvmaPCEFXDJYOdIuGiaD7KZX+hPVuyTljdHb+W/W1qn1YT/nU/ZywPqaSM5J5
 IV7vFuTj/17msK0Gzbq5N/0jiJO4TiAeWGsx/YB4vES5cgZLk8NYcMMiUEa4IcobEkls9X8rI
 k3STZmXEy16wpXO1FFG7LHiJfNlOc9RutOyW3kUoTszNL8r1n8sspnreU2Snh7ztOs7ahl0Mp
 N6TRnlF9dgE7zGdPjIpAvp99nw5POQjGPgkhA4NT2EWJpZcnyA+1XJOuOvQlIEXddkXvkeZIN
 ywlMaplF/E0CMay1kEU3FKm4NbClRtKiBpjP0rFnvv0+g0S2248g4jmipKL4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, for this refactoring to happen,
> the second argument should be IORESOURCE_MEM
> instead of generic 'arg2'.

A corresponding adjustment was committed on 2019-07-17.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
scripts/coccinelle/api/devm_platform_ioremap_resource.cocci?id=3Dd09778d16=
e20bc4f1f4971cc9a9fd7ff6ba898ff

I constructed another variant of a script for the semantic patch language
based on this contribution.
I tried out to delete a bit of exception handling code after a call
of the function =E2=80=9Cplatform_get_resource=E2=80=9D.
Yesterday I sent a selection of patches from this transformation approach.
(An analysis based on =E2=80=9CLinux next-20190916=E2=80=9D pointed 56 sou=
rce files
as update candidates out.)

Will it be useful to integrate such a case distinction into
the SmPL script directory?


The analysis based on the committed SmPL script pointed 657 source files
as update candidates out.
So there are further opportunities for collateral software evolution.
Can it become easier to check how many update suggestions are already
in corresponding patch review queues?

Regards,
Markus
