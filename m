Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5148C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8252B2183F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014560;
	bh=DkN/eWh84P0WOrD2lxwKnME4yFd+Hlu70ZVZeL4R4GE=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=AZacxurD+Hah1W4BoorWOW71TqRldIKKmhUIpCxoyqSUOuxTUj0dmMG+7dXs4Rybl
	 k4+AXuJojDFHLva1WlMQPQYHV5n5es+iHlRKp2jHvDp5vCCOynqAENS6kMEFfYHGe5
	 a7RRy8U3X/obaToeEFbRMJz/s687vUks9HUfB8yQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfCaGmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42893 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbfCaGmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so2973442pfn.9;
        Sat, 30 Mar 2019 23:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=T7peQwL7cI9hAs2vgRhFPr2ZAQIqwe808x3ehowYToI=;
        b=gcwJvuagbB329e88HbiJeATN33XDwu4wa06riFHnWKgxmaCjycm7WYBda8ANRuwz+h
         OaFpP/vIfSWRCCaepWTb9zAATSRisHQeIhJHETWV84u/22R6FQuVm7u1AJctJP9Z0box
         7h19BTXckHk5AZObvnRyfpjG8wtnACLOx66SOgEE3Aa01KKyC2g4rhUXd+IhxBE0PrN9
         sG38o3svT29FxjgJj4pvtrCM2PaxBNCzuaGnVRq+Yj4zM5T+oJ1QOGOb/lq49nu2OIm4
         JgQNni502o220tImdI0fasdvqQVcGsgY0BzzmpphzV/y90xW2U89EBsc3CCYLm1HgH9D
         NdUA==
X-Gm-Message-State: APjAAAVY4+3ffupsvHNRyaTYodN/UEFPK79itqh8zrmZieMrFG+qFrcY
        S29swnCrnpQ93/nfp7x8Qebw5TevPA==
X-Google-Smtp-Source: APXvYqxOltetbpRY5z5/m/89W9y1w/T8j9TpBv0VcOrm0Pc1PGBq+QpTw8ig0rrTnJE7vQ1iblY0Eg==
X-Received: by 2002:a62:5582:: with SMTP id j124mr3408180pfb.53.1554014555410;
        Sat, 30 Mar 2019 23:42:35 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id v188sm9052773pgb.7.2019.03.30.23.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:34 -0700 (PDT)
Message-ID: <5ca0615a.1c69fb81.26b1d.7b52@mx.google.com>
Date:   Sun, 31 Mar 2019 01:42:33 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 1/6] dt-bindings: clk: meson: add g12b periph clock controller bindings
References: <20190327103308.25058-1-narmstrong@baylibre.com> <20190327103308.25058-2-narmstrong@baylibre.com>
In-Reply-To: <20190327103308.25058-2-narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Neil Armstrong <narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 11:33:03 +0100, Neil Armstrong wrote:
> This patch adds the specific Amlogic G12B clock driver compatible.
> 
> G12B clock driver is very close, the main differences are :
> - the clock tree is duplicated for the both clusters, and the
>   SYS_PLL are swapped between the clusters
> - G12A has additional clocks like for CSI an other components
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

