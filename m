Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327A5C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2254206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfECLzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:55:31 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45823 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfECLzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:55:31 -0400
Received: by mail-vk1-f196.google.com with SMTP id h127so1296291vkd.12;
        Fri, 03 May 2019 04:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VCheTd5Z52teJFWvnQeU956xBJ2CRF4Y806I5zmdrA=;
        b=Y7mX8MDgpuOhuDYxVtf0tWhd0JvaI/Vjd4nNnidsOSDM3vFmNzFjsP4h6cPXJJDreK
         fVO6E9L8O9dsvyCGEIGzblYLNKJhc8+7IjYqsicjv0R7irX8kkzlbZYpygKPEG0Q9yrC
         LWLMda6Ep92RYXnYimw85HF0gCeD0TkfhVfpvtglGUPwkJkyx3/G6FCqw3/DaHWCffcS
         RzdzMVR031WA53zQ7DEOSkb3H6nnoabIzisk8fd2S4T/4AzKlQwNcjAgni7ipeSrp/yV
         B9F/eOd3npaDSkQ0MdItNH8VmNloqtpENGAh9ukhv4QFYTIf13WiI5S7XvdI26yqxiFr
         EtMQ==
X-Gm-Message-State: APjAAAWfqJ2X4+R69M2U+Dzc9tQu2oiH1/Ue6vQ4+lwvcD2xxU/YVvGP
        StIfK696IJLi9gCSj8+EuU6fcz3nzT4oSQyUZ3VPyzwM
X-Google-Smtp-Source: APXvYqzw23e43kzerbAa8l1zHyyfUmacEItjitBTgD2T2EwUzRoG5YLRLAZt6EtCG0tqu2fTsqLxKB1yTfaRhd9sYAw=
X-Received: by 2002:a1f:b297:: with SMTP id b145mr5022264vkf.74.1556884530046;
 Fri, 03 May 2019 04:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555938375.git.mchehab+samsung@kernel.org> <efe82e7f9621c5f756d30fdb7d04fbd19c5d268c.1555938376.git.mchehab+samsung@kernel.org>
In-Reply-To: <efe82e7f9621c5f756d30fdb7d04fbd19c5d268c.1555938376.git.mchehab+samsung@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 3 May 2019 13:55:18 +0200
Message-ID: <CAMuHMdXBK4v9FMU5G3r9tORwo-19-XzxGpdn-3SUJDF9VQvQxw@mail.gmail.com>
Subject: Re: [PATCH v2 43/79] docs: m68k: convert docs to ReST and rename to *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Mon, Apr 22, 2019 at 3:34 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> Convert the m68k kernel-options.txt file to ReST.
>
> The conversion is trivial, as the document is already on a format
> close enough to ReST. Just some small adjustments were needed in
> order to make it both good for being parsed while keeping it on
> a good txt shape.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks for the conversion!

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

P.S. Looks like some kernel options no longer exist, and need to be removed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
