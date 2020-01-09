Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216CEC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C8D2051A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgAITcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:32:10 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:46294 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbgAITcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:32:09 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E612A80497;
        Thu,  9 Jan 2020 20:32:04 +0100 (CET)
Date:   Thu, 9 Jan 2020 20:32:03 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: display: simple: Add Satoz panel
Message-ID: <20200109193203.GA22666@ravnborg.org>
References: <20200109184037.9091-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109184037.9091-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=oYh99mQ5AAAA:8
        a=P-IC7800AAAA:8 a=iQciiuR6OtxbVP0T3JUA:9 a=CjuIK1q_8ugA:10
        a=Dexii-P0nw1V_nRav-Pa:22 a=d3PnA9EDa4IxuAV0gXij:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel.

On Thu, Jan 09, 2020 at 07:40:36PM +0100, Miquel Raynal wrote:
> Satoz is a Chinese TFT manufacturer.
> Website: http://www.sat-sz.com/English/index.html
> 
> Add the compatible for its SAT050AT40H12R2 5.0 inch LCD panel.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied this and the following patch to drm-misc-next.
I manually resolved the conflict in panel-simple.yaml.

Thanks,

	Sam


> ---
> 
> Changes since v4:
> * Drop the satoz,sat050at40h12r2.yaml file in favor of the very new
>   panel-simple.yaml common file. Just add the compatible there.
> 
> Changes since v3:
> * Added the missing ".yaml" suffix in the $id.
> * Removed the unnecessary "contains" assertion about the compatible.
> * Added a precision : there is no public specification for this panel
>   (known for the moment).
> * Bindings checked with "make dt_binding_check"
> 
> Changes since v2:
> * None.
> 
> Changes since v1:
> * New patch
> 
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 090866260f4f..8a9c37640dc0 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -33,6 +33,8 @@ properties:
>        - ampire,am-480272h3tmqw-t01h
>          # Ampire AM-800480R3TMQW-A1H 7.0" WVGA TFT LCD panel
>        - ampire,am800480r3tmqwa1h
> +        # Satoz SAT050AT40H12R2 5.0" WVGA TFT LCD panel
> +      - satoz,sat050at40h12r2
>  
>    backlight: true
>    enable-gpios: true
> -- 
> 2.20.1
