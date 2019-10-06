Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F89CC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474842133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570356141;
	bh=WoWzz39cjtCzCBsaJMsfzp2UsQsEkwZw/OfDAiF+O6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=znB3BY2gSR8ZhzNnyrxAmp0to7cmhXAfJvE1/flzXe1idx+yy0hHA8q28f6FAQCip
	 97PRhU+iDyFJEjAkN2q4Cl+YjiHJMUdtkMYJy9dfWrkFfwSMzxFbjzKEJVRWZ9t5Rk
	 Yk1MpXSs4tU4BQdbRCZNx3dXKO8G6zng/2mIwhOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfJFKCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFKCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:02:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77A352087E;
        Sun,  6 Oct 2019 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570356138;
        bh=WoWzz39cjtCzCBsaJMsfzp2UsQsEkwZw/OfDAiF+O6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qXeNzunK/8EmIm8JxKPKzqkJ4VlMw4VuwJgpXwDkKaidkpxGSo3bRNW4gnWxblqae
         MrGTom/yIde5y8P8MclKhvLK9qC2xFxxQpyj5p0aYp+txlb3T1xgSpVus0TSzx9y5Z
         t1WFjkL7Rum72VkyaKs67wUpMHR7WZvajvdbidyM=
Date:   Sun, 6 Oct 2019 11:02:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: iio: adc: exynos: Use defines instead
 of clock numbers
Message-ID: <20191006110212.4e6fe30e@archlinux>
In-Reply-To: <20191002160744.11307-4-krzk@kernel.org>
References: <20191002160744.11307-1-krzk@kernel.org>
        <20191002160744.11307-4-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Oct 2019 18:07:44 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Make the examples in Exynos ADC bindings more readable and bring them
> closer to real DTS by using defines for clocks.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml     | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index a0a9b909ac40..a3010e7ea051 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -135,6 +135,8 @@ examples:
>      };
>  
>    - |
> +    #include <dt-bindings/clock/exynos3250.h>
> +
>      adc@126c0000 {
>          compatible = "samsung,exynos3250-adc";
>          reg = <0x126C0000 0x100>;
> @@ -142,8 +144,8 @@ examples:
>          #io-channel-cells = <1>;
>          io-channel-ranges;
>  
> -        clocks = <&cmu 0>, // CLK_TSADC
> -                 <&cmu 1>; // CLK_SCLK_TSADC
> +        clocks = <&cmu CLK_TSADC>,
> +                 <&cmu CLK_SCLK_TSADC>;
>          clock-names = "adc", "sclk";
>  
>          vdd-supply = <&buck5_reg>;

