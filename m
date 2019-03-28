Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AE7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33A920823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553786307;
	bh=xFINGphdxWEjv5g8DPyTnwDHGYXQZTPrdjdrwC7Jdps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ccV3U3bLeds+pIEmk1kV2bXzvZdSy+hIgB7j4QbAbi8X9+QFZ29ccPEiHvLeFtGpQ
	 dR6cSkuyc3TgITcu6ORIPU+hwroCDhGSTEN7sZB+IrtJnvz6XB5DKGmfXeXSBunp8X
	 kkEJTNah9NnGH28QJjmkBcskKTfNr1StrsL5l974=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfC1PS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:18:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35729 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfC1PSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:18:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id m10so11057292otp.2;
        Thu, 28 Mar 2019 08:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rlz/E9aBeERHaafHlYwwHyQhxL7ccMisMBW6pUe7jeY=;
        b=ovqziT96DNFZ3HX4VmCB5HWP9GlMjcXDpnBm9z9IXMoNbiEkQvsOpJa1U9xa2/5bg8
         U/V0Vs3SvT4UCjShbBtCSxXwB+18yaMDil1OyH9o1u6PWeBuAWMQrZ1UhPlj2RtQTve6
         UOTrk8IgCecyt0faORAZPRhSuIJpHNeN4+IvMv+Sg9Enm27B1zusActyCVedOwnbYhxs
         puLR4x3+dWbUamDtRwlKKlayRnBGsxDC32MzYVlsvGY4pLfXxjkbQSKP13f1sNDCysXA
         u3MI3yhCVWA6XPWzbPdaZasnIbFp5BDVR423OqrGODc6A2Jdl+7TiGv6QzmSI9DpfyiM
         BfLQ==
X-Gm-Message-State: APjAAAWwXuWXwH1XOD0LSiJjMCrw+0x5ZVGnHtGBpx5SiBwaGCmbvp5O
        YOy+NgxQd0bM5XobB5tZ8w==
X-Google-Smtp-Source: APXvYqwr3b7VafRWAumXZLC9gA9GInZpHjQbI13dhw21ZjdvIo55Ghj5gaSk7JMPpTvaDS6vWR1K2A==
X-Received: by 2002:a9d:7359:: with SMTP id l25mr29811751otk.189.1553786304840;
        Thu, 28 Mar 2019 08:18:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o18sm5447627otp.65.2019.03.28.08.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:18:24 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:18:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/3] dt-bindings: power: amlogic,  meson-gx-pwrc: Add
 G12A compatible
Message-ID: <20190328151823.GA22216@bogus>
References: <20190313141030.5958-1-narmstrong@baylibre.com>
 <20190313141030.5958-4-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313141030.5958-4-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 15:10:30 +0100, Neil Armstrong wrote:
> The Amlogic G12A has a slighly different Power Control, but uses the
> same address space and sysctrl registers.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/power/amlogic,meson-gx-pwrc.txt       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
