Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A083C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C212080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578387895;
	bh=r1wDW23r/YjPiDMuICfuT5d52gAql+2ws9tKVfO4uKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YBzvvm+4TjVC6mug8wbDgcwc3rqrdNbw5myFTsLh5ZE6yXDWRW3JVY+xREOV2pO72
	 +ALvew96klizHEPMZ3pdHqnzcPWPNzF29PW0er3JvqYQWeYSj5p5cUSyXuiAtNLlbv
	 HhYuoBmdGixldWWuTohqMsf1osN3Wiloa5oZijhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgAGJEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:04:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42399 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgAGJEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:04:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so49760554edv.9;
        Tue, 07 Jan 2020 01:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SGG4xHX2YATIq9VZs4BAzLmEWAu7JtLxJw2WW5I4CiA=;
        b=ml4yFRXcG07xR5Ec5LlVMuyB0MdnKiA7vbz0DIxsAFT6bqY5wlQZ96YqYvcu244Bp+
         CCSFABy1MfGGddECldMe21vxMXxkRKgEcgIXVXwRLjD4ix8deTmjt63drd240WfZsd7r
         DNZfE7jnj5Oxi+0F+sozycZvVnZJ0aRLMw0xeovr2oC07ojMlhfhSqJi1WMLksYyHK+N
         1gETWiNkgqlnI0NLhEFoDmx2sKHGSV2DdOkZn+7KNU+/bCaw0APnwCpAX/dtS8oaJ8P5
         HP9Q3+hZf0fV4DcOaqoZxRuTmP5fFQBSuzwdKMra0rLMMjO04IDCIpYhca6yiy7fMrZ8
         3UIw==
X-Gm-Message-State: APjAAAX5XQsoItwqaVX1GAKuAiaxgxR1xEdbJxdVuGOD2aTXANT83Pgy
        EO5lgeWcNU/2k5GvLglyfGRwM4ZP
X-Google-Smtp-Source: APXvYqyYO/ux/7ZOIuaH8J6fcPFS8f5Bcu/C6zg1+oGXA5GRJ16yYiqmjY4rrOHIsud0A3lqXQDsVw==
X-Received: by 2002:a17:907:212f:: with SMTP id qo15mr86708540ejb.245.1578387891926;
        Tue, 07 Jan 2020 01:04:51 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id s12sm8054935eja.79.2020.01.07.01.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:04:51 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:04:49 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: exynos: tiny4412: add proper panel node
Message-ID: <20200107090449.GA32007@pi3>
References: <20200106191003.21584-1-tiny.windzz@gmail.com>
 <20200106191003.21584-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200106191003.21584-2-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 07:10:03PM +0000, Yangtao Li wrote:
> This patch add at070tn92 panel for tiny4412 board.

Please fix description as in patch 1.

> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4412-tiny4412.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
> index 2b62cb27420c..57f9d09233ad 100644
> --- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
> +++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
> @@ -66,6 +66,16 @@
>  			clock-frequency = <24000000>;
>  		};
>  	};
> +
> +	panel {
> +		compatible = "innolux,at070tn92";
> +
> +		port {
> +			panel_input: endpoint {
> +				remote-endpoint = <&lcdc_output>;
> +			};
> +		};
> +	};
>  };
>  
>  &fimd {
> @@ -74,6 +84,12 @@
>  	#address-cells = <1>;
>  	#size-cells = <0>;
>  	status = "okay";

One empty space here.

> +	port@3 {
> +		reg = <3>;

Why starting from "3"? Why this is port@3, not just "port"?

Best regards,
Krzysztof

