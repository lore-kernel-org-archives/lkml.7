Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87740C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6105524E09
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559626728;
	bh=EBN4ZNSd8NhEYdq0hNKqzuNHBo2t+PXzbNlAzkbg4+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kjzn/x7f4ng0GYR+O0pZVn/YDQwGiFg8GAOHQjECErUHOWqNLXWKAgN8+uzW+b6/2
	 m3btzWexcpafM91a1ND62nu7WMhc05zfSoeWO1OQKGqSSfu9ZDptTKcC+zJ3Do953U
	 HTiDP6XIY4mbFzv95gYpwcJAJAdJ45PCk8PfhmVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFDFir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfFDFir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:38:47 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34AED24E0A;
        Tue,  4 Jun 2019 05:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559626726;
        bh=EBN4ZNSd8NhEYdq0hNKqzuNHBo2t+PXzbNlAzkbg4+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VuL7lsDLsUUTY9oR6W4cEQghyMVMAelaoT9rdrNk1YK9AwJO+G/4Y2J9LjaDNR6Gq
         +lg75l9/ghvaJoLigtCFFsarWc79IbswOuln/YriXudbw4t9KrBkZN3MEXfK4wZVKy
         3Gh++XVNxcRNM9nXN7QOTpugEumE1W1CN2LTyk44=
Received: by mail-wm1-f52.google.com with SMTP id 22so5042511wmg.2;
        Mon, 03 Jun 2019 22:38:46 -0700 (PDT)
X-Gm-Message-State: APjAAAUAQtPw/fMf93ZGnSmShYMIXVerTs9SGCCRYjX5zJo4MYBfO+KF
        lU7ULY6QWbFsg6uyPvMH6tL3ptkRhP5iAJL99Ac=
X-Google-Smtp-Source: APXvYqzHeFGkVUehks97OWkC5HOZXieHQK5qjxqhvFMi6v+vpeVPeUJlFla+oTSuP1/eZlyMgfYs9Rkg9/ylE2kbaMA=
X-Received: by 2002:a1c:a807:: with SMTP id r7mr16193800wme.137.1559626724784;
 Mon, 03 Jun 2019 22:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559614824.git.han_mao@c-sky.com> <0ac19e3d8840bc422967653dba9c9b96f5767357.1559614824.git.han_mao@c-sky.com>
In-Reply-To: <0ac19e3d8840bc422967653dba9c9b96f5767357.1559614824.git.han_mao@c-sky.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 4 Jun 2019 13:38:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT0bkBwxpmR2xzPWwHk8E_v-uA-Zcf_JY4x_SKMkXAsnQ@mail.gmail.com>
Message-ID: <CAJF2gTT0bkBwxpmR2xzPWwHk8E_v-uA-Zcf_JY4x_SKMkXAsnQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/6] dt-bindings: csky: Add csky PMU bindings
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <ren_guo@c-sky.com>

On Tue, Jun 4, 2019 at 10:25 AM Mao Han <han_mao@c-sky.com> wrote:
>
> This patch adds the documentation to describe that how to add pmu node in
> dts.
>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Guo Ren <guoren@kernel.org>
> ---
>  Documentation/devicetree/bindings/csky/pmu.txt | 38 ++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/csky/pmu.txt
>
> diff --git a/Documentation/devicetree/bindings/csky/pmu.txt b/Documentation/devicetree/bindings/csky/pmu.txt
> new file mode 100644
> index 0000000..53c3b0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/csky/pmu.txt
> @@ -0,0 +1,38 @@
> +============================
> +C-SKY Performance Monitor Units
> +============================
> +
> +C-SKY 8xx series cores often have a PMU for counting cpu and cache events.
> +The C-SKY PMU representation in the device tree should be done as under:
> +
> +==============================
> +PMU node bindings definition
> +==============================
> +
> +       Description: Describes PMU
> +
> +       PROPERTIES
> +
> +       - compatible
> +               Usage: required
> +               Value type: <string>
> +               Definition: must be "csky,csky-pmu"
> +       - interrupts
> +               Usage: required
> +               Value type: <u32>
> +               Definition: must be pmu irq num defined by soc
> +       - count-width
> +               Usage: optional
> +               Value type: <u32>
> +               Definition: the width of pmu counter
> +
> +Examples:
> +---------
> +
> +        pmu {
> +                compatible = "csky,csky-pmu";
> +                interrupts = <0x17 IRQ_TYPE_EDGE_RISING>;
> +                interrupt-parent = <&intc>;
> +               count-width = <0x30>;
> +        };
> +
> --
> 2.7.4
>
