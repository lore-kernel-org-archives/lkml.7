Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51859C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222192086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="CI78I/cC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDAMCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:02:12 -0400
Received: from vps.xff.cz ([195.181.215.36]:57940 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDAMCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554120129; bh=2zOODUMyFiC7YQgjsmodF8nV/CCGCjpvY/q+XM2SBh4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=CI78I/cCNW9qK3w6YmK3crMrFHpvPTF71WQm0HsWVPcBLQbw+nLPCXjcoq6+oofXQ
         X5HkdE8spzrJ6rJgH26rCabVRz/tYSgrt+h5937JL08YOu7xkY9KAjbmW0mDU+YR/O
         +yzCFDP1JwXE9pN8IihrWw7UfZEuIUoYF7FUXW7I=
Date:   Mon, 1 Apr 2019 14:02:09 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v2 4/5] dt-bindings: gnss: Add
 u-blox,neo-6m compatible
Message-ID: <20190401120209.fhjyvevk4tsc533s@core.my.home>
Mail-Followup-To: maxime.ripard@free-electrons.com, wens@csie.org,
        robh@kernel.org, johan@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20190401115616.21337-1-megous@megous.com>
 <20190401115616.21337-5-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401115616.21337-5-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 01:56:15PM +0200, megous via linux-sunxi wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> Add compatible for u-blox NEO-6M GPS module.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Ouch, I forgot to add:

Reviewed-by: Rob Herring <robh@kernel.org>

I'll do v3 if necessary, for this.

regards,
  Ondrej

> ---
>  Documentation/devicetree/bindings/gnss/u-blox.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/gnss/u-blox.txt b/Documentation/devicetree/bindings/gnss/u-blox.txt
> index e475659cb85f..7cdefd058fe0 100644
> --- a/Documentation/devicetree/bindings/gnss/u-blox.txt
> +++ b/Documentation/devicetree/bindings/gnss/u-blox.txt
> @@ -9,6 +9,7 @@ Required properties:
>  
>  - compatible	: Must be one of
>  
> +			"u-blox,neo-6m"
>  			"u-blox,neo-8"
>  			"u-blox,neo-m8"
>  
> -- 
> 2.21.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
