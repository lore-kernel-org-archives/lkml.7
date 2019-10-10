Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68100C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3B52190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbfJJHKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:10:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33205 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJJHKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:10:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id a15so4039179oic.0;
        Thu, 10 Oct 2019 00:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TU10B3nKbfIpm9WNlkT9iNcLTqsb+xgrJpyrz4+X/IA=;
        b=qQHHWk0I+urGfE8LZvAvu1TBDwXUAl/bP9PhX/4PTKuUBO3e9CkUBJ3BbS8uqKeHtG
         gf87ZfbRNIHoBbudgsi5R/nJm44XPd67sU5g0zp21Mgtt/jTQDDVvNG6xK/7kTkX+xgm
         oxnY1mTVy/y1hDckeQ9Y/rdNbID+F81Ja3IiVXl5xYk/lomXwDletaeyUdYnMYG7nFWi
         UQT/rvjFync/diRvrd+Bu1HqXF5LzQCEZWrKpoz7zssilH6ZoA7xD9B0jK9sNNaVfphR
         swxxeR8HerrJbhukoaOAcmKPOQ00pODij/Re584/JWj4Wha77ttvsVA9hHtm6ewxL5LC
         fsEQ==
X-Gm-Message-State: APjAAAWLcBOpWFS+isspzS7R75d4o9zqgokChK5crZGTMtFDlOnwVb0Q
        3ja9bm18H5uRFT7TrZbhdHC+lSyawIiKWyN+e+Q=
X-Google-Smtp-Source: APXvYqy+li7Xr8sM09s9qHeHYmcP9+9HHF++GuPo9eOazB7/UBi9MtzGp2SFtJxnjCj66BmyNdMv5eH+ZbbiswlC9f4=
X-Received: by 2002:a54:4e89:: with SMTP id c9mr5896405oiy.148.1570691429202;
 Thu, 10 Oct 2019 00:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1910091252160.11044@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910091252160.11044@viisi.sifive.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Oct 2019 09:10:18 +0200
Message-ID: <CAMuHMdUfqvkVJHHwyuYxLSxj_iUofx-vSvEj92C5mg3bGxHqmA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation
 for RISC-V
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Andreas Schwab <schwab@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 9:53 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> Kernels booting on RISC-V can specify "earlycon" with no options on
> the Linux command line, and the generic DT earlycon support will query
> the "chosen/stdout-path" property (if present) to determine which
> early console device to use.  Document this appropriately in the
> admin-guide.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
