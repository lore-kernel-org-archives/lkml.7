Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710FBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431B021850
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfCMTPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:15:36 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33943 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfCMTPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:15:32 -0400
Received: by mail-vs1-f65.google.com with SMTP id e126so1515624vse.1;
        Wed, 13 Mar 2019 12:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFIxdQAhhkGV8VPhrx+7Vx5ZiE2NjNFKTCrLqhzBDX0=;
        b=t71sQIoxl1VikU/dd7T48cwFBJ1a2/LyJY9L5CU5Q0ca3/m703k/kIGp8xIfXLTelF
         MSHmDcXVLxHWNSBj92N+YN5G9+NHoz3Yo9Rk3AARHxmv6nErZFz7goiRiYsnRskPkzDb
         klUDspythpmFrYmBqyCfwRszbPwnltdHvPvzeMIEW4YaMfjfGdfmzr4ApA9/4yxVe668
         PEv1B/sF8cryFF8C9o05ERFcVQpE2GvALVMv/ON83Tlypm4y0AS/w71gy0Ftixwxg9vg
         lKVLOlx0+nCnEd9U3rrSFqZ6trOlPQETEZmLPr5ZyrrGjhcL5dbc+3gXjDl8NbkppMV0
         a41Q==
X-Gm-Message-State: APjAAAVd6q/dx/jM/p9lpDtQChoxcuUUkoBqGWRI/r9qcGU8SoZ5AQvn
        QaMvO35q6pG8TjGn/sPyLOlBc9gDgFFqDE56C8Q=
X-Google-Smtp-Source: APXvYqzbEN7/LltuGjmumOnJRO1FDv8QyW/6UQ+RgaWKzvHgW0ONrkJAYdOI7ZgjNrJ7D6VOYxYb5vrUnf9ItLUx6TI=
X-Received: by 2002:a67:8588:: with SMTP id h130mr22710612vsd.11.1552504530660;
 Wed, 13 Mar 2019 12:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190307155506.2993868-1-arnd@arndb.de> <20190311172421.275811128896@debutante.sirena.org.uk>
In-Reply-To: <20190311172421.275811128896@debutante.sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Mar 2019 20:15:18 +0100
Message-ID: <CAMuHMdXeuHwF2y1S=bpvQ_qXn+DYacUSS-uP2Zj9yKiHzghhqQ@mail.gmail.com>
Subject: Re: Applied "spi: work around clang bug in SPI_BPW_RANGE_MASK()" to
 the spi tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Mar 11, 2019 at 6:26 PM Mark Brown <broonie@kernel.org> wrote:
> The patch
>
>    spi: work around clang bug in SPI_BPW_RANGE_MASK()
>
> has been applied to the spi tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> From eefffb42f6659c9510105f3e4ebf2a8499d56936 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 7 Mar 2019 16:54:21 +0100
> Subject: [PATCH] spi: work around clang bug in SPI_BPW_RANGE_MASK()
>
> Clang-8 evaluates both sides of a ?: expression to check for
> valid arithmetic even in the side that is never taken. This
> results in a build warning:
>
> drivers/spi/spi-sh-msiof.c:1052:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>         .bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32),
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Change the implementation to use the GENMASK() macro that does
> what we want here but does not have a problem with the shift
> count overflow.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/linux/spi/spi.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 662b336aa2e4..b27386450089 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -444,8 +444,7 @@ struct spi_controller {
>         /* bitmask of supported bits_per_word for transfers */
>         u32                     bits_per_word_mask;
>  #define SPI_BPW_MASK(bits) BIT((bits) - 1)
> -#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
> -#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
> +#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)

This is not correct: GENMASK() order is from msb to lsb.
So it should it:

+#define SPI_BPW_RANGE_MASK(min, max) GENMASK((max) - 1, (min) - 1)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
