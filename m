Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629E4C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3151521773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553779095;
	bh=6FZXcnNmk5G33bEqZFtf+hbwK7Nk/+58HSkJ7b5eIqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u9q0n2BFQdOPi8Ld1ip0Sc3X8yE5b2mC2IhDONSkBmOx16Hgps+B/QN9Z/FFQDEiY
	 udhkGOqXAJCbjEyIGH3ujRBCAKu5aCyebWP0t6YkrFVpjPuotkv37YCp+TZTlR8IU/
	 ZS7tPyzbMe5JHq+W9C77ucffH1IkQ9riyVFq9kMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfC1NSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:18:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41440 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1NSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:18:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id v7so15716144oie.8;
        Thu, 28 Mar 2019 06:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PAUHSaWpxbn7PSEvM5CGdSDcxQi8C5+zzsyaVESNVXs=;
        b=Lh+DFuKJ6qmBY1D1BJem8yjoOozu7iH6Js8atNQzLgAiZVFfunRXbKdz/WBTr8L4Ka
         PxUK2oxwJMT7ob8L06/v820w8om0bpAsq46rYSl61moPb40mgbAtPS8/Fu+u9FzG+Qru
         76GXeee/0VLy6TXoxYeWQ1cAQsiQSinUwpCChXnFMhrV7ADxYgzGzQaBSBLrX2TaCK9V
         Brm95m1KVsyK/MGRDK+PlnszXuWd1sSNYWNaA3BnRz5TrYj6oXXoPwC3oEcg3F+tZc76
         M0vt9Fln1LSN7przbZmGE2R0NIXHZxP46UxLIGmFALNCE1Gi4zqSa6mTgVRP3DTO6bQI
         4vSA==
X-Gm-Message-State: APjAAAUHqhmBmiIyQYKCHGxx1vRZ02sZT1SzuQcOOP4t+CT3nOi8fDKY
        8pfsAYlfmMiVZmbuVkhV+A==
X-Google-Smtp-Source: APXvYqxyWnXxytYhA6omSLTDwT1nvkjyyvEfd6ibGtbgYaZDtt3Jbmreoqoa3LDXNO+5STDGaMIzIQ==
X-Received: by 2002:aca:ad91:: with SMTP id w139mr21579046oie.120.1553779092471;
        Thu, 28 Mar 2019 06:18:12 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id m21sm6382466otj.48.2019.03.28.06.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:18:11 -0700 (PDT)
Date:   Thu, 28 Mar 2019 08:18:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 01/14] dt-bindings: pinctrl: add missing compatible
 string for  V3s
Message-ID: <20190328131810.GA29469@bogus>
References: <20190312152256.35574-1-icenowy@aosc.io>
 <20190312152256.35574-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312152256.35574-2-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 23:22:43 +0800, Icenowy Zheng wrote:
> The pinctrl driver of V3s is already available and used in the kernel,
> but the compatible string of it is forgotten to be added.
> 
> Add the missing compatible string.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt      | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
