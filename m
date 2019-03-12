Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D612EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E481205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552416151;
	bh=KTgcnzSqr5s4xtLT8XEy16yiduTqMRALz8SU6NbrVms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oatsjoIefxIh81NohmurrzAafp0mn1+GvKsEZu+MV+xVhmQXeLoTds46VJ8akhlS2
	 37Dr3giomoeOATfMR64/5NpGr6qCiaT+1SIedNoJJFigKLkTDCRmjbICcjvMs50fN9
	 ZlJFAaaSKLPjspU1b08gGanRRVABrHuGeGs7Q2dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfCLSma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:42:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40592 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCLSm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:42:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id k11so2439345oic.7;
        Tue, 12 Mar 2019 11:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5n1uCBjWcl/28MibD3HNIW723i2RMaI4TU7tL+Jx1DU=;
        b=XHHeZFl/0hZVRJOwRbz1/zLi8XE4LQVAE4agQCoapP3Y9pRyWkTd8bQTUQq4HuPbJv
         +QxA60bswJ6pRQXmDzST/vMEn4U6At1xXGMWnCD53kJIFucgSrQur1pgQbDYFQOxP7TY
         h3KTzmXARlTfBli2F+14H9KsHQzqiZM36Kd9sDbYw1vAkj2hIInuvQ3Wln9wVKHwY8P2
         8LHvW7+F6Y3X7jkTXCYmf+RCPndwQdQ8g1IFVcJoDYrtCYmOPtHeIXEIvFawih4r4xLu
         ysoPV/588aBwjbLuqHbgguT6IFn/knpmegxEYknSO79geSmEjMCEBTkglgNBwlXTVou+
         C1Nw==
X-Gm-Message-State: APjAAAWvrQDsR8VvfMbTKDAkMMU/S7ot5g08QvHzC+Ibhc4TRkG88PFH
        pcywC9odxbudmFdn7fyRWg==
X-Google-Smtp-Source: APXvYqyCZTqHBztaXR9WqQnstJ5GPAB6QcJ8oMQud/lB2NirHmVMAXLI8QfoZA3P4uS7QanqB978kw==
X-Received: by 2002:aca:e5c9:: with SMTP id c192mr2511225oih.118.1552416148518;
        Tue, 12 Mar 2019 11:42:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm3632216otf.73.2019.03.12.11.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 11:42:28 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:42:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: display: armada: Add more compatible
 strings
Message-ID: <20190312184227.GA1766@bogus>
References: <20190304202006.3863-1-lkundrak@v3.sk>
 <20190304202006.3863-5-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304202006.3863-5-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 09:20:05PM +0100, Lubomir Rintel wrote:
> There's a generic compatible string and the driver will work on a MMP2 as
> well, using the same binding.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Added marvell,armada-lcdc compatible string.
> 
>  .../devicetree/bindings/display/marvell,armada-lcdc.txt       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
> index 2606a8efc956..4ef66bc2845c 100644
> --- a/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
> +++ b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
> @@ -3,7 +3,9 @@ Marvell Armada LCD controller
>  
>  Required properties:
>  
> - - compatible: value should be "marvell,dove-lcd".
> + - compatible: value should be "marvell,armada-lcdc" along with
> +   "marvell,dove-lcd" or "marvell,mmp2-lcd", depending on the
> +   exact SoC model.

It is not exactly clear what the order is here. The preferred form is:

compatible: must be one of:
 a
 b
 c
followed by 'fallback'

So "marvell,armada-lcdc" is the fallback, but you can't start requiring 
the existing "marvell,dove-lcd" to have a fallback. At least you can't 
depend on that.

>   - reg: base address and size of the LCD controller
>   - interrupts: single interrupt number for the LCD controller
>  
> -- 
> 2.20.1
> 
