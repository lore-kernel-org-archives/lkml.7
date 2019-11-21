Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F36FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D318A206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574378230;
	bh=2TdgKys+18eBd0yx06PVsa4uvvycUVEGoBi7ZYvSVgQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ELzApsVTLKMG2+pXaTfPUx8P89X1qmTFjhIwEsqGTxBLPNmfV4TB6MSnRHxYTzPuT
	 jkMOscuhFtN9muxykCjZkO/L01jEmIloGdGA8ukSkQOep6sDykhqBeRnISTFfcadKJ
	 dzID+zRD0kqapnjk+Pe8msr1OMTBhGLhc5wco46M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKUXRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfKUXRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:17:09 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00D78206F4;
        Thu, 21 Nov 2019 23:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574378229;
        bh=2TdgKys+18eBd0yx06PVsa4uvvycUVEGoBi7ZYvSVgQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xxXmsSIpUd9vMfsf/PRW9c0fS+N73Cy/1BSDaa0e0wufLlKoXUjkmtum6HxSy0MhI
         YerGBMWPuXTMD98TSjmsb1z+HlGRl0OKcEKK94rRfrT/6J5v0AtSLywQpRF0I+Tlhw
         8psvKeN2y5gcDrGZTA+qk308BmPyDATMI+ZN45OE=
Received: by mail-qk1-f169.google.com with SMTP id i19so4716520qki.2;
        Thu, 21 Nov 2019 15:17:08 -0800 (PST)
X-Gm-Message-State: APjAAAUsUwHjJDPGnxyeoWUdnDNLBqG8P0Sb4G15mESHGpY9+IB1VzFU
        6lj3MWIanXBCsd041V4+JU8ngNifVaDYShi5zw==
X-Google-Smtp-Source: APXvYqzdCnSu2pZqQVq5MbhOL/7Hy1JyTSLPkq53mY0rE1lgCOTMJNSU+hlwHHmM1PcgWTaymDDIZ1TCNyBYPqI8OKU=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr5153029qkn.254.1574378228095;
 Thu, 21 Nov 2019 15:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20191121190124.1936-1-jdk@ti.com>
In-Reply-To: <20191121190124.1936-1-jdk@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 21 Nov 2019 17:16:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJhWj1RoT9LWe5-gA91aAkCYrJ6S6vm1DEkqwx56WNEGQ@mail.gmail.com>
Message-ID: <CAL_JsqJhWj1RoT9LWe5-gA91aAkCYrJ6S6vm1DEkqwx56WNEGQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add vendor prefix for BeagleBoard.org
To:     Jason Kridner <jkridner@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jason Kridner <jdk@ti.com>, Jyri Sarha <jsarha@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 1:02 PM Jason Kridner <jkridner@gmail.com> wrote:
>
> Add vendor prefix for BeagleBoard.org Foundation
>
> Signed-off-by: Jason Kridner <jdk@ti.com>

Author and Sob emails don't match.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 967e78c5ec0a..3e3d8e3c28d3 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -139,6 +139,8 @@ patternProperties:
>      description: Shenzhen AZW Technology Co., Ltd.
>    "^bananapi,.*":
>      description: BIPAI KEJI LIMITED
> +  "^beagleboard.org,.*":

'.' would need need to be escaped as this is a regex.

The '.' may cause some problems with schemas. We can adapt or just
drop the '.org'.

> +    description: BeagleBoard.org Foundation
>    "^bhf,.*":
>      description: Beckhoff Automation GmbH & Co. KG
>    "^bitmain,.*":
> --
> 2.17.1
>
