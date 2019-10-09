Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435FCECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1126920B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfJIKzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:55:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36375 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfJIKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:55:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id 67so1325901oto.3;
        Wed, 09 Oct 2019 03:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3unWFkcJpXKNb8dXSk7twjyfVkZd7Gwb6TQxf0CzFw=;
        b=lAmUTsQY/CZlaq/zouJspiWWkWjppJp7Bz40rl8QTVpeci1l9iUh513qoiNsMcTl5O
         zkOubDZRouSluts+9nyFP19B14ky/wnw8CwyC+KidIood94Zmw1TSeZUghnbjfeLJ2tx
         GiYQFLGGXnz6X0l6fB3I8sX9vSmSMHj+UaYI2y/rkhEqOsfDrKY7eR+kRGthVwLbrcKP
         AKlw3LBXhjHk7Xdm4sfBWKOskixf9Q6zw/EBvRo7tmLrKlrVtt/tOoEP7HRd46gjjs8Z
         m0ES2RYkxcwW2jLtqolMu36gPd6RxRJhE6eM1FAVp+gEz8yisG/pFYWWnoLti1OwxTyK
         hP3w==
X-Gm-Message-State: APjAAAU0ymdXheYJJlU3ePFOKE4EgWvZZPUhkbU7PhNLEc/a11LBi0Jx
        VMBE3f7nTsiC9Ocg2KT1IHcN0BB1jbSm1UIz+bU=
X-Google-Smtp-Source: APXvYqw5IAzTjVBhlc8iRLqf+cdJpgzj6zNsVffXtkNnQdcMdYKmNwxtMA0YZ+q29ei9YF0gwMf5pwNvdwDZQVDcfXk=
X-Received: by 2002:a9d:70d0:: with SMTP id w16mr2140239otj.107.1570618548788;
 Wed, 09 Oct 2019 03:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com>
 <CAMuHMdVdPFSU_3VEtO=P73kqLezV5Dmki=N3nxsKibzy-U5pBg@mail.gmail.com> <mvmv9syz10h.fsf@suse.de>
In-Reply-To: <mvmv9syz10h.fsf@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Oct 2019 12:55:37 +0200
Message-ID: <CAMuHMdVh=CUXKwnXee067cRccVBDVuwWpo1wP7crAaCFA=y2Tw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation
 for the sifive serial driver
To:     Andreas Schwab <schwab@suse.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Wed, Oct 9, 2019 at 12:06 PM Andreas Schwab <schwab@suse.de> wrote:
> On Okt 09 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > I believe risc-v is DT-only, so if chosen/stdout-path is set up
>
> If.  Currently, it isn't.

IC. So isn't it better to fix that, instead of pointing people to more obscure
legacy solutions?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
