Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D27C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D342186A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="b6vY6YID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfEWHcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:32:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39046 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfEWHcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:32:07 -0400
Received: from pendragon.ideasonboard.com (85-76-106-214-nat.elisa-mobile.fi [85.76.106.214])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9139B337;
        Thu, 23 May 2019 09:32:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1558596722;
        bh=/W2SCMLQvihCKvM7mxR3BE+Y239YuZ1nvKLwS2lS22s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6vY6YIDsBJ6mfZ1r7Cjz+6RS7YWDC4UqQv/GhyPYWnwLaqWsHk4FioMivLW63tzk
         cr3JIVwoKX+zuCtO47ebgD+Lo5+6DQctzjSOf0UjhryORcxtcJ/jenCG8PBz3Y3v+N
         RFtQvviCFCcE6TLV0l9RHjyP2CIv6RzPEGaxsvFk=
Date:   Thu, 23 May 2019 10:31:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: Add ANX6345 DP/eDP transmitter binding
Message-ID: <20190523073141.GB4745@pendragon.ideasonboard.com>
References: <20190523065013.2719D68B05@newverein.lst.de>
 <20190523065400.BD9EB68B05@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523065400.BD9EB68B05@newverein.lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

Thank you for the patch.

On Thu, May 23, 2019 at 08:54:00AM +0200, Torsten Duwe wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The anx6345 is an ultra-low power DisplayPort/eDP transmitter designed
> for portable devices.
> 
> Add a binding document for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Torsten Duwe <duwe@suse.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../bindings/display/bridge/anx6345.txt       | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx6345.txt b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> new file mode 100644
> index 000000000000..e79a11348d11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> @@ -0,0 +1,56 @@
> +Analogix ANX6345 eDP Transmitter
> +--------------------------------
> +
> +The ANX6345 is an ultra-low power Full-HD eDP transmitter designed for
> +portable devices.
> +
> +Required properties:
> +
> + - compatible		: "analogix,anx6345"
> + - reg			: I2C address of the device
> + - reset-gpios		: Which GPIO to use for reset
> + - dvdd12-supply	: Regulator for 1.2V digital core power.
> + - dvdd25-supply	: Regulator for 2.5V digital core power.
> +
> +Optional properties:
> +
> + - Video ports for RGB input and eDP output using the DT bindings
> +   defined in [1]
> +
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +Example:
> +
> +anx6345: anx6345@38 {
> +	compatible = "analogix,anx6345";
> +	reg = <0x38>;
> +	reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
> +	dvdd25-supply = <&reg_dldo2>;
> +	dvdd12-supply = <&reg_fldo1>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		anx6345_in: port@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +			anx6345_in_tcon0: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&tcon0_out_anx6345>;
> +			};
> +		};
> +
> +		anx6345_out: port@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			anx6345_out_panel: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&panel_in_edp>;
> +			};
> +		};
> +	};
> +};

-- 
Regards,

Laurent Pinchart
