Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4D3C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0BE2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569883793;
	bh=TpbBqZ8gFAIh52TmHgdkKFih+laUHPQc4l26827BuAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=14ptSuZIAqUwueMILWReCCVUe/ljdf5NbbY3v4pEz/7I/HrHc/nwipqfu6YyC5geN
	 1Fvj9siz2JzZQZGUalHtaVqtpVyU0RXXz79Vnv8IqUA2lOaTmISMaqqcgRQPi6szxh
	 VvP5thp6guS0LaLdT4pEDRuOiGFJjnO7hNyBfyiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfI3Wtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:49:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41528 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfI3Wtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:49:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id w17so12660898oiw.8;
        Mon, 30 Sep 2019 15:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PczlEvTcFQArjHB6+AobRiVj/8O0AsH2F+pyn4AkV9Q=;
        b=nNeSO0TCEvvDVrENgB0CKHZZGZojppVqr+10Lxs9OiCN4QXuhNirM/cz+GhO66lkc1
         S4R2dXMoGyHTaqMBS/UYpwcXSN2/OOcTlOBx1hqZdaKIdiFNnVykepCX51kbntvtamdM
         zAh3/zzxMTPYWzVbo8QvvL2f+qK/1wAmxDYCnlWYbrImIdw6xzfZNNgNrZMZJdC4+1MD
         aRgXLdjI71JixHaj7ej9Z9ISk+jv3F3i2XnsFhsHWJdtlUxpOoYNSz+iRY/N6fPIM0kT
         TJ0LnqYEElZMsuPnkK35aNGmyxfctMqoYAGQSkqXf+01XKBLrS0k7MTf5gqyXMFUpcpQ
         B1NQ==
X-Gm-Message-State: APjAAAVRwTSryLt+FXoaguRJFTdmEef7yiWluTiHuOTXlM8blgGQScWZ
        ve+aoOmednG1QxIY3YAugQ==
X-Google-Smtp-Source: APXvYqwTDeeH9jMNF4XEpuXW6/a8oSBcyxUotRCwupjdOMxLrSLEeTuiggY2bfZGFDq6quemIM81TA==
X-Received: by 2002:aca:4a50:: with SMTP id x77mr1296885oia.115.1569883791410;
        Mon, 30 Sep 2019 15:49:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i13sm4391632otj.58.2019.09.30.15.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 15:49:50 -0700 (PDT)
Date:   Mon, 30 Sep 2019 17:49:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] phy: phy-rockchip-inno-usb2: add phy description for px30
Message-ID: <20190930224950.GA32051@bogus>
References: <20190917082532.25479-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917082532.25479-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 10:25:32 +0200, Heiko Stuebner wrote:
> The px30 soc from Rockchip shares the same register description as
> the rk3328, so can re-use its definitions.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt | 1 +
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c                    | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
