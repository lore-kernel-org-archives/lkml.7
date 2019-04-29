Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65415C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3707720673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556560132;
	bh=W9V6CouoTRQEgUu60bewd9p9Zh9JwiwDRPhGYdBsLWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dmqrgJN08vvB1IK7c9bUS5bwxRWlZ7POCcgeSjdjMbyq4t7fUBhv0FqRCt+lnHEl2
	 dVrBVISSCz48ScAkWlub0w+/CHH0Zgy9U9af1E5mz4QHj/Gv5b1aBhNpv5gaUYCeg5
	 OjJRE+Oy3ll1rMDW7lHiSU/EYgRcZaOHFjYnu80I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfD2Rsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:48:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42386 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2Rsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:48:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id f23so9406613otl.9;
        Mon, 29 Apr 2019 10:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=96Pv4XmpD2oLDllhCoFarHwO67SqW17W7Bz6iMLIAPg=;
        b=rro8PmO9SauQzfgaGbcdQ65eTnHnGoelwLQS/F6iqYmShMH0jKxolNpbaOm9FARLrk
         V0bvxnjuv+sU2fUav9af8rlHcKuLXvC3itH/Iom6iIcad2wkRn/z/J01JplqzwKBZYmW
         Z45eA9dx1jjtKxESU3hJluDB6/jJCTMKqoe4titHVpmm0R5ZxNc+LG5Y/MJgHuQ8WhT4
         CrVuFAbYL5BucFOQJSsgJdogwBwucpZ32K4YdtwfUcHe7vlggWHBg0VHYWmzxbi9x/si
         kkZsA47s4RXVBmz0o9UoA2fAH2VIRsY9z8C0O1dNWeQJCbd7hNL3P4YqPy6GlE2sxu4D
         r0Tg==
X-Gm-Message-State: APjAAAW77g9Kx5qS558M/bWTibrCFIveRE/0jOXRnXNhCAsaH/hZIkGI
        dgOSEoBB+VL7+K0vbRIUsA==
X-Google-Smtp-Source: APXvYqy5RZ6ixsBcrAfarmCt6sR4eTlJQvc1g+ILNKDBjbhglFflOHlsQy2h1OTxaR6NC5Gvde0Lhg==
X-Received: by 2002:a9d:4a9c:: with SMTP id i28mr9855983otf.326.1556560130035;
        Mon, 29 Apr 2019 10:48:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i17sm13852752otr.36.2019.04.29.10.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:48:49 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:48:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add support for
 imx6ul-pico-nymph
Message-ID: <20190429174848.GA27422@bogus>
References: <20190410010013.17259-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410010013.17259-1-otavio@ossystems.com.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Apr 2019 22:00:12 -0300, Otavio Salvador wrote:
> From: Fabio Estevam <festevam@gmail.com>
> 
> Add support for TechNexion's imx6ul-pico-nymph board.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
