Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C58220651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553730487;
	bh=YnJY9d/7vR1MIuHo5ylFkDCki5Iz1TTWHg+m3dbK/GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R4TGRsretm/6c4lJjpFRwrk2orzA1ZuGPtmRD037JIwzgmDZz81TzphnhLQ2qu+lr
	 7XnU58/sQrpijI94PJz9IZTQwD0mdRXORRuOhSV8b6lpthIfycDzsXhYzbpEri6GrM
	 eCJceHuSy2GfvemAArTzgQ3ciomiNbyz0KI3mCdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbfC0XsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:48:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36521 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732571AbfC0XsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:48:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id t206so14337832oib.3;
        Wed, 27 Mar 2019 16:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ikuOxhpGtJ/bxOUWg8RlRbVRkQusFZ83LnkMpu6Rwvo=;
        b=ouNer7FQtzruZ6oVtghI6iz5md4MS0DQ6zwC06zTvDqvLO2q3X90Pl5hEjVGR2n36e
         xOgIVkzVEutr2MwhQos9AZXyzpAxiq6NMiMuKs4t+wL5MICl6kofVGLoSxF/DwSnWoaq
         9+nhjDZb6cLESfepkhD5S1GmpVu2LT/stCHTKBVXLxLdIswnWFlLzF1zkK9jrvsGskDm
         uIaI22mu1+YwsObWEqyU9YfKTjzS53kcB+Ci/351sJDLpgCliyldtXnh/IGfdCWBP2OR
         9lhvhca6sf+VppXt1Vt4+ptRYM60aZv3HaesVQkLEiv7H0RhMSa2XSf1Wb2WfHZ/AmAv
         gZPA==
X-Gm-Message-State: APjAAAUqMJhM6PPe3gODbSEpinJVwJG3J704h4k6SaDQPNAy219l2jn2
        mJK9VLAJ/7UdYBDHeh97mg==
X-Google-Smtp-Source: APXvYqy5Rm94PjUq87kcGtFh4b00zN/PZAxnnYNG6nfHC97RUPoO2mIV+3WTMZ/qUOCd7SU9sn57zw==
X-Received: by 2002:aca:5bd7:: with SMTP id p206mr14772941oib.128.1553730479213;
        Wed, 27 Mar 2019 16:47:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k23sm9815064otr.6.2019.03.27.16.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 16:47:58 -0700 (PDT)
Date:   Wed, 27 Mar 2019 18:47:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, jernej.skrabec@siol.net,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, robh+dt@kernel.org, dmaengine@vger.kernel.org,
        dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: arm64: allwinner: h6: Add binding for
 DMA  controller
Message-ID: <20190327234758.GA26796@bogus>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
 <20190307165829.9086-2-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307165829.9086-2-jernej.skrabec@siol.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Mar 2019 17:58:24 +0100, Jernej Skrabec wrote:
> DMA in H6 is similar to other DMA controller, except it is first which
> supports more than 32 request sources and has 16 channels. It also needs
> additional clock to be enabled.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/dma/sun6i-dma.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
