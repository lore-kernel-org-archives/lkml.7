Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B43C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 07:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5F3208E3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 07:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfFIHyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 03:54:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44321 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfFIHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 03:54:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so4500821lfm.11;
        Sun, 09 Jun 2019 00:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Qx4/qdUcALjIorcXjs7AxmiMGoinkmfGOdHptpmwpU=;
        b=VnzhNd6w7mHyqWKZiqP7zGC4ONUcth8yhbe0Lo90zLDFCwzJhrLUZo05SR4S44EuWy
         wlABAZfEcB+gwGXPPGaVpP/Yrv6+3l7c2DqoQTeqFmGPs+gdOJZ93sNzROR8cSmWoJo+
         5IIzrQHR8M5tj9D2fJAPYiT0N90UZike0AHTHYDoEHRsqREudfpy/V7mctr/tnI93R/T
         esG2bVjT5/dzfokupaehnxuO+ePdfcW8MMuoyuDJg5NKnD36yk+tDCM4CRrG9wx6nCqV
         ZpPSBiQdbcuSQplQO1KVJ14Tgzq5lwj5avVhIbKN8A71EAPPIhauw2ML8pjSFMLYknZk
         j65w==
X-Gm-Message-State: APjAAAWkWw6Ab6aDE7UnNc2a/HEzGa5HmTnHkPe84Xpu0F0t4FhgEYMr
        QZszusJh8ovp0mZZFM+cHbSm4Vstcc0KsOoa0V0=
X-Google-Smtp-Source: APXvYqwAkUTnyc4orITPqql8Dcq/2FZxVHDXSWXEX68+M70BfTiu1lPz3E0qFz5+GRtrzFsL1+dJET1c4NH3BB9tQiI=
X-Received: by 2002:ac2:5467:: with SMTP id e7mr7954978lfn.23.1560066881888;
 Sun, 09 Jun 2019 00:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560045490.git.mchehab+samsung@kernel.org> <f7f9c692a870f836e5657b8a763d751b6ac0e86e.1560045490.git.mchehab+samsung@kernel.org>
In-Reply-To: <f7f9c692a870f836e5657b8a763d751b6ac0e86e.1560045490.git.mchehab+samsung@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 9 Jun 2019 09:54:29 +0200
Message-ID: <CAMuHMdUyvZ89=P4GOY-BkyS45cj66STgZe9gN3q0L+sj-Wc+wg@mail.gmail.com>
Subject: Re: [PATCH v3 10/33] docs: fb: convert docs to ReST and rename to *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maik Broemme <mbroemme@libmpq.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bernie Thompson <bernie@plugable.com>,
        Michal Januszewski <spock@gentoo.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Sun, Jun 9, 2019 at 4:29 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks!

> --- a/Documentation/fb/framebuffer.txt
> +++ b/Documentation/fb/framebuffer.rst
> @@ -1,5 +1,6 @@
> -                       The Frame Buffer Device
> -                       -----------------------
> +=======================
> +The Frame Buffer Device
> +=======================
>
>  Maintained by Geert Uytterhoeven <geert@linux-m68k.org>

I'm happy to see this line dropped ;-)

>  Last revised: May 10, 2001


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
