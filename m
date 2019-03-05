Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5106C20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551785770;
	bh=XFUes7GdOksQM4mA+OSH4FC7XXt5+0KgBMovc5w26Vs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PULiweEEKWBxKShsOcLQdmZk5sB4WwTVAAp0JfHPM+yMmgNVIXT58ZGxmpA2+1BqM
	 SVf5IqfdTIQ+XoXO9jsEHqZswRK5EvSXzxkzP7piE52HjLpnwRAhF/4PR+3HyXn2w5
	 +KlQTaVgrvzuSVfgwhYKA9upJ4Umo9UvZjEbsiJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfCELgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:36:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfCELgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:36:08 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6654D2087C;
        Tue,  5 Mar 2019 11:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551785766;
        bh=XFUes7GdOksQM4mA+OSH4FC7XXt5+0KgBMovc5w26Vs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rvRzBScn51P+UO8qfFGkJ/HTANQTddrk/YOmlMQ+EJdl2zJ6yCj+F44ZXZ2WVV5Nu
         xo3eUKK+KaMEsioc+xD2+ZWvDn6W+tnBTiD3a3WfNntqq8gaQ9Z4rGqSuDAEtQA/BV
         SNP3mRPy5N9PZB5JZE/3/Yb0DemK2u0lD015dLNM=
Received: by mail-lj1-f175.google.com with SMTP id g80so7293570ljg.6;
        Tue, 05 Mar 2019 03:36:06 -0800 (PST)
X-Gm-Message-State: APjAAAU4RMsjbNeRX8yRaf6yASYSsCH00flqjpkUZ3o9MrrbpNkAEImI
        DonSFD/qXIt/F1wKf4gl4pulribNQjDRSPdV7hE=
X-Google-Smtp-Source: APXvYqwGosdS+RYN6DWUWjvMuoJ5XMkSgJDEYM1Led7cpHQ2W/u3KebTogM3O5sGVQ9zPIHcjQFmgveYvlwDBTwjXds=
X-Received: by 2002:a2e:2c3:: with SMTP id y64mr13712590lje.131.1551785764433;
 Tue, 05 Mar 2019 03:36:04 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb@eucas1p2.samsung.com>
 <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com> <1551781151-5562-5-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1551781151-5562-5-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 5 Mar 2019 12:35:53 +0100
X-Gmail-Original-Message-ID: <CAJKOXPchn1nFH2FvvCTKoEen2+9EgTfHKbmzEfgKFxGmKGH8Pw@mail.gmail.com>
Message-ID: <CAJKOXPchn1nFH2FvvCTKoEen2+9EgTfHKbmzEfgKFxGmKGH8Pw@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] dt-bindings: devfreq: add Exynos5422 DMC device description
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 at 11:19, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> The patch adds description for DT binding for a new Exynos5422 Dynamic
> Memory Controller device.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/devfreq/exynos5422-dmc.txt | 177 +++++++++++++++++++++
>  1 file changed, 177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
> new file mode 100644
> index 0000000..0e73e98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
> @@ -0,0 +1,177 @@
> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
> +
> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
> +memory chips are connected. The driver is to monitor the controller in runtime
> +and switch frequency and voltage. To monitor the usage of the controller in
> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
> +is able to measure the current load of the memory.
> +When 'userspace' governor is used for the driver, an application is able to
> +switch the DMC frequency.
> +
> +Required properties for DMC device for Exynos5422:
> +- compatible: Should be "samsung,exynos5422-bus".
> +- clock-names : the name of clock used by the bus, "bus".
> +- clocks : phandles for clock specified in "clock-names" property.
> +- devfreq-events : phandles for PPMU devices connected to this DMC.
> +
> +The example definition of a DMC and PPMU devices declared in DT is shown below:
> +
> +       ppmu_dmc0_0: ppmu@10d00000 {
> +               compatible = "samsung,exynos-ppmu";
> +               reg = <0x10d00000 0x2000>;
> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +               clock-names = "ppmu";
> +               status = "okay";
> +               events {
> +                       ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +                               event-name = "ppmu-event3-dmc0_0";
> +                       };
> +               };
> +       };
> +
> +
> +       ppmu_dmc0_1: ppmu@10d10000 {
> +               compatible = "samsung,exynos-ppmu";
> +               reg = <0x10d10000 0x2000>;
> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
> +               clock-names = "ppmu";
> +               status = "okay";
> +               events {
> +                       ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
> +                               event-name = "ppmu-event3-dmc0_1";
> +                       };
> +               };
> +       };
> +
> +       ppmu_dmc1_0: ppmu@10d10000 {
> +               compatible = "samsung,exynos-ppmu";
> +               reg = <0x10d60000 0x2000>;
> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
> +               clock-names = "ppmu";
> +               status = "okay";
> +               events {
> +                       ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
> +                               event-name = "ppmu-event3-dmc1_0";
> +                       };
> +               };
> +       };
> +
> +       ppmu_dmc1_1: ppmu@10d70000 {
> +               compatible = "samsung,exynos-ppmu";
> +               reg = <0x10d70000 0x2000>;
> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
> +               clock-names = "ppmu";
> +               status = "okay";
> +               events {
> +                       ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
> +                               event-name = "ppmu-event3-dmc1_1";
> +                       };
> +               };
> +       };
> +
> +       dmc: memory-controller@10c20000 {
> +               compatible = "samsung,exynos5422-dmc";
> +               reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +                       <0x10000000 0x1000>;
> +               clocks =        <&clock CLK_FOUT_SPLL>,
> +                               <&clock CLK_MOUT_SCLK_SPLL>,
> +                               <&clock CLK_FF_DOUT_SPLL2>,
> +                               <&clock CLK_FOUT_BPLL>,
> +                               <&clock CLK_MOUT_BPLL>,
> +                               <&clock CLK_SCLK_BPLL>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                               <&clock CLK_MOUT_MCLK_CDREX>,
> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
> +                               <&clock CLK_CLKM_PHY0>,
> +                               <&clock CLK_CLKM_PHY1>,
> +                               <&clock CLK_CDREX_PAUSE>,
> +                               <&clock CLK_CDREX_TIMING_SET>;
> +               clock-names =   "fout_spll",
> +                               "mout_sclk_spll",
> +                               "ff_dout_spll2",
> +                               "fout_bpll",
> +                               "mout_bpll",
> +                               "sclk_bpll",
> +                               "mout_mx_mspll_ccore",
> +                               "mout_mx_mspll_ccore_phy",
> +                               "mout_mclk_cdrex",
> +                               "dout_clk2x_phy0",
> +                               "clkm_phy0",
> +                               "clkm_phy1",
> +                               "clk_cdrex_pause",
> +                               "clk_cdrex_timing_set";
> +               status = "okay";
> +               operating-points-v2 = <&dmc_opp_table>;
> +               devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
> +                               <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
> +       };
> +
> +The needed timings of DRAM memory are stored in dedicated nodes.
> +There are two nodes with regular timings and for bypass mode.
> +
> +       dmc_bypass_mode: bypass_mode {
> +               compatible = "samsung,dmc-bypass-mode";

This looks like an example, not bindings.

> +
> +               freq-hz = <400000000>;
> +               volt-uv = <887500>;

-microvolt
Documentation/devicetree/bindings/property-units.txt

> +               dram-timing-row = <0x365a9713>;
> +               dram-timing-data = <0x4740085e>;
> +               dram-timing-power = <0x543a0446>;
> +       };
> +
> +       dram_timing: timing {
> +               compatible = "samsung,dram-timing";

Probably you should use timings from Documentation/devicetree/bindings/lpddr2/
If not, all the fields below should be described.

All these bindings (memory-controller, timings) look like description
of memory controller so maybe they should go into
Documentation/devicetree/bindings/memory-controllers ?

Best regards,
Krzysztof

> +
> +               dram-timing-names = "165MHz", "206MHz", "275MHz", "413MHz",
> +                                   "543MHz", "633MHz", "728MHz", "825MHz";
> +               dram-timing-row = <0x11223185>, <0x112331C6>, <0x12244287>,
> +                                 <0x1B35538A>, <0x244764CD>, <0x2A48758F>,
> +                                 <0x30598651>, <0x365A9713>;
> +               dram-timing-data = <0x2720085E>, <0x2720085E>, <0x2720085E>,
> +                                  <0x2720085E>, <0x3730085E>, <0x3730085E>,
> +                                  <0x3730085E>, <0x4740085E>;
> +               dram-timing-power = <0x140C0225>, <0x180F0225>, <0x1C140225>,
> +                                   <0x2C1D0225>, <0x38270335>, <0x402D0335>,
> +                                   <0x4C330336>, <0x543A0446>;
> +       };
> +
> +The frequencies supported by the DMC are stored in OPP table v2.
> +
> +       dmc_opp_table: opp_table2 {
> +               compatible = "operating-points-v2";
> +
> +               opp00 {
> +                       opp-hz = /bits/ 64 <165000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp01 {
> +                       opp-hz = /bits/ 64 <206000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp02 {
> +                       opp-hz = /bits/ 64 <275000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp03 {
> +                       opp-hz = /bits/ 64 <413000000>;
> +                       opp-microvolt = <887500>;
> +               };
> +               opp04 {
> +                       opp-hz = /bits/ 64 <543000000>;
> +                       opp-microvolt = <937500>;
> +               };
> +               opp05 {
> +                       opp-hz = /bits/ 64 <633000000>;
> +                       opp-microvolt = <1012500>;
> +               };
> +               opp06 {
> +                       opp-hz = /bits/ 64 <728000000>;
> +                       opp-microvolt = <1037500>;
> +               };
> +               opp07 {
> +                       opp-hz = /bits/ 64 <825000000>;
> +                       opp-microvolt = <1050000>;
> +               };
> +       };
> +
> --
> 2.7.4
>
