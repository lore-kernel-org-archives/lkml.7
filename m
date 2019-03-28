Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2E4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F039F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553779691;
	bh=R2qNDLFzl17nbW3UuWzM29+spzfo2oq6sIadhkWYKNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hFi6z5MjG6lKS4p1kl+KkgO1t8rb7Y1IBXgYzHKnbpDIHq7QXHJeQrozNUlW2JhM/
	 Yx2+dmOs9rfP+qzF8/cCKuNaNO4ikUsLJM5gDWeB8bipxy9sG6oTxCLWegrLMD7+tK
	 qaF65MDoU9dOiNALQFyvDnUWGeRgobGUMtlRvJRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfC1N2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:28:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33868 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1N2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:28:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id v10so11396304oib.1;
        Thu, 28 Mar 2019 06:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SbmoDSU7o/QZaadaHrYila3fYQJvHJA05JDc3ABJrgc=;
        b=sfRmCK3lKELZpJQn5Cz6HYOq75szaJRosl+1SrvOsbJsXzRek4lfBI/beuE6xHittW
         myVaSK1VueO2JUK/Hn2UsXud47miMPcZMia+g4E3PpCEgw6JyuIHsTTthl4i7UjChjTQ
         kYm/GwAU3eTzcdcbtsaSKcaCyzLz8pQw2IA/SRjo3tCuuYeIS92q4OIMoPAFeP5Q37AZ
         9322tQLKQYGtUPD7XntQ7eBVonrz/fJPT0vtxg13u+eqZmD1lKPzCSogLLUE5g1Z19xR
         6pIYMVR0kb1PvvAn8HxP5DmMicL2ldQu7+jaUF6YunwovIJIMYUmUOyblSGrqkFmSUQP
         EAsw==
X-Gm-Message-State: APjAAAWb7VOcbXVlckxrXLoSe3KbU8DZcBxRq76DamRMrgq4jexLZ3di
        8xNKJrX6iWCcv5HwMrnWBQ==
X-Google-Smtp-Source: APXvYqxvrqOfsWh5OU1XP+UQTW9Y8CM/C5Mg2oeeBpGleK9QU54wdQa3O/EZd9AWY7ZDyalEiB+5lQ==
X-Received: by 2002:aca:bdc4:: with SMTP id n187mr428oif.140.1553779682055;
        Thu, 28 Mar 2019 06:28:02 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id 4sm8203250ois.5.2019.03.28.06.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:28:01 -0700 (PDT)
Date:   Thu, 28 Mar 2019 08:28:01 -0500
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
Subject: Re: [PATCH 09/14] dt-bindings: vendor-prefixes: add SoChip
Message-ID: <20190328132801.GA11253@bogus>
References: <20190312152256.35574-1-icenowy@aosc.io>
 <20190312152256.35574-10-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312152256.35574-10-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 23:22:51 +0800, Icenowy Zheng wrote:
> Shenzhen SoChip Technology Co., Ltd. is a hardware vendor that produces
> EVBs with Allwinner chips. There's also a SoC named S3 that is developed
> by Allwinner (based on Allwinner V3/V3s) but branded SoChip.
> 
> Add the vendor prefix for SoChip.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
