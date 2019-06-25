Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC539C4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2310205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 01:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561427875;
	bh=MJtxpRjdgeKsk26oDPJlP5SZ3sdJ7xVel8rCfI+KFQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dR36yzZ5dRphMSv7JtwRiT13tX1lk6pOja8vBqu1srZfgQXSrox/pS3Yn12kH8WkH
	 0MFwHAzxdRWqwQKhMhs8D0lwpmE8vUj46bftbzU6516BGGfbbF0rFgdTNJsvFs+LtM
	 floGR1KP8Obl2yDwuXo8pKC2GDqIVS62JVRtvoQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfFYB5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 21:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729894AbfFYB5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 21:57:53 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8157D2077C;
        Tue, 25 Jun 2019 01:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561427871;
        bh=MJtxpRjdgeKsk26oDPJlP5SZ3sdJ7xVel8rCfI+KFQw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OeVfDOhXwkdHsuv30TcUVHuS5CGGEteTOw4/RjtT/8EOZ30xuE580ExalG5bqfmVc
         B4+cWaTq/9LzqBFF44awiqFvhomIF+TwfYNm+3gpdCTtuZg+PWzaGM9PfgspgZcDjP
         4eTrsCjkpz0glIZM+0rPZaAyJV1EVuqwDY0ajKUA=
Received: by mail-wm1-f50.google.com with SMTP id s3so1117724wms.2;
        Mon, 24 Jun 2019 18:57:51 -0700 (PDT)
X-Gm-Message-State: APjAAAUb6pOnsAF1fUJJFZXo5l6vY0zDMOi0TTkiNAd3ijr+DB/HQefx
        kZNOz5uOgYZhb2FaLbFDASqEKMZX0xGsX35oBks=
X-Google-Smtp-Source: APXvYqzkCXe52mlQoLGvpJrB37dUOrIl+OdJu8k0kgiwPLIagTSgY8ydNzJ37lBhg64m2YTHjPqAvODk8VK8MaqhCc8=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr17852370wmj.79.1561427870082;
 Mon, 24 Jun 2019 18:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190625002829.17409-1-afaerber@suse.de> <CAJF2gTTnhTQK-mOyC+e8U8xrDwaoDUACb1R_zQfDCKwdKzc96w@mail.gmail.com>
 <a27255d3-e21c-787d-c510-359d72f53a1c@suse.de>
In-Reply-To: <a27255d3-e21c-787d-c510-359d72f53a1c@suse.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 25 Jun 2019 09:57:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRkB+W_pYJYJLLcL=hkUm5Y6dvH_Z=BSdkz=M0+D0UOiA@mail.gmail.com>
Message-ID: <CAJF2gTRkB+W_pYJYJLLcL=hkUm5Y6dvH_Z=BSdkz=M0+D0UOiA@mail.gmail.com>
Subject: Re: [PATCH] csky: dts: Add NationalChip GX6605S
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Tue, Jun 25, 2019 at 9:25 AM Andreas F=C3=A4rber <afaerber@suse.de> wrot=
e:
>
> Am 25.06.19 um 02:45 schrieb Guo Ren:
> > Thx for the patch. No need seperate part into dtsi,
>
> Sorry, I know from many arm contributions that using a .dtsi is the
> right thing here. It logically separates the chip from the board, even
> if there's only one evaluation board currently. Think about set-top
> boxes that someone might author a .dts for - they should be able to
> reuse the .dtsi for the SoC rather than copy it.
gx6605s.dts is simple now, it's unnecessary to seperate it into two
pieces. Other things from you is all OK for me.

>
> > just follow:
> > https://lore.kernel.org/linux-csky/1561376581-19568-1-git-send-email-gu=
oren@kernel.org/T/#u
>
> Thanks for that pointer! I still think my node names are cleaner and
> also the structure of keeping clocks and gpio users outside of /soc. I
> see the value you use is 27 MHz, will try it tomorrow. I see you use
> nice KEY_ constants, whereas I just took the raw values from the dtb.
>
> I notice that your patch doesn't have any Copyright header, how should I
> credit you in the resulting combined patch? I would then also add your
> SoB from the patch you linked to.
Copyright could be the same in arch/csky/kernel/setup.c or add yours
in addition.

>
> More comments inline...
>
> > On Tue, Jun 25, 2019 at 8:28 AM Andreas F=C3=A4rber <afaerber@suse.de> =
wrote:
> >>
> >> Add Device Trees for NationalChip GX6605S SoC (based on CK610 CPU) and=
 its
> >> dev board. GxLoader expects as filename gx6605s.dtb, so keep that.
> >> The bootargs are prepared to boot from USB and to output to serial.
> >>
> >> Compatibles for the SoC and board are left out for now.
> >>
> >> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> >> ---
> >>  arch/csky/boot/dts/gx6605s.dts  | 104 +++++++++++++++++++++++++++++++=
+++++++++
> >>  arch/csky/boot/dts/gx6605s.dtsi |  82 +++++++++++++++++++++++++++++++
> >>  2 files changed, 186 insertions(+)
> >>  create mode 100644 arch/csky/boot/dts/gx6605s.dts
> >>  create mode 100644 arch/csky/boot/dts/gx6605s.dtsi
> >>
> >> diff --git a/arch/csky/boot/dts/gx6605s.dts b/arch/csky/boot/dts/gx660=
5s.dts
> >> new file mode 100644
> >> index 000000000000..f7511024ec6f
> >> --- /dev/null
> >> +++ b/arch/csky/boot/dts/gx6605s.dts
> [...]
> >> +       leds {
> >> +               compatible =3D "gpio-leds";
> >> +
> >> +               led0 {
> >> +                       label =3D "led10";
>
> I forgot to align the numbering here. The label matches the GPIO and
> what is printed on the board.
leds and button is so specific, that's is just a example. You could
keep your own style in the dts.

>
> >> +                       gpios =3D <&gpio 10 GPIO_ACTIVE_LOW>;
> >> +                       linux,default-trigger =3D "heartbeat";
>
> This green one stops blinking and stays on.
Seems there is no driver for it.

>
> >> +               };
> >> +
> >> +               led1 {
> >> +                       label =3D "led11";
> >> +                       gpios =3D <&gpio 11 GPIO_ACTIVE_LOW>;
> >> +                       linux,default-trigger =3D "timer";
>
> This red one keeps blinking after the panic.
>
> >> +               };
> >> +
> >> +               led2 {
> >> +                       label =3D "led12";
> >> +                       gpios =3D <&gpio 12 GPIO_ACTIVE_LOW>;
> >> +                       linux,default-trigger =3D "default-on";
> >> +               };
> >> +
> >> +               led3 {
> >> +                       label =3D "led13";
> >> +                       gpios =3D <&gpio 13 GPIO_ACTIVE_LOW>;
> >> +                       linux,default-trigger =3D "default-on";
>
> These two remain off. So I wonder whether the GPIO polarity is wrong?
> In the example usb.img the gpio-leds module is not loaded by default, so
> maybe it wasn't noticed before?
I try this 1 years ago in linux-4.9 and it need verifying.

>
> Also, many arm boards use more complex LED labels with multiple parts
> separated by colon, like "boardname:name:function" or so.
Name is Ok for me as long as it's correct.

>
> >> +               };
> >> +       };
> [...]
> >> diff --git a/arch/csky/boot/dts/gx6605s.dtsi b/arch/csky/boot/dts/gx66=
05s.dtsi
> >> new file mode 100644
> >> index 000000000000..956af5674add
> >> --- /dev/null
> >> +++ b/arch/csky/boot/dts/gx6605s.dtsi
> >> @@ -0,0 +1,82 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause */
> >> +/*
> >> + * NationalChip GX6605S SoC
> >> + *
> >> + * Copyright (c) 2019 Andreas F=C3=A4rber
> >> + */
> >> +
> >> +/ {
> >> +       #address-cells =3D <1>;
> >> +       #size-cells =3D <1>;
> >> +
> >> +       cpus {
> >> +               #address-cells =3D <1>;
> >> +               #size-cells =3D <0>;
> >> +
> >> +               cpu0: cpu@0 {
> >> +                       device_type =3D "cpu";
> >> +                       compatible =3D "csky,ck610";
> >> +                       reg =3D <0>;
> >> +               };
> >> +       };
> >> +
> >> +       soc {
> >> +               compatible =3D "simple-bus";
> >> +               interrupt-parent =3D <&intc>;
> >> +               #address-cells =3D <1>;
> >> +               #size-cells =3D <1>;
> >> +               ranges;
> >> +
> >> +               timer0: timer@20a000 {
> >> +                       compatible =3D "csky,gx6605s-timer";
>
> The reason I left out the compatible for the SoC/board is that it looks
> unclean to me that you're using a "csky," vendor prefix for interrupt
> controller and timer instead of a new "nationalchip," prefix for the SoC
> vendor. Did I miss some reasoning for that, or did that slip through
> patch review?
csky is my current company and nationalchip is my prior company. The
gx6605s is belong to nationachip and gx6605s use csky 610 as its CPU.

>
> Being the first board we'd need to create a new YAML file to document
> them, I assume. Not sure what the best scope (=3Dname) would be here.
>
> >> +                       reg =3D <0x0020a000 0x400>;
> >> +                       clocks =3D <&dummy_apb_clk>;
> >> +                       interrupts =3D <10>;
> >> +               };
> [...]
> >> +               intc: interrupt-controller@500000 {
> >> +                       compatible =3D "csky,gx6605s-intc";
>
> Here's the other SoC compatible.
It's defined in irqchip/irq-csky-apb-intc.c.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
