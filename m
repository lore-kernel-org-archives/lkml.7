Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8253C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD922084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfJKWsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 18:48:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34698 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfJKWsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 18:48:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so10395159qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 15:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOKIN9Nyp1JbsZ7BUkjibIlWkzxw3BXcx3Hv1FQA6jE=;
        b=KualsdexNgkQX8jeKWQwszOWaakiOl4IrKR9HozgZCubunWStkVpW8jIOpgMLaxAfH
         mydk7pGzQ3vo2wEtsmNvxdLRMz6Txm0JafpMbHKQhYsorT0zgrfxy/Kbpbiiwg/R8JRl
         jiRZwKOifim1CjNEh9uTcAf+QyBjusMVugXB6XiObkpo5O0sgW/BO4tOIwEp5opSCZDz
         Z+9OHgLjzyjOAIkZU3cT+oAlXHi4hqXky2DL0ODpf29ba4aPJ6pOviEgvoLWszB0Rc14
         bMtddVZP1a8Ldn+T+6vv9xZHLqGX4h+pUutlFmkq6bl35feGXQpTkwuCRHlI2w/SDDUm
         V+8w==
X-Gm-Message-State: APjAAAX2+tmQUQhc0ERmNwrN3XLduJaAx5ALxQ44xcT8mFuEbYbEDPDl
        g9uKe2V1TFadyeFrmLX5hPgk4zGjU4tH74Lc4aA=
X-Google-Smtp-Source: APXvYqwY0ItApn6Ic7IwoO2WjxHjjLQlid2e5HLIE2yCMJII+3/pFE7ZZeN+anW8mmfuckghY9tUfC0lFrSLy9QTGz0=
X-Received: by 2002:a05:620a:218f:: with SMTP id g15mr17971150qka.3.1570834081941;
 Fri, 11 Oct 2019 15:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org> <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
 <CADYN=9LB9RHgRkQj=HcKDz1x9jqmT464Kseh2wZU5VvcLit+bQ@mail.gmail.com>
 <d978673e-cbd1-5ab5-b2a4-cdb407d0f98c@huawei.com> <CAK8P3a0kBz1-i-3miCo1vMuoM39ivXa3oxOE9VnCqDO-nfNOxw@mail.gmail.com>
 <20191011102747.lpbaur2e4nqyf7sw@willie-the-truck> <20191011103342.GL25745@shell.armlinux.org.uk>
In-Reply-To: <20191011103342.GL25745@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 12 Oct 2019 00:47:45 +0200
Message-ID: <CAK8P3a1ADTc0woWWNjpeqYEtgb=snj264P4QNWOj7ZRMDv8WNg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chunrong Guo <chunrong.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 12:33 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Oct 11, 2019 at 11:27:48AM +0100, Will Deacon wrote:
> > Does anybody use BIG_ENDIAN? If we're not even building it then maybe we
> > should get rid of it altogether on arm64. I don't know of any supported
> > userspace that supports it or any CPUs that are unable to run little-endian
> > binaries.

So far, all 'allmodconfig' builds are big-endian and have been that way
since the option was first added, so build coverage is something we
have plenty of. It's also covered by randconfig testing, regardless of
the default endianess.

> 32-bit ARM experience is that telco class users really like big
> endian.

Right, basically anyone with a large code base migrated over from a
big-endian MIPS or PowerPC legacy that found it cheaper to change
the rest of the world than to fix their own code. The only other example
of this I heard of besides networking was from banking, where they
looked at moving from AIX on PowerPC to Linux on something cheaper,
but IIRC they ended up going with LE after all because of the lack
of distro support.

Whether any users remain in use at this time, I don't know. As most
of the larger machines require UEFI to boot, they are currently limited
to little-endian for all practical purposes, and smaller embedded
machines tend to have a smaller amount of legacy code and are
easier to move over to little-endian.

One recent reference I could find is specifically for the NXP
Layerscape LS1043 in
https://www.nxp.com/docs/en/application-note/AN5129.pdf
which apparently has some support in their codewarrior tools
for big-endian binaries.

There are also some recent openembedded bugfixes for
big-endian arm64 from NXP:
https://www.mail-archive.com/meta-freescale@yoctoproject.org/msg22378.html

Adding Chungrong Guo to Cc for additional insight on whether
they expect any notable big-endian users in the future.

      Arnd
