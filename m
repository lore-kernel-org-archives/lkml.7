Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DE0C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583CA208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578428067;
	bh=1kRpl3D/84++yLzuVo/93IHEm/dKswMXhcgmSQzkB/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HLd9A2UDwkLtxlLYbIm1XQ7CaRvfXPm8BiRqw37mPDQnyqMkcRdIfU3PItiapCHSL
	 d2ucEcO9LX4XZseZQu3flrKfhj4gkSR2hdUADKsZ8GFsxyd/tPux+avVKKmCzFTNGl
	 +//MEJaj8qIS6IoXoZD3Md4Psc3hTaTKnPoZIgOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAGUO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:14:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43450 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgAGUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:14:26 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so639896edb.10;
        Tue, 07 Jan 2020 12:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3aS4Jy/hBVuzIbx1M24ZHNxqIgSBkpGASRqgDczsY+s=;
        b=aGNyRd3VY9cTMQ/eljJ03a9OFsacMzKg29cFkxqFtYnHqXBLFUNdA/eGHaYlpeCSfa
         qvLMElPLfejKzp4AjqJmA7NwTsvmnzO3wV1BJd/Op9WpSSf4/QKnetX9ERL+xOrcg80+
         KNdn0Cwo8xsLFj9G+8u3VTm4f9Nu62+HvtDk6nA1dZUf8V1J/4OcpCEU03YH9UwFl7Ww
         ga2nPKIbEW3h9tZdxWVuIWvV6502+rba6wET+hhQl4N3R/uLaXKeQ057+gYw2Vqi5E8x
         yy8ThdhIahqWC55XWj/azCJPDrrLiyJu07fOZe3WE4eTJldr1aSOsGgrOd6ZMH/B2q4/
         xWcg==
X-Gm-Message-State: APjAAAX5K/rvTK19RonAj0xYAzZ3TrZ/QeMrLmw0edErJITsi56hG9o+
        qW++gBRGz+40n8P91uNzzEIAqd31
X-Google-Smtp-Source: APXvYqwm8bN/J1cRIU0kGkZ/Ucp0J0RgPBy+IBYEsfHdkNRt4A0cKKb2/owPSuFmmfFe275aBXb7YA==
X-Received: by 2002:a17:906:5358:: with SMTP id j24mr1298906ejo.44.1578428064594;
        Tue, 07 Jan 2020 12:14:24 -0800 (PST)
Received: from kozik-book ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id r13sm11313ejb.27.2020.01.07.12.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 12:14:23 -0800 (PST)
Date:   Tue, 7 Jan 2020 21:14:20 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 03/20] ARM: dts: samsung: Rename Samsung and Exynos to
 lowercase
Message-ID: <20200107201420.GB8636@kozik-book>
References: <20200104152107.11407-1-krzk@kernel.org>
 <20200104152107.11407-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200104152107.11407-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 04:20:50PM +0100, Krzysztof Kozlowski wrote:
> Fix up inconsistent usage of upper and lowercase letters in "Samsung"
> and "Exynos" names.
> 
> "SAMSUNG" and "EXYNOS" are not abbreviations but regular trademarked
> names.  Therefore they should be written with lowercase letters starting
> with capital letter.
> 
> The lowercase "Exynos" name is promoted by its manufacturer Samsung
> Electronics Co., Ltd., in advertisement materials and on website.
> 
> Although advertisement materials usually use uppercase "SAMSUNG", the
> lowercase version is used in all legal aspects (e.g. on Wikipedia and in
> privacy/legal statements on
> https://www.samsung.com/semiconductor/privacy-global/).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts      | 2 +-
>  arch/arm/boot/dts/exynos5250-smdk5250.dts     | 4 ++--
>  arch/arm/boot/dts/exynos5250.dtsi             | 8 ++++----
>  arch/arm/boot/dts/exynos5260-xyref5260.dts    | 4 ++--
>  arch/arm/boot/dts/exynos5260.dtsi             | 2 +-
>  arch/arm/boot/dts/exynos5410-smdk5410.dts     | 4 ++--
>  arch/arm/boot/dts/exynos5410.dtsi             | 6 +++---
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts | 2 +-
>  arch/arm/boot/dts/exynos5420-cpus.dtsi        | 2 +-
>  arch/arm/boot/dts/exynos5420-smdk5420.dts     | 4 ++--
>  arch/arm/boot/dts/exynos5420.dtsi             | 6 +++---
>  arch/arm/boot/dts/exynos5422-cpus.dtsi        | 2 +-
>  arch/arm/boot/dts/exynos5800.dtsi             | 6 +++---
>  arch/arm/boot/dts/s3c2416-smdk2416.dts        | 2 +-
>  arch/arm/boot/dts/s3c6410-smdk6410.dts        | 4 ++--

Applied.

Best regards,
Krzysztof

