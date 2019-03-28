Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C099AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A4320823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553795579;
	bh=yCsZpGPM/I7xTZcB4D4dOSldfSohZLYtSeN9TkvImMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DIgUdgbq9rAhmL7LZzE4Usd/Q7Wj21v9WycX/yShpNEy8jaCCwxpsx88cl6/EHdqv
	 JY0Nq02Fyo8iiy1AcSjXY/L+n65PlLDmyzIZJ+vKioMfSc17gWwdg/NqSiKaeDJWuE
	 xI3S2wIp0nULrUXqUv5Eq6KlUzBSizK9O+wCz8m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfC1Rw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:52:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33946 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1Rw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:52:57 -0400
Received: by mail-oi1-f195.google.com with SMTP id v10so12140581oib.1;
        Thu, 28 Mar 2019 10:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fI+gDSyWCizcKdacmuigZkb2BqYT4rJQLzs2eeoQNu4=;
        b=Sl1nLVoGXhjVDvAI1ech6pv8tiiT3dJqcpB7TbnMl/ilb1uWo5UX7gDMzU0zeB4JSd
         c9XnYXWAVw4NH1l26b9+Bv6fHL/SBkERkraZFyriFSVmtCaTDLsR23DNw4JuS+wsUetO
         KQK0tni8kf69vTiiNGU/LllorQC+XpqjGSy2vkMe7zoG/+jGaadsm2a8Vhr/1O3FKopp
         Wad3Bhjy8zsqFGJ/Ks67nWBd4LJa8IDfKf3P1iJkj8Mu4aclkK5YEjdBjlYD+er4p4Tz
         siaOcB7wtNE3sodPHXqyGkxq/4zgLNQ9kzTZOfwfYnNrqEAz0DI6Swoxw9CXbwV6fpwj
         Yt8w==
X-Gm-Message-State: APjAAAWS/Dx/2dDfknYz4cmJB2LCgPiyVmTz6/Y+ZUD6VF2DGVjf/H3Z
        iKFRmQUqlWbqTYNmNjaJag==
X-Google-Smtp-Source: APXvYqyAAmpm/4HjRU6NJyMZcmBEsI0u5/3AT74LTDSD6/KvCV4SaVug+GApdQ/6u1g7rKccLCmy4A==
X-Received: by 2002:aca:d9c1:: with SMTP id q184mr901853oig.89.1553795576909;
        Thu, 28 Mar 2019 10:52:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 70sm3345123otd.52.2019.03.28.10.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:52:56 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:52:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v3 4/5] dt-bindings: display: armada: Add more compatible
 strings
Message-ID: <20190328175255.GA19100@bogus>
References: <20190320082057.856943-1-lkundrak@v3.sk>
 <20190320082057.856943-5-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320082057.856943-5-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 09:20:56 +0100, Lubomir Rintel wrote:
> There's a generic compatible string and the driver will work on a MMP2 as
> well, using the same binding.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v2:
> - Order marvell,armada-lcdc after the model-specific strings.
> 
> Changes since v1:
> - Added marvell,armada-lcdc compatible string.
> 
>  .../devicetree/bindings/display/marvell,armada-lcdc.txt        | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
