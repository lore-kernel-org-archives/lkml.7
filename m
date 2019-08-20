Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D69C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BEB2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566320387;
	bh=L7h/XqDISyn5yvXuXcHP6xKVJUvZ9mGZbH2dVM9Kvlk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x1bPqkHoYEpimiPrrLMRSGSSmkDKnWL6Gi7URJ0ddlYsodpqBQCIDmYXR7BKb47c0
	 BlzU/EY5y8fGmBpQsdWhnbJ3Ca6KKAz4vYQCh7OvJbHtj/HqGPDUNhMN77Sv4JEMEz
	 FYjc25we6zmbVHflxhbY8rq4OVR51+CDZMVQZ6RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfHTQ7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfHTQ7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:59:45 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F8A22CE3;
        Tue, 20 Aug 2019 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566320384;
        bh=L7h/XqDISyn5yvXuXcHP6xKVJUvZ9mGZbH2dVM9Kvlk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PiO5eRHnS1A+gmOTGiQevuK6aC0wGaeU58KOfQFnrX+U14IR8LbZyu8AYtvn3W88e
         Z30kxZ9I7AJw9JOfwOiy1M5sF1lhgl5wF6mjJAq5tFnzxTl7SWO8FkoykrrOql608f
         vFC31S2IDYAwRNwkZsiToMNayGzudHQk/3hGPwlM=
Received: by mail-qt1-f169.google.com with SMTP id q4so6846552qtp.1;
        Tue, 20 Aug 2019 09:59:44 -0700 (PDT)
X-Gm-Message-State: APjAAAUGZFBqYCaC5g6zkWYgc2ZFDgBVvljqyGaLocXHQmXBNm+L3STy
        jwIRzVQ78FRfeFLoISlh7ZB2Zp+zr32GRBJ6OQ==
X-Google-Smtp-Source: APXvYqwnHzjzAYM1xrZcnV9c1IC181pdYRyQzGboJkXby4DXCfCxM8cRlMfws27ylf+AmUmWlPw2ALiMRnzjFRwdcns=
X-Received: by 2002:ac8:386f:: with SMTP id r44mr27739887qtb.300.1566320383501;
 Tue, 20 Aug 2019 09:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <1566315318-30320-1-git-send-email-krzk@kernel.org> <1566315318-30320-3-git-send-email-krzk@kernel.org>
In-Reply-To: <1566315318-30320-3-git-send-email-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Aug 2019 11:59:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJLSZ50tdFcdPFc2ifcDoFZFuw=SoKsunzjtAhZ-11fBg@mail.gmail.com>
Message-ID: <CAL_JsqJLSZ50tdFcdPFc2ifcDoFZFuw=SoKsunzjtAhZ-11fBg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] dt-bindings: arm: fsl: Add Kontron i.MX6UL N6310 compatibles
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:35 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Add the compatibles for Kontron i.MX6UL N6310 SoM and boards.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v5:
> New patch
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 7294ac36f4c0..d07b3c06d7cf 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -161,6 +161,9 @@ properties:
>          items:
>            - enum:
>                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> +              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
> +              - kontron,imx6ul-n6310-s    # Kontron N6310 S Board
> +              - kontron,imx6ul-n6310-s-43 # Kontron N6310 S 43 Board

This doesn't match what is in your dts files. Run 'make dtbs_check' and see.

>            - const: fsl,imx6ul
>
>        - description: i.MX6ULL based Boards
> --
> 2.7.4
>
