Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2CACA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754462084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571874345;
	bh=Fa2BUPBPRcQjdyWWpFyyHoW4dQxZIcz9syU46fPjnKI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yDdHts3l/SagWgf8+JoWZG639AHusABpSrZBIzRJZ1aC4gcZ5/lzv0nfWn2tIeZ+Z
	 fy7IhU78xVaaWjVYrDi+6uKjdwuBfXMa6Fq3ISNj5wjFom0Te7kBawfJQi5HwwobqI
	 qr85CjDb7IRZtDa/tAV7hWLA62mVBTXk/DSsrNWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392134AbfJWXpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 19:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfJWXpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 19:45:42 -0400
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB212084C;
        Wed, 23 Oct 2019 23:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571874342;
        bh=Fa2BUPBPRcQjdyWWpFyyHoW4dQxZIcz9syU46fPjnKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tA9Qqei3FhXSnB6neknr+m6VKuRlDXX5FuvMql6gJUtN7mx7PvTa45NEp2xjOYGL1
         cGr6CzFFB6rrHDAK1kZH3KE6/YHDKCN9enufBCDoDZBm6x8DslCKNvCwlS7T4yCTwI
         hl3IboeGHDLkCCGFIe0Q3BGQfdpZm3HhbQG6uQQ4=
Received: by mail-yw1-f43.google.com with SMTP id d5so2448285ywk.9;
        Wed, 23 Oct 2019 16:45:42 -0700 (PDT)
X-Gm-Message-State: APjAAAUphaqRr894cJExS/kShWSzyLF6Lm1Lw/RPp9Wu6F79l/WT/oEj
        IbKY0pn93zDyFXSeX4RWQctZFRGF35K7ebSakA==
X-Google-Smtp-Source: APXvYqyFLY8JEsxRT4xuHCHY1O1xGIo/yncNBmpBlQbPJqs9qHVdgTyVJ0Tp+2CyWQP/88e55lcfuUKbBeS/tmTHYMA=
X-Received: by 2002:a81:748a:: with SMTP id p132mr4577615ywc.174.1571874341350;
 Wed, 23 Oct 2019 16:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061617.10296-1-daniel@0x0f.com> <20191023200228.GA29675@bogus>
 <20191023224357.GA26445@goma>
In-Reply-To: <20191023224357.GA26445@goma>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Oct 2019 18:45:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKTiieO_7gM4YNGV-BAT67Mi+PX4Gqyyd7nowZsjhnFqQ@mail.gmail.com>
Message-ID: <CAL_JsqKTiieO_7gM4YNGV-BAT67Mi+PX4Gqyyd7nowZsjhnFqQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: arm: Initial MStar vendor prefixes and
 compatible strings
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 5:44 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> On Wed, Oct 23, 2019 at 03:02:28PM -0500, Rob Herring wrote:
> > > +# SPDX-License-Identifier: (GPL-2.0+ OR X11)
> >
> > (GPL-2.0-only OR BSD-2-Clause) is preferred. Any reason to differ?
>
> I used the sunxi file as a template and thought they had some
> reason to do that. I'll change it to just GPL-2.0.

That wasn't a choice, but dual license it please.

> > > +      - description: thingy.jp BreadBee
> > > +        items:
> > > +          - const: thingyjp,breadbee
> > > +          - const: mstar,infinity
> > > +          - const: mstar,infinity3
> >
> > infinity vs. infinity3? What's the difference? It's generally sufficient
> > to just list a board compatible and a SoC compatible.
>
> Apart from some very slight differences (max clock speed, different PWM block)
> they are the same and the PCB for the BreadBee can take either the msc313(i1) or
> msc313e(i3). My v2 patch will remove the mstar,infinity line from there and move
> it to a second board called the breadbee-crust to handle the i1 configuration.

Sounds like you want:

items:
 - const: thingyjp,breadbee
 - enum:
     - mstar,infinity
     - mstar,infinity3

If one board can do both chips. Though if the same PCB is populated
differently beyond the SoC, then maybe 2 board compatibles makes
sense.

Why not use the part numbers (msc313...)?

Rob
