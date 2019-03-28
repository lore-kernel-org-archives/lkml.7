Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92456C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFF22146F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553731688;
	bh=au3zjdoEee6XftmlOSqFK09C10FQeX6GOQsa32QVKik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vgQFeUoDyg5Z3bpy5MgQ30a0tAAFRx1w5TsjUGD0SMfPsnvqpzdIg+olkz8mvhHtA
	 mNF9UBr3IZad5kwy/UB67zWfTh0GskNC/Ue4RRhUOZCChZtUCE25vU0xLpCxre6fLO
	 ZyLsrJpDzzA0iWx2y2aDhgmKmRi7SsazP3sysmro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfC1AIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:08:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34573 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfC1AIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:08:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id k21so15313216otf.1;
        Wed, 27 Mar 2019 17:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GkNuw7hvK8Cpi2fLPdvDnQhSLrGyXuapUI2Ro1xz+fQ=;
        b=KpFgDii1H6IwX4pkK6G7pj9ux175siiO/DiXJmJApljItlVs493i79YJQr+CLkSk7k
         L3MoEW55du/ldb1LL7grZypV3jF4TkrGidHExahSlMzMDlSipYoEZSkEDd0FP9v+Ufs8
         0Pgixa6F/j5HFB4fGy2wZ9cR7sgkHb1jmiHu2ckmlHXmXNm/kkXDaQoCmyVYo0gm11o7
         K8TCXzGkGxXt3yaTGpiy6UTqVIJLJ0TInA1VgEsF3Ca0YIq6eaXzFPnFHe+AbK+fuORU
         kst0HH1LLhSYsrvftxSuXbIvkwZkU+b5VS3IUx/FMin3bxJhCrvNmVvSrC01pC5oUw+F
         b8lA==
X-Gm-Message-State: APjAAAVumDmt6QPGm0FBUfRWoEoZIHbTF80TE+TqaQgtl+Kvjx3+qKjB
        3+CFIQzqO8w8ht84msM4+w==
X-Google-Smtp-Source: APXvYqz/naKYBm4c0OvLkgAlTPOtc+ogV7gaqbFQpWYNDiHp4c5pP59tC5uh/r7497pZpAcCJQ+yUQ==
X-Received: by 2002:a9d:7306:: with SMTP id e6mr27468999otk.79.1553731686203;
        Wed, 27 Mar 2019 17:08:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 189sm6847710oii.58.2019.03.27.17.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 17:08:05 -0700 (PDT)
Date:   Wed, 27 Mar 2019 19:08:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH 04/25] dt-bindings: leds: Add LED_COLOR_NAME definitions
Message-ID: <20190328000804.GA17215@bogus>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-5-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310182836.20841-5-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 07:28:15PM +0100, Jacek Anaszewski wrote:
> Add common LED color name definitions for use in Device Tree.

Do we actually have variations in color strings? Maybe someone uses 
"RED" or something. If not, I think this adds less value compared to 
function names. Just my 2 cents, either way is fine.

> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  include/dt-bindings/leds/common.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index ffcd46317307..0e986bb59391 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -57,4 +57,13 @@
>  #define LED_FUNCTION_WLAN "wlan"
>  #define LED_FUNCTION_WPS "wps"
>  
> +/* Standard LED colors */
> +#define LED_COLOR_NAME_WHITE    "white"
> +#define LED_COLOR_NAME_RED      "red"
> +#define LED_COLOR_NAME_GREEN    "green"
> +#define LED_COLOR_NAME_BLUE     "blue"
> +#define LED_COLOR_NAME_AMBER    "amber"
> +#define LED_COLOR_NAME_VIOLET   "violet"
> +#define LED_COLOR_NAME_YELLOW   "yellow"
> +
>  #endif /* __DT_BINDINGS_LEDS_H */
> -- 
> 2.11.0
> 
