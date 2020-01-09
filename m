Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBF6C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB152067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgAIGUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:20:31 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:53846 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgAIGUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:20:30 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 3B0542006A;
        Thu,  9 Jan 2020 07:20:28 +0100 (CET)
Date:   Thu, 9 Jan 2020 07:20:27 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: panel-simple: Add compatible for Sharp
 LS020B1DD01D
Message-ID: <20200109062026.GB9071@ravnborg.org>
References: <20200109003000.119516-1-paul@crapouillou.net>
 <20200109003000.119516-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109003000.119516-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=4zq-3AoUyEjbUeS7jCwA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 09:30:00PM -0300, Paul Cercueil wrote:
> Add a compatible string for the Sharp LS020B1DD01D 2" HQVGA TFT LCD
> panel, and remove the old sharp,ls020b1dd01d.txt documentation which is
> now obsolete.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied to drm-misc-next, thanks

	Sam

> ---
>  .../bindings/display/panel/panel-simple.yaml         |  2 ++
>  .../bindings/display/panel/sharp,ls020b1dd01d.txt    | 12 ------------
>  2 files changed, 2 insertions(+), 12 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index c1a77d9105a2..f1fba1db382a 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -35,6 +35,8 @@ properties:
>        - ampire,am800480r3tmqwa1h
>          # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
>        - giantplus,gpm940b0
> +        # Sharp LS020B1DD01D 2.0" HQVGA TFT LCD panel
> +      - sharp,ls020b1dd01d
>  
>    backlight: true
>    enable-gpios: true
> diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt b/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
> deleted file mode 100644
> index e45edbc565a3..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -Sharp 2.0" (240x160 pixels) 16-bit TFT LCD panel
> -
> -Required properties:
> -- compatible: should be "sharp,ls020b1dd01d"
> -- power-supply: as specified in the base binding
> -
> -Optional properties:
> -- backlight: as specified in the base binding
> -- enable-gpios: as specified in the base binding
> -
> -This binding is compatible with the simple-panel binding, which is specified
> -in simple-panel.txt in this directory.
> -- 
> 2.24.1
