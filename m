Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8436C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 07:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2AC2070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 07:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfFIHug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 03:50:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42430 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfFIHug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 03:50:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so5148388lje.9;
        Sun, 09 Jun 2019 00:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSX7llxKdi9V6Dhe2O0h1mDrjGuwY5+038rCGBEDJQI=;
        b=CtbGsD+8PhS2T0/dcB2hQsFRnbmoMphfNUT3Gopj4E1inxQ0s3CE5Nv0BfgC5TCPPX
         jmsWiCUWEeaDkCCGmByED+aVi5UNDWrXW7BoYWz9EbpdP4zJREhzdBRCseNUg+ZtdBWD
         60as8Yb+utzScN6rTNAwbAEreZF4c9sYt3lYb5Ejothljmshs3QSHI5InVofQXflUKsY
         gRWVwC1navXSgdJK2MywnBuHFNj1ATyTFuig/6I7Fzwf9h7rsz+ktnhTrUlg8BX0YWLB
         UqYRux5hs0HlCiDvkCq+fanlGa3aR/wwqKs2PC8xQADuO3tBwyLe6ToidfFC/wLmNMV8
         1rsA==
X-Gm-Message-State: APjAAAUftzO41o+XH6lQ9i3of5sL/oUh/3bOKeFwv4oosFs9g6IUnxIx
        /xwntbsOfK1JIjKW0U4K6hdvFttid8LZJsZw9TM=
X-Google-Smtp-Source: APXvYqzjDEboHFvODgKNMZuwSZdEyAu0DsAlCQEVkihn9muiB0rp40QvtYDUKeudIzc6SifXEuymRS6kh4s+DB9xirg=
X-Received: by 2002:a2e:91c5:: with SMTP id u5mr21611820ljg.65.1560066633700;
 Sun, 09 Jun 2019 00:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560045490.git.mchehab+samsung@kernel.org> <472757a7481a8645837092f0f257f37996af6299.1560045490.git.mchehab+samsung@kernel.org>
In-Reply-To: <472757a7481a8645837092f0f257f37996af6299.1560045490.git.mchehab+samsung@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 9 Jun 2019 09:50:21 +0200
Message-ID: <CAMuHMdV9Xy7MKAY9tU4WTe=tvuLpnXQE5GMNmtEXgCj6YNhRYg@mail.gmail.com>
Subject: Re: [PATCH v3 12/33] docs: ide: convert docs to ReST and rename to *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>, Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 9, 2019 at 4:27 AM Mauro Carvalho Chehab
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

>  arch/m68k/q40/README                          |   2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
