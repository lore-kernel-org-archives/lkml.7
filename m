Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128DC47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CDD206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439600AbfJYM4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:56:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39448 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438960AbfJYM4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:56:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id s22so2006038otr.6;
        Fri, 25 Oct 2019 05:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hj0kvi+vVbyfIJI30UL1Cpmnr3zPIpRpeA9rzCxH54U=;
        b=i4grp6CEYmePOU1teGRTNDyM9fK1TwP6tYXBDB42ixbJv13HBSaq/HFy009r3uSHwx
         m0ekoivF8mqUvLu4J3A1sOldaUxEa5ApHVpmLESwt538mP1ukX8mWgRQ4pxunTeqmW/8
         CoWy2Q6VSgooWr3TfYk+DWpYxP0PcjD1HyKvE4M9XwRlOTS2WpIQG+y41cBPL6B8piMT
         TxEnaHdPGSX92ijd4f5VC8RMOrkLv1QdUaVl5BXkP1l6QSqhKfeJ7R7cJcy50W93Z8xH
         kNYfSNrIpBiYnpQXesGynQNBkp44CG2g/2Rw4470hGmwC5gKkxaDfxsgoMjrAOVQ0rDw
         5sZA==
X-Gm-Message-State: APjAAAU1Ubs1KWk8brAjVr3bgfyEwrWdR+P753sznOEpLUwZ0rwB/Xuj
        Lg+VP8lPJPIGu6OEQttEyAUuzgC825SpEPCzNk4=
X-Google-Smtp-Source: APXvYqyGZIlyFoM/7awbc2SMmvfFJP+ChjfvSdn1k5oIzBGk3fKsfPhFJ49DQVrqFikAaFR6J0W278qfnN/Mt4JoFLk=
X-Received: by 2002:a9d:422:: with SMTP id 31mr2544652otc.107.1572008208146;
 Fri, 25 Oct 2019 05:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190114172930.7508-1-robh@kernel.org> <20190114172930.7508-2-robh@kernel.org>
In-Reply-To: <20190114172930.7508-2-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Oct 2019 14:56:36 +0200
Message-ID: <CAMuHMdVnPREgPmn5TAmiqXSxuAYKv_AkQ6StZiDH79vKMRuBGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: Move renesas,rzn1-uart into
 the snps-dw-apb-uart binding
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Jan 14, 2019 at 6:30 PM Rob Herring <robh@kernel.org> wrote:
> The renesas,rzn1-uart binding only differs in compatible string from the
> snps-dw-apb-uart binding. Move it there, converting it to json-schema in
> the process.
>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Rob Herring <robh@kernel.org>

> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -15,6 +15,11 @@ allOf:
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - enum:
> +              - renesas,r9a06g032-uart
> +              - renesas,r9a06g033-uart
> +          - const: renesas,rzn1-uart
>        - items:
>            - enum:
>                - rockchip,px30-uart

With ARCH=arm and shmobile_defconfig, "make dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml"
complains:

arch/arm/boot/dts/r9a06g032-rzn1d400-db.dt.yaml: compatible:
['renesas,r9a06g032-uart', 'renesas,rzn1-uart', 'snps,dw-apb-uart'] is
not valid under any of the given schemas
arch/arm/boot/dts/r9a06g032-rzn1d400-db.dt.yaml: compatible:
['renesas,r9a06g032-uart', 'renesas,rzn1-uart', 'snps,dw-apb-uart'] is
not valid under any of the given schemas
arch/arm/boot/dts/r9a06g032-rzn1d400-db.dt.yaml: compatible:
['renesas,r9a06g032-uart', 'renesas,rzn1-uart', 'snps,dw-apb-uart'] is
not valid under any of the given schemas

Do you know what's wrong?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
