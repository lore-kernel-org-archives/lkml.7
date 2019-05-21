Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF3EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAC521773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfEUOMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:12:55 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39279 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbfEUOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:12:54 -0400
Received: by mail-vs1-f67.google.com with SMTP id m1so11205771vsr.6;
        Tue, 21 May 2019 07:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meuwVDcWiHzKd3QLlto0JwOFJrZ32Pszf+ArvDouslQ=;
        b=pqef8omwxkDWoCqZX8cMEp4TDVoKsXf4MAsPd4I9QxxYBZIbbfgM7Y5UP0veI2LiGh
         QmkNiZlWWtVCoWXqNiv90Lnxi6Okl11EyO0hb+OvSA6yge9XcUvSP77XA2L8NDliEpIn
         csFvEZG1Mo1AdjP5swiUWwpdT3NHZ9DzEm9kgatxV4O+/aQzss5Bvi7bza1ZLO1D+69G
         Ld37mcjLDbtc27izCuutLLJo1AHZAGRxBa6Dc3Sh+4ZuGFA//ggUoChaD9t40tvoQebz
         RR3Xzd9ZWoza3bLr8xPhCf1QBXFDrL8/wcXF+1Ro8rENPr/2ih1Ox0hX6DD8wwFEq08O
         OqFg==
X-Gm-Message-State: APjAAAWdXYDB5H1NmvBpxymY4mdi+NPVpwNaXZJrWtIPo4ezllHdT6wk
        8DSBeEEUtfuxomnxcbA83su5ND4eubRLKrM3Wxo=
X-Google-Smtp-Source: APXvYqwgTAAhKI1NXLdbqAMXLmcBRGxa1dy1X2cOKTmSVbVHteKudBaqituHCBTIggl5J5pblm4A0uFUEyZw0ler8Ys=
X-Received: by 2002:a67:770f:: with SMTP id s15mr31142617vsc.11.1558447973350;
 Tue, 21 May 2019 07:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190521140244eucas1p244e5e1306a52021a4a0c3910098c4f7c@eucas1p2.samsung.com>
 <50411fd1-9da0-aab6-709e-749d5e0ce509@samsung.com>
In-Reply-To: <50411fd1-9da0-aab6-709e-749d5e0ce509@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 May 2019 16:12:41 +0200
Message-ID: <CAMuHMdVbFaY583xJMd9kkW=-dQDY_yPAeToQT854kWFvokECLw@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: atafb: remove superfluous function prototypes
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 4:02 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> No need for them.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
