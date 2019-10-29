Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BEECA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1C821734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572385575;
	bh=cOrTVqvB+bpLeUHvdQ9wpiF/tsADAa/IgEYhzucn2Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ywkdhbcFy5zCqlbwf/3HuHhttKbeB4mg7uYHeBQBgWiQEdHFKHt3HDkJrt1lDIWw
	 Hu13Cds6eU4xIUEzmApXES6tlwRghw2EjDSvrsrms/9Qt+Zg1+DbklDyG5TyfP6R6I
	 HxVKL3jm/+4uUKDK0KfA1OOhL6O3wumv4LWDvX60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfJ2VqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:46:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36915 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfJ2VqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:46:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id y194so198145oie.4;
        Tue, 29 Oct 2019 14:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yJCcYJZxu+ClTD5mONx1BPgjKtKL8ywc/i/0sGI3cjs=;
        b=jMaATXtT4AlBJO6UwDQBAezFkZfONXxgzzBYfks+mwlX2NuVIgtETGovUPHVpfNCiG
         HceETN0GOruKMxUEKz7pBaC9yXdW9bEiqi2+QBGxQr0E/aGo4PzYjaGZoAsHwBqkfvvQ
         kbrQUHImwci1kZm+jlkCzUzSAKgxqWYkrf3JkJhl1LwYe/lCUbZ8G6bo7/Wnak3QTbx6
         +bsRt+QMkpybAQPgmpi1fKsKyRpeMCtp94TQu/p/EZh5BpAsLYS2ULa2P16EvaAdw1ZN
         zVt8JpX3L6SthF/gfQWt/Uhy9Cb8AA9zFHcAZzQ62JnPB1Fk2HgWi0gL6zVtUg7zXi0w
         44Og==
X-Gm-Message-State: APjAAAVA1Vrq4/RQ6npf9rjzoTr+8qhl+il+pENn6wDcoykUumGA87VF
        pL6FrZtLGeNSd1zbya5vJjurfLuqsA==
X-Google-Smtp-Source: APXvYqwPXaijas36sViYh9m6BOsvN8Quaw3gVnxynwsDpGLqfDJ59AdtsfwABefP7yfQUtH/S0XxvA==
X-Received: by 2002:aca:fc92:: with SMTP id a140mr5726869oii.153.1572385571564;
        Tue, 29 Oct 2019 14:46:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm75531otb.63.2019.10.29.14.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:46:10 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:46:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: Add bindings for Unisoc's SC9863A
Message-ID: <20191029214610.GA20831@bogus>
References: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
 <20191025102915.23677-3-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025102915.23677-3-chunyan.zhang@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 06:29:14PM +0800, Chunyan Zhang wrote:
> 
> Added bindings for Unisoc's SC9863A board and SC9863A SoC.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/arm/sprd.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Can you please convert this to DT schema first. See 
Documentation/devicetree/writing-schema.rst.

> 
> diff --git a/Documentation/devicetree/bindings/arm/sprd.txt b/Documentation/devicetree/bindings/arm/sprd.txt
> index 3df034b13e28..c244c911f8df 100644
> --- a/Documentation/devicetree/bindings/arm/sprd.txt
> +++ b/Documentation/devicetree/bindings/arm/sprd.txt
> @@ -12,3 +12,11 @@ Required root node properties:
>  SP9860G 3GFHD Board
>  Required root node properties:
>  	- compatible = "sprd,sp9860g-1h10", "sprd,sc9860";
> +
> +SC9863A SoC
> +Required root node properties:
> +	- compatible = "sprd,sc9863a"
> +
> +SP9863A-1H10 Board
> +Required root node properties:
> +	- compatible = "sprd,sp9863a-1h10", "sprd,sc9863a";
> -- 
> 2.20.1
> 
> 
