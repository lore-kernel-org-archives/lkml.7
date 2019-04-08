Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC86CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25AA20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfDHGDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:03:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35645 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHGDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:03:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id s39so10525723edb.2;
        Sun, 07 Apr 2019 23:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iRQ0LjHXaiZNgPu0/n0A6d0cMpaNc8Ae4QAy9FAhEM=;
        b=rYTkMirA03Mgw6T3wahGsP4XBNeztdXrHx1yxBKoQ7VWWUCi1SYV4HmnRjpLOtRrTp
         cq8rC5divM4M/snTBd3q389kNfcWAVuQlE9fIXSh+eSQfYp1bpSxJtPIA8JExWgE4ULC
         co+jsZlZzmVc1tdqYr6UVbIbZLoSCBuRUxDosDf6PBXyEz6MJZzXNgvwLIpu3vOwAQIK
         CLqtqZHCc0sXRGhiykRXXhIAObFRotXLRXUJs52ZRvL5v0BzQc1of2X/aIhK2PLHubvg
         yia5j7zN4QnjSCyCU8urUN1OVKVJWiC/Zj+0iQbXh9cH7+jFRkylRNu+9rwEwkeES5K1
         Jtfw==
X-Gm-Message-State: APjAAAWxIo/wHD/wjraiOLExT49DTbgmrfYx6LFsnqQhA9iJSgZzGHfx
        1NhuVKCKqv3zAJMTttUDKQVyz+2xUkw=
X-Google-Smtp-Source: APXvYqwQV8cjrOyNtfrJ10TqSD/0WPnIdzyvbJyPb/30LGQ9mKataQcTmfQN50lGffsSaNaxJtcxww==
X-Received: by 2002:a17:906:924e:: with SMTP id c14mr15220751ejx.230.1554703411135;
        Sun, 07 Apr 2019 23:03:31 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id g46sm8625848edc.10.2019.04.07.23.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 23:03:30 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id n25so13240443wmk.4;
        Sun, 07 Apr 2019 23:03:30 -0700 (PDT)
X-Received: by 2002:a1c:40c3:: with SMTP id n186mr16625540wma.3.1554703410424;
 Sun, 07 Apr 2019 23:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190408055415.1374-1-jagan@amarulasolutions.com>
In-Reply-To: <20190408055415.1374-1-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 8 Apr 2019 14:03:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v64g9=VoHP0s2OKt2Xv8Fj97dhy7iUkAp-hqLKBLZd5qAg@mail.gmail.com>
Message-ID: <CAGb2v64g9=VoHP0s2OKt2Xv8Fj97dhy7iUkAp-hqLKBLZd5qAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: a64-amarula-relic: Add GT5663
 CTP node
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 1:54 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Add Goodix GT5663 capacitive touch controller node on
> Amarula A64-Relic board.
>
> The CTP connected to board with,
> - SDA, SCK from i2c1
> - GPIO-LD0 as AVDD28 supply
> - PH4 gpio as interrupt pin
> - PH8 gpio as reset pin
> - X axis is inverted
> - Y axis is inverted
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../allwinner/sun50i-a64-amarula-relic.dts    | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> index 3575db216016..a76353d59aaa 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> @@ -49,6 +49,28 @@
>         bias-pull-up;
>  };
>
> +&i2c1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c1_pins>;
> +       status = "okay";
> +
> +       touchscreen@5d {
> +               compatible = "goodix,gt5663";
> +               reg = <0x5d>;
> +               AVDD28-supply = <&reg_ldo_io0>;                 /* VCC-CTP: GPIO0-LDO */
> +               interrupt-parent = <&pio>;
> +               interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
> +               irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;        /* CTP-INT: PH4 */
> +               reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;      /* CTP-RST: PH8 */
> +               touchscreen-inverted-x;
> +               touchscreen-inverted-y;
> +       };
> +};
> +
> +&i2c1_pins {
> +       bias-pull-up;
> +};
> +

Do you know if the pins have external pull-ups? If so then you
don't need this bit. Same for the other patch.

AFAIK the internal pull-ups are kind of weak.

>  &mmc1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&mmc1_pins>;
> @@ -212,6 +234,13 @@
>         regulator-name = "vdd-cpus";
>  };
>
> +&reg_ldo_io0 {
> +       regulator-min-microvolt = <3300000>;
> +       regulator-max-microvolt = <3300000>;
> +       regulator-name = "vcc-ctp";
> +       status = "okay";
> +};
> +
>  &reg_rtc_ldo {
>         regulator-name = "vcc-rtc";
>  };
> --
> 2.18.0.321.gffc6fa0e3
>
