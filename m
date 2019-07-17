Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930B0C76188
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C09F2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfGQDXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 23:23:07 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:46014 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726069AbfGQDXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 23:23:07 -0400
X-UUID: 43c241652bea41cb955581edb6965474-20190717
X-UUID: 43c241652bea41cb955581edb6965474-20190717
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 89910540; Wed, 17 Jul 2019 11:23:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Jul 2019 11:22:59 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Jul 2019 11:22:58 +0800
Message-ID: <1563333778.29169.5.camel@mtksdaap41>
Subject: Re: [PATCH v4, 01/33] dt-bindings: mediatek: add binding for mt8183
 display
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 17 Jul 2019 11:22:58 +0800
In-Reply-To: <1562625253-29254-2-git-send-email-yongqiang.niu@mediatek.com>
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
         <1562625253-29254-2-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: B08C90B4972A6A74DF94ECDCEBA3A927F8F9ECC3D464E9044F2A116F6D54F9162000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Tue, 2019-07-09 at 06:33 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Update device tree binding documention for the display subsystem for
> Mediatek MT8183 SOCs
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,display.txt  | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,display.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,display.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,display.txt
> new file mode 100644
> index 0000000..951d2a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,display.txt
> @@ -0,0 +1,21 @@
> +Mediatek Display Device
> +============================
> +
> +The Mediatek Display Device provides power control to the system.
> +
> +Required Properties:
> +
> +- compatible: Should be one of:
> +	- "mediatek,mt8183-display"

I think this is "mediatek,mt8183-mmsys". In [1], Matthias has agreed
that we could keep work on his patch, so you should apply his patch and
remove this patch. In [2], I've found that MT8183 scpsys has some
problem with Matthias' patch, so please also fix this problem.

[1] https://patchwork.kernel.org/patch/10686327/
[2] https://patchwork.kernel.org/patch/11005731/

Regards,
CK

> +
> +The Display Device power name are defined in
> +include\dt-bindings\power\mt*-power.h
> +
> +
> +Example:
> +
> +display_components: dispsys@14000000 {
> +	compatible = "mediatek,mt8183-display";
> +	reg = <0 0x14000000 0 0x1000>;
> +	power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +};
> \ No newline at end of file


