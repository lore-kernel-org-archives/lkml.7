Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05625CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D813F208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfKACmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:42:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34840 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfKACmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:42:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id w3so4159154edt.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 19:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEItDoI/WeAoU1peUct7EvzKqvglpEF7cvTUFCv7y5k=;
        b=Ax8CJe1xZQhqemX4QOkAnEB9Bt8R1lIzge9gYO4I24yNxceCm1Vevke1WS7LbniRkj
         grRIUhyxozl72bBQsxMzgpDTriwNrIbMWw93OMkFE3ygLSvbwRA6MCd6j/bQsN9EXEDd
         J6Gw6J0wvq304/HX6Lmf4rf+cOxBQgQWG4oVEsYTpQv1PH+BDEHrKhKXfTfIucXnhPwy
         W/XbnADkPOopOYqC6e8pTSNyn88M+PtIc7jZKB23oGBAECL1/d1DPFj5Gk3Dxk/z5H74
         tyNgzxh8FO2hmx2QT2yp/jKtB8epbW2NTlTVfVCCqVQPa5WGk3HLjnO3OfMIQfyN/pmU
         eRyA==
X-Gm-Message-State: APjAAAVfKIATgeShUFD/kGoszhw9vx9zFXToiQv0ygyiUR5XQAUwqFvP
        jPWhcA4jkYHr/w3RmlQbv5mHbQlil6A=
X-Google-Smtp-Source: APXvYqww4BVLmD/vsl7CBDu0CZtZaIehqa1PQiEvm+PBnV32lVaeeFdhLoNxhwGJE/Ktp5cMvGWYXA==
X-Received: by 2002:a50:eb49:: with SMTP id z9mr2185616edp.31.1572576169418;
        Thu, 31 Oct 2019 19:42:49 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id i6sm164142eds.96.2019.10.31.19.42.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 19:42:49 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id q70so7980418wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 19:42:48 -0700 (PDT)
X-Received: by 2002:a7b:c925:: with SMTP id h5mr7292349wml.61.1572576168752;
 Thu, 31 Oct 2019 19:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191031231104.30725-1-karlp@tweak.net.au>
In-Reply-To: <20191031231104.30725-1-karlp@tweak.net.au>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 1 Nov 2019 10:42:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v64pYuA6yN3CYEv=MUeD+pSb49UauukehENzVsBvHhDx=w@mail.gmail.com>
Message-ID: <CAGb2v64pYuA6yN3CYEv=MUeD+pSb49UauukehENzVsBvHhDx=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: sunxi: h3/h5: add missing uart2 rts/cts pins
To:     Karl Palsson <karlp@tweak.net.au>
Cc:     Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 7:16 AM Karl Palsson <karlp@tweak.net.au> wrote:
>
> uart1 and uart3 had existing pin definitions for the rts/cts pairs.
> Add definitions for uart2 as well.
>
> Signed-off-by: Karl Palsson <karlp@tweak.net.au>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 84977d4eb97a..2d8637300321 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -472,6 +472,11 @@
>                                 function = "uart2";
>                         };
>
> +                       uart2_rts_cts_pins: uart2-rts-cts-pins {

We started adding "/omit-if-no-ref/" for all pin definitions that
aren't selected by default. I think we can do this wholesale for
all the ones in this file after this patch is merged though. So,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> +                               pins = "PA2", "PA3";
> +                               function = "uart2";
> +                       };
> +
>                         uart3_pins: uart3-pins {
>                                 pins = "PA13", "PA14";
>                                 function = "uart3";
> --
> 2.20.1
>
