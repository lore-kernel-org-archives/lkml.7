Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1998EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE77A222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XjDCVYJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfKMLqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:46:55 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:41915 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfKMLqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:46:55 -0500
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id xADBkm9a015831;
        Wed, 13 Nov 2019 20:46:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xADBkm9a015831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573645609;
        bh=1ubNpZLrnhXlyu3RPs3fBr0mVNdSQ/kPzqbpM1dwK0M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XjDCVYJUixS5Ds0Nn5xpa3r3yDjHmUzBHWeTCoFZciGpGr/OLXQOkty/wONciIYak
         KwiYYIN2wcrS7wREc2WjNCys4DxuuPzCRNcR46/4A5ZH0DV7sZRYmfGtH3nxDr3w67
         uZQVMnOyhvvSSGies+IxoCGRuBUVOGlyL2p4Y60fqDMovZg+ctbo3m/ue6Qix7jDKO
         um0RlS/Er1sCqCjH79JRIOEsHYHWCfAmKNZp5Q63M/SykJxMU1kKx/zzUIAM9rao2Y
         TwJt9MzUQzHI+yiUuTPcghSDV/n/q6+CDZR6dJ8rpRVYQsShC2vG8o6P6aeqA2kvva
         moXX4WaV+WvIA==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id r4so475673vkf.9;
        Wed, 13 Nov 2019 03:46:48 -0800 (PST)
X-Gm-Message-State: APjAAAWGGPxvZFGN8d6K/UhkJLuXVajvajsOSbtroL2+/UzMUlD19HG3
        zfglmyH4hOhrvnMTJpSMGW1hJDMwZ6X6/1qcFSY=
X-Google-Smtp-Source: APXvYqxCOSvbIgyJn7QaXffqBOHdbUYvifvtpftshC0h8o88zZUjvsKEOaHwO3irsjmKGOAP57sDoaRv0X99WX7ByBA=
X-Received: by 2002:a1f:6a43:: with SMTP id f64mr16682vkc.96.1573645607742;
 Wed, 13 Nov 2019 03:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20191018045053.8424-1-yamada.masahiro@socionext.com> <20191018101510.GA1172290@kroah.com>
In-Reply-To: <20191018101510.GA1172290@kroah.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Nov 2019 20:46:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS3oYkaBTG+59prgu0Yqxn=2vi94mjHbKdx7TXBkPy5Xw@mail.gmail.com>
Message-ID: <CAK7LNAS3oYkaBTG+59prgu0Yqxn=2vi94mjHbKdx7TXBkPy5Xw@mail.gmail.com>
Subject: Re: [PATCH] export,module: add SPDX GPL-2.0 license identifier to
 headers with no license
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 7:15 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 18, 2019 at 01:50:53PM +0900, Masahiro Yamada wrote:
> > Commit b24413180f56 ("License cleanup: add SPDX GPL-2.0 license
> > identifier to files with no license") took care of a lot of files
> > without any license information.
> >
> > These headers were not processed by the tool perhaps because they
> > contain "GPL" in the code.
> >
> > I do not see any license boilerplate in them, so they fall back to
> > GPL version 2 only, which is the project default.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Ah, nice catch!
>
> I'll queue this up to my spdx tree if no one objects.
>
> thanks,
>
> greg k-h


No objection (comment) so far.

I think it is OK to apply this.



-- 
Best Regards
Masahiro Yamada
