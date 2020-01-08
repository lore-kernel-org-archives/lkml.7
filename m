Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DC2C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D44920692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578514908;
	bh=xbnZweZysNvjJs5HrwfqefXp1VjWQsaLFHlxz4jQYzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n+G1QpXjIkBycUh10wNenSN8ClK+crBAOwDFg1Tck68im98mUerIq0hFWWbTkH+ol
	 AZuXgefbPN4Zc7pyQ/vKXkoY774oxYxEp9td+vJ1tbUGisuGgtZTA0g5lKxfB9xy/j
	 7oRiKyW67CxTRRW3hAslw/u6As3ZKMkHBQf4MME0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAHUVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:21:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55533 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgAHUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:21:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so297944wmj.5;
        Wed, 08 Jan 2020 12:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DAChl6Ul9fKSKLSUyoPgGNo0ChhyAr0XJVth8mI90zs=;
        b=MOPb+EvtynICKVb4YpklQxm9YdA2sGVaK1Bl47sG/ChZVWWUVkL7eP3lYVuj2dyRma
         l91eqPosW4LgGGtMWM+7IJjQk0H8t4iLkhvyQ4RqgLNFpwaZVTO4wDwbhy9POvAPyKq2
         G0bLrWOY/dw04ymaLWrNT1EuFJBVELceZxygSmjZIM+7MAeZP/02zkGGKyng+pX39eZo
         FaDh5s2PT5r9ADpomlPW+uprxxyIju6zt8dgGW5r5d+EYC1zA6uwm+QXjmmz9oWpJUaE
         i82OAbp/JkF2TA5mq/JXoWsVxEJuIw350pSWSoi7BVbO84XeQ7vDeSXlZCeLrA1QRElw
         cGQw==
X-Gm-Message-State: APjAAAVdbCh1Yz73cntUKfR0A5imwKzUC4JR6tApCF5vxVb2cYM+4Q3b
        /o99l5DcktgelvzHFDMZXrSDt64tZuP12Q==
X-Google-Smtp-Source: APXvYqzpZx5bVmQEcf1bpPT5tN7m0CBp56yBmQq5PdtRIz3mJs/1AeH+ujtV+juGwD4/yfPcficuPA==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr408703wml.83.1578514905607;
        Wed, 08 Jan 2020 12:21:45 -0800 (PST)
Received: from kozik-book ([83.218.167.187])
        by smtp.googlemail.com with ESMTPSA id q3sm238868wmj.38.2020.01.08.12.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 12:21:44 -0800 (PST)
Date:   Wed, 8 Jan 2020 21:21:42 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: exynos: tiny4412: enable fimd node and add
 proper panel node
Message-ID: <20200108202142.GA8492@kozik-book>
References: <20200107191020.27475-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107191020.27475-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 07:10:20PM +0000, Yangtao Li wrote:
> Enable fimd device node which is a display controller, and add panel
> node required by it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> v2:
> -update commit msg and merge to one patch
> ---
>  arch/arm/boot/dts/exynos4412-tiny4412.dts | 25 +++++++++++++++++++++++

Thanks, applied.

Best regards,
Krzysztof

