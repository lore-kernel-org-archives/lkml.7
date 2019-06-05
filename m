Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D13FC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59AB206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kiWAsPzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfFEGUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:20:25 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:53717 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfFEGUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:20:24 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x556K9Te018192
        for <linux-kernel@vger.kernel.org>; Wed, 5 Jun 2019 15:20:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x556K9Te018192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559715610;
        bh=Ojboyi9ZYqHo5qkbWSZookahlhHYjfJvXncHmnUVX7w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kiWAsPzD3A2U5JCaZA1yCur4gPQVsZoQFvLRwgdSbsfgdtnKj8Co9QhLEsduv/8zY
         eovuP/IWHJffnX+mktAFQi/JxGU4IDi5Yw9pJSm3c18dDTpbaIrK40ZhCYB76W/+CB
         xGALKCCI03OJffIiRybiGDrsU6ANGHvUFyqzcAlk6bPh/iPgRI9Tm0ezKN/uCHkE7a
         7Q6iNAcF05acWT9ISSZ65LzVnb6X9hsr0hEeUQVw8smTzzaH1Sx4uEiQNlc3GeA0NI
         33fNl1ACcYgLgSKnMiiv0ryveXAej0Sp+SeAZuJkY6fsSFUMuXp3ATKsK5179HbzOV
         ldvWYNlyGB1rQ==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id u124so4488025vsu.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 23:20:10 -0700 (PDT)
X-Gm-Message-State: APjAAAXWmMxp2iBMbF8Fas0aPsvEuAUPNiiufDluekVt3aKLj+BFB941
        ZIZC5YmjtNqidG0PdRNB3ivhd1HU21RxNXfPkYg=
X-Google-Smtp-Source: APXvYqx9aJlOShxCbPONz1FJbnW7ROQjQspurPhnUr26ELCgRss/o+Jqn0R1OZa2rU+KJVG0SjOGUKrBJKkbvtFW3Zc=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr605229vsl.155.1559715609026;
 Tue, 04 Jun 2019 23:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190527083412.26651-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190527083412.26651-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 5 Jun 2019 15:19:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvOC-TsJbGA2-0i5tDtHkoL4o8jdFn5_MghY5UzXd-iA@mail.gmail.com>
Message-ID: <CAK7LNARvOC-TsJbGA2-0i5tDtHkoL4o8jdFn5_MghY5UzXd-iA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allow assembly code to use BIT(), GENMASK(), etc. and
 clean-up arm64 header
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Is this series applicable to arm64 tree?

Thanks.

On Mon, May 27, 2019 at 5:37 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
>
> Some in-kernel headers use _BITUL() instead of BIT().
>
>  arch/arm64/include/asm/sysreg.h
>  arch/s390/include/asm/*.h
>
> I think the reason is because BIT() is currently not available
> in assembly. It hard-codes 1UL, which is not available in assembly.
>
> 1/2 replaced
>    1UL -> UL(1)
>    0UL -> UL(0)
>    1ULL -> ULL(1)
>    0ULL -> ULL(0)
>
> With this, there is no more restriction that prevents assembly
> code from using them.
>
> 2/2 is a clean-up as as example.
>
> I can contribute to cleanups of arch/s390/, etc.
> once this series lands in upstream.
>
> I hope both patches can go in the arm64 tree.
>
>
>
> Masahiro Yamada (2):
>   linux/bits.h: make BIT(), GENMASK(), and friends available in assembly
>   arm64: replace _BITUL() with BIT()
>
>  arch/arm64/include/asm/sysreg.h | 82 ++++++++++++++++-----------------
>  include/linux/bits.h            | 17 ++++---
>  2 files changed, 51 insertions(+), 48 deletions(-)
>
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
