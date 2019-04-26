Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A04C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D272084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556319162;
	bh=sxkMT30bkxEz+mq/UX4/kDFaioLja6wT2w1GZWv4CVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UMO85SL0BTkL4xzZe/Iwd4MXZXY3oKr9Xgo95Ou31ca96aLX5ebpHzgh6UaUETkUZ
	 ce0U6XFjdnNOvTzBRKWXCaYq7Zj3nRxtt31C6kLsP1uA67mpxo2gbyWZZjOrCiCEhs
	 Oy7vnXvfeR4+b0vXXM4BPPNg4dLWW69A71wCGzXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfDZWwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:52:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42914 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfDZWwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:52:40 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so1183434oig.9;
        Fri, 26 Apr 2019 15:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vJM+zidfR9Cd+tBgnmLE+joxMOTQaIhVeEbiqiWTdow=;
        b=G0bzZOE5J4AWx6AqdEWSjR0Y4RikTP1e4MLiBE0JawYj3kGWMEXCWjEyVh1fVkMa5b
         stOtjDKyyFU8axy/LrbcpZ55seEK1w/y6J3EGwhbpjVdmlnhaGogdrn3zwMw/2eUn3Dw
         P8CNEg/m0TFGLVrqYLvGJf8EwE4bOes/+RuVpT4R46gn9LQQ/kSUdyEedGno9Fn+gvic
         NqYarA08Fdfe9R8tyDTUotz9aZlQdayj+5fhqX5tej59+bCw8w/29nsSykM9kY7KMHGC
         QxvMpB5KuaH6mQ7/Q7Y2loHIDZq9tPDW/q2TeSshHzvIOXByLFxf6yYW6QEvxl28B4bT
         4LFw==
X-Gm-Message-State: APjAAAUHYcn6glUr2rWWeE/xFOV+lU/R7cVGJwBJkJd9fdFkZD5s+wAD
        9bQibx9JJEqdljGc6KVvsw==
X-Google-Smtp-Source: APXvYqyHs5uGUkGxtqnuYas8LrF6nuezxQoBbKWaPj/1j5q07cOVZqJFA8O2KsJR6k2Lo4T24PvhWg==
X-Received: by 2002:aca:bb07:: with SMTP id l7mr8824825oif.142.1556319159498;
        Fri, 26 Apr 2019 15:52:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q25sm10583219otl.60.2019.04.26.15.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 15:52:38 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:52:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: [PATCH v3 3/8] dt-bindings: gpu: mali-midgard: Add h6 mali gpu
 compatible
Message-ID: <20190426225238.GA17375@bogus>
References: <20190417173031.9920-1-peron.clem@gmail.com>
 <20190417173031.9920-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417173031.9920-4-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 19:30:26 +0200, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= wrote:
> This add the H6 mali compatible in the dt-bindings to later support
> specific implementation.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-midgard.txt         | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
