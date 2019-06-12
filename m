Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41E2C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D172080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rqqV6hwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfFLIQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:16:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35821 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730863AbfFLIQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:16:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190612081640euoutp02e999b53556a57e0ee156723971f6db4a~nZYEAHI890187801878euoutp02Y
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 08:16:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190612081640euoutp02e999b53556a57e0ee156723971f6db4a~nZYEAHI890187801878euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560327400;
        bh=PWdb377o0rER7E11sck9S6AwPDJeCROTCX+Ce5iaBhg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rqqV6hwRtsZr3pMKSHZLKMOzb69tEi2HDVq0T/SileIHlwTTeaxoILHgNsK5t5AhC
         sPh25ynt/cAcLHl6zwbf/5kN1PeO8jQxODkA4GoDejvKd7FSwyVBaWvy/m0vU7R0aS
         SJLwbFDpH5BWS4xFjZIIk4aaRjmC4ah/kRGzuqms=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190612081639eucas1p13c5abc807f9673acb6e5e6bcb9e0a729~nZYDQXeWy0358603586eucas1p1s;
        Wed, 12 Jun 2019 08:16:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 76.23.04377.7E4B00D5; Wed, 12
        Jun 2019 09:16:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190612081639eucas1p142d77338598e9f08936f2cd7cd789ec5~nZYChiO7s0358603586eucas1p1r;
        Wed, 12 Jun 2019 08:16:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190612081638eusmtrp163fe6b8fce83e69a682fce03661d98e8~nZYCSimvv0940709407eusmtrp1D;
        Wed, 12 Jun 2019 08:16:38 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-c2-5d00b4e7dccc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 54.CD.04140.6E4B00D5; Wed, 12
        Jun 2019 09:16:38 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190612081638eusmtip29b466797963a373670843704ae62f10e~nZYBjrKm01710717107eusmtip2i;
        Wed, 12 Jun 2019 08:16:37 +0000 (GMT)
Subject: Re: [PATCH v2 6/7] dt-bindings: Add ANX6345 DP/eDP transmitter
 binding
To:     Torsten Duwe <duwe@lst.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <354de37d-57bb-6b06-c81a-a2081ea4f222@samsung.com>
Date:   Wed, 12 Jun 2019 10:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604122305.07B9068B05@newverein.lst.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRj1/W77lGbvZuWDJdXKHxlpRcEbWST140O6WNGFTGrlh0rbik3t
        TnaxvFKaYc40UyOxhTYvy3VXaZk5s+xiUa6yOxalCQtzOb9J/jvnPOd5n3Pg5WllIRfAx+sS
        RL1OrVFxPkzdPWfbrE81XtGzL9+YQrLszRRJufcREVddNk3ON9lZ0vH7B0f6Ox5Q5GhpJUdq
        rK0s6b3whiJp2WUyYn7/jCVPrOc4cvF5O0UcX24jknKzSUZeV7UiUm0+QxOntYghzoY2aomf
        UOocpARTkQkJRab9wofGbzKhILmdEareXWaFm/3FjFBvfD2kpeazgrkijRO+2+0ywdLvYIXb
        hSaZ0JVho4TqskPC9c5kLlKxyScsRtTEJ4n60MVbfeIcV0uoXXfH7znsLGKTkQunI28e8Dxw
        lvyk0pEPr8TlCJpKXUgifQgGMjM8pBeB69cHemQl/e4Xz8olBPnNaZxEehBkPWxBbpcfXg2X
        mh/K3INxuJGB3JMPWDehcQqC4upexu3i8Az4W93JubEcLwbTjyvDOoODoOD+s2F9PN4IffVm
        JHkU0JzfPeTheW+8AJ6+i3fLNJ4Mlp5ztIT94WX3eUqK+oKH2s+hEl4GFw5f9+h+8NVWI5Pw
        JGg5nclI+BB0lR+j3TkBpyKorar3dF4IjbZ21n2XHspcafW8GQ6vjj4dlgH7wosehRTBF3Lq
        8mhJlkPqcaXkngpdrbWeB/3h4qPf3CmkMo7qZRxVxjiqjPH/3WLEVCB/MdGgjRUNc3Xi7hCD
        WmtI1MWGbN+pNaOhT9syaOu7hqwD2xoQ5pFqjPxOnmuzklUnGfZqGxDwtGqcfO4Or2ilPEa9
        d5+o37lFn6gRDQ1oIs+o/OX7vRxRShyrThB3iOIuUT8ypXjvgGTEz1oYsihMV1VesZw6lbQ8
        qjIwMxfHjO1ozOl20XGbEsM73h4ZiJy/0vKnUNFtiyh5daJpzczggNC3RxzR675Pt6YGzvDK
        nR3U+mTJHkuepfjs2qUHxQ1lN/hV2LjlsSai62WJvS0jWHFrdVZdUEqU5vOB6WGftCvWTHCt
        T28rLcuZpmIMceo5wbTeoP4H7/wXZbADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfc9tR3N22rS9CGGMwhI6tpn5LtSiqA4ZZfSh8oId9ORE52pn
        WhbhVIRcBu1DVLPmncAWmVqWUuYUTfOSZZZdzEqDISpRSQPTNlfgtx//5/d/4IGHxmX1ZDCd
        kW0UDNl8lpLyI54vdI9t+tbkk7x54SeLLg30YKi46xtAiw8sOCrvHCDR8K9ZCs0N92KoqPou
        hZpa+kn0o3IMQyWWGglq+DpColctNyhU+2YIQ+PONoCKH3dK0Mf6foAaG67gyNViI5DLMYjt
        kHPVrgWMs9vsgLPZz3GTHVMSrsw0RHD1X26T3OO5CoJ7ZP3ozi5cJ7mGuhKKmxkYkHDNc+Mk
        13bTLuE+XezGuMaafK511ETFr0pgow36HKOwVqsXjTHKRBVSsyoNYtVbNKwqIip5mzpSGR4b
        nSZkZeQKhvDY46x2/F4VdrI96EyBy0aawCJjBr40ZLZAc7sTMwM/WsbUAlhY30V6BwrYWj6N
        e1kO50fMlFeacks225IkZw7BWz19Es8gkOkmoHn22tIqnCkGcL7UKfFYMqYVwNHfcg9TzEb4
        p3GU8rCUiYX22TuEhwlmPSx7NrKUBzFHYVmLifA6q2DP9Qk307Qvo4Gvv2R4YpwJhfO2l7iX
        Q2Dz9I1/rIDvJsqxy0BmXda2LqtYl1WsyyoVgKgDgUKOqEvXiWpW5HViTnY6m6rXNQD3tzzo
        cjU9BOaZww7A0EDpL316dTFJRvK5Yp7OASCNKwOl6kyfZJk0jc87Kxj0KYacLEF0gEj3bRY8
        OChV7/69bGOKKlIVhTSqqIioiK1IqZBeYNqTZEw6bxQyBeGkYPjfw2jfYBNA06OJhvgD6vt3
        via0rwwrUCjWvE1zZn439xXGTuvlyvNxbMJqq84nxLz9YBEfohFPmfYeLn7fu1Pe2vFi39bq
        ibix0tAT+9bdjrF8lj+5ix1TTxY5pTv4Pb2stk4+6O93xLHhTfjusfDodysWayabqq4EnNr/
        odKxK+CQ4J9/2qIkRC2vCsMNIv8X4rr5UkMDAAA=
X-CMS-MailID: 20190612081639eucas1p142d77338598e9f08936f2cd7cd789ec5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190604122333epcas2p2f2c750e19a363901c83abb83354f55d4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190604122333epcas2p2f2c750e19a363901c83abb83354f55d4
References: <20190604122150.29D6468B05@newverein.lst.de>
        <CGME20190604122333epcas2p2f2c750e19a363901c83abb83354f55d4@epcas2p2.samsung.com>
        <20190604122305.07B9068B05@newverein.lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.2019 14:23, Torsten Duwe wrote:
> The anx6345 is an ultra-low power DisplayPort/eDP transmitter designed
> for portable devices.
>
> Add a binding document for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../devicetree/bindings/display/bridge/anx6345.txt | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx6345.txt b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> new file mode 100644
> index 000000000000..bd63f6ac107e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> @@ -0,0 +1,57 @@
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


You have not specified it's active state, since in driver's code you
named it RESETN I guess it should be active low.


> + - dvdd12-supply	: Regulator for 1.2V digital core power.
> + - dvdd25-supply	: Regulator for 2.5V digital core power.
> + - Video port for LVTTL input, using the DT bindings defined in [1].


Please assign port number for input (I guess 0).


> +
> +Optional properties:
> +
> + - Video port for eDP output (panel or connector) using the DT bindings
> +   defined in [1].


Shouldn't it be also required?


Regards

Andrzej


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


