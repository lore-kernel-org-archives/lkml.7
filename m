Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD40C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451DA2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553779190;
	bh=RRU7lrJeGMpo/6/QcVXp2TDNeN3lBUzMK+3d34ZfhPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U2YkF0htwg8j2BVqLFVYTUVE13TwZ0uvvD03aFWWmPSSY5Oh2/MYzcPxNT49Avmdy
	 ExmEAJri2BlryRiZQ3TZlSqWrYisdG4pJLpnTG9XvRhJB0P0p5ZYPUl/IJrP/9Luvv
	 bSVd6BPBpARZS59I2N8GCIXWWH04UWQdNzHJqS3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfC1NTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:19:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41639 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1NTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:19:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so18237921otb.8;
        Thu, 28 Mar 2019 06:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YWynbtCoFnyvx9w4xa5zagT1n5QTRdX7h92csjMPSRk=;
        b=dAzntw7kEE0qDnY1onNH4H6HI5TROz96CKNJ8v39iqWB+mxyY6xaerC4bTC0Q01BO3
         SvJPwlyjZl0j5fQhPEKHju4I2ZRi5IDR3KFsG27PNtlEqcspg4Gv4FUZzcN/GsHfqlbt
         pn8S36kNCNBpHU7p5kMa0BgJxzuNgnMNuiqiw4ZGC7GnPKKur9tzZQC7XiQvGXaFT8GW
         IzkTNgZQo9V4aFiDsu6a3ZImv1c2DFGMQYgyC9lqyp8anVUmTbymKYt6T45BWst03Otb
         vaVzyOdqAoOXydE74gamYSVp1rg92ul77KQob4d9DCoPJWRii7+K5vb3mnH9CJPeSVE8
         obEw==
X-Gm-Message-State: APjAAAWEtesMQUvfSl2hX49bJRO40hgoUJPVG4oOtjdUpc2B2WPdscZ+
        2tWxjUzIWajCsHTYcnafFg==
X-Google-Smtp-Source: APXvYqz6qAyxyMrElAFkHpWzGHqF05+jTyeYNUtRi4CPvvpqlXgsKTNoTJAJftSAe13253jsGE/gXg==
X-Received: by 2002:a9d:3a66:: with SMTP id j93mr29842740otc.158.1553779188037;
        Thu, 28 Mar 2019 06:19:48 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id 131sm2678860oib.51.2019.03.28.06.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:19:45 -0700 (PDT)
Date:   Thu, 28 Mar 2019 08:19:45 -0500
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
Subject: Re: [PATCH 07/14] dt-bindings: clk: sunxi-ccu: add compatible string
 for V3 CCU
Message-ID: <20190328131945.GA31970@bogus>
References: <20190312152256.35574-1-icenowy@aosc.io>
 <20190312152256.35574-8-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312152256.35574-8-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 23:22:49 +0800, Icenowy Zheng wrote:
> Despite Allwinner V3 and V3s shares the same die, one peripheral (I2S)
> is only available on V3, and thus the clocks is not declared for V3s
> CCU.
> 
> Add a V3 CCU compatible string to the binding to prepare for a CCU
> driver that provide I2S clock on V3, but not on V3s.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
