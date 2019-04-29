Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D13C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B5F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556558621;
	bh=n1ubx+oWtf7WOYgVqR7dl2IrPm4uAA3JofEweVZkvqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ptuX4AymZDcPD1uy1e5T+PYHjhqe+2NqprGyQJkVE3CXZg0Q/1dcepfuITn09eMJ0
	 65ukEBDyEvwAbCbm0ReOlSzSjOkxWOgdTrYDxk619s24caHZbpxETPy25yeKOzc6e4
	 ipgMkVsTc3kmUiKSSIYKPFuPH/p3rAUJrOqexYVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfD2RXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:23:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45242 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbfD2RXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:23:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id t189so5923652oih.12;
        Mon, 29 Apr 2019 10:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A0I+WeeWwMxjNXSYH+7ynj45eY9o+5Gg1/EFwuWtM7U=;
        b=MOyXQMkheITZ/VUqShgL3Yf6Cdvd2eT5MZeBNBBFljmqvS+MSQcDoOEhvRdiaNO9mw
         SFiQsUBCa6slWso83FbkHHuRyd8xwt1VvIfSx5OGacGExg8ru1dO0+Gx992q8rLgh9De
         1RW7MwJfWKlQkeRCM6isIlQYunZibwoTy6Qvlr5g/hoDNNSkzhtzTyX80t3fXRq4a9KW
         URhLn3MyhTy2rrJDbmfBmYef5d+7AzWM7UQP4Q8dwImEf1fQemXhi33E0qLOb0mFnzkD
         8I5/Ep/jMpymU7sBv/0TD2mapf65Pizg4Jm4gUxfnlY7f9OEYsKMYHGn/bsbgENSH9kR
         Sv4g==
X-Gm-Message-State: APjAAAWz416ukYBor4+pOwz7cY+MGiq7Nbu8VcqISmZ72VQH8FswxPAk
        n4daLGvYKshuzmb4tMValYUriJQ=
X-Google-Smtp-Source: APXvYqwJbkFnAP9SY9gK21fN7QNbYRGokvHTqwXkjjG2EwAueI58HKRICiwEd5IDm2D8dlODxUiijw==
X-Received: by 2002:aca:cdc9:: with SMTP id d192mr124199oig.134.1556558619041;
        Mon, 29 Apr 2019 10:23:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q26sm672522ota.35.2019.04.29.10.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:23:38 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:23:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     krzk@kernel.org, kgene@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH RFC 3/8] dt-bindings: exynos: Add ASV tables binding
 documentation
Message-ID: <20190429172337.GA30032@bogus>
References: <20190404171735.12815-1-s.nawrocki@samsung.com>
 <CGME20190404172234epcas1p37667ec0996000aff9297f13639908dfc@epcas1p3.samsung.com>
 <20190404171735.12815-4-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404171735.12815-4-s.nawrocki@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 07:17:30PM +0200, Sylwester Nawrocki wrote:
> This patch adds documentation of the Exynos ASV (Adaptive Voltage Supply)
> tables DT binding.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  .../devicetree/bindings/arm/samsung/asv.txt   | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/asv.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/asv.txt b/Documentation/devicetree/bindings/arm/samsung/asv.txt
> new file mode 100644
> index 000000000000..0db907263a91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/samsung/asv.txt
> @@ -0,0 +1,76 @@
> +Exynos Adaptive Supply Voltage (ASV) tables
> +-------------------------------------------
> +
> +The Adaptive Supply Voltage (ASV) on Exynos SoCs is a technique of adjusting
> +operating points, i.e. the power supply voltage for given clock frequency,
> +in order to better match actual capabilities of the hardware and optimize power
> +consumption.  This applies to subsystem of the SoC like: CPU clusters, GPU,
> +the memory controller or camera ISP.  During production process the SoC chip
> +is assigned to one of several bins (ASV groups) and the group information
> +is encoded in the SoC CHIPID block registers and/or OTP memory. This information
> +is then used by the OS to select more finely matching operating points for
> +devices.

We already have OPP tables defined for QCom CPUs to do speed bining, and 
I just reviewed something from Allwinner for similar purposes. We can't 
have each vendor doing their own thing here.

Rob
