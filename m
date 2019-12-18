Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B5FC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC28821582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576711685;
	bh=2MOG2KfC4U6x0joOC/5pJ1zLsq2eNUecCyOu3VFK71M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a2DbaIGKINUCLweN48mS4Gxb9hAr/SiwLl/tVlVlbsQ7QswZ2HXYExoRHP2PVfwov
	 3BZB7uhA1UkYim4d4Wi754rrEKTWpdgZpdi+cycII9A+dplB0QDpubbl8QpUFiNoAy
	 GRiHtY48bk4CDWO199CyVM6+9DeDk2r0MHXPExDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLRX2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:28:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42446 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLRX2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:28:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so4554074otd.9;
        Wed, 18 Dec 2019 15:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ZyKu0j0L9P7EvNBTxpXXf5dLPtT7NxrO5TJj8pvG5Y=;
        b=hagH+WzcPCj5kQRzJkjSsDBJnAZ/8sDX4zQp2MbznxGTBL5dBiKdyTL2bhj/vVz67r
         rL7fvtQ6l4l6c7D2BIwYuzw/lswe7WDPTNUXs1i91koDMMKOGvgfkDGi8JXl/LknXQuE
         8KS+zSW/0VtccllfqnZOLFMuBOZiky7NjQFBx0oSLqiVcBOSEDLlR+HKWsUZLGCdDZDN
         4+AcvxImpEAFcvb6vCbmjwnQb6tpeCdLQAgJ6EPk1/LWeHMl1J3ijSu4QE8wqotHVtuD
         GP93pfS7VV8Qbeo5hOYuoYRPdBfMCzRX2migc6XrAKAi5OcdNySJpuAJxCFSarjHm/6f
         0lDw==
X-Gm-Message-State: APjAAAX2FnoHyrdDfhScWEU53eMrpOW/HaxIFa24EqjqflJ1Uw/7qnuJ
        vwW7IRullOVFVLF19DBUbg==
X-Google-Smtp-Source: APXvYqwFPAhcuE93trHjiCLFU7ouah/UBbc6dMZe8ceDZG28OQ30K7jW48tVS8UqkME+NAqnpXd6Vw==
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr5388885otp.202.1576711682987;
        Wed, 18 Dec 2019 15:28:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w203sm1369927oia.12.2019.12.18.15.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 15:28:02 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:28:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     James Tai <james.tai@realtek.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: realtek: Document RTD1319 and
 Realtek PymParticle EVB
Message-ID: <20191218232801.GA28835@bogus>
References: <20191205082555.22633-1-james.tai@realtek.com>
 <20191205082555.22633-2-james.tai@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205082555.22633-2-james.tai@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019 16:25:54 +0800, James Tai wrote:
> Define compatible strings for Realtek RTD1319 SoC and Realtek PymParticle
> EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
>  Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
