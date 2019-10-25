Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A4CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30B82084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572039200;
	bh=bJE7Nae9mt77RHU15ZI/ggF7f9RsYQvqYKO0m65blLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tmCZENZZC/ye7lbcGpY97NAt/3aT9S+nFzOkpQJ5X6Uikp8szycjc2YfjTEyUt5Xv
	 /V0wXgUGbEGLD2SDLjnO+mYej9d/AUmbyIRqM1NqG9NDAFxkGH/QqAK+oAwmjsFtmb
	 MXSzgGzogdo/C6AVuv0fJCJ8VsoxYg40a4SzKJvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfJYVdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:33:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41773 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYVdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:33:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id 94so3022030oty.8;
        Fri, 25 Oct 2019 14:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u02r+RvqhjVwFLtRSwVlPnNfcLAkCZS1vUmCFAkSORk=;
        b=kkbE2B3yzezEsIwrD7tdBnJP9EAcIEwMwhHmLXcqAGRVHePyepScJXCYhEh1M2/V6S
         uN30yR9XcjHDhdAwP5+NL81qn0AIwRhorUU0C8tzxo8GMhtx8wSXmkZ4rJzzycOU5odA
         yQQAd6kdEn8UR94t8fyFMRz8HCQu2BwBg+SRikNSsSnQzHFtGNPkgRsU2JnuFpmbmfcW
         73Qvsdr0fvCFVsX8pLO11DYZCExCSG0qN0qcEjgA6jPhFYaG5kQILI7LaJF9gZBlOMOC
         gdxghdWmigreUMgAEdhJkTW9dA8QqutAoNfS6WAJv5rByZbrpuZvaCXfHzZKtYWULvyi
         sULA==
X-Gm-Message-State: APjAAAX4/JaFE2N6DROp4bJHk88Ii56RypeP0iUeFGsDUNY/8edFl8yz
        h+icb6pXgmlrZxzTk6Blgw==
X-Google-Smtp-Source: APXvYqxJZE75SyD3KWy2FDsc6KlG/GM5vZiuhH0phipAvGuV7QL6R6q4uMTygxmkwaJPAgNQIZslnw==
X-Received: by 2002:a9d:3675:: with SMTP id w108mr4556144otb.81.1572039199057;
        Fri, 25 Oct 2019 14:33:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c19sm1112928otl.6.2019.10.25.14.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:33:18 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:33:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     heiko@sntech.de, kever.yang@rock-chips.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: Add doc for rk3308-evb
Message-ID: <20191025213317.GA22718@bogus>
References: <20191021084437.28279-1-andy.yan@rock-chips.com>
 <20191021084642.28562-1-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021084642.28562-1-andy.yan@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 16:46:42 +0800, Andy Yan wrote:
> Add compatible for RK3308 Evaluation board
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - Split with the dts file
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
