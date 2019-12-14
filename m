Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E012C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D9D24125
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLNKyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 05:54:22 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:46754 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 05:54:22 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E184B804CE;
        Sat, 14 Dec 2019 11:54:19 +0100 (CET)
Date:   Sat, 14 Dec 2019 11:54:18 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/6] dt-bindings: display/ingenic: Add compatible
 string for JZ4770
Message-ID: <20191214105418.GA5687@ravnborg.org>
References: <20191210144142.33143-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210144142.33143-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=VwQbUJbxAAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8 a=nZJdUF_zLBciypfbcfYA:9
        a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22 a=AjGcO6oz07-iQ99wixmX:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Tue, Dec 10, 2019 at 03:41:37PM +0100, Paul Cercueil wrote:
> Add a compatible string for the LCD controller found in the JZ4770 SoC.
> 
> v2: No change
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Rob Herring <robh@kernel.org>

Whole series looks good.
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  Documentation/devicetree/bindings/display/ingenic,lcd.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/ingenic,lcd.txt b/Documentation/devicetree/bindings/display/ingenic,lcd.txt
> index 7b536c8c6dde..01e3261defb6 100644
> --- a/Documentation/devicetree/bindings/display/ingenic,lcd.txt
> +++ b/Documentation/devicetree/bindings/display/ingenic,lcd.txt
> @@ -4,6 +4,7 @@ Required properties:
>  - compatible: one of:
>    * ingenic,jz4740-lcd
>    * ingenic,jz4725b-lcd
> +  * ingenic,jz4770-lcd
>  - reg: LCD registers location and length
>  - clocks: LCD pixclock and device clock specifiers.
>  	   The device clock is only required on the JZ4740.
> -- 
> 2.24.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
