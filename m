Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988F5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEB820855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKUH3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:29:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32814 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUH3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:29:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id DD3A028DB43
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Martyn Welch <martyn.welch@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-imx@nxp.com, kernel@collabora.com
Subject: Re: [PATCH v3 4/4] dt-bindings: display: add IMX MIPI DSI host
 controller doc
In-Reply-To: <e19aca1f-842d-a5b4-6fc1-02f7f6dd136d@baylibre.com>
References: <20191118152518.3374263-1-adrian.ratiu@collabora.com>
 <20191118152518.3374263-5-adrian.ratiu@collabora.com>
 <e19aca1f-842d-a5b4-6fc1-02f7f6dd136d@baylibre.com>
Date:   Thu, 21 Nov 2019 09:29:39 +0200
Message-ID: <87a78p7km4.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019, Neil Armstrong <narmstrong@baylibre.com> 
wrote:
> Hi, 
> 
> On 18/11/2019 16:25, Adrian Ratiu wrote: 
> 
> A small commit log would be welcome here. 
> 
>> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.com> 
>> Signed-off-by: Martyn Welch <martyn.welch@collabora.com> 
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com> --- 
>>  .../bindings/display/imx/mipi-dsi.txt         | 56 
>>  +++++++++++++++++++ 1 file changed, 56 insertions(+) create 
>>  mode 100644 
>>  Documentation/devicetree/bindings/display/imx/mipi-dsi.txt 
>>  diff --git 
>> a/Documentation/devicetree/bindings/display/imx/mipi-dsi.txt 
>> b/Documentation/devicetree/bindings/display/imx/mipi-dsi.txt 
>> new file mode 100644 index 000000000000..3f05c32ef963 --- 
>> /dev/null +++ 
>> b/Documentation/devicetree/bindings/display/imx/mipi-dsi.txt 
> 
> New bindings should use the yaml dt-schema format, could you 
> convert it ?

Yes, I will convert to yaml and add a commit log in the next 
version.

Will leave the current patches a little more on review to give 
others a chance to see them.

Thank you!

>
> Neil
>
>> @@ -0,0 +1,56 @@
>> +Freescale i.MX6 DW MIPI DSI Host Controller
>> +===========================================
>> +
>> +The DSI host controller is a Synopsys DesignWare MIPI DSI v1.01 IP
>> +with a companion PHY IP.
>> +
>> +These DT bindings follow the Synopsys DW MIPI DSI bindings defined in
>> +Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt with
>> +the following device-specific properties.
>> +
>> +Required properties:
>> +
>> +- #address-cells: Should be <1>.
>> +- #size-cells: Should be <0>.
>> +- compatible: "fsl,imx6q-mipi-dsi", "snps,dw-mipi-dsi".
>> +- reg: See dw_mipi_dsi.txt.
>> +- interrupts: The controller's CPU interrupt.
>> +- clocks, clock-names: Phandles to the controller's pll reference
>> +  clock(ref) and APB clock(pclk), as described in [1].
>> +- ports: a port node with endpoint definitions as defined in [2].
>> +- gpr: Should be <&gpr>.
>> +       Phandle to the iomuxc-gpr region containing the multiplexer
>> +       control register.
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +[2] Documentation/devicetree/bindings/media/video-interfaces.txt
>> +
>> +Example:
>> +
>> +	mipi_dsi: mipi@21e0000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		compatible = "fsl,imx6q-mipi-dsi", "snps,dw-mipi-dsi";
>> +		reg = <0x021e0000 0x4000>;
>> +		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
>> +		gpr = <&gpr>;
>> +		clocks = <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
>> +			 <&clks IMX6QDL_CLK_MIPI_IPG>;
>> +		clock-names = "ref", "pclk";
>> +		status = "okay";
>> +
>> +		ports {
>> +			port@0 {
>> +				reg = <0>;
>> +				mipi_mux_0: endpoint {
>> +					remote-endpoint = <&ipu1_di0_mipi>;
>> +				};
>> +			};
>> +			port@1 {
>> +				reg = <1>;
>> +				mipi_mux_1: endpoint {
>> +					remote-endpoint = <&ipu1_di1_mipi>;
>> +				};
>> +			};
>> +		};
>> +        };
>> 
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
