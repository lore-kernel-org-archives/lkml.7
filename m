Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FB5C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B382075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgAIGUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:20:01 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:53798 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgAIGUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:20:00 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 876082006C;
        Thu,  9 Jan 2020 07:19:56 +0100 (CET)
Date:   Thu, 9 Jan 2020 07:19:55 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: panel-simple: Add compatible for
 GiantPlus GPM940B0
Message-ID: <20200109061955.GA9071@ravnborg.org>
References: <20200109003000.119516-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109003000.119516-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=RvkJcNcchRBvts6rJX0A:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 09:29:59PM -0300, Paul Cercueil wrote:
> Add a compatible string for the GiantPlus GPM740B0 3" QVGA TFT LCD
> panel, and remove the old giantplus,gpm740b0.txt documentation which is
> now obsolete.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Thanks,
applied to drm-misc-next.

	Sam

> ---
>  .../bindings/display/panel/giantplus,gpm940b0.txt    | 12 ------------
>  .../bindings/display/panel/panel-simple.yaml         |  2 ++
>  2 files changed, 2 insertions(+), 12 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/giantplus,gpm940b0.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/giantplus,gpm940b0.txt b/Documentation/devicetree/bindings/display/panel/giantplus,gpm940b0.txt
> deleted file mode 100644
> index 3dab52f92c26..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/giantplus,gpm940b0.txt
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -GiantPlus 3.0" (320x240 pixels) 24-bit TFT LCD panel
> -
> -Required properties:
> -- compatible: should be "giantplus,gpm940b0"
> -- power-supply: as specified in the base binding
> -
> -Optional properties:
> -- backlight: as specified in the base binding
> -- enable-gpios: as specified in the base binding
> -
> -This binding is compatible with the simple-panel binding, which is specified
> -in simple-panel.txt in this directory.
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 090866260f4f..c1a77d9105a2 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -33,6 +33,8 @@ properties:
>        - ampire,am-480272h3tmqw-t01h
>          # Ampire AM-800480R3TMQW-A1H 7.0" WVGA TFT LCD panel
>        - ampire,am800480r3tmqwa1h
> +        # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
> +      - giantplus,gpm940b0
>  
>    backlight: true
>    enable-gpios: true
> -- 
> 2.24.1
