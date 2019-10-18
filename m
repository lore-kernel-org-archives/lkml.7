Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F1CCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C0E222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405743AbfJRNu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:50:28 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:54940 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731183AbfJRNu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:50:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 27700FB04;
        Fri, 18 Oct 2019 15:50:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TA8MpUsK2edw; Fri, 18 Oct 2019 15:50:23 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B98DB49A41; Fri, 18 Oct 2019 15:50:22 +0200 (CEST)
Date:   Fri, 18 Oct 2019 15:50:22 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     "To : Lucas Stach" <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] dt-bindings: etnaviv: Add #cooling-cells
Message-ID: <20191018135022.GA6728@bogon.m.sigxcpu.org>
References: <cover.1568255903.git.agx@sigxcpu.org>
 <6e9d761598b2361532146f43161fd05f3eee6545.1568255903.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e9d761598b2361532146f43161fd05f3eee6545.1568255903.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Sep 11, 2019 at 07:40:36PM -0700, Guido Günther wrote:
> Add #cooling-cells for when the gpu acts as a cooling device.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../devicetree/bindings/display/etnaviv/etnaviv-drm.txt          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> index 8def11b16a24..640592e8ab2e 100644
> --- a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> +++ b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> @@ -21,6 +21,7 @@ Required properties:
>  Optional properties:
>  - power-domains: a power domain consumer specifier according to
>    Documentation/devicetree/bindings/power/power_domain.txt
> +- #cooling-cells: : If used as a cooling device, must be <2>

The other patch of the series made it into linux-next already but this
documentation fixup didn't. Anything i can do to get this applied as
well so documentation stays in sync?
Cheers,
 -- Guido

>  
>  example:
>  
> -- 
> 2.23.0.rc1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
