Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6EAC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B9621872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573571964;
	bh=wHDZMbSdKhyJC2fgnNIgn0VK5Tg314l+sk7EP5PeKTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ezP7KdmumjaGiBTe5FGFZJAppinoYLtjILWYm6ojbREgZBNEgKAkeqwO0+OALS985
	 uVOihClRQZUh059QlOC1bM7sPiH8+ySqu+TxfcKFqxpSOSsiIMWzt2KnNVGBZyyaea
	 ddSVqPb179MkQEhYZstUEle0dJQqEMFoPn/gE2Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfKLPTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:19:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35285 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfKLPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:19:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id q22so12078336pgk.2;
        Tue, 12 Nov 2019 07:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BZANFq4xix4Xx203tkzaxuFkXxyuVqwVXr98xMHZnnc=;
        b=YeSbv/o238TihuHuHsLnc7+bdmZy/QkzZyYaF031u7mpD8YNKqev8YWcQrJkAITcwU
         3BVH3qOs7m0v1XmCSlfFJEMmvXcqPQ/ozYwOiRd3WrORKgOKBiKPR1WRHs6nEg/tT/N5
         sHdex8rRaIaHt45wfzjAfxlJMTcLK9FO2UpECNI4J/epf1RCxgtiv0ZrhnbSRJzGfg1j
         a8XUnFliDvDxcNV3k9M3ElszJRYH2qlhzNv1Qzj0VPBMsK5q6YEeSuu+i3anYhitG/dV
         IDDxHdYdyy7bjk11+zSS894TYOnD55EAcCNEFOYSmjEMwD7WQPhOBUNobxBfBvu6rkuE
         3JUA==
X-Gm-Message-State: APjAAAV8fDTDhEvq4xpng9QJnpEQBk9WueqRMDmFiUDjemB5TrEx5d5j
        zP4ZSOA1y9Xn2J6vO4yAlHs=
X-Google-Smtp-Source: APXvYqwmlQNvZHi0kGC31dBquXDWMrtHIO5u9GdO7oPYqwAqhXo8lw8ouNas9FGnjW/2SPI9uWr2og==
X-Received: by 2002:aa7:8a97:: with SMTP id a23mr37221666pfc.76.1573571960433;
        Tue, 12 Nov 2019 07:19:20 -0800 (PST)
Received: from kozik-lap ([118.189.143.39])
        by smtp.googlemail.com with ESMTPSA id 21sm25298308pfa.170.2019.11.12.07.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 07:19:19 -0800 (PST)
Date:   Tue, 12 Nov 2019 16:19:15 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marian Mihailescu <mihailescu2m@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org
Subject: Re: [PATCH v4 2/2] ARM: dts: exynos5420: add mali dt node and enable
 mali on Odroid XU3/4
Message-ID: <20191112151915.GA15786@kozik-lap>
References: <20191106225527.9121-1-mihailescu2m@gmail.com>
 <20191106225527.9121-2-mihailescu2m@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106225527.9121-2-mihailescu2m@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:25:27AM +1030, Marian Mihailescu wrote:
> Add device tree node for Mali GPU for Exynos 542x SoC.
> GPU is disabled by default, and is enabled for each board after the
> regulator is defined. Tested on Odroid-XU4.
> 
> Changes since v3:
> - fixed compatible to match bindings
> 
> Changes since v2:
> - separate patch for bindings
> - fixed bindings typo
> 
> Changes since v1:
> - used generic node and label for GPU
> - added bindings for compatible
> - fixed irq indentation
> - fixed interrupt-names to match bindings
> - added cooling cells for future TMU connection
> - used generic node and label for GPU opp table
> - removed always-on from SoC GPU regulator
> 
> Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 50 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  6 +++-

Hi,

Unfortunately this does not apply around exynos5422-odroid-core.dtsi.
I think there were no changes to this file in current development cycle
so I am surprised that there are conflicts.

On what version were you basing your patch? Was it tested on latest
kernel? The patches should be based usually on one of:
1. current-rc1 (v5.4-rc1)
2. latest-rc (v5.4-rc7)
3. maintainer's tree (my next/dt or for-next)
4. linux-next

In all other cases the patch would need rebasing and re-testing.

Best regards,
Krzysztof

