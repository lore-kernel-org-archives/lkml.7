Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEAAC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BEB2051A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578386758;
	bh=W7fCVfEcsVq7YjfVrP/tRdV5yKG9ABz6dqFXtySmrFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HQC8sj3c5bqnXjQP5TnxfCa0BatEQWYkkAYPYHZdUsjPwFeVt4blC0PVsK3T/63E2
	 Ox47zEdcFh+eDzksKrF3VQw94S9gN0g73hWYAKDn824YOuzEj67O77tSoumID1sPY9
	 LrIZJGiJmI8e2fazL5SGpJqL89DSat/4RvkrCdjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgAGIp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:45:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46343 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgAGIp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:45:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so49671699edi.13;
        Tue, 07 Jan 2020 00:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8plItG8DbNYbwBcAqdDSAMoRYlALr96HuHXReZfE9QI=;
        b=n3Gs/llNIVwR+K7PkS9NAsGd5qf4FieL6qXh/bofrqKbv4fBFFhhroa5tUgtoJ9Oyn
         0zUR0cwuH0zjmxcFE8pxXrlSBloYLHzfAUQ7ycgo19rkIXNgNxb5UkoRws7MGcujJ+cs
         /nEK7/9km8crzvCiYFqbuxCRZR5iGyWrXYVRQlHNFciMuD6JEnGrrEgDIEJNgKBS8YwS
         o5yIITPAhwWyiXBETTGmS6pXGMz0Uz2ohy2ARSCEvuHQdRvuQX82waV/nGUdwoV0g2oG
         5jtxkm3ksxylcMc9DHon0dTh4NbcGzrKkrnKkCIYmJpTXOwhvgL5lrM7T0R2xs6z8sv1
         jIMA==
X-Gm-Message-State: APjAAAUPHGx0qgj5egw/2QUfT8kGiMWBEp6JiW0w2RoiUul5ratVWdAI
        FaZLZ7xxMAb3iBSVil4ID8PXoQ4v
X-Google-Smtp-Source: APXvYqzbFY7PNYNI0ARSqYBPkHcoX6e4/UrD7HFurJucJLwHzP2dKHYzhk5s1vaVLtajDWHetj7/bg==
X-Received: by 2002:a50:d5c9:: with SMTP id g9mr110412544edj.131.1578386754616;
        Tue, 07 Jan 2020 00:45:54 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id c24sm7406894eds.40.2020.01.07.00.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 00:45:53 -0800 (PST)
Date:   Tue, 7 Jan 2020 09:45:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: exynos: tiny4412: add fimd node
Message-ID: <20200107084551.GB31906@pi3>
References: <20200106191003.21584-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200106191003.21584-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 07:10:02PM +0000, Yangtao Li wrote:
> The patch adds fimd node for tiny4412 device.

Hi,

Thanks for the patch.

Do not use "This patch ..." sentences but simple, imperative mode:
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L151

Here you do not add FIMD node, because the FIMD is already there
(defined in exynos4.dtsi).  You however enable it.

Enabling it without panel does not really make sense - does it work?
I guess not, so this should be squashed with second patch.

Best regards,
Krzysztof

> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4412-tiny4412.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
> index 01f37b5ac9c4..2b62cb27420c 100644
> --- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
> +++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
> @@ -68,6 +68,14 @@
>  	};
>  };
>  
> +&fimd {
> +	pinctrl-0 = <&lcd_clk>, <&lcd_data24>;
> +	pinctrl-names = "default";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
>  &rtc {
>  	status = "okay";
>  };
> -- 
> 2.17.1
> 
