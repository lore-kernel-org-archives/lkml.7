Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4943C32757
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8122173E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d5M6DY0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfHOLr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:47:26 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43608 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbfHOLr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:47:26 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E32B2B2;
        Thu, 15 Aug 2019 13:47:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1565869643;
        bh=7YHIexGsypHKPBrHkKhWFogXO6dZbIw8bhIG8muuOqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5M6DY0HUEV5MQtRh5Vn9NcRMQ4In57gkO1EnrM4iMjn/aX7onIcfXLuV3h5mEqFR
         CV1YluX1JPfiNsIUYD///aVF/Hu4JXSMkF1m7k/LzushWEVVK5R8v7xjI1HtQl/hXb
         Xfb4p1TAEnYx4/Wm2xWhNTeNdsrTGSDAGlFvwmmM=
Date:   Thu, 15 Aug 2019 14:47:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH v2 2/9] dt-bindings: display: Add bindings for Advantech
 IDK-2121WR
Message-ID: <20190815114719.GI5011@pendragon.ideasonboard.com>
References: <1565867073-24746-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1565867073-24746-3-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1565867073-24746-3-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Thu, Aug 15, 2019 at 12:04:26PM +0100, Fabrizio Castro wrote:
> This panel is handled through the generic lvds-panel bindings,
> so only needs its additional compatible specified.
> 
> Some panel-specific documentation can be found here:
> https://buy.advantech.eu/Displays/Embedded-LCD-Kits-High-Brightness/model-IDK-2121WR-K2FHA2E.htm
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> ---
> v1->v2:
> * Reworked according to Laurent's feedback
> * Renamed lvds0_panel_in to panel_in0
> * Renamed lvds1_panel_in to panel_in1
> 
> Laurent,
> 
> Should this be a .yaml file already?

It's not a strict requirement, but I'm sure Rob would really appreciate.
I've converted a DT binding to yaml recently (for a panel too), and I
have to say I'm impressed by the validation yaml brings, both for DT
sources and for DT bindings. It even validates the example in the
bindings, which is great. Documentation/devicetree/writing-schema.md
should give you a few pointers to get started (in particular make sure
you run make dt_binding_check for your new bindings).

>  .../display/panel/advantech,idk-2121wr.txt         | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.txt b/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.txt
> new file mode 100644
> index 0000000..6ee1d1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.txt
> @@ -0,0 +1,56 @@
> +Advantech Co., Ltd. IDK-2121WR 21.5" LVDS panel
> +===============================================
> +
> +Required properties:
> +- compatible: should be "advantech,idk-2121wr" followed by "panel-lvds"
> +
> +This binding is compatible with the lvds-panel binding, which is specified
> +in panel-lvds.txt in this directory.
> +The panel operates in dual-link mode and thus requires two port nodes,
> +the first port node expects odd pixels (1, 3, 5, etc.) and the second port
> +expects even pixels (0, 2, 4, etc.).
> +
> +Example
> +-------
> +
> +	panel {
> +		compatible = "advantech,idk-2121wr", "panel-lvds";
> +
> +		width-mm = <476>;
> +		height-mm = <268>;
> +
> +		data-mapping = "vesa-24";
> +
> +		panel-timing {
> +			clock-frequency = <148500000>;
> +			hactive = <1920>;
> +			vactive = <1080>;
> +			hsync-len = <44>;
> +			hfront-porch = <88>;
> +			hback-porch = <148>;
> +			vfront-porch = <4>;
> +			vback-porch = <36>;
> +			vsync-len = <5>;
> +		};
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				/* Odd pixels */
> +				reg = <0>;
> +				panel_in0: endpoint {
> +					remote-endpoint = <&lvds0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				/* Even pixels */
> +				reg = <1>;
> +				panel_in1: endpoint {
> +					remote-endpoint = <&lvds1_out>;
> +				};
> +			};
> +		};
> +	};
> -- 
> 2.7.4
> 

-- 
Regards,

Laurent Pinchart
