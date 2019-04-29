Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53074C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208482075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556561330;
	bh=rrBhOQTxCKJbo/xhQag+zuWAULOGAvmOK3mtvBRvrGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z9R1hvgy97y9EkSum6JMpgK7V7L0BRgwaEPNlJo3JGUqxRhZxPDOp7h3mJm8JJRVS
	 H0Xz4BFEeHBCWeXf6ZrCmx5hR2K58XO2ju3R1pJ/QVTapOhf7Zlbog6nSOIQIKXoJm
	 t9R480ESpkXC1y5Lc27fPt0tXiDS6EKXOxYMBLWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfD2SIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:08:49 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35862 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2SIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:08:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id b18so492382otq.3;
        Mon, 29 Apr 2019 11:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k8gAARN4apicDkk5HczIkkY69NduYn2gyzEh87JDG00=;
        b=h7lYQERl4H2NztyqPUosTxN+DfKhpQAEZVE8gyDF/5zU8jP0GIiAxw9apQW3oRTwZH
         Tnsp9f/LMaRU586Y607VQaH2sxL6bJXsJebtMQvHztm4xAVgTBGj2GggnSeNNCJxBNuU
         Vvu02pUYcGfjD82ODpE9B/YbvXdGkrs2eh6CS/GWfsz99ao5ZGy2fvl82QmedRDmIm4g
         x3fz/jr21fT7BbwZi5RhT1+d5Ntsvq/fTo/XULiVW1IGe+n7YFJ7RZ+JCMH33738Aqxd
         kg5OzIS+RAqXsjVjst4t7vCB6LqG+xLYpnWXJWhyOagMIoi9aIpaJhOxo25qG6/1GrOe
         i84g==
X-Gm-Message-State: APjAAAVZ//FPvE6s41s3C/hdFdCD7LC4lVb9rS18IYGiKLacqOGidO+p
        WdU3S83TwYMY7OqQQZ6Ejg==
X-Google-Smtp-Source: APXvYqy13wDJjfHnr6l9xY4z5mnssj1zSTsBbAclybaVJHKRzHVXehef93dFsU95+qt+zSW7u7YIrQ==
X-Received: by 2002:a9d:360b:: with SMTP id w11mr13052433otb.238.1556561328209;
        Mon, 29 Apr 2019 11:08:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v10sm2732527oiv.36.2019.04.29.11.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 11:08:47 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:08:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 2/6] dt-bindings: riscv: sifive: add YAML documentation
 for the SiFive FU540
Message-ID: <20190429180846.GA26021@bogus>
References: <20190411084304.5072-2-paul.walmsley@sifive.com>
 <20190411084304.5072-3-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411084304.5072-3-paul.walmsley@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 01:43:00AM -0700, Paul Walmsley wrote:
> Add YAML DT binding documentation for the SiFive FU540 SoC.  This
> SoC is documented at:
> 
>     https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> 
> Passes dt-doc-validate, as of yaml-bindings commit 4c79d42e9216.
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../devicetree/bindings/riscv/sifive.yaml     | 26 +++++++++++++++++++
>  MAINTAINERS                                   |  9 +++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sifive.yaml b/Documentation/devicetree/bindings/riscv/sifive.yaml
> new file mode 100644
> index 000000000000..d2808d8d79bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/sifive.yaml
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/sifive/sifive.yaml#

The path here should match the file path. IOW, drop 'sifive/'.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive SoC-based boards
> +
> +maintainers:
> +  - Paul Walmsley <paul.walmsley@sifive.com>
> +  - Palmer Dabbelt <palmer@sifive.com>
> +
> +description:
> +  SiFive SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    items:
> +      - enum:
> +          - sifive,freedom-unleashed-a00-fu540
> +          - sifive,freedom-unleashed-a00
> +      - const: sifive,fu540-c000
> +      - const: sifive,fu540
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ec37f17f90e..c02bf352a8c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14138,6 +14138,15 @@ S:	Supported
>  K:	sifive
>  N:	sifive
>  
> +SIFIVE FU540 SYSTEM-ON-CHIP
> +M:	Paul Walmsley <paul.walmsley@sifive.com>
> +M:	Palmer Dabbelt <palmer@sifive.com>
> +L:	linux-riscv@lists.infradead.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pjw/sifive.git
> +S:	Supported
> +K:	fu540
> +N:	fu540
> +
>  SILEAD TOUCHSCREEN DRIVER
>  M:	Hans de Goede <hdegoede@redhat.com>
>  L:	linux-input@vger.kernel.org
> -- 
> 2.20.1
> 
