Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D46C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC3D20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407241AbfFLGwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:52:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46176 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403835AbfFLGwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:52:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so8481144lfh.13;
        Tue, 11 Jun 2019 23:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgzSwecmSEJ7vf9Bv6DohIWO3+c4jeRqODjRR347TX0=;
        b=Gjth3Wc50O9CRk+CL+1J4MEC29HzcvF9SWfG3lFVlivazQVWMVdP6MS6+EMRVNNfbD
         tHlqS72VNpbzXUn/Qblw+qTYx6v4EbgVlkpd1rBNcZQeN/7HOEcBENV+oKfU7m3TwoGl
         HyfEfUF+oXwLy1rhO1gOInqXijE/Tgezs4mT0meFHFmz/0e5UeTyHwQwX9GcvdQsxu3e
         4fxLXanQ+ScFpzBfS5KTvoyG7kFxH1G8nXzDE4+92oYX2evVrDUd65d/LBvXqmX8ZQEh
         kXgHtsYokQwh89/mlY+Jwz5n6o2bXu1EDqWQ+sc81qcXuMP10d0iEL5qdz9iw8gAdVqX
         IDXQ==
X-Gm-Message-State: APjAAAVErPWywTDoVAPBv/XwVoN5dhd0BH2e6HAMKdrLTtkJH3d6M31C
        4zNGVAxVhjegeSIKfRoakHjFtKexlEuSx1M5068=
X-Google-Smtp-Source: APXvYqzo0BzuPQr+EJoh/gmOvumQDwiFG1BYgL54a567MX2Pya/359gm+7uCxDKaPstY8RvnhPfwvGgAh+grqfPDfGU=
X-Received: by 2002:ac2:44b1:: with SMTP id c17mr40332376lfm.87.1560322353613;
 Tue, 11 Jun 2019 23:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <1560258401-9517-1-git-send-email-fabrizio.castro@bp.renesas.com> <1560258401-9517-6-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1560258401-9517-6-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jun 2019 08:52:20 +0200
Message-ID: <CAMuHMdVEhRDcd8aJ-mYKvNeGX3RzvfFLn6CdqmDrux01bJ1ktA@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: timer: renesas: tmu: Document r8a774a1 bindings
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 3:07 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document RZ/G2M (R8A774A1) SoC in the Renesas TMU bindings.
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
