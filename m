Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EA1C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF8820674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="df/ach9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfKLOez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:34:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41718 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfKLOez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:34:55 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACEYMKc047218;
        Tue, 12 Nov 2019 08:34:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573569262;
        bh=GqoAyPZ2YH6DjjBqdDeKxfRVu+HXSjCjk4pGHnvMwIk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=df/ach9OOPSvZhaEudcfm+MC847EE+bTy6QZ9f3YDt/2bNbns0LombCqF4TiLmc2K
         8sJUfcDlYostrFoRMYw6NiljzTgwvYk/9wXTPJnVp9S7RWAMyORPAG4uVJwGVtcRGr
         FKQiz9ZJBfffvg2MlDVy127qgzzVWgsKVhBGyD60=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACEYLIq045996;
        Tue, 12 Nov 2019 08:34:21 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:34:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:34:04 -0600
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with SMTP id xACEYL99039841;
        Tue, 12 Nov 2019 08:34:21 -0600
Date:   Tue, 12 Nov 2019 08:37:24 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 02/20] dt-bindings: media: cal: update binding example
Message-ID: <20191112143724.374xnycptzdul2lw@ti.com>
References: <20191112143152.23176-1-bparrot@ti.com>
 <20191112143152.23176-3-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191112143152.23176-3-bparrot@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rob

Benoit Parrot <bparrot@ti.com> wrote on Tue [2019-Nov-12 08:31:34 -0600]:
> Update binding example to show proper endpoint properties and linkage.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  .../devicetree/bindings/media/ti-cal.txt      | 31 ++++++++++---------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/ti-cal.txt b/Documentation/devicetree/bindings/media/ti-cal.txt
> index 93096d924786..7e960cf26e23 100644
> --- a/Documentation/devicetree/bindings/media/ti-cal.txt
> +++ b/Documentation/devicetree/bindings/media/ti-cal.txt
> @@ -27,7 +27,6 @@ Documentation/devicetree/bindings/media/video-interfaces.txt.
>  Example:
>  	cal: cal@4845b000 {
>  		compatible = "ti,dra72-cal";
> -		ti,hwmods = "cal";
>  		reg = <0x4845B000 0x400>,
>  		      <0x4845B800 0x40>,
>  		      <0x4845B900 0x40>;
> @@ -45,9 +44,10 @@ Example:
>  
>  			csi2_0: port@0 {
>  				reg = <0>;
> -				endpoint {
> -					slave-mode;
> -					remote-endpoint = <&ar0330_1>;
> +				csi2_phy0: endpoint {
> +					remote-endpoint = <&csi2_cam0>;
> +					clock-lanes = <0>;
> +					data-lanes = <1 2>;
>  				};
>  			};
>  			csi2_1: port@1 {
> @@ -57,19 +57,20 @@ Example:
>  	};
>  
>  	i2c5: i2c@4807c000 {
> -		ar0330@10 {
> -			compatible = "ti,ar0330";
> -			reg = <0x10>;
> +		clock-frequency = <400000>;
>  
> -			port {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> +		camera-sensor@3c {
> +			compatible = "ovti,ov5640";
> +			reg = <0x3c>;
> +
> +			clocks = <&clk_fixed>;
> +			clock-names = "xclk";
>  
> -				ar0330_1: endpoint {
> -					reg = <0>;
> -					clock-lanes = <1>;
> -					data-lanes = <0 2 3 4>;
> -					remote-endpoint = <&csi2_0>;
> +			port {
> +				csi2_cam0: endpoint {
> +					remote-endpoint = <&csi2_phy0>;
> +					clock-lanes = <0>;
> +					data-lanes = <1 2>;
>  				};
>  			};
>  		};
> -- 
> 2.17.1
> 
