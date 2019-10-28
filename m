Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF5BCA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17258214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572262732;
	bh=Hqz4uOmBIFtpJSTeQy8WTtrFrjLsh09wtHM25ONUe+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dz6VRUrwXkT5X+e4oRm6HMJ8xunQPsYDxagufF0aqSm45S0bG1Q634ejx6iH/vhWy
	 OHiucOcJMo069XZNh20KrAS4MoV3ReFjb96tELGgZasDGGE16LuKjU2MKL4BwbwkUE
	 RSzj55h6J0S1N1rZO2uoL3bJkebY7wsXOoYbVSw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbfJ1Liu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388533AbfJ1Liu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:38:50 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C8FE20873;
        Mon, 28 Oct 2019 11:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572262729;
        bh=Hqz4uOmBIFtpJSTeQy8WTtrFrjLsh09wtHM25ONUe+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwLWo5fe4kUMcYg+Ta/IsuIKstxfMaQZYYcR53MbQJT1nXSKCU1mPotJ6hJkj2Wc5
         Cf3kpBh+845CUXBwApN4cVhNU5W9dSycuXd+tbJW9yxQbaHLjBUankjoNBdHfWCfYq
         6sY3LIKmV01P7yF3R+jQ5pGeYbLCdmGpDK9Eki1w=
Date:   Mon, 28 Oct 2019 19:38:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oliver Graute <oliver.graute@kococonnector.com>
Cc:     "oliver.graute@gmail.com" <oliver.graute@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: arm: fsl: Document Variscite i.MX6q
 devicetree
Message-ID: <20191028113826.GD16985@dragon>
References: <20191024092019.4020-1-oliver.graute@kococonnector.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024092019.4020-1-oliver.graute@kococonnector.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 09:22:37AM +0000, Oliver Graute wrote:
> Document the Variscite i.MX6qdl board devicetree binding
> already supported:
> 
> - variscite,dt6customboard
> 
> Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>

Please organise it into the patch series, where it's being used.

Shawn

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 41db01d77c23..f0ddebfcf1a1 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -121,6 +121,7 @@ properties:
>                - fsl,imx6q-sabresd
>                - technologic,imx6q-ts4900
>                - technologic,imx6q-ts7970
> +              - variscite,dt6customboard
>            - const: fsl,imx6q
>  
>        - description: i.MX6QP based Boards
> -- 
> 2.17.1
> 
