Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D659C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7922189D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfH0JZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:25:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46986 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfH0JZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:25:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id z51so30385095edz.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 02:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1Hq21GWlHfVsAHB0YA3+1WJiGcX5YVFh0QLDfo8rZM=;
        b=ew5YJbaZrvSRCv6nd5/sbAA8bkyhhLmp5RMX1708o9tCnEFwGhPrmiMY44CluYw+Tg
         owytqJyhGU83XG3oyeDfCC0hm/UlTwbERQWAk2IGVSYhbpmmFdhgq0iY12x+s14DPPaP
         EMwrr5iSTDRcT9mzLAJMChSZSZrHMR4j1dldYTOHTnSBYYf4oXyyTfkjQfqsAWQ2srg6
         2zygl06B7jOebnb9VamP0hnRR27YSaViwM6fLB8tqvtuYZmlDCbXVGAwwiKfq+M8YR7Y
         7YVW7LgFmJ6dBMmt21sdtCFoD8Wxljzsvh6BeO/qRgYNGJwkjMUTXIY0JwOSvJH6qnW2
         bN9Q==
X-Gm-Message-State: APjAAAVPwQYB1PrOj+mH3gtrMYgDVJefiYcvUQ65LQegRCZ3f/zskjzb
        KZDGlRhypoEtvID25YTqLfOCv9IEhLA=
X-Google-Smtp-Source: APXvYqz0Fdq0n1EiOxnTqPjqmMew/WgpvsvUxbDYzqYdlBkpjz/OhmLPNoI3JoaacLS8bcJSAa0Vtg==
X-Received: by 2002:a17:906:1dd6:: with SMTP id v22mr20499049ejh.277.1566897933881;
        Tue, 27 Aug 2019 02:25:33 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id w3sm1798265edq.12.2019.08.27.02.25.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 02:25:33 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id p17so18023499wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 02:25:33 -0700 (PDT)
X-Received: by 2002:adf:e941:: with SMTP id m1mr2612297wrn.279.1566897933029;
 Tue, 27 Aug 2019 02:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <0e5b4abf06cd3202354315201c6af44caeb20236.1566242458.git-series.maxime.ripard@bootlin.com>
 <20190820174105.96899274314F@ypsilon.sirena.org.uk>
In-Reply-To: <20190820174105.96899274314F@ypsilon.sirena.org.uk>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 27 Aug 2019 17:25:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v64vzcZbXqfW27cgobpQ-AXQjb2zanqotAR0ezw+6KCdpw@mail.gmail.com>
Message-ID: <CAGb2v64vzcZbXqfW27cgobpQ-AXQjb2zanqotAR0ezw+6KCdpw@mail.gmail.com>
Subject: Re: Applied "ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer
 SoCs" to the asoc tree
To:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 21, 2019 at 1:41 AM Mark Brown <broonie@kernel.org> wrote:
>
> The patch
>
>    ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer SoCs
>
> has been applied to the asoc tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4
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
> From c1d3a921d72bd21f266ca28c15213fbe78160a4b Mon Sep 17 00:00:00 2001
> From: Maxime Ripard <maxime.ripard@bootlin.com>
> Date: Mon, 19 Aug 2019 21:25:16 +0200
> Subject: [PATCH] ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer SoCs
>
> From: Marcus Cooper <codekipper@gmail.com>

The authorship of this patch looks to be wrong. Maybe it's a tooling issue.
I imagine it might have happened if Maxime created the patches using
`git format-patch` with his @bootlin.com address, then sent them with his
@kernel.org address, and `git send-email` swapped out the "From:" header
and prepended it to the body.

Either way the "From:" line looks odd in the commit log.

ChenYu

> The clock division dividers have changed between the older (A10/A31) and
> newer (H3, A64, etc) SoCs.
>
> While this was addressed through an offset on some SoCs, it was missing
> some dividers as well, so the support wasn't perfect. Let's introduce a
> pointer in the quirk structure for the divider calculation functions to use
> so we can have the proper range now.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> [Maxime: Fix the commit log, use a field in the quirk structure]
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Link: https://lore.kernel.org/r/0e5b4abf06cd3202354315201c6af44caeb20236.1566242458.git-series.maxime.ripard@bootlin.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
