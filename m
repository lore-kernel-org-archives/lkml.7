Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F0FC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25F3218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573118223;
	bh=eXjp4yvxD3i0v0a45uyudjiecAlo5Of1vdnTJQf3bfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RctGN3w1Ks5f+v2mRW8uPjyMcH7/XFgO5xRaPb+eSdD4EiTM05uJ4ND3ViVhWVhmv
	 pShAaYKBQUtp6EsiZrYte8yD17ug/E8t+CKJdKDjbn87qmddp/Wp3Lckvs5rPfT4DB
	 fQkReWr/pt9uhvtOtnqomReU5tBKbOkJWbMCESAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbfKGJRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:17:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33840 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfKGJRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:17:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id b72so1313861edf.1;
        Thu, 07 Nov 2019 01:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+cXJFXXsnATWqtEsKiXk/PSn6Yx53JG8HWCNQMhhHfQ=;
        b=teNHJiERNGMYEXXVz/3kzIQ7xFA1WcXADsGHJnmn4kKsJs4dYuvoCtFiGv1m+mdhxz
         Zk9wSSrKYmS2ArWfWX/gzBBqfoUeW0IgzUMjNzKC842C98QOxzQVsMLpVlLnx26JMo70
         fTvplB3utrsbFhPZPjCJBzW41hXMiYcIPdpaslpUX09RzlXS4JGg7jCsu8zSffwP1z3Q
         kfyl7m2h12Y78SQ+EBrXL/a8WFDivbnWnXhlS0E2jPkKztv7PkJeRSz6/Z+hnDokq7pr
         R0u9oee6c1DzfLIPhFPhHFMEeXEg5fCHGfUhwoDr2XACouLh+gnbmrZpbRwt6HvBpYBs
         slFA==
X-Gm-Message-State: APjAAAVDb0Mespd1ICF5v0PagsBJ/6rXeJ98hFzZkQ1+NZQ/wxIIA9j0
        B9FFPv1cgay21ASt+r/1Aoc=
X-Google-Smtp-Source: APXvYqyrfUmrxvutI2K8KWIH3Rq6U4N44TbfKgh7ZWU6pMln4QW3jBx76gJVr9JNqtc2MbNpjl+jlw==
X-Received: by 2002:a17:906:2ada:: with SMTP id m26mr1978741eje.87.1573118220534;
        Thu, 07 Nov 2019 01:17:00 -0800 (PST)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id t4sm33952edj.53.2019.11.07.01.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 01:16:59 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:16:57 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marian Mihailescu <mihailescu2m@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: gpu: mali-midgard: add samsung
 exynos 5420 compatible
Message-ID: <20191107091657.GA1828@pi3>
References: <20191106225527.9121-1-mihailescu2m@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106225527.9121-1-mihailescu2m@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:25:26AM +1030, Marian Mihailescu wrote:
> Add "samsung,exynos5420-mali" binding
> 
> Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> index 47bc1ac36426..41b928bce4ea 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> @@ -38,9 +38,12 @@ properties:
>            - enum:
>               - samsung,exynos5433-mali
>            - const: arm,mali-t760
> +      - items:
> +          - enum:
> +             - samsung,exynos5420-mali
> +          - const: arm,mali-t628

I would prefer to order it logically/alphabetically, so after 5250 and
before 5433. With that change:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

