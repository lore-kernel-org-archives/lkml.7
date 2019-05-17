Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177BAC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E742B20645
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfEQN11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 09:27:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:27144 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbfEQN11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 09:27:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 06:27:26 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 17 May 2019 06:27:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 17 May 2019 16:27:21 +0300
Date:   Fri, 17 May 2019 16:27:21 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Biju Das <biju.das@bp.renesas.com>,
        Yu Chen <chenyu56@huawei.com>, Min Guo <min.guo@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [v3 PATCH] dt-binding: usb: add usb-role-switch property
Message-ID: <20190517132721.GB1887@kuha.fi.intel.com>
References: <c3596e996c9ab39c6b9bc14b93309244c4a55014.1557306151.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3596e996c9ab39c6b9bc14b93309244c4a55014.1557306151.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 05:17:44PM +0800, Chunfeng Yun wrote:
> Add a property usb-role-switch to tell the driver that use
> USB Role Switch framework to handle the role switch,
> it's useful when the driver has already supported other ways,
> such as extcon framework etc.
> 
> Cc: Biju Das <biju.das@bp.renesas.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Who is meant to pick this? Can you include this in your series where
you introduce that USB Type-B GPIO connector driver?

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v3:
>     add property type, modify description suggested by Heikki
> 
> v2:
>     describe it in terms of h/w functionality suggested by Rob
> 
> v1:
>     the property is discussed in:
>     [v2,2/7] dt-bindings: usb: renesas_usb3: add usb-role-switch property
>     https://patchwork.kernel.org/patch/10852497/
> 
>     Mediatek and Hisilicon also try to use it:
>     [v4,3/6] dt-bindings: usb: mtu3: add properties about USB Role Switch
>     https://patchwork.kernel.org/patch/10918385/
>     [v4,6/6] usb: mtu3: register a USB Role Switch for dual role mode
>     https://patchwork.kernel.org/patch/10918367/
> 
>     [v6,10/13] usb: dwc3: Registering a role switch in the DRD code
>     https://patchwork.kernel.org/patch/10909981/
> ---
>  Documentation/devicetree/bindings/usb/generic.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> index 0a74ab8dfdc2..cf5a1ad456e6 100644
> --- a/Documentation/devicetree/bindings/usb/generic.txt
> +++ b/Documentation/devicetree/bindings/usb/generic.txt
> @@ -30,6 +30,10 @@ Optional properties:
>  			optional for OTG device.
>   - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
>  			optional for OTG device.
> + - usb-role-switch: boolean, indicates that the device is capable of assigning
> +			the USB data role (USB host or USB device) for a given
> +			USB connector, such as Type-C, Type-B(micro).
> +			see connector/usb-connector.txt.
>  
>  This is an attribute to a USB controller such as:
>  
> -- 
> 2.21.0

thanks,

-- 
heikki
