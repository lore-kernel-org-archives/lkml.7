Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BE3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA87820661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tHd7x27l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfCFHfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:35:41 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57259 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbfCFHfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:35:40 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190306073538euoutp029aada409f5141c38039e3dfe1040b397~JTmQRj4ti0505705057euoutp02M
        for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2019 07:35:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190306073538euoutp029aada409f5141c38039e3dfe1040b397~JTmQRj4ti0505705057euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551857738;
        bh=kVuHMzQfmEZtEl3B5Op757Cj1illB/4/YuF0mexjPEw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tHd7x27lniJoPf1MLGsh+VzDjPLn1pJ1GmDlt6+e9Lw0bjPT9MTBr9mzCszIb7oq5
         k7qYjldyv5MCWiqIGjEcmVODhz4USKPq+RdeWUtvPfpzidBDfKRsyZQo7CBFbKOJbd
         Y2hHwvwQmg/EYoZl5fEwuvaiQs2uh08luvDnyxoU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190306073537eucas1p2fd4dafaecb2315ae58f5ad2097325313~JTmPu3IlJ0741907419eucas1p2a;
        Wed,  6 Mar 2019 07:35:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DD.2D.04806.9487F7C5; Wed,  6
        Mar 2019 07:35:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190306073536eucas1p17f0f877c6aefe304ba991ee33fdab921~JTmPA6aKA0570905709eucas1p1f;
        Wed,  6 Mar 2019 07:35:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190306073536eusmtrp11cd56c8c4d8ecb0d1f2d6f1697e288eb~JTmOvO-xZ0177401774eusmtrp17;
        Wed,  6 Mar 2019 07:35:36 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-23-5c7f78494543
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7F.03.04284.8487F7C5; Wed,  6
        Mar 2019 07:35:36 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190306073536eusmtip1db8e6378fe190ce30fdc131187a589d3~JTmOK-w1B2061220612eusmtip13;
        Wed,  6 Mar 2019 07:35:36 +0000 (GMT)
Subject: Re: [PATCH v5 4/8] dt-bindings: devfreq: add Exynos5422 DMC device
 description
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
Message-ID: <82e9065e-100b-646f-68e2-aa85a8807b40@partner.samsung.com>
Date:   Wed, 6 Mar 2019 08:35:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPchn1nFH2FvvCTKoEen2+9EgTfHKbmzEfgKFxGmKGH8Pw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7qeFfUxBucfSFtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVmsPXKX3eJ24wo2i8Nv2lkd
        eDw2repk8+jbsorR4/MmuQDmKC6blNSczLLUIn27BK6Mj1fesxac8a9417qOrYHxun4XIweH
        hICJxLHZIl2MXBxCAisYJf48PMUE4XxhlLiz9SQzhPOZUeLxzyvsXYycYB2z/98Cs4UEljNK
        rN6eBFH0llHiX+cFNpCEsECkxJpjDWC2iICmxPW/31lBipgF1jFLTJ10kxFkN5uAnsSOVYUg
        NbwCbhKX90wHC7MIqEjseZAOEhYViJA43PuOEaJEUOLkzCcsIDanQKDE0otHmUFsZgFxiVtP
        5jNB2PIS29/OATtaQuAcu8S1eZcYIY52kXj5cjEThC0s8er4FqhnZCROT+5hgbCLJc52rGKD
        sGsk2k/ugKqxljh8/CIryG3MQL+s36UPEXaU+PriECskFPkkbrwVhDiBT2LStunMEGFeiY42
        IYhqDYktPRegDhCTWL5mGvsERqVZSB6bheSZWUiemYWwdwEjyypG8dTS4tz01GLjvNRyveLE
        3OLSvHS95PzcTYzA1HT63/GvOxj3/Uk6xCjAwajEwzuhtS5GiDWxrLgy9xCjBAezkgivZ1Z9
        jBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH0UIC6YklqdmpqQWpRTBZJg5OqQbGgE91tZ4h
        PWlPeNQVlkwLsChcuTAulXFBYZG/ypxb3xrOs0+Um3f+94/izRmWoQH5aw09ktVq5jJt+rIr
        Prah8sz+FNuSVdNSmxa+WDLb1mXF7Lf3JNN3GUq/aZpy4uDF1pszBJ+orJSbzas3efepH75O
        rouWZcSI7Ps3kef/rsxpa91mZcsYKrEUZyQaajEXFScCAEwiH3ZJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7oeFfUxBm37VS02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLS7vmsNm8bn3CKPFjPP7mCzWHrnLbnG7cQWbxeE37awO
        PB6bVnWyefRtWcXo8XmTXABzlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7GxyvvWQvO+Fe8a13H1sB4Xb+LkZNDQsBEYvb/W+xdjFwcQgJLGSW+
        tj9jhkiISUzat50dwhaW+HOtiw2i6DWjxP5v+xlBEsICkRJrjjWwgdgiApoS1/9+ZwUpYhbY
        wCyxbdFtFoiOJUwSH9rbgUZxcLAJ6EnsWFUI0sAr4CZxec90RpAwi4CKxJ4H6SBhUYEIiY9P
        9zFBlAhKnJz5hAXE5hQIlFh68SjYccwCZhLzNj+EssUlbj2ZzwRhy0tsfzuHeQKj0Cwk7bOQ
        tMxC0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgTG57djPzTsYL20MPsQowMGo
        xMM7obUuRog1say4MvcQowQHs5IIr2dWfYwQb0piZVVqUX58UWlOavEhRlOg3yYyS4km5wPT
        RV5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBkazX6YrNhht3Pn3
        5BdOi8/XLao/PMiUPRoQWZRpsN3g450pJ/ueuR/tyzPSOCwsuLdeaMZjNRMT8e4Zh1cUHlil
        87stQ+9VdCqXQk7Hf+0piv8rgrr8bvb4qYVffdLG+FEgcPm0VQceBbUs6mh1WvtCn2NBmOKC
        k5INj7ZN/SN34MUr/8mOH3qUWIozEg21mIuKEwFtdaUm3wIAAA==
X-CMS-MailID: 20190306073536eucas1p17f0f877c6aefe304ba991ee33fdab921
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb
References: <CGME20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb@eucas1p2.samsung.com>
        <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <1551781151-5562-5-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPchn1nFH2FvvCTKoEen2+9EgTfHKbmzEfgKFxGmKGH8Pw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 3/5/19 12:35 PM, Krzysztof Kozlowski wrote:
> On Tue, 5 Mar 2019 at 11:19, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>> Memory Controller device.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/devfreq/exynos5422-dmc.txt | 177 +++++++++++++++++++++
>>   1 file changed, 177 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>> new file mode 100644
>> index 0000000..0e73e98
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>> @@ -0,0 +1,177 @@
>> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
>> +
>> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>> +memory chips are connected. The driver is to monitor the controller in runtime
>> +and switch frequency and voltage. To monitor the usage of the controller in
>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>> +is able to measure the current load of the memory.
>> +When 'userspace' governor is used for the driver, an application is able to
>> +switch the DMC frequency.
>> +
>> +Required properties for DMC device for Exynos5422:
>> +- compatible: Should be "samsung,exynos5422-bus".
>> +- clock-names : the name of clock used by the bus, "bus".
>> +- clocks : phandles for clock specified in "clock-names" property.
>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>> +
>> +The example definition of a DMC and PPMU devices declared in DT is shown below:
>> +
>> +       ppmu_dmc0_0: ppmu@10d00000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d00000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>> +                               event-name = "ppmu-event3-dmc0_0";
>> +                       };
>> +               };
>> +       };
>> +
>> +
>> +       ppmu_dmc0_1: ppmu@10d10000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d10000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
>> +                               event-name = "ppmu-event3-dmc0_1";
>> +                       };
>> +               };
>> +       };
>> +
>> +       ppmu_dmc1_0: ppmu@10d10000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d60000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
>> +                               event-name = "ppmu-event3-dmc1_0";
>> +                       };
>> +               };
>> +       };
>> +
>> +       ppmu_dmc1_1: ppmu@10d70000 {
>> +               compatible = "samsung,exynos-ppmu";
>> +               reg = <0x10d70000 0x2000>;
>> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
>> +               clock-names = "ppmu";
>> +               status = "okay";
>> +               events {
>> +                       ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
>> +                               event-name = "ppmu-event3-dmc1_1";
>> +                       };
>> +               };
>> +       };
>> +
>> +       dmc: memory-controller@10c20000 {
>> +               compatible = "samsung,exynos5422-dmc";
>> +               reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>> +                       <0x10000000 0x1000>;
>> +               clocks =        <&clock CLK_FOUT_SPLL>,
>> +                               <&clock CLK_MOUT_SCLK_SPLL>,
>> +                               <&clock CLK_FF_DOUT_SPLL2>,
>> +                               <&clock CLK_FOUT_BPLL>,
>> +                               <&clock CLK_MOUT_BPLL>,
>> +                               <&clock CLK_SCLK_BPLL>,
>> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
>> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>> +                               <&clock CLK_MOUT_MCLK_CDREX>,
>> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
>> +                               <&clock CLK_CLKM_PHY0>,
>> +                               <&clock CLK_CLKM_PHY1>,
>> +                               <&clock CLK_CDREX_PAUSE>,
>> +                               <&clock CLK_CDREX_TIMING_SET>;
>> +               clock-names =   "fout_spll",
>> +                               "mout_sclk_spll",
>> +                               "ff_dout_spll2",
>> +                               "fout_bpll",
>> +                               "mout_bpll",
>> +                               "sclk_bpll",
>> +                               "mout_mx_mspll_ccore",
>> +                               "mout_mx_mspll_ccore_phy",
>> +                               "mout_mclk_cdrex",
>> +                               "dout_clk2x_phy0",
>> +                               "clkm_phy0",
>> +                               "clkm_phy1",
>> +                               "clk_cdrex_pause",
>> +                               "clk_cdrex_timing_set";
>> +               status = "okay";
>> +               operating-points-v2 = <&dmc_opp_table>;
>> +               devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
>> +                               <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
>> +       };
>> +
>> +The needed timings of DRAM memory are stored in dedicated nodes.
>> +There are two nodes with regular timings and for bypass mode.
>> +
>> +       dmc_bypass_mode: bypass_mode {
>> +               compatible = "samsung,dmc-bypass-mode";
> 
> This looks like an example, not bindings.
I have not seen similar, since it is not just 'timing' but other
Exynos register specific stuff in the register.
> 
>> +
>> +               freq-hz = <400000000>;
>> +               volt-uv = <887500>;
> 
> -microvolt
> Documentation/devicetree/bindings/property-units.txt
Thanks
> 
>> +               dram-timing-row = <0x365a9713>;
>> +               dram-timing-data = <0x4740085e>;
>> +               dram-timing-power = <0x543a0446>;
>> +       };
>> +
>> +       dram_timing: timing {
>> +               compatible = "samsung,dram-timing";
> 
> Probably you should use timings from Documentation/devicetree/bindings/lpddr2/
> If not, all the fields below should be described.
It is not just 'timing'. It is a whole register specific value for the
Exynos5422. It could be named 'dram-config-regs' to avoid confusion.
The regs are called 'row', 'data' and 'power' and adding a procedure
in the driver which takes ~30 values for each speed-grade and combines
into a reg value makes no sense.
> 
> All these bindings (memory-controller, timings) look like description
> of memory controller so maybe they should go into
> Documentation/devicetree/bindings/memory-controllers ?
I don't know, maybe Chanwoo has some opinion since he requested to put
these register values into DT.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
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
>> +
>> +The frequencies supported by the DMC are stored in OPP table v2.
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
>> --
>> 2.7.4
>>
> 
> 
