Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366C0C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177D3206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfHZH3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:29:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34213 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfHZH3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:29:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so14326512otp.1;
        Mon, 26 Aug 2019 00:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVAemWech0/N9j46salFy/chbSjzAsoD07I5FsrQwuc=;
        b=iTWxrRq0uY+7Gg4FV2Kv4au45Q68JxTw81xoj2pEDi0ZXts1QE9BX7+0ZdWaQZH8fE
         W9uIwrSZvVyV8IMLMTQBRn445xJOIt924K3kpptXWgP8SZw0ta8Rhuo11dqSeh66d7kD
         qOCuOlsgDgN5nnPLr3bPcvYjpNMadVDSgSLJHA5202TaJO2JazIqtWijblihJAwm+87y
         H3W5+v6bDSIgmG6kvrKf/aijTphhiWmexF8euimPDeNYagH2e3kXJtfiAwZ/2ywWkJUa
         Smh8FgPck6GBE4xsSgNchSXDZz+OuPPVn/SzvA/Nhr+1JOqtBpm7KN7bAfMiBpE8SJoM
         bWyQ==
X-Gm-Message-State: APjAAAVasu8ajewSGrxRFyEuP85009JSxn1+NUyAiOpGGoFzCXoTmGBa
        1HPcln5F+Z3YRtu6x6VQHcNJnDX/MX3T4V34ad4=
X-Google-Smtp-Source: APXvYqzoCKdB/hIeBgXGceXns+/B+5wibRNIPKaLnLL/CiK1K2Rlx0LtZWGUpdJdqX71NMSi2o1ijtCVulsx3OX4ycg=
X-Received: by 2002:a9d:61c3:: with SMTP id h3mr14488208otk.39.1566804547272;
 Mon, 26 Aug 2019 00:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190825135154.11488-1-jacopo+renesas@jmondi.org> <20190825135154.11488-4-jacopo+renesas@jmondi.org>
In-Reply-To: <20190825135154.11488-4-jacopo+renesas@jmondi.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Aug 2019 09:28:56 +0200
Message-ID: <CAMuHMdV6_VW-2BYYJ3yNi1i81n2Oeh+Hw+J6ohgqkmjsEjhX+w@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] arm64: dts: renesas: r8a7796: Add CMM units
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>, Ulrich Hecht <uli@fpond.eu>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Koji Matsuoka <koji.matsuoka.xm@renesas.com>, muroya@ksk.co.jp,
        VenkataRajesh.Kalakodima@in.bosch.com,
        Harsha.ManjulaMallikarjun@in.bosch.com,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Sun, Aug 25, 2019 at 3:50 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add CMM units to Renesas R-Car M3-W device tree and reference them from
> the Display Unit they are connected to.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 25 ++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> index 3dc9d73f589a..8d78e1f98a23 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -2613,6 +2613,30 @@
>                         renesas,fcp = <&fcpvi0>;
>                 };
>
> +               cmm0: cmm@fea40000 {
> +                       compatible = "renesas,cmm-r8a7796";

Shouldn't you add "renesas,rcar-gen3-cmm" as a fallback?
(for all CMM nodes in all DT patches)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
