Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87F8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E5821871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfJHLhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:37:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33538 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfJHLhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:37:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id 60so13754152otu.0;
        Tue, 08 Oct 2019 04:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWU50A1ftSfnXS5t6he0dr7vBuFC5vEUJUAdKOgY8bw=;
        b=XdY+t87rVueuhNbWb80CL1hZxwEcXseSUTJ7vi0IiBYVb3mmfUEXGExmXD2pgkKCFE
         B+zGQ2a6FgBz+bYZjygvdI1xvscCXxHQRH4D6fJsYK4qyndnYLeLjQEOJxgClxsPGWZh
         6feChc/uG8HHW8n7VqcMOdkLnA5Rj7dHcupjOrG4E7tgMTttW06vcMqkMXiD5NQ3UNr0
         0+YdU+wd6La/TEDK+AgQQ+3NMa+ejZiGlWV36yVvgDh17Ao2cC/rePyrBbc4FH8gTmtF
         ZGDqqCyIX9qfVRjSbQeC8WtC5FEo2a435jQPtoR/PXN8CFGVoZiJ2ZMAKiMxkg4ZnmBa
         iuQg==
X-Gm-Message-State: APjAAAUrm47BoKgrsjj7bigE2jRboZjmZkmxZ78NP+oD6s8a7DKuxBnm
        U7WGosSoPF7zqDGaJlqrNNaU11GzGNGFyUlupBo=
X-Google-Smtp-Source: APXvYqy4mjg9CQq9wdKlkAK2E94Y9maSeWKkM5Wv+Mk3W6HhO7CU5U5FAvdtUrmrFsbdj6SxQiaVnh07xPFanDbaHv4=
X-Received: by 2002:a9d:17e6:: with SMTP id j93mr25205226otj.297.1570534668567;
 Tue, 08 Oct 2019 04:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570531132-21856-6-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-6-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 13:37:37 +0200
Message-ID: <CAMuHMdWkSDMLKr10MEycGFoZpxC5VqMFY7XoKfLia3T5U98Xew@mail.gmail.com>
Subject: Re: [PATCH 05/10] dt-bindings: usb-xhci: Add r8a774b1 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Simon Horman <horms@verge.net.au>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 12:39 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document RZ/G2N (R8A774B1) SoC bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
