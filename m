Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79F0C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A5C2182B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbfFSM2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:28:55 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:57633 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSM2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:28:54 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9517A20026;
        Wed, 19 Jun 2019 14:28:51 +0200 (CEST)
Date:   Wed, 19 Jun 2019 14:28:50 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: Add King Display
 KD035G6-54NT panel documentation
Message-ID: <20190619122850.GC29084@ravnborg.org>
References: <20190603152555.23527-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603152555.23527-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=7gkXJVJtAAAA:8 a=4-pPdtRa6f10XkIaLb0A:9 a=CjuIK1q_8ugA:10
        a=9LHmKk7ezEChjTCyhBa9:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 05:25:54PM +0200, Paul Cercueil wrote:
> The KD035G6-54NT is a 3.5" 320x240 24-bit TFT LCD panel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Rob - ping for review.

	Sam

> ---
> 
> Notes:
>     v2: - Add an address to the panel node
>     	- Add information about SPI properties
>     	- Add information about the 'port' sub-node
> 
>  .../panel/kingdisplay,kd035g6-54nt.txt        | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
> new file mode 100644
> index 000000000000..fa9596082e44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
> @@ -0,0 +1,42 @@
> +King Display KD035G6-54NT 3.5" (320x240 pixels) 24-bit TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "kingdisplay,kd035g6-54nt"
> +- power-supply: See panel-common.txt
> +- reset-gpios: See panel-common.txt
> +
> +Optional properties:
> +- backlight: see panel-common.txt
> +
> +The generic bindings for the SPI slaves documented in [1] also apply.
> +
> +The device node can contain one 'port' child node with one child
> +'endpoint' node, according to the bindings defined in [2]. This
> +node should describe panel's video bus.
> +
> +[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
> +[2]: Documentation/devicetree/bindings/graph.txt
> +
> +Example:
> +
> +&spi {
> +	panel@0 {
> +		compatible = "kingdisplay,kd035g6-54nt";
> +		reg = <0>;
> +
> +		spi-max-frequency = <3125000>;
> +		spi-3wire;
> +		spi-cs-high;
> +
> +		reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
> +
> +		backlight = <&backlight>;
> +		power-supply = <&ldo6>;
> +
> +		port {
> +			panel_input: endpoint {
> +				remote-endpoint = <&panel_output>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.21.0.593.g511ec345e18
