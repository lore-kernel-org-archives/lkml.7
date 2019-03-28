Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F0FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BBA20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfC1ICJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:02:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41202 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfC1ICI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:02:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id a25so16356597edc.8;
        Thu, 28 Mar 2019 01:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0dyk/6WTaPK32KcXXwdfBBK15JjRugwXEVvwXqqG8A=;
        b=YT/uCjM0HWh+u3vvM7Z4DaxlX49F/aNTKxcQpegcpEEsNyVhlHFAYYuCt1YSoQNAiL
         DUs5hBD95XuxC2d49OMZ5O+IrxjuTcEEduwtlirqmE9+E0HCLSi6aoeF1VfqFAishCg7
         irscMG0aZ03tR+z8j2zoBDf2TTcHqpJh2Bm8Uz9M47vrn/xPfSzIEUwDFQx0emweEcrw
         yhaXKRu/r7dIZXnRxD2EOmQyDfei4lwMu/nxx8sLmSf3esllC4uJU5xttWBaq+fOcSjm
         iRPlAHnmu4+fYQIhtQwFLg1M6ZGavc0bZZ19CTGVMaYZeLOxUYP6fv0yuJ+stIPnNh+p
         viGQ==
X-Gm-Message-State: APjAAAXmv5AP5D2npLbI9MSeIp/qrr5aZlyoLc0iDCy9xYnGYSvJB9N4
        MhPqdZ42qmN9DkqkiBHQHuGDIrDmY54=
X-Google-Smtp-Source: APXvYqxTdI4WgWortzUsrYxEU7rwTzSPwxrajcY0qw1HWunb9nTYfEb2qCw42s4tX2mhXiHWzTIjMg==
X-Received: by 2002:a50:c404:: with SMTP id v4mr14911322edf.146.1553760126565;
        Thu, 28 Mar 2019 01:02:06 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id c7sm1159421edt.70.2019.03.28.01.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 01:02:06 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id y13so3906193wrd.3;
        Thu, 28 Mar 2019 01:02:06 -0700 (PDT)
X-Received: by 2002:a5d:458f:: with SMTP id p15mr27489721wrq.188.1553760125840;
 Thu, 28 Mar 2019 01:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190327001843.2420-1-megous@megous.com> <20190327001843.2420-5-megous@megous.com>
In-Reply-To: <20190327001843.2420-5-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Mar 2019 16:01:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v67V+tq8+Jn-moKJs4npM9KuQJjh8G2BQ+5-mc9qXd6zOQ@mail.gmail.com>
Message-ID: <CAGb2v67V+tq8+Jn-moKJs4npM9KuQJjh8G2BQ+5-mc9qXd6zOQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 4/7] ARM: dts: sun8i: a83t: Add UART2 PB pins
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Rob Herring <robh@kernel.org>, johan@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 8:18 AM megous via linux-sunxi
<linux-sunxi@googlegroups.com> wrote:
>
> From: Ondrej Jirman <megous@megous.com>
>
> Add pin definitions for UART2 PB pins. These are used on TBS-A711
> tablet.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index e5c39eef1c29..921cfb30ab46 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -768,6 +768,11 @@
>                                 pins = "PG8", "PG9";
>                                 function = "uart1";
>                         };
> +

Please add "/omit-if-no-ref/" before the pin definitions.

See

https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?h=sunxi/dt-for-5.2&id=73b670023327a014688c2d5309a43604cd553f1e

for such an example. This is a new policy.

ChenYu


> +                       uart2_pb_pins: uart2-pb-pins {
> +                               pins = "PB0", "PB1";
> +                               function = "uart2";
> +                       };
>                 };
>
>                 timer@1c20c00 {
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
