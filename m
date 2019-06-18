Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732F1C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2512084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfFRHYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:24:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36853 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFRHYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:24:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so12012720ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vww4gF/9h7dDeufpKWDU6hTs9TyDrRL/grObKHzNy0Q=;
        b=nudEp50eKPaOi0UxwETFyxOeUbDZU+lUIyqRZXWL4lYmaYkm3FHZzDSV1SLDzve25g
         rXQaC1pO9c5P4trXwepzgMrtpUnC3f171id6yzn7Z7JhuDDx7GScxypS5Ln89ckhJxae
         pU9emtrqGw2nVjuGFzQfrw/i42vhMdnZYnpC8jg7+qr4V706cgvRePCtI0seS2CxW0o4
         RpnUKtbL6QbDPFUSrEF/8qFxtVicmZDsnoTxo9AfVudtNTjdssDb3LTxM6rDXz/RziS9
         L8SwKSJUdHrOqNEWr6N6UvyoHNhb3XBbv8nG6gjz8I1Wd1uloDE32HEl9Rhsm7gwqbNC
         xvvw==
X-Gm-Message-State: APjAAAVdJfI/pieaH/eyNZ8Li5DCagY3ES8OWx6IDRtK7vHYEKCfxjX5
        yNk9x8NzaQ/LreYHO4IPQRsqLCTkAqLBlz3mXPo=
X-Google-Smtp-Source: APXvYqyhbIZwb3rY0t46VAbU/ee00LM6NJrGGTiQk8GC3qtaQCqHwgfE8FknXhKhY/vvUxzPbvE+4f9B6QySz3NFGNA=
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr38257300ljl.21.1560842651347;
 Tue, 18 Jun 2019 00:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190617144048.5450-1-geert+renesas@glider.be> <20190617151335.GW5316@sirena.org.uk>
In-Reply-To: <20190617151335.GW5316@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jun 2019 09:23:58 +0200
Message-ID: <CAMuHMdXqSL6h6uk15hm9nvG3PsODRvAxbqGJD_x=pBBhgNKYMw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Add missing newline at end of file
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Jun 17, 2019 at 5:13 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jun 17, 2019 at 04:40:48PM +0200, Geert Uytterhoeven wrote:
>
> >  sound/usb/bcd2000/Makefile         | 2 +-
>
> This isn't ASoC but I'm just going to go ahead and apply it on the basis

You're right, sorry for missing that.

> that it's trivial and more trouble than it's worth to split or anything
> like that.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
