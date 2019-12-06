Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533A1C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABF824673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="qVvSJYj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLFS6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:58:10 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:51602 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfLFS6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:58:09 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47V1xd4KSvz3c;
        Fri,  6 Dec 2019 19:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1575658536; bh=ezWxskmwxI8C/8lBttgiFOBWumB5XqgQX2Lyv35wtXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVvSJYj9YFwdhcAJDhCbE27sYYMUvgdTONxp+WWKd+z5M7iiAI5MehkQT3K2RazLO
         Fd9fJReH4fmO4JIbPH7vvAG5OF2f+k2n+Ld1c3N3PX5ld+hkdoJQ2IFzQMJIwLVZc3
         677oFRZnpUv7WC+skB2A72eXwr/NiceO2d59iHAuZSWyiZ9j4ZIfNR224I4LEuylT/
         OgQXR2R6mep2NizcYogzTvDzpSM7LavHwjNn8x1geUwhPTgKNZ4p0HkFQKk3rbFUkn
         D2t6f0Opeh7KPGs9oDBi617XDzVFR99l7Pg+gcwf5VVg4jPbwVWPMzXiXjjzcViHtW
         OGnWhmW29zmJQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 6 Dec 2019 19:58:00 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh-dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, mturquette@baylibre.com,
        horms-renesas@verge.net.au, Jisheng.Zhang@synaptics.com,
        krzk@kernel.org, arnd@arndb.de, spujar@nvidia.com,
        josephl@nvidia.com, vidyas@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alexios.zavras@intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 01/15] dt-bindings: soc: tegra-pmc: Add Tegra PMC
 clock bindings
Message-ID: <20191206185800.GB20259@qmqm.qmqm.pl>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1575600535-26877-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 06:48:41PM -0800, Sowjanya Komatineni wrote:
> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 clocks and each of
> these clocks has mux and a gate as a part of PMC controller.
[...]
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
[...]
> +Clock consumer example:
> +	host1x@50000000 {
> +		...
> +		vi@54080000 {
> +			...
> +			assigned-clocks = <&pmc TEGRA_PMC_CLK_OUT_3_MUX>;
> +			assigned-clock-parents = <&tegra_car TEGRA210_CLK_EXTERN3>;
> +		};
> +		...
> +	};
> +	...
> +	i2c@7000c500 {
> +		cam_sensor {
> +			...
> +			clocks = <&pmc TEGRA_PMC_CLK_OUT_3>;
> +			clock-names = "mclk";
> +			...
> +		};
> +	};

The assigned-clocks should be in the cam_sensor node, unless vi device
also uses the clock.

Best Regards,
Micha³ Miros³aw
