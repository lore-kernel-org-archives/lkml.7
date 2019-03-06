Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6450C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD3D20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RLwKdj1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfCFHYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:24:14 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53353 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfCFHYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:24:13 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190306072410euoutp01d160f1ff6bd18cd867e5a726b05081b4~JTcPTmPTF2075020750euoutp01j
        for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2019 07:24:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190306072410euoutp01d160f1ff6bd18cd867e5a726b05081b4~JTcPTmPTF2075020750euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551857050;
        bh=I9IfR1Siq/KS12bBRHj4R83WF0Ch3hXt0C29so/9/tg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RLwKdj1c4a9The0GHC0gz9roxO7f/UIpTiClRWDws8xDCVpd9OmInAxFK5gk6Dt8C
         h8Lh9iLKW8vVvk3azMLD55P+ckMCQ8+vtCs8Egfuc/VI9rQImufQ7Kk8DuzRRdyuyS
         r0xWsGjtSC1hFN3ocGt7OyKIQZ3Zozxtd4ZpgMKs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190306072409eucas1p20a3e5c3076b794d7591f20738b8753bf~JTcOeVy6d3078630786eucas1p2l;
        Wed,  6 Mar 2019 07:24:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 17.BB.04806.8957F7C5; Wed,  6
        Mar 2019 07:24:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190306072408eucas1p224c24f990fb5d78526996d49eccf3568~JTcNu903P3089530895eucas1p2x;
        Wed,  6 Mar 2019 07:24:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190306072408eusmtrp11987dd43431222f858f413b1b6093fcb~JTcNfpInW3040930409eusmtrp1d;
        Wed,  6 Mar 2019 07:24:08 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-ac-5c7f7598b007
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 71.CA.04128.8957F7C5; Wed,  6
        Mar 2019 07:24:08 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190306072407eusmtip164aa84b4a9b0885eddaa34e282526728~JTcM2DY6A2036420364eusmtip1D;
        Wed,  6 Mar 2019 07:24:07 +0000 (GMT)
Subject: Re: [PATCH v5 6/8] DT: arm: exynos: add DMC device for exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <2090ee57-bb23-6de7-12ef-1f55ed176831@partner.samsung.com>
Date:   Wed, 6 Mar 2019 08:24:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdXQuGotKONE4GR8AZr1gMZHM3dgAu-TSKSDqVeYw5zWw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7ozSutjDCatsLDYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JYe+Quu8XtxhVsFofftLM6
        8HhsWtXJ5tG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZt/5WFJzyqli8+AdTA+NE9S5GDg4J
        AROJdTcKuhi5OIQEVjBKrJz9khnC+cIo8e3XbkYI5zOjxJUbF1m7GDnBOj7sfsICkVjOKLFx
        yx6oqrdAVbsmM4FUCQt4SbSeOsIGYosIaEpc//udFaSIWWAds8TUSTcZQZazCehJ7FhVCFLD
        K+Am8f7dCbANLAIqEn+3HGYEsUUFIiQO975jhKgRlDg5E2QzJwenQKDEzOWzweYzC4hL3Hoy
        nwnClpfY/nYO2A8SAufYJZad+8gK8aiLRP9kf4gPhCVeHd/CDmHLSJye3MMCYRdLnO1YxQZh
        10i0n9wBVWMtcfj4RbAxzEC/rN+lDxF2lPjXupEdYjqfxI23ghAX8ElM2jadGSLMK9HRJgRR
        rSGxpecCE4QtJrF8zTT2CYxKs5D8NQvJL7OQ/DILYe8CRpZVjOKppcW56anFxnmp5XrFibnF
        pXnpesn5uZsYganp9L/jX3cw7vuTdIhRgINRiYd3QmtdjBBrYllxZe4hRgkOZiURXs+s+hgh
        3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjPNDthw0y9uR
        NMuayWOq/7kL8zK/tmzfs08xY3+8pr35RpnmmxMYo5Rz2D/s3l8ZfHV6771vzRdKjzN7pUiU
        Bj8VEPYvq7vJPElihfTb43MfLwmqC9cXnpBwj+fc4Z+6EfdOPGKQu2Dt8Csz1svz0juvHaVh
        5YkXThztexhxdA6zyi+FnYZCe5RYijMSDbWYi4oTAYfvwwhJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7ozSutjDH41M1tsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVmsPXKX3eJ24wo2i8Nv2lkd
        eDw2repk8+jbsorR4/MmuQDmKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MW38rCk55VSxe/IOpgXGiehcjJ4eEgInEh91PWLoYuTiEBJYySiz6
        tZEJIiEmMWnfdnYIW1jiz7UuNoii14wSr9uughUJC3hJtJ46wgZiiwhoSlz/+50VpIhZYAOz
        xLZFt6HGLmGSuDV3FXMXIwcHm4CexI5VhSANvAJuEu/fnWAFsVkEVCT+bjnMCGKLCkRIfHy6
        jwmiRlDi5EyQ8zg5OAUCJWYunw22jFnATGLe5ofMELa4xK0n85kgbHmJ7W/nME9gFJqFpH0W
        kpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAmtx37uWUHY9e74EOMAhyM
        Sjy8E1rrYoRYE8uKK3MPMUpwMCuJ8Hpm1ccI8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4w
        XeSVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamDcrrORb82ElN5F
        XlUTpzSuPr5k7Q+LuAwZtuROfq2LNUu0+n8+b0yz3VnGe7F1atF3hdn7fNrO+h3f0nzC5KXS
        /9POB89OFBLZuHfaiejANxNuM90xT2J4r2pcnBX2PXPB8Rtza8u2Z4gU/Eng3cjocNvHd9X7
        23MfbTeyXF/D8kl5/aw1mWdmKLEUZyQaajEXFScCADfOv73fAgAA
X-CMS-MailID: 20190306072408eucas1p224c24f990fb5d78526996d49eccf3568
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101927eucas1p250bbcbccb43590edd2b9ccf06cce2023
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101927eucas1p250bbcbccb43590edd2b9ccf06cce2023
References: <CGME20190305101927eucas1p250bbcbccb43590edd2b9ccf06cce2023@eucas1p2.samsung.com>
        <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <1551781151-5562-7-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPdXQuGotKONE4GR8AZr1gMZHM3dgAu-TSKSDqVeYw5zWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 3/5/19 12:36 PM, Krzysztof Kozlowski wrote:
> On Tue, 5 Mar 2019 at 11:19, Lukasz Luba <l.luba@partner.samsung.com>
> wrote:>> Add description of Dynamic Memory Controller and PPMU
> counters.> They are used by exynos5422-dmc driver.>> Signed-off-by:
> Lukasz Luba <l.luba@partner.samsung.com>In previous email I asked to
> fix the subject prefix in case of resend. Please fix it.
> 
>> ---
>>   arch/arm/boot/dts/exynos5420.dtsi             | 83 +++++++++++++++++++++++++
>>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 87 +++++++++++++++++++++++++++
>>   2 files changed, 170 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index aaff158..fc00fda 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -235,6 +235,41 @@
>>                          status = "disabled";
>>                  };
>>
>> +               dmc: memory-controller@10c20000 {
>> +                       compatible = "samsung,exynos5422-dmc";
>> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>> +                               <0x10000000 0x1000>;
>> +                       clocks = <&clock CLK_FOUT_SPLL>,
>> +                                <&clock CLK_MOUT_SCLK_SPLL>,
>> +                                <&clock CLK_FF_DOUT_SPLL2>,
>> +                                <&clock CLK_FOUT_BPLL>,
>> +                                <&clock CLK_MOUT_BPLL>,
>> +                                <&clock CLK_SCLK_BPLL>,
>> +                                <&clock CLK_MOUT_MX_MSPLL_CCORE>,
>> +                                <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>> +                                <&clock CLK_MOUT_MCLK_CDREX>,
>> +                                <&clock CLK_DOUT_CLK2X_PHY0>,
>> +                                <&clock CLK_CLKM_PHY0>,
>> +                                <&clock CLK_CLKM_PHY1>,
>> +                                <&clock CLK_CDREX_PAUSE>,
>> +                                <&clock CLK_CDREX_TIMING_SET>;
>> +                       clock-names = "fout_spll",
>> +                                     "mout_sclk_spll",
>> +                                     "ff_dout_spll2",
>> +                                     "fout_bpll",
>> +                                     "mout_bpll",
>> +                                     "sclk_bpll",
>> +                                     "mout_mx_mspll_ccore",
>> +                                     "mout_mx_mspll_ccore_phy",
>> +                                     "mout_mclk_cdrex",
>> +                                     "dout_clk2x_phy0",
>> +                                     "clkm_phy0",
>> +                                     "clkm_phy1",
>> +                                     "clk_cdrex_pause",
>> +                                     "clk_cdrex_timing_set";
>> +                       status = "disabled";
>> +               };
>> +
>>                  nocp_mem0_0: nocp@10ca1000 {
>>                          compatible = "samsung,exynos5420-nocp";
>>                          reg = <0x10CA1000 0x200>;
>> @@ -271,6 +306,54 @@
>>                          status = "disabled";
>>                  };
>>
>> +               ppmu_dmc0_0: ppmu@10d00000 {
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d00000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>> +                                       event-name = "ppmu-event3-dmc0_0";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               ppmu_dmc0_1: ppmu@10d10000 {
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d10000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
>> +                                       event-name = "ppmu-event3-dmc0_1";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               ppmu_dmc1_0: ppmu@10d10000 {
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d60000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
>> +                                       event-name = "ppmu-event3-dmc1_0";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               ppmu_dmc1_1: ppmu@10d70000 {
>> +                       compatible = "samsung,exynos-ppmu";
>> +                       reg = <0x10d70000 0x2000>;
>> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
>> +                       clock-names = "ppmu";
>> +                       events {
>> +                               ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
>> +                                       event-name = "ppmu-event3-dmc1_1";
>> +                               };
>> +                       };
>> +               };
>> +
>>                  gsc_pd: power-domain@10044000 {
>>                          compatible = "samsung,exynos4210-pd";
>>                          reg = <0x10044000 0x20>;
>> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> index bf09eab..6b28fb3 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> @@ -34,6 +34,69 @@
>>                          clock-frequency = <24000000>;
>>                  };
>>          };
>> +
>> +       dmc_opp_table: opp_table2 {
>> +               compatible = "operating-points-v2";
>> +
>> +               opp00 {
>> +                       opp-hz = /bits/ 64 <165000000>;
>> +                       opp-microvolt = <875000>;
>> +               };
>> +               opp01 {
>> +                       opp-hz = /bits/ 64 <206000000>;
>> +                       opp-microvolt = <875000>;
>> +               };
>> +               opp02 {
>> +                       opp-hz = /bits/ 64 <275000000>;
>> +                       opp-microvolt = <875000>;
>> +               };
>> +               opp03 {
>> +                       opp-hz = /bits/ 64 <413000000>;
>> +                       opp-microvolt = <887500>;
>> +               };
>> +               opp04 {
>> +                       opp-hz = /bits/ 64 <543000000>;
>> +                       opp-microvolt = <937500>;
>> +               };
>> +               opp05 {
>> +                       opp-hz = /bits/ 64 <633000000>;
>> +                       opp-microvolt = <1012500>;
>> +               };
>> +               opp06 {
>> +                       opp-hz = /bits/ 64 <728000000>;
>> +                       opp-microvolt = <1037500>;
>> +               };
>> +               opp07 {
>> +                       opp-hz = /bits/ 64 <825000000>;
>> +                       opp-microvolt = <1050000>;
>> +               };
>> +       };
>> +
>> +       dmc_bypass_mode: bypass_mode {
>> +               compatible = "samsung,dmc-bypass-mode";
>> +
>> +               freq-hz = <400000000>;
>> +               volt-uv = <887500>;
>> +               dram-timing-row = <0x365a9713>;
>> +               dram-timing-data = <0x4740085e>;
>> +               dram-timing-power = <0x543a0446>;
>> +       };
>> +
>> +       dram_timing: timing {
>> +               compatible = "samsung,dram-timing";
>> +
>> +               dram-timing-names = "165MHz", "206MHz", "275MHz", "413MHz",
>> +                                   "543MHz", "633MHz", "728MHz", "825MHz";
>> +               dram-timing-row = <0x11223185>, <0x112331C6>, <0x12244287>,
>> +                                 <0x1B35538A>, <0x244764CD>, <0x2A48758F>,
>> +                                 <0x30598651>, <0x365A9713>;
>> +               dram-timing-data = <0x2720085E>, <0x2720085E>, <0x2720085E>,
>> +                                  <0x2720085E>, <0x3730085E>, <0x3730085E>,
>> +                                  <0x3730085E>, <0x4740085E>;
>> +               dram-timing-power = <0x140C0225>, <0x180F0225>, <0x1C140225>,
>> +                                   <0x2C1D0225>, <0x38270335>, <0x402D0335>,
>> +                                   <0x4C330336>, <0x543A0446>;
>> +       };
>>   };
>>
>>   &bus_wcore {
>> @@ -127,6 +190,14 @@
>>          cpu-supply = <&buck2_reg>;
>>   };
>>
>> +&dmc {
>> +       devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
>> +                       <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
>> +
>> +       operating-points-v2 = <&dmc_opp_table>;
> 
> The opp-tables have voltage entry but I do not see the regulator
> supply. How do you change the voltage?
Right. There is a missing entry in &dmc node
vdd-supply = <&buck1_reg>;

In the driver code it is taken by name "vdd_mif".

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
