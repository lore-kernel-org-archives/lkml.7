Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68529C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6D62073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VgRGuQWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404405AbfHBInM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:43:12 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:61191 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbfHBInM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:43:12 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x728h6K2001670;
        Fri, 2 Aug 2019 17:43:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x728h6K2001670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564735387;
        bh=wardMXZhqHfzRdaUlSRopeNLdww/l/rmzyPDmUhlXoo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VgRGuQWUqhWhXTBkiq4DIonh2QCcj/QII79U1nOFS+0JcL4bpKDpYrxykm3tnyvll
         n1Ee5JP7t9W00qU/H9nOYEcFZbHArDCHE3NoTVMNBbbXXy9Zzot4keYIQKUyaCCjDC
         gq0jZaiJHoB51JXyk7csyKde3gmsp0uCjNBBQ9Btz9CJTv0B1KvZ1IQU34rWuhIUMr
         Vmaj6IZ8GyWFf5XQlbjF1xMXJFsfYsfFGZF6e1krbFxMtAPFF+z+Wsw/wM17JAV7VD
         MFT7kpGiY6fEzGGpB3/qeCdQ7X21CIqyyPVOB5LJ0Go3YJEP5ZGU+1en/oOXY2ed+8
         5rBEWfAnGzDTg==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id h28so50790795vsl.12;
        Fri, 02 Aug 2019 01:43:07 -0700 (PDT)
X-Gm-Message-State: APjAAAVPpNcPs9acSAhXYvK7ueGc7sLMrO+qy5LqtZUz4MzC+L0Ss+jx
        JHlKPc5zlFyutq8VsiRp3mTNWW1zgjEFADoZo7I=
X-Google-Smtp-Source: APXvYqxb7HdOEocm1IkNIV8cZl+5shkbOoifQs/U/sfBj+Ev+87riBEz7Tu/XQyoeC1AxLbAnSyV3St7fc8y/cJtAOw=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr61970449vsd.215.1564735386265;
 Fri, 02 Aug 2019 01:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190728161304.32022-1-yamada.masahiro@socionext.com> <20190729105125.GA4787@sirena.org.uk>
In-Reply-To: <20190729105125.GA4787@sirena.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 2 Aug 2019 17:42:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASq-WB5zJ+3uFHtzxtc2Vhmv5SKRXA2JwwFGrR5q9uMnw@mail.gmail.com>
Message-ID: <CAK7LNASq-WB5zJ+3uFHtzxtc2Vhmv5SKRXA2JwwFGrR5q9uMnw@mail.gmail.com>
Subject: Re: [RFC PATCH] spi: tle620x: remove stale driver
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 7:51 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jul 29, 2019 at 01:13:04AM +0900, Masahiro Yamada wrote:
> > This driver seems obsolte because this driver needs platform data
> > but no one in upstream passes it.
>
> I've not noticed this driver getting in the way of anything?


I just happened to take a look at include/linux/spi/tle62x0.h
when I was working on my header-test feature of Kbuild.

Then, I asked this in ML, and Arnd was positive
for deleting this.

https://lkml.org/lkml/2019/7/21/19


IMHO, stale code should be cleaned away periodically.

Yet, if you are happy with keeping this driver,
that is fine.

If we could get comments from Ben Books,
that would be helpful.




-- 
Best Regards
Masahiro Yamada
