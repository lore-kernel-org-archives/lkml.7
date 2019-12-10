Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E4C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EEB2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfLJJfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:35:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45123 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJJfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:35:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so15312850edw.12;
        Tue, 10 Dec 2019 01:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RH04wiz8V0hoWb27QqHxPfCqkEIpOrBir1lGd6+fDNE=;
        b=gVY6hL3XypPkha7PPySWJgkzw9sAdFnc9SW1MVnW/6Xwxuw05OdlIB99KPhXOdVuqZ
         oKc06kLKgK8sY6J6+duaMncGw9Oaa5hFSawfAzLEzLxhcr2XfFgtRsOihBpAbr0XiWTL
         4Ipbs34yuXtLEp4oSGmyGBXWxa4upDTldFT+DuCUuDw0OT4B6CdzsEukM/8xk/5v52hO
         95nth3bEgpgrup1/zcD87cB9hcI63wgkGHXTFw4/LIqyPE83AVrBErq05r0okPg6V0VJ
         NLAQ3IJnVcv9nLHos+gyuPNmm6IJU14VWgzXsYQoVlYifCTFPUnCPF1obCvfHjRAQMN9
         rcww==
X-Gm-Message-State: APjAAAXZQpOyBIEFcbGYQM9m5rGFfMpBOlMUT5JRpuVM88OxEjpGJlWC
        2Vp/vcYHv+wbjEaeQQ7nt8u6IFPqyIU=
X-Google-Smtp-Source: APXvYqxMRJVqjS4o3qMfvwDZbXmQF76c+1zMxROF9jGogr0svmYRcUYb8epZMA4dAtOdTLpzEas6ww==
X-Received: by 2002:a05:6402:3187:: with SMTP id di7mr36723656edb.207.1575970503028;
        Tue, 10 Dec 2019 01:35:03 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id w12sm56612eds.85.2019.12.10.01.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:35:02 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id g17so19215873wro.2;
        Tue, 10 Dec 2019 01:35:02 -0800 (PST)
X-Received: by 2002:adf:81e3:: with SMTP id 90mr2041259wra.23.1575970502213;
 Tue, 10 Dec 2019 01:35:02 -0800 (PST)
MIME-Version: 1.0
References: <1575970087-11667-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1575970087-11667-1-git-send-email-clabbe@baylibre.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Dec 2019 17:34:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v66x0CLPBj_BJv0QzKXi-p61dqcKSjCrT=XO-vkEXR1YFw@mail.gmail.com>
Message-ID: <CAGb2v66x0CLPBj_BJv0QzKXi-p61dqcKSjCrT=XO-vkEXR1YFw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: allwinner: restore hdmi_con_in node
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        aleksandr.aleksandrov@emlid.com,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 5:28 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> Compiling today next (20191210) fail to build with
> arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts:53.25-55.4: ERROR (phandle_references): /soc/hdmi@1ee0000/ports/port@1/endpoint: Reference to non-existent node or label "hdmi_con_in"


Patch subject should read:

arm64: dts: allwinner: h5: emlid-neutis-n5-devboard: Restore hdmi_in_con node

ChenYu

> This patch fixes the build by restoring this node.
>
> Fixes: b120a822ef10 ("ARM: dts: allwinner: Split out non-SoC specific parts of Neutis N5")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts  | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
> index fb96d356055e..d6cc6592cfa3 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
> @@ -15,6 +15,17 @@
>                      "emlid,neutis-n5",
>                      "allwinner,sun50i-h5";
>
> +       connector {
> +               compatible = "hdmi-connector";
> +               type = "a";
> +
> +               port {
> +                       hdmi_con_in: endpoint {
> +                               remote-endpoint = <&hdmi_out_con>;
> +                       };
> +               };
> +       };
> +
>         vdd_cpux: gpio-regulator {
>                 compatible = "regulator-gpio";
>                 regulator-name = "vdd-cpux";
> --
> 2.23.0
>
