Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FFFC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F9A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfFQSyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:54:11 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:41723 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFQSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:54:10 -0400
Received: by mail-lj1-f173.google.com with SMTP id s21so10371799lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66m4iUUvYIXxs91ImWOwQpe/gowMn0dh9jwp7NXwltk=;
        b=kkgx5GryyrSEQE7/3soXS1on3Hyi36tM18M2SFySXIzj7JscZrIvTXutx0L2GU7lOM
         xecqhsl9xMmWji8seDlON3jj1hool9nwt1zP3zIqeM8MWaBHm4VP2P1vtwVcfQ6yfoO+
         O8GTiUv6SpispaFb+hTt/gmpKLOuRrCZPVQmGSTQbPHoN4mQXI/ybCZWx9dsftHN1I9g
         nlUP/fpJPxWQhTwh9+KFvjTGf46Dwgy3a8qXd036fQru7HiKHuZpYtAGI1j+qI7ewFFK
         1uaTqv0P/igkGGtXZ41dMGxAkvEHmBWTJoanvmUPFxk157w6LQMOukEWdDexSerAaVAs
         /mZw==
X-Gm-Message-State: APjAAAVyXFVxnd0hTDH1CwBNJdvobvFqjTIoo0yFdw8T0G6uKMW+qj/4
        Yw0VMSENthlLXcKWdsAkHS8z4UZpJRpHmICEq5I=
X-Google-Smtp-Source: APXvYqxmc0OIHh1u8In/WbFdOyPZmFDCbAj41wxY9ICm/ETICkV5L88DRwCmmCfwk1E5mh9JaqqSXC67mdkWs9VyE/g=
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr36540791ljl.21.1560797648597;
 Mon, 17 Jun 2019 11:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190614102126.8402-1-hch@lst.de>
In-Reply-To: <20190614102126.8402-1-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jun 2019 20:53:55 +0200
Message-ID: <CAMuHMdVPU5RQyX4FnHFEhxXZeG3v0uh_-t2FB=vAzQ8_3u-gSw@mail.gmail.com>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Jun 14, 2019 at 12:21 PM Christoph Hellwig <hch@lst.de> wrote:
> can you take a look at the (untested) patches below?  They convert m68k
> to use the generic remapping DMA allocator, which is also used by
> arm64 and csky.

Thanks. But what does this buy us?

bloat-o-meter says:

add/remove: 75/0 grow/shrink: 11/6 up/down: 4122/-82 (4040)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
