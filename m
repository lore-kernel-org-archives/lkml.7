Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611DBC73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3364020693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfGJHSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:18:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40480 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJHSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:18:12 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so836287oie.7;
        Wed, 10 Jul 2019 00:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+66WptPslvEPgd/65JkLpfo/5RQSrFyShnLhyw9s5hs=;
        b=fWUS0Xr/QRTsmeu6u0oXHc0trHvii3RL4dDi9/7UhwtUEy9OXNO/GjOOeCtsPyh1rB
         C4MdDpR+Os9nYrLeJNEdOCjYzj8psH/Sb6fBxfoy9ziXcfQ96AUgu6IAVp8Xz32OVh8U
         zA9LgacKsJ2eJxbgaWJwVISTyalyGFJi3Ovs5z29KMs5DBFgZVIT/xp/sSYG8AU1kBLO
         NyTm/+ckq4CO2sL84Jr1qwryJZ3m7wq2uUu0fcnV3GTNS5zpKrtp8FZlcn39tjHAIyDZ
         iLi3bplCH6K7KwSb2AfGfDAL+erwF6D8/vC3O63oi7DUjRAnM0dgumGCml9TFNk0Ps1d
         VRGQ==
X-Gm-Message-State: APjAAAUVIzGFL28oNbqSgD1EaY7ZviLDdVRAwSq+WmJ1kgjhKUxnn3lG
        RfgbeXGyEbPEcgiog9AQn/RCQrM+NlQiLtMrnpBV2bXW
X-Google-Smtp-Source: APXvYqy2I+l892aw7i5aJ/0OUWJQ+Pt3I+xgUHl3uaQiFntdXS8NhASUc/nbjpE8yzmZmtEsYh/zZ4RBTRxDM5p/o6E=
X-Received: by 2002:aca:bd43:: with SMTP id n64mr2302244oif.148.1562743091643;
 Wed, 10 Jul 2019 00:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <cf9d62c7-2b47-e234-ee35-2562b125a411@linux-m68k.org>
In-Reply-To: <cf9d62c7-2b47-e234-ee35-2562b125a411@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Jul 2019 09:18:00 +0200
Message-ID: <CAMuHMdVTq1mftwsLuePwzNN33bsNFWyL99bwnvJLhAO0RgSeXQ@mail.gmail.com>
Subject: Re: [git pull] m68knommu changes for v5.3
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Jul 10, 2019 at 7:22 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> Can you please pull the m68knommu git tree, for-next branch.
>
> A series of cleanups for the FLAT format binary loader, binfmt_flat,
> from Christoph. The end goal is to support no-MMU on RISC-V, and the
> last patch enables that.

Please note there will be two add/add merge conflicts in
arch/m68k/Kconfig.  The correct resolution is to keep the additions from
both sides (and keep them sorted).

Sorry for the troubles.

Thanks!

> The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:
>
>    Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next
>
> for you to fetch changes up to ad97f9df0fee4ddc9ef056dda4dcbc6630d9f972:
>
>    riscv: add binfmt_flat support (2019-06-24 09:16:47 +1000)

>   arch/m68k/Kconfig                                  |  2 +

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
