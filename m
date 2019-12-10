Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B75AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2726220663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfLJISF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:18:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40726 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfLJISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:18:04 -0500
Received: by mail-oi1-f195.google.com with SMTP id 6so9007804oix.7;
        Tue, 10 Dec 2019 00:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0t6BygI7LR4P3npISzoIFLrulT/ZjkgVbIJ3rXhwSlA=;
        b=oeCpT5aNr/Pz6ppqL+xXfcrmSk72WEuB5gCm/FN2WUh4saC79v5FaOHEU4sXfqh3lW
         DbdWYzF9T3Ma+bwXHNmozeo9KBE5SJVZEGlL5gVijltp3m//wqT4CmF0PC0o/nrqBzSP
         uxmh+uQ56Q1ErOZbpEbydZMHzNCbWsqx2rtRK6o/EqobPb/EFf9ybzKPnD0V30/dzOyj
         ehmiWfKCmjbt3O4iYC+Pr15Znd9n+9b/Bg8ZtFWxa/Ro9oXY9PEVFnEnkRWFXypj0IVp
         fGCCSHBEUO6LSK8H2DYhaJnwXfst6t3VqP9mGMrqN8pmp+G5yFHy+2OLOhqABeFIMdg7
         QeTg==
X-Gm-Message-State: APjAAAXOcvirUrF1TyITJaSZrtODraSG2pmz1X2E2OkjxGINQ2zvhouT
        PkthYX211rlI8ccE7SsiR0S/a6N55CvHT4vG5Hv1+7NZ
X-Google-Smtp-Source: APXvYqwrZUEYZojjfpkgjPqaUslY8uQ/wa/kO+nTiz8i0MhyFYjSfBho3TmcDZZMDxjNKXhATPaCB4+jCWZLuvoBX/E=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr3059534oia.102.1575965883580;
 Tue, 10 Dec 2019 00:18:03 -0800 (PST)
MIME-Version: 1.0
References: <87muc1yqip.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87muc1yqip.wl-kuninori.morimoto.gx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 09:17:52 +0100
Message-ID: <CAMuHMdUqSFhUScPJWqaBLO2zzX=qtp-dmh3y+jsJ0wX7j=P8Hw@mail.gmail.com>
Subject: Re: [PATCH][resend] sh: kgdb: Mark expected switch fall-throughs
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

On Tue, Dec 10, 2019 at 1:26 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> I'm posting this patch from few month ago,
> but it seems SH ML maintainer is not working in these days...
>
> I'm not sure who can handle this patch in this case,
> but is it possible to consider about it ?

You may want to CC Andrew Morton <akpm@linux-foundation.org>, who
tends to pick up patches for non-responsive architecture maintainers.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
