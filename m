Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795F7C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B8B2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgAIO0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:26:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgAIO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:26:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5E0F22934FF
Subject: Re: [PATCH 1/2] dt-bindings: arm64: dts: mediatek: Add mt8173 elm and
 hana
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
References: <20200109101042.201500-1-hsinyi@chromium.org>
 <20200109101042.201500-2-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <46ccc713-5951-62ee-1909-f572772217c2@collabora.com>
Date:   Thu, 9 Jan 2020 15:26:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200109101042.201500-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thanks for sending this patch upstream, one comment below ...

On 9/1/20 11:10, Hsin-Yi Wang wrote:
> Elm is Acer Chromebook R13. Hana is Lenovo Chromebook. Both uses mt8173
> SoC.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  .../devicetree/bindings/arm/mediatek.yaml      | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 4043c5046441..a27b22f264a2 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -86,6 +86,24 @@ properties:
>            - const: mediatek,mt8135
>        - items:
>            - enum:
> +              - google,elm
> +              - google,elm-rev1
> +              - google,elm-rev2
> +              - google,elm-rev3
> +              - google,elm-rev4
> +              - google,elm-rev5
> +              - google,elm-rev6
> +              - google,elm-rev7
> +              - google,elm-rev8

Did you run dtbs_check [1] after having patch 2 applied? I think that will
trigger some errors. I am not sure if this should be a const instead of an enum
like we have in rockchip.yaml?

[1] make ARCH=arm64
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/mediatek.yaml dtbs_check

Thanks,
 Enric

> +              - google,hana
> +              - google,hana-rev0
> +              - google,hana-rev1
> +              - google,hana-rev2
> +              - google,hana-rev3
> +              - google,hana-rev4
> +              - google,hana-rev5
> +              - google,hana-rev6
> +              - google,hana-rev7
>                - mediatek,mt8173-evb
>            - const: mediatek,mt8173
>        - items:
> 
