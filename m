Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D033FC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3A921582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfLRPY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:24:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34472 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfLRPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:24:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E696C291739
Subject: Re: [PATCH v21 1/2] Documentation: bridge: Add documentation for
 ps8640 DT properties
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        drinkcat@chromium.org, Jitao Shi <jitao.shi@mediatek.com>,
        Ulrich Hecht <uli@fpond.eu>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        matthias.bgg@gmail.com, Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org
References: <20191216135834.27775-1-enric.balletbo@collabora.com>
 <20191216135834.27775-2-enric.balletbo@collabora.com>
 <20191217142821.xitumpvfg52heb4t@gilmour.lan>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <da1f3c1b-30b5-7708-9527-7f210e817a31@collabora.com>
Date:   Wed, 18 Dec 2019 16:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217142821.xitumpvfg52heb4t@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thanks for your comment, just preparing another version.

On 17/12/19 15:28, Maxime Ripard wrote:
> On Mon, Dec 16, 2019 at 02:58:33PM +0100, Enric Balletbo i Serra wrote:
>> From: Jitao Shi <jitao.shi@mediatek.com>
>>
>> Add documentation for DT properties supported by
>> ps8640 DSI-eDP converter.
>>
>> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>> Signed-off-by: Ulrich Hecht <uli@fpond.eu>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v21: None
>> Changes in v19: None
>> Changes in v18: None
>> Changes in v17: None
>> Changes in v16: None
>> Changes in v15: None
>> Changes in v14: None
>> Changes in v13: None
>> Changes in v12: None
>> Changes in v11: None
>>
>>  .../bindings/display/bridge/ps8640.txt        | 44 +++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ps8640.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/ps8640.txt b/Documentation/devicetree/bindings/display/bridge/ps8640.txt
>> new file mode 100644
>> index 000000000000..7b13f92f7359
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/ps8640.txt
>> @@ -0,0 +1,44 @@
>> +ps8640-bridge bindings
>> +
>> +Required properties:
>> +	- compatible: "parade,ps8640"
>> +	- reg: first page address of the bridge.
>> +	- sleep-gpios: OF device-tree gpio specification for PD pin.
>> +	- reset-gpios: OF device-tree gpio specification for reset pin.
>> +	- vdd12-supply: OF device-tree regulator specification for 1.2V power.
>> +	- vdd33-supply: OF device-tree regulator specification for 3.3V power.
>> +	- ports: The device node can contain video interface port nodes per
>> +		 the video-interfaces bind[1]. For port@0,set the reg = <0> as
>> +		 ps8640 dsi in and port@1,set the reg = <1> as ps8640 eDP out.
>> +
>> +Optional properties:
>> +	- mode-sel-gpios: OF device-tree gpio specification for mode-sel pin.
>> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
>> +
>> +Example:
>> +	edp-bridge@18 {
>> +		compatible = "parade,ps8640";
>> +		reg = <0x18>;
>> +		sleep-gpios = <&pio 116 GPIO_ACTIVE_LOW>;
>> +		reset-gpios = <&pio 115 GPIO_ACTIVE_LOW>;
>> +		mode-sel-gpios = <&pio 92 GPIO_ACTIVE_HIGH>;
>> +		vdd12-supply = <&ps8640_fixed_1v2>;
>> +		vdd33-supply = <&mt6397_vgp2_reg>;
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			port@0 {
>> +				reg = <0>;
>> +				ps8640_in: endpoint {
>> +					remote-endpoint = <&dsi0_out>;
>> +				};
>> +			};
>> +			port@1 {
>> +				reg = <1>;
>> +				ps8640_out: endpoint {
>> +					remote-endpoint = <&panel_in>;
>> +				};
>> +			};
>> +		};
>> +	};
> 
> It's not really fair to ask this after the rough history of this
> patchset apparently, but bindings should be submitted in the YAML
> format now.
> 
> This wouldn't be nice to stop it from going in just because of this,
> so can you send a subsequent patch fixing this?
> 

I don't mind to use YAML format for next version, in fact, I think is the best.

Thanks,
 Enric


> Thanks!
> Maxime
> 
