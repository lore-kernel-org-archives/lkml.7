Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CC2C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E2E205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfH0LZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:25:41 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33501 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0LZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:25:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id l2so14645487oil.0;
        Tue, 27 Aug 2019 04:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbe+mD9TjSIALmM4jOBGJ1BaowYoqtIQG+RaLF5qQhI=;
        b=eTXK9izBdwTlFWv0RU23WWahbCd+EPJ0V9Au7L01EW5caynzj9QUh/T0uQsnaO1gsF
         9cnXxNhKk6e+O3B0D+O3oBK1zEM2x7kkrHMI7oINmHh6gO0gcwvK+o7ADBThEN0GeV1g
         dyiMTu/lN1uACbHBhqwGlHoshPP/8ABQE/op3BbWHhBukmTBwwIlFSlRcixTn5YeQeZt
         +M6GfwyKOJECZnyoaW/QplzvDA1rGiO72szZ3Ta/vNhB/YN274BIdtoFXy3mYjmDR1aA
         BGrY3dfpd0CFCvziE7EKZ94wLNQ9HniAPEI8RfK/vpUrJsQHU14vjIKi+IGAeqkd1ygl
         7GGA==
X-Gm-Message-State: APjAAAWRoAkschgcPOKbMmac3Pntfb+19Zc+J1bNZBzHdHBOSpYarA41
        T93RNM/oif1Mkt7ED4waU7+SA2Sa7sLSyGTUwiQ=
X-Google-Smtp-Source: APXvYqyBmLm+aF54MGwelCc+w4hkzT2alLYfQdaYjb4e9WDwRSce6dti3GUc+LGiArPFcvFQ7bgcck/G/b9VD42wTiI=
X-Received: by 2002:a54:478d:: with SMTP id o13mr15817144oic.54.1566905140208;
 Tue, 27 Aug 2019 04:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190827110854.12574-1-peda@axentia.se> <20190827110854.12574-3-peda@axentia.se>
In-Reply-To: <20190827110854.12574-3-peda@axentia.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Aug 2019 13:25:29 +0200
Message-ID: <CAMuHMdU1PEyqh8e5n3_xp1NT8YdPYXEyHDiaVQYOYKYKCm8y1A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fbdev: fbmem: allow overriding the number of
 bootup logos
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 1:09 PM Peter Rosin <peda@axentia.se> wrote:
> Probably most useful if you want no logo at all, or if you only want one
> logo regardless of how many CPU cores you have.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
