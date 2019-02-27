Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CCEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863FF218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551311040;
	bh=kzroDD+kFrrt2x9DMyXnSVmdGkCGR8Ajivoj7vbRHTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bMY/gjaAynPIVVQrz8ZxIRYg89Q2ED1keGja7G9O0tDBZSA+qiJXsGJQk18BgIsme
	 yvSYFGkmbYiPBbXFDHjHCInFah7pDUm/hay6bpvwUL3EVpbwHFIVd8U2h+40roZO6m
	 FF0IdyOoYkhBikCFS5zv+crHUoTVgA8EDUDNYkT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfB0Xn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:43:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43563 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB0Xn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:43:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id n71so16041124ota.10;
        Wed, 27 Feb 2019 15:43:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2I8cHKVpQgeCx4ZtLhiOT9wisNnRRnhdpv3N3OERvj8=;
        b=uILFdt5pfDE/U5s5yaIu8s1kVvb6uAIK/iGAQzftzixzDRL3lTcyKg074o1DUpRx7h
         4tdc2kdATZQr/YX1nLEtdGXphp07Tj0gdkYkY9tN79OeWahrD6fubmZQBzxN1rfCSeLN
         31F9WHf7isAoLu+o4vb1Ht1Sy0A9vnmzb4thxH4jYFRyCEkb0CpgHB0cgEmri5FctCbD
         vxAi7GXzTz2B6vKm0B7D5yq0FhI1z3de/uN6dWROEl9NQidK8zwkfG/2Ysylcrgt9XOl
         8b6vCj4qkvK9c9i2KxoUs/SsjBeb5953UJCTR6EW0zegrNlATphV9oeXNg1imvYxRbjs
         fuHA==
X-Gm-Message-State: AHQUAub5L30+6Lesg1j86VHzLDDIcJR/ofWwa5uRDLaHDUaPYZzm4d/b
        Zba6+HtAt7PoTdQsq0grSQ==
X-Google-Smtp-Source: AHgI3IbModXXVdguRsM/nmRVypNF+23zZKlxAp+QARCAZ6DqC1Sil/hMwdGKy17DNsKoQLf+XdT64Q==
X-Received: by 2002:a9d:7482:: with SMTP id t2mr3979230otk.180.1551311037723;
        Wed, 27 Feb 2019 15:43:57 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u79sm3553952oia.45.2019.02.27.15.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 15:43:57 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:43:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: power: supply: axp20x_usb_power: add
 axp813 compatible
Message-ID: <20190227234356.GA1909@bogus>
References: <20190225033107.17326-1-wens@csie.org>
 <20190225033107.17326-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225033107.17326-2-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 11:30:59 +0800, Chen-Yu Tsai wrote:
> This adds the "x-powers,axp813-usb-power-supply" to the list of
> compatibles for AXP20X VBUS power supply driver.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/power/supply/axp20x_usb_power.txt        | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
