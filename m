Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654EFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467FA20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfH0NYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:24:17 -0400
Received: from shell.v3.sk ([90.176.6.54]:35524 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfH0NYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:24:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C31EAD80FE;
        Tue, 27 Aug 2019 15:24:11 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fX9pmDjAEMa4; Tue, 27 Aug 2019 15:24:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C4E0CD80FF;
        Tue, 27 Aug 2019 15:24:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ASGlmL8EOUht; Tue, 27 Aug 2019 15:24:01 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 6DE9DD80FE;
        Tue, 27 Aug 2019 15:24:00 +0200 (CEST)
Message-ID: <136a57cf3d293e3233f31d5ee660a6418726333a.camel@v3.sk>
Subject: Re: [PATCH v2 02/20] dt-bindings: arm: Convert Marvell MMP
 board/soc bindings to json-schema
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Date:   Tue, 27 Aug 2019 15:23:58 +0200
In-Reply-To: <CAL_JsqJ4_h+M=6L-nzK2N+A9TAy-N8SoiFv1SSTk_kCcKt0eXw@mail.gmail.com>
References: <20190822092643.593488-1-lkundrak@v3.sk>
         <20190822092643.593488-3-lkundrak@v3.sk>
         <CAL_JsqJ4_h+M=6L-nzK2N+A9TAy-N8SoiFv1SSTk_kCcKt0eXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-27 at 06:59 -0500, Rob Herring wrote:
> On Thu, Aug 22, 2019 at 4:27 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > Convert Marvell MMP SoC bindings to DT schema format using json-schema.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > 
> > ---
> > Changes since v1:
> > - Added this patch
> > 
> >  .../devicetree/bindings/arm/mrvl/mrvl.txt     | 14 ---------
> >  .../devicetree/bindings/arm/mrvl/mrvl.yaml    | 31 +++++++++++++++++++
> >  2 files changed, 31 insertions(+), 14 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> > deleted file mode 100644
> > index 951687528efb0..0000000000000
> > --- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> > +++ /dev/null
> > @@ -1,14 +0,0 @@
> > -Marvell Platforms Device Tree Bindings
> > -----------------------------------------------------
> > -
> > -PXA168 Aspenite Board
> > -Required root node properties:
> > -       - compatible = "mrvl,pxa168-aspenite", "mrvl,pxa168";
> > -
> > -PXA910 DKB Board
> > -Required root node properties:
> > -       - compatible = "mrvl,pxa910-dkb";
> > -
> > -MMP2 Brownstone Board
> > -Required root node properties:
> > -       - compatible = "mrvl,mmp2-brownstone", "mrvl,mmp2";
> > diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
> > new file mode 100644
> > index 0000000000000..dc9de506ac6e3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
> > @@ -0,0 +1,31 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/mrvl/mrvl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell Platforms Device Tree Bindings
> > +
> > +maintainers:
> > +  - Lubomir Rintel <lkundrak@v3.sk>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: PXA168 Aspenite Board
> > +        items:
> > +          - enum:
> > +              - mrvl,pxa168-aspenite
> > +          - const: mrvl,pxa168
> > +      - description: PXA910 DKB Board
> > +        items:
> > +          - enum:
> > +              - mrvl,pxa910-dkb
> 
> Doesn't match what's in dts file:
> 
> arch/arm/boot/dts/pxa910-dkb.dts:       compatible =
> "mrvl,pxa910-dkb", "mrvl,pxa910";

It corresponds to the .txt bindings specification this commit is
converting. I thought it wouldn't be a good idea to do any changes to
the contents at the time the conversion is done.

I also don't understand why does the dts file specify the board-
specific compatible string. Surely "mrvl,pxa910" alone would be
sufficient?

> > +      - description: MMP2 Brownstone Board
> 
> If this entry is only for this board...
> 
> > +        items:
> > +          - enum:
> > +              - mrvl,mmp2-brownstone
> 
> ...then this can be a 'const' instead. Same for the others.

Sure, but is it preferable? I've actually done a "git grep -A3 enum
Documentation/devicetree/bindings/" to see if the single-element is
typically used and it seems like it is. Perhaps it's a good idea to
indicate to a human reader that this is a list that's expected to
eventually be extended with new elements.

In any case, there are more boards with MMP2 currently supported,
notably the XO-1.75 laptop. I've actually sent out the dts file for
review some time ago. I haven't added a separate compatible string for
it because I thought it is not necessary (see above).

> > +          - const: mrvl,mmp2
> > +...
> > --
> > 2.21.0

Thank you
Lubo

