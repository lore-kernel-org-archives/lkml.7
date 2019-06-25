Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C4AC4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BB720820
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561423568;
	bh=RNzIAso/rxBfUpe7MNS93/SEMT2Rlb+4I7VdtoiS4Ao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U23qpaNZihhRuWllDUodUNbQKSWmVPXWWPURS/63LFV7C+kKOF53XRKnbs5pTjhsE
	 FK0SWl+8pa1jMeP7Em0lplq5Rqe3f6Dc8tpK7kuswcryF710s1ahCSwOh+4tQUrjN+
	 8ghuV8dMWF4fVMD5Okv/6gy5l39zo+/7iPAnANV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfFYAqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfFYAqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:46:07 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5368D2077C;
        Tue, 25 Jun 2019 00:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561423565;
        bh=RNzIAso/rxBfUpe7MNS93/SEMT2Rlb+4I7VdtoiS4Ao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sg/xYLajjPzvbCUt3gTxv+J3BGhiIKQCGXIfEbrs29tmJaMzUjIDeBFZub4k+s9ZU
         kxCBkjBXSrjMWDFRRNbx9bfFUxh/uDGSkOJRZqG3Y3uKYNJexxo0k4V6XRt8okkaHO
         N+xrLWqOFndyRz+6BsqtLqv6+AtSEYXxhcZM5MO8=
Received: by mail-wr1-f50.google.com with SMTP id x4so15775132wrt.6;
        Mon, 24 Jun 2019 17:46:05 -0700 (PDT)
X-Gm-Message-State: APjAAAUbAq75J7g2S0GjZ/I61CZY4XPlK6AOmZuGND04tpitMXoC/oRc
        krSl6pafEOF0JQtq5mzKXsusHxtrTRYd8vUh+DA=
X-Google-Smtp-Source: APXvYqzKYUCkQ9YHQyKo9cbGgoCkXaJbgZgwvjyDy4gpYiUq/NjlZHSjWg2dvXgMl4unyn/RE1JzYUxIYwZlkTfP9a8=
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr63999161wrx.80.1561423563959;
 Mon, 24 Jun 2019 17:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190625002829.17409-1-afaerber@suse.de>
In-Reply-To: <20190625002829.17409-1-afaerber@suse.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 25 Jun 2019 08:45:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTnhTQK-mOyC+e8U8xrDwaoDUACb1R_zQfDCKwdKzc96w@mail.gmail.com>
Message-ID: <CAJF2gTTnhTQK-mOyC+e8U8xrDwaoDUACb1R_zQfDCKwdKzc96w@mail.gmail.com>
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

Thx for the patch. No need seperate part into dtsi, just follow:
https://lore.kernel.org/linux-csky/1561376581-19568-1-git-send-email-guoren=
@kernel.org/T/#u

On Tue, Jun 25, 2019 at 8:28 AM Andreas F=C3=A4rber <afaerber@suse.de> wrot=
e:
>
> Add Device Trees for NationalChip GX6605S SoC (based on CK610 CPU) and it=
s
> dev board. GxLoader expects as filename gx6605s.dtb, so keep that.
> The bootargs are prepared to boot from USB and to output to serial.
>
> Compatibles for the SoC and board are left out for now.
>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
>  arch/csky/boot/dts/gx6605s.dts  | 104 ++++++++++++++++++++++++++++++++++=
++++++
>  arch/csky/boot/dts/gx6605s.dtsi |  82 +++++++++++++++++++++++++++++++
>  2 files changed, 186 insertions(+)
>  create mode 100644 arch/csky/boot/dts/gx6605s.dts
>  create mode 100644 arch/csky/boot/dts/gx6605s.dtsi
>
> diff --git a/arch/csky/boot/dts/gx6605s.dts b/arch/csky/boot/dts/gx6605s.=
dts
> new file mode 100644
> index 000000000000..f7511024ec6f
> --- /dev/null
> +++ b/arch/csky/boot/dts/gx6605s.dts
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause */
> +/*
> + * GX6605S dev board
> + *
> + * Copyright (c) 2019 Andreas F=C3=A4rber
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "gx6605s.dtsi"
> +
> +/ {
> +       model =3D "Nationalchip GX6605S";
> +
> +       aliases {
> +               serial0 =3D &uart;
> +       };
> +
> +       chosen {
> +               bootargs =3D "console=3DttyS0,115200n8 root=3D/dev/sda2 r=
w rootwait";
> +               stdout-path =3D "serial0:115200n8";
> +       };
> +
> +       memory@10000000 {
> +               device_type =3D "memory";
> +               reg =3D <0x10000000 0x04000000>;
> +       };
> +
> +       dummy_apb_clk: dummy-apb-clk {
> +               compatible =3D "fixed-clock";
> +               clock-frequency =3D <24000000>; /* guesstimate */
> +               #clock-cells =3D <0>;
> +       };
> +
> +       buttons {
> +               compatible =3D "gpio-keys-polled";
> +               poll-interval =3D <100>;
> +               autorepeat;
> +
> +               button5 {
> +                       label =3D "button5";
> +                       linux,code =3D <103>;
> +                       gpios =3D <&gpio 5 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               button6 {
> +                       label =3D "button6";
> +                       linux,code =3D <106>;
> +                       gpios =3D <&gpio 6 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               button7 {
> +                       label =3D "button7";
> +                       linux,code =3D <28>;
> +                       gpios =3D <&gpio 7 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               button8 {
> +                       label =3D "button8";
> +                       linux,code =3D <105>;
> +                       gpios =3D <&gpio 8 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               button9 {
> +                       label =3D "button9";
> +                       linux,code =3D <108>;
> +                       gpios =3D <&gpio 9 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       leds {
> +               compatible =3D "gpio-leds";
> +
> +               led0 {
> +                       label =3D "led10";
> +                       gpios =3D <&gpio 10 GPIO_ACTIVE_LOW>;
> +                       linux,default-trigger =3D "heartbeat";
> +               };
> +
> +               led1 {
> +                       label =3D "led11";
> +                       gpios =3D <&gpio 11 GPIO_ACTIVE_LOW>;
> +                       linux,default-trigger =3D "timer";
> +               };
> +
> +               led2 {
> +                       label =3D "led12";
> +                       gpios =3D <&gpio 12 GPIO_ACTIVE_LOW>;
> +                       linux,default-trigger =3D "default-on";
> +               };
> +
> +               led3 {
> +                       label =3D "led13";
> +                       gpios =3D <&gpio 13 GPIO_ACTIVE_LOW>;
> +                       linux,default-trigger =3D "default-on";
> +               };
> +       };
> +};
> +
> +&timer0 {
> +               clocks =3D <&dummy_apb_clk>;
> +};
> diff --git a/arch/csky/boot/dts/gx6605s.dtsi b/arch/csky/boot/dts/gx6605s=
.dtsi
> new file mode 100644
> index 000000000000..956af5674add
> --- /dev/null
> +++ b/arch/csky/boot/dts/gx6605s.dtsi
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause */
> +/*
> + * NationalChip GX6605S SoC
> + *
> + * Copyright (c) 2019 Andreas F=C3=A4rber
> + */
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       cpus {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               cpu0: cpu@0 {
> +                       device_type =3D "cpu";
> +                       compatible =3D "csky,ck610";
> +                       reg =3D <0>;
> +               };
> +       };
> +
> +       soc {
> +               compatible =3D "simple-bus";
> +               interrupt-parent =3D <&intc>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges;
> +
> +               timer0: timer@20a000 {
> +                       compatible =3D "csky,gx6605s-timer";
> +                       reg =3D <0x0020a000 0x400>;
> +                       clocks =3D <&dummy_apb_clk>;
> +                       interrupts =3D <10>;
> +               };
> +
> +               gpio: gpio@305000 {
> +                       compatible =3D "wd,mbl-gpio";
> +                       reg-names =3D "dirout", "dat", "set", "clr";
> +                       reg =3D <0x00305000 0x4>,
> +                             <0x00305004 0x4>,
> +                             <0x00305008 0x4>,
> +                             <0x0030500c 0x4>;
> +                       gpio-controller;
> +                       #gpio-cells =3D <2>;
> +               };
> +
> +               uart: serial@403000 {
> +                       compatible =3D "ns16550a";
> +                       reg =3D <0x00403000 0x400>;
> +                       interrupts =3D <15>;
> +                       clock-frequency =3D <29491200>;
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <1>;
> +               };
> +
> +               intc: interrupt-controller@500000 {
> +                       compatible =3D "csky,gx6605s-intc";
> +                       reg =3D <0x00500000 0x400>;
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <1>;
> +               };
> +
> +               ehci_hcd: usb@900000 {
> +                       compatible =3D "generic-ehci";
> +                       reg =3D <0x00900000 0x400>;
> +                       interrupts =3D <59>;
> +               };
> +
> +               ohci_hcd0: usb@a00000 {
> +                       compatible =3D "generic-ohci";
> +                       reg =3D <0x00a00000 0x400>;
> +                       interrupts =3D <58>;
> +               };
> +
> +               ohci_hcd1: usb@b00000 {
> +                       compatible =3D "generic-ohci";
> +                       reg =3D <0x00b00000 0x400>;
> +                       interrupts =3D <57>;
> +               };
> +       };
> +};
> --
> 2.16.4
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
