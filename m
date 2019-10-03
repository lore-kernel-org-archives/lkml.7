Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D744EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCFE2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfJCNEP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:04:15 -0400
Received: from hermes.aosc.io ([199.195.250.187]:58025 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730251AbfJCNEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:04:14 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 6FBCB8236F;
        Thu,  3 Oct 2019 13:04:12 +0000 (UTC)
Date:   Thu, 03 Oct 2019 21:04:03 +0800
In-Reply-To: <20191003114733.56mlar666l76uoyb@gilmour>
References: <20191003064527.15128-1-jagan@amarulasolutions.com> <20191003064527.15128-5-jagan@amarulasolutions.com> <20191003114733.56mlar666l76uoyb@gilmour>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v11 4/7] dt-bindings: sun6i-dsi: Add VCC-DSI supply property
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
CC:     devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        michael@amarulasolutions.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <0086CD40-F161-4B33-8D76-8DCA20E7DB07@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年10月3日 GMT+08:00 下午7:47:33, Maxime Ripard <mripard@kernel.org> 写到:
>On Thu, Oct 03, 2019 at 12:15:24PM +0530, Jagan Teki wrote:
>> Allwinner MIPI DSI controllers are supplied with SoC DSI
>> power rails via VCC-DSI pin.
>>
>> Some board still work without supplying this but give more
>> faith on datasheet and hardware schematics and document this
>> supply property in required property list.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>  .../bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml         | 3
>+++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git
>a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
>b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
>> index 47950fced28d..9d4c25b104f6 100644
>> ---
>a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
>> +++
>b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
>> @@ -36,6 +36,9 @@ properties:
>>    resets:
>>      maxItems: 1
>>
>> +  vcc-dsi-supply:
>> +    description: VCC-DSI power supply of the DSI encoder
>> +
>
>The driver treats it as mandatory, so I've added it to the binding, as
>suggested by the commit log.

No. The regulator_get function will return dummy regulator, rather than
fail, if the regulator is not specified.

>
>Maxime

-- 
使用 K-9 Mail 发送自我的Android设备。
