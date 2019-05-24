Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B44C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC2621848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404393AbfEXWcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 18:32:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35339 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfEXWcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 18:32:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id n14so10107588otk.2;
        Fri, 24 May 2019 15:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVeRAKhCRQ02qZS9WMOT7P0FRvYl1V3YDTvinSJEfGc=;
        b=QYpqU2LNG33XuZDh3KHkAfGzoCU/ce312YNG6R47+HxEGgFE6YIqczhQMpd9nVW0bl
         eAuRS4PQCOBBOpeYNlANAe07HhRYm1zJ0o4FM/1Qij62+RuH0neM/MFIJhLn8EKg6kIe
         QNZWkY1pgQVEfOm78tYhG9G6j5ywqvDmgXAYBhTFN3B/VfNWYgnryE/vRpMPCAPt8lAI
         BgTNxs2y0+lxPBqQWqgURABMGwTsD33VeSye41HXENiqbw5Ev9uoGVAOCc1JZEw/IMpr
         ltWAHVT3xuuTa1/CTGj72Mg0DHH1jd4FgGQTHxqGXjVRLZTlH3hUX8m0TuO3ykkHoZEP
         Kacw==
X-Gm-Message-State: APjAAAVtxusubqHky5JcFupYUIBykA4giTFDuOIndTN8fXDCgF9iZRnl
        bc7ruIuPjhLKOOZQMSuwbeiLltUtpyg=
X-Google-Smtp-Source: APXvYqygcOrEBg6geV/M3/I/lozE/24T1Vv3zX1xouapOwgVnoX3RrTYQbQ+5plBUTkonD0gey6l5g==
X-Received: by 2002:a9d:6e17:: with SMTP id e23mr35208419otr.258.1558737129778;
        Fri, 24 May 2019 15:32:09 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id v134sm1403132oie.54.2019.05.24.15.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 15:32:09 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 203so8129437oid.13;
        Fri, 24 May 2019 15:32:08 -0700 (PDT)
X-Received: by 2002:aca:5f07:: with SMTP id t7mr2665286oib.175.1558737128772;
 Fri, 24 May 2019 15:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190524012151.31840-1-andy.tang@nxp.com>
In-Reply-To: <20190524012151.31840-1-andy.tang@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 24 May 2019 17:31:57 -0500
X-Gmail-Original-Message-ID: <CADRPPNRYwq0NABXobC1jQrT3QMxxm+e6zvoNwoZ-fu6NU9qDMA@mail.gmail.com>
Message-ID: <CADRPPNRYwq0NABXobC1jQrT3QMxxm+e6zvoNwoZ-fu6NU9qDMA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: Add temperature sensor node
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 8:30 PM Yuantian Tang <andy.tang@nxp.com> wrote:
>
> Add nxp sa56004 chip node for temperature monitor.
>
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 5 +++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index b359068d9605..31fd626dd344 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -131,6 +131,11 @@
>                                 compatible = "atmel,24c512";
>                                 reg = <0x57>;
>                         };
> +
> +                       temp@4c {

The recommended name for temperature senor in dts spec is temperature-sensor.

> +                               compatible = "nxp,sa56004";

The binding says the following property is required.  If it is not the
case, probably we should update the binding.
- vcc-supply: vcc regulator for the supply voltage.

> +                               reg = <0x4c>;
> +                       };
>                 };
>
>                 i2c@5 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index f9c272fb0738..012b3f8696b7 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -119,6 +119,11 @@
>                                 compatible = "nxp,pcf2129";
>                                 reg = <0x51>;
>                         };
> +
> +                       temp@4c {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4c>;
> +                       };
>                 };
>         };
>  };
> --
> 2.17.1
>
