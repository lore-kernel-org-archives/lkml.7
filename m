Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9BBC47E49
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E81C21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfKALBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:01:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35990 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKALBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:01:39 -0400
Received: by mail-oi1-f194.google.com with SMTP id j7so7837154oib.3;
        Fri, 01 Nov 2019 04:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwOb7c/bCokB7dKeYdJq+R5da1cRDoqnSzfr9hONEPw=;
        b=RnqYyopSWNe26xO6bVsGasMF+knlFFP5Bwppq8QQ0w8kKK+sn9r4w9bWXS/45r7vaA
         t7i7jOP0Cmxm0Xrwx8iP1L5pzFIlTfJZcj2AT86cEMaUrRKNZbFJvaAd6WabDwEgiyMt
         BEKz3LBRsoxXtAsgD0bmF6ZIC9s/ujn9+rzkELF2O9osQRYfWcrhAJYItdvAB3cVGMVn
         GmqcKhD/CvaPOKpk5JpHUs2Qk8bOUc2h84uRmJJTs0ViT3A4cfidDe6q5hjUmyGddBfW
         u0B/MJVPnEyOAbRU4nsaWuqfvpEO1kLbZu0TCvCC1yHpJDwfJQ45v8H1+sc4wZ7Appuz
         bNoA==
X-Gm-Message-State: APjAAAUFPughy0uv/MV9TLuWU+lNvq9YAkYxMEHfA9m38EUqtJJ8Mk9E
        lVPo6pSdjM6kC9UukffVZAwtdmBY4fKefjZs5Vc=
X-Google-Smtp-Source: APXvYqytWpFj+aHVVrjgJ+XuIgmDCveEj6FlTqbtlSt/b3e6XNqNbZZ0OLo3TR/ZeHv/URN1HIIZVg8kUhpb/iGo/CI=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr7835580oia.131.1572606097659;
 Fri, 01 Nov 2019 04:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191021161351.20789-1-krzk@kernel.org> <20191021161351.20789-4-krzk@kernel.org>
 <CAMuHMdXr7_HP5NUQ_0D76N-eBuootQqyPusqmf6nyDnLN__ORA@mail.gmail.com> <CAJKOXPcZGhC1+-tOwL6N_ohWzXEqJ3T6=HWefNzXsa3eeQN1fg@mail.gmail.com>
In-Reply-To: <CAJKOXPcZGhC1+-tOwL6N_ohWzXEqJ3T6=HWefNzXsa3eeQN1fg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Nov 2019 12:01:26 +0100
Message-ID: <CAMuHMdV34BfnVGXCtoL1EDk=uYPiaku1WvBuB0cXoGy3zeoBJw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: sram: Merge Renesas SRAM bindings
 into generic
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Nov 1, 2019 at 11:54 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, 1 Nov 2019 at 11:08, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Oct 21, 2019 at 6:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > The Renesas SRAM bindings list only compatible so integrate them into
> > > generic SRAM bindings schema.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Thanks for your patch, whcih is now commit 0759b09eadd0d9a1 ("dt-bindings:
> > sram: Merge Renesas SRAM bindings into generic") in Rob's for-next branch.
> >
> > > --- a/Documentation/devicetree/bindings/sram/renesas,smp-sram.txt
> > > +++ /dev/null
> > > @@ -1,27 +0,0 @@
> > > -* Renesas SMP SRAM
> > > -
> > > -Renesas R-Car Gen2 and RZ/G1 SoCs need a small piece of SRAM for the jump stub
> > > -for secondary CPU bringup and CPU hotplug.
> > > -This memory is reserved by adding a child node to a "mmio-sram" node, cfr.
> > > -Documentation/devicetree/bindings/sram/sram.txt.
> > > -
> > > -Required child node properties:
> > > -  - compatible: Must be "renesas,smp-sram",
> > > -  - reg: Address and length of the reserved SRAM.
> > > -    The full physical (bus) address must be aligned to a 256 KiB boundary.
> > > -
> > > -
> > > -Example:
> > > -
> > > -       icram1: sram@e63c0000 {
> > > -               compatible = "mmio-sram";
> > > -               reg = <0 0xe63c0000 0 0x1000>;
> > > -               #address-cells = <1>;
> > > -               #size-cells = <1>;
> > > -               ranges = <0 0 0xe63c0000 0x1000>;
> > > -
> > > -               smp-sram@0 {
> > > -                       compatible = "renesas,smp-sram";
> > > -                       reg = <0 0x10>;
> > > -               };
> >
> > > --- a/Documentation/devicetree/bindings/sram/sram.yaml
> > > +++ b/Documentation/devicetree/bindings/sram/sram.yaml
> >
> > > @@ -186,3 +187,17 @@ examples:
> > >              reg = <0x1ff80 0x8>;
> > >          };
> > >      };
> > > +
> > > +  - |
> > > +    sram@e63c0000 {
> > > +        compatible = "mmio-sram";
> > > +        reg = <0xe63c0000 0x1000>;
> >
> > Is there any specific reason you converted the example from 64-bit to
> > 32-bit addressing?
> > All Renesas SoCs using this have #address-cells and #size-cells = <2>.
>
> I should mention it in commit msg. The reason is because examples are
> compiled inside a {} with address/size cells of 1. Instead of

Thanks, that's what I was already afraid of...

> conversion maybe it would be reasonable to put it inside additional
> node adjusting the address/size cells.

I think it's fine to leave it as-as, though.  If we ever get to DT-ize
secondary CPU startup on EMMA Mobile EV2 or SH-Mobile AG5, we'll have
users without LPAE ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
