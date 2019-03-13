Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE068C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A1A2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfCMV7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:59:46 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38657 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMV7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:59:45 -0400
Received: by mail-vs1-f66.google.com with SMTP id h132so2020276vsd.5;
        Wed, 13 Mar 2019 14:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lceU+y3Bfo27v0Ch861coZu7GL6x7dsXYtJWRpQdd9A=;
        b=Tjt4dSpNe4vsFkF/kK6tlTOckJaffbxw46GNhb7hw2t3C3u8AnG2MsGcAxJ0HLx2Qq
         JmjBrdJLXp3IPJLs0uSZFsA77VRcIFBFjK33arAcM9zlx2XZgxEWB3WV1KH7FsSEPmRR
         xmJJ++xCZA14sHlGJtr8Q1gq7CNXGQLrnZbl4Ohv3OZeWD0bHSSkrWe6KVAZHCrkQG7C
         iLez/9tYjAfAIV3I4qAX7uDKzRkg76Im47VbyKelMjUS+VQvBVS1SNxse5tXKgkPpDT/
         PNYY6LKTTr8maYcXYLwiWsy/TmmpsJ9OhjKcQq23tKtYWwVnGmlsLBqyTUiq7kbVqn3M
         dReQ==
X-Gm-Message-State: APjAAAUVS4g+REubBRL+w/+qpc5kFR3+izqaypHPVlAKMd5q/ROM7f2S
        y2/p7CL2AxjYGWBl8mPPAmeNHyhyr+B8rzPu7Q/IOmBw
X-Google-Smtp-Source: APXvYqzdX/rw32Sc0T+CpWOmmUEGi2JC0YkteSTdjdtXZ05YUo+JCGL7mYq0V5WegBewnmmCJmv66ejGq2r410IvTjk=
X-Received: by 2002:a67:ebcd:: with SMTP id y13mr2469898vso.152.1552514384582;
 Wed, 13 Mar 2019 14:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190313210118.3507256-1-arnd@arndb.de>
In-Reply-To: <20190313210118.3507256-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Mar 2019 22:59:33 +0100
Message-ID: <CAMuHMdUBZRxE-E8T03C85B5-UeM+ofLSbZhyRKWHrcmQksQvag@mail.gmail.com>
Subject: Re: [PATCH] spi: fix SPI_BPW_RANGE_MASK() regression
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 10:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Geert points out that I confused the min/max arguments that are
> reversed between SPI_BPW_RANGE_MASK() and GENMASK(). This time
> I have verified the result of the macro after fixing the arguments.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: eefffb42f665 ("spi: work around clang bug in SPI_BPW_RANGE_MASK()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
