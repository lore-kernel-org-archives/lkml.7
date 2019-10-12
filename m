Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1091C4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 14:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F762087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 14:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfJLOGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 10:06:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38358 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfJLOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 10:06:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id u28so8924360lfc.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 07:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24ZirRRGg0v732pLKiSe7vKc4Up3RxG069bpntU0vog=;
        b=lUnmS9osxdIVlpOb8Z/8YAVtfFRBBKBhsPMhu/2sGiiv2W7JDFRo7NrcetTZWZbBud
         PIhzA6RGkgVlJ25lnEcJMUK4ACWFbevrZpJYqcBUGx+BIbUo8aMN7wxuzSXCOi7spZgm
         DwNdG+y7jQ5oqCfCxxX9y2UxWEh+N6eExQ8KxFsM5TiTkxrCZl4l6/E3A7ctRuar+i4k
         bBAHyxIh0+CZRQjtpquPrMQuxomlOad46Hxy0yKX8LTD2lbRC6Z42Heqv40Va3cF19/n
         UQpgQ4g/N+ZW8qjJnz67ZSWM0SCk4hXgoyQbe/9sree9W5W54kF34v1ZqH5nDAZvLaPq
         t6Pg==
X-Gm-Message-State: APjAAAUPZLDoofSnlkRZWWoFkVW4so86+DCiAwUg6QzBpBYojQorm0hz
        z3tVoduU74ehFSp2p94Kuh7F8HlbMh8Rmdnme5o=
X-Google-Smtp-Source: APXvYqz/N44lTDZ3C6FqrxhAQd7CKTW7oprYc+Z10ugHoqrtiYGVXVVSW59S9Syz+o6xNYXpTYTOjsFJe1huv5MMCWw=
X-Received: by 2002:a19:4b8f:: with SMTP id y137mr11923942lfa.19.1570889174048;
 Sat, 12 Oct 2019 07:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org> <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
 <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
 <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com> <CAK8P3a0kBz1-i-3miCo1vMuoM39ivXa3oxOE9VnCqDO-nfNOxw@mail.gmail.com>
 <20191011102747.lpbaur2e4nqyf7sw@willie-the-truck> <73701e9f-bee1-7ae8-2277-7a3576171cd4@huawei.com>
In-Reply-To: <73701e9f-bee1-7ae8-2277-7a3576171cd4@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 12 Oct 2019 16:05:57 +0200
Message-ID: <CAK8P3a1C8cFB6DS9eVXTEiTQu1kPzy65JvL=BxqEe5MTkds8sQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 9:33 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2019/10/11 18:27, Will Deacon wrote:
> [...]
> >
> > Does anybody use BIG_ENDIAN? If we're not even building it then maybe we
> > should get rid of it altogether on arm64. I don't know of any supported
> > userspace that supports it or any CPUs that are unable to run little-endian
> > binaries.
>
> FWIW, massive telecommunication products (based on ARM64) form Huawei are using
> BIG_ENDIAN, and will use BIG_ENDIAN in the near future as well.

Ok, thanks for the information -- that definitely makes it clear that
it cannot go
away anytime soon (though it doesn't stop us from change the
allmodconfig default
if we decide that's a good idea).

Do you know if there are currently any patches against mainline to
make big-endian
work in products, or is everything working out of the box?

     Arnd
