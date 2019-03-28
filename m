Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD88C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A50206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553779158;
	bh=etCttmxGgzP8Lt1fh3sXtzJ3WShzEqUzs/hTn+nFG7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IwKFtIx09Kpvoo5J61TOiTpk245sC1ZOz6CXGjIRbdUXhk9MwAPAVrnSt2eOoHaL8
	 MMDib8vWeLXEqMJ+iExgWC+X6tS+yr07+fG97crH64ibjap4+0ch2zI46OhH/adJOQ
	 jrFPNRvzEphtG4SNdYjeAalh7rruEAiFk7IXCCtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfC1NTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:19:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33791 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1NTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:19:16 -0400
Received: by mail-oi1-f196.google.com with SMTP id e5so4134926oii.0;
        Thu, 28 Mar 2019 06:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JZ7X1QFoxpeRsaPjNWNZgIfCyCrphqfB7Iv5jh613n4=;
        b=qPu3FvFjEdfai2sraPz9jN/2BPQFBn+1OseKwiRNVJtHbN9kLRq3H0Kq5rnSW6EiEG
         MeA/Arh8vTIgjuspbZpHnavi2inxgQFLDS/XIMHG3qVf35yE+DFs66gDMFDvF1HfQThk
         0zGQ7Lm585UQMh95WZ+iebvvKpxLg4oVMWyGY9hO+FspHIQ1+7u+O3llgULenp1OPTcS
         hydlfI7vQI3RrO1efN3IYhDruWKogDqOaWtWTWw6x/jEJQpZWSrb3FMYSN0xRa1vCu2Z
         o0Go7oT0IIjWkvID1F7D2O3moTmjuLT7z5JfLkvhuKTCEAexFc69I82Xx8suzl9zSuBB
         6ZhA==
X-Gm-Message-State: APjAAAXnrDkkJTcwqFmLvfk3M5wAEiO0WFBARvW1wg/OPA/aqK3dtHiT
        0fqABxNBPX9qIEKcMsQaoA==
X-Google-Smtp-Source: APXvYqztmDYgWSUnRRD3nLjXR2hQ3h0+jLFsQd2UdNq72UI8YVggP8WIN1lHAYM/sWSF7+BM8hBsLA==
X-Received: by 2002:aca:c002:: with SMTP id q2mr21743082oif.145.1553779155904;
        Thu, 28 Mar 2019 06:19:15 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id l49sm6220827otc.19.2019.03.28.06.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:19:14 -0700 (PDT)
Date:   Thu, 28 Mar 2019 08:19:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 06/14] dt-bindings: clock: sunxi-ccu: remove bogus +
 before R40 compatible
Message-ID: <20190328131914.GA31098@bogus>
References: <20190312152256.35574-1-icenowy@aosc.io>
 <20190312152256.35574-7-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312152256.35574-7-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 23:22:48 +0800, Icenowy Zheng wrote:
> When adding the R40 compatible string to the binding document, a + is
> left behind the string, which seems to be a fault when dealing with
> patches.
> 
> Remove the bogus + sign.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
