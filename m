Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D46C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9BC2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NggL0PvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfCFHum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:50:42 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:21195 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfCFHum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:50:42 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190306075038epoutp04f8c2faef363503c40ae0ba0052a5be82~JTzW0oblo3151831518epoutp04f
        for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2019 07:50:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190306075038epoutp04f8c2faef363503c40ae0ba0052a5be82~JTzW0oblo3151831518epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551858638;
        bh=gbAIz0KABNheCDGP18ek3mG1YtfbRniTf1BF7r1niM4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NggL0PvWJ+1I+WdaQmEEdv2a3GmFTjxA+wLqW3QXTQb4KezgyYfW8Xu63D3FzCZMW
         FHxX2VQsmp8CrVZgWurlDs3JmdWbqUWJjmZIZ3vlVGaOjiWHYWXiuU5P/oVkpuFfP3
         3tn3o9eCR8ELMygxCMwOMO4jQOJmMFw3DFp6r3ME=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190306075034epcas1p33e6f7c988441fbf65d4211f8929ed41f~JTzTSeDP92415124151epcas1p3T;
        Wed,  6 Mar 2019 07:50:34 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.AD.04074.5CB7F7C5; Wed,  6 Mar 2019 16:50:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190306075029epcas1p4de92074e6bafeccd645a9b88cb43233c~JTzN-oB6w0345703457epcas1p4I;
        Wed,  6 Mar 2019 07:50:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190306075029epsmtrp28f981f9ab692e3fb6f6141e121d16f3f~JTzN_MJr80180001800epsmtrp2K;
        Wed,  6 Mar 2019 07:50:29 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-48-5c7f7bc5c523
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.DC.03971.4CB7F7C5; Wed,  6 Mar 2019 16:50:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190306075028epsmtip1567c323bed489740988998585829d890~JTzNs2gKL2430324303epsmtip1O;
        Wed,  6 Mar 2019 07:50:28 +0000 (GMT)
Subject: Re: [PATCH v5 4/8] dt-bindings: devfreq: add Exynos5422 DMC device
 description
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <07aa779e-1752-0eb2-8fcd-a3d223c952b1@samsung.com>
Date:   Wed, 6 Mar 2019 16:50:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1800b874-75c3-420d-71df-9b9a8e7ad1c8@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TWUwTURTN6zIdDNVnUbkSFzrqhyiWsVQGtW4YrIqK+qMEgyNMSkM3Oy0u
        RK2iskSkBDeQBBeMWjQogkFQCFg1JAoqMVFWjZC4BaJ1i8al7WDk75x7z3vnnreQYsUtIow0
        mO2czcwaKWKU5ObdmarIe1n7kqOyb8Qy109VSZlyT5uUKXz9Xsy0t1+TMY8OfJAxnc5JTEd9
        GcF4CzyIOdXeKGKuenpkTNf+SwRz90OOdEmwrtqdR+iaB2+LdEdr3EjnrZ6SKEnKWJjOsWmc
        LZwzp1rSDGa9llq9MSUuRTMvio6kY5kYKtzMmjgttTwhMTLeYPRNRoVnskaHr5TI8jylWrTQ
        ZnHYufB0C2/XUpw1zWiNtc7hWRPvMOvnpFpM8+moqLkan3BrRnpBb7PI+mLpzm73NifqVuej
        IBJwNHwrLxDlo1GkAtchcLkODJNPCH72npAK5CuCkv4Tsn9Lru+vGG7cQXCuok4ikCEE3cVP
        pH5VCN4MV+47CX9jHL6IoPF4D/ITMXYjuHHcjfwqAkdA05vnhB+PwUp49v11oC7Hi6CrsCCA
        JXg6/BloDmjG400wNNAgETRjobWkP4CD8Ar49ftjQCPGodDZXy4S8FTIrj0tFuYulMHQ5zgB
        L4cfRfeQgEPg3YOa4Wxh4B28Qwg4Cy63egIJAOciqGl6LBUaami6UOwzIH0GM6GqXiV4jYbB
        L0ek/jJgOeQeVgjqadDxskck4IlwPidveHsdlLlyJC6kLB2RpnREgtIRCUr/m51BEjeawFl5
        k57jaSs98rqrUeDZRmjq0LG2hBaESUQFy12H9iYrpGwmv8vUgoAUU+PkHTv2JSvkaeyu3ZzN
        kmJzGDm+BWl8h10kDhufavF9ArM9hdbMVavVTDQ9T0PTVKi8aklcsgLrWTuXwXFWzvZvnYgM
        CnOi3MVHsi5n1jVUVs5ibi+dP6BVOtFWT9uV7fEXlE8H9eqQ+pV7VF0fF3w2VL598ujlQZz/
        dN22+qScdvvsh7+yOmPO9VV0FW1QtmrXzogOiiHXp2aefb7FsXlyrpddk9Fw1B1aE1JbFHyS
        jPxpWtZIrjKMKTZh0auehI3Zed4VpKqPkvDpLB0htvHsXwPrI4jMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSnO7R6voYg/4lTBYbZ6xntZh/5Byr
        Rf/j18wW589vYLc42/SG3eJWg4zF5V1z2Cw+9x5htJhxfh+Txdojd9ktbjeuYLM4/Kad1YHH
        Y9OqTjaPg+/2MHn0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXRu+9g0wFNx0r7qxKamC8Y9zF
        yMkhIWAisbFxCWsXIxeHkMBuRold33ezQSQkJaZdPMrcxcgBZAtLHD5cDBIWEnjLKDG7XRLE
        FhaIlFhzrIENpFdEYDmjxNy/S1lAHGaBVYwS7/7OZYaYep5JYuW0BkaQFjYBLYn9L26AbeAX
        UJS4+uMxWJxXwE7idn8vmM0ioCLx/+lBsBpRgQiJuxdfsEDUCEqcnPkEzOYUcJf4++8jWA2z
        gLrEn3mXmCFscYlbT+YzQdjyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iw
        wDAvtVyvODG3uDQvXS85P3cTIzjqtDR3MF5eEn+IUYCDUYmHd0JrXYwQa2JZcWXuIUYJDmYl
        Ed7L5fUxQrwpiZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTBK
        aGnpKBjebF3B+OL1rCvPjTcZ5kS2eW591CLKVjVp9orEuY/uuC66e5Q3LZW1M3rZ6ZU3V23K
        3bq55ohEut2RKLfrKhsZu2SYnDz7l1lEXFw8i+fc8jvJ/ybrrN6vEX4s/euenetv6HYoMG7j
        vRYtdP54o8yMwD99Ezec5WBhYxGqfWIsdGavEktxRqKhFnNRcSIA+fLxebYCAAA=
X-CMS-MailID: 20190306075029epcas1p4de92074e6bafeccd645a9b88cb43233c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb@eucas1p2.samsung.com>
        <1551781151-5562-5-git-send-email-l.luba@partner.samsung.com>
        <3f413631-1a6f-61f7-58aa-38df3e2ffea4@samsung.com>
        <1800b874-75c3-420d-71df-9b9a8e7ad1c8@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 3. 6. 오후 4:14, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 3/6/19 5:18 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> On 19. 3. 5. 오후 7:19, Lukasz Luba wrote:
>>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>>> Memory Controller device.
>>>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   .../devicetree/bindings/devfreq/exynos5422-dmc.txt | 177 +++++++++++++++++++++
>>>   1 file changed, 177 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>>> new file mode 100644
>>> index 0000000..0e73e98
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
>>> @@ -0,0 +1,177 @@
>>> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
>>> +
>>> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>>> +memory chips are connected. The driver is to monitor the controller in runtime
>>> +and switch frequency and voltage. To monitor the usage of the controller in
>>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>>> +is able to measure the current load of the memory.
>>> +When 'userspace' governor is used for the driver, an application is able to
>>> +switch the DMC frequency.
>>> +
>>> +Required properties for DMC device for Exynos5422:
>>> +- compatible: Should be "samsung,exynos5422-bus".
>>> +- clock-names : the name of clock used by the bus, "bus".
>>> +- clocks : phandles for clock specified in "clock-names" property.
>>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>>
>>
>> I already replied with following comments on v4 patch[1].
>> But, you didn't reply anything. We can reduce the duplicate
>> review by keeping the basic review rule.
> I have lost these changes while I was adding the OPPs, timings into the
> dt-binding.
>>
>> - Re: [PATCH v4 5/8] dt-bindings: devfreq: add Exynos5422 DMC device description
>> [1] https://do-db2.lkml.org/lkml/2019/2/3/64
>>
>>
>> [Following comments were replied on v4 patch[1]]
>>
>>> +- compatible: Should be "samsung,exynos5422-bus".
>>
>> The compatible name is wrong.
>> - exynos5422-bus -> exynos5422-dmc
>>
>>> +- clock-names : the name of clock used by the bus, "bus".
>>
>> 'bus' is right?
> right

As I knew, the clocks of exynos5422-dmc is for DMC.
Why do you think 'bus' is right insted of DMC?.
I think that it is not a 'bus' driver.

>>
>>> +- clocks : phandles for clock specified in "clock-names" property.
>>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>>
>> The dt-binging file doesn't contain the any description for 'reg' properties.
> There are 3 regs: cdrex0, cdrex1, chip_id. I will add this description.
> 
> The patch set has this OPPs and timings coming from DT as you requested
> but I am not sure if it is in the right place in the DT.
> Thus dt-binding you may consider as 'in-progress' till the DT entries
> are fixed
> 
> Regards,
> Lukasz
>>
>>
>>
>>> +
>>> +The example definition of a DMC and PPMU devices declared in DT is shown below:
>>> +
>>> +	ppmu_dmc0_0: ppmu@10d00000 {
>>> +		compatible = "samsung,exynos-ppmu";
>>> +		reg = <0x10d00000 0x2000>;
>>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>>> +		clock-names = "ppmu";
>>> +		status = "okay";
>>> +		events {
>>> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>>> +				event-name = "ppmu-event3-dmc0_0";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +
>>> +	ppmu_dmc0_1: ppmu@10d10000 {
>>> +		compatible = "samsung,exynos-ppmu";
>>> +		reg = <0x10d10000 0x2000>;
>>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
>>> +		clock-names = "ppmu";
>>> +		status = "okay";
>>> +		events {
>>> +			ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
>>> +				event-name = "ppmu-event3-dmc0_1";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	ppmu_dmc1_0: ppmu@10d10000 {
>>> +		compatible = "samsung,exynos-ppmu";
>>> +		reg = <0x10d60000 0x2000>;
>>> +		clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
>>> +		clock-names = "ppmu";
>>> +		status = "okay";
>>> +		events {
>>> +			ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
>>> +				event-name = "ppmu-event3-dmc1_0";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	ppmu_dmc1_1: ppmu@10d70000 {
>>> +		compatible = "samsung,exynos-ppmu";
>>> +		reg = <0x10d70000 0x2000>;
>>> +		clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
>>> +		clock-names = "ppmu";
>>> +		status = "okay";
>>> +		events {
>>> +			ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
>>> +				event-name = "ppmu-event3-dmc1_1";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	dmc: memory-controller@10c20000 {
>>> +		compatible = "samsung,exynos5422-dmc";
>>> +		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>>> +			<0x10000000 0x1000>;
>>> +		clocks = 	<&clock CLK_FOUT_SPLL>,
>>> +				<&clock CLK_MOUT_SCLK_SPLL>,
>>> +				<&clock CLK_FF_DOUT_SPLL2>,
>>> +				<&clock CLK_FOUT_BPLL>,
>>> +				<&clock CLK_MOUT_BPLL>,
>>> +				<&clock CLK_SCLK_BPLL>,
>>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
>>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>>> +				<&clock CLK_MOUT_MCLK_CDREX>,
>>> +				<&clock CLK_DOUT_CLK2X_PHY0>,
>>> +				<&clock CLK_CLKM_PHY0>,
>>> +				<&clock CLK_CLKM_PHY1>,
>>> +				<&clock CLK_CDREX_PAUSE>,
>>> +				<&clock CLK_CDREX_TIMING_SET>;
>>> +		clock-names =	"fout_spll",
>>> +				"mout_sclk_spll",
>>> +				"ff_dout_spll2",
>>> +				"fout_bpll",
>>> +				"mout_bpll",
>>> +				"sclk_bpll",
>>> +				"mout_mx_mspll_ccore",
>>> +				"mout_mx_mspll_ccore_phy",
>>> +				"mout_mclk_cdrex",
>>> +				"dout_clk2x_phy0",
>>> +				"clkm_phy0",
>>> +			        "clkm_phy1",
>>> +			        "clk_cdrex_pause",
>>> +			        "clk_cdrex_timing_set";
>>> +		status = "okay";
>>> +		operating-points-v2 = <&dmc_opp_table>;
>>> +		devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
>>> +				<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
>>> +	};
>>> +
>>> +The needed timings of DRAM memory are stored in dedicated nodes.
>>> +There are two nodes with regular timings and for bypass mode.
>>> +
>>> +	dmc_bypass_mode: bypass_mode {
>>> +		compatible = "samsung,dmc-bypass-mode";
>>> +
>>> +		freq-hz = <400000000>;
>>> +		volt-uv = <887500>;
>>> +		dram-timing-row = <0x365a9713>;
>>> +		dram-timing-data = <0x4740085e>;
>>> +		dram-timing-power = <0x543a0446>;
>>> +	};
>>> +
>>> +	dram_timing: timing {
>>> +		compatible = "samsung,dram-timing";
>>> +
>>> +		dram-timing-names = "165MHz", "206MHz", "275MHz", "413MHz",
>>> +				    "543MHz", "633MHz", "728MHz", "825MHz";
>>> +		dram-timing-row = <0x11223185>, <0x112331C6>, <0x12244287>,
>>> +				  <0x1B35538A>, <0x244764CD>, <0x2A48758F>,
>>> +				  <0x30598651>, <0x365A9713>;
>>> +		dram-timing-data = <0x2720085E>, <0x2720085E>, <0x2720085E>,
>>> +				   <0x2720085E>, <0x3730085E>, <0x3730085E>,
>>> +				   <0x3730085E>, <0x4740085E>;
>>> +		dram-timing-power = <0x140C0225>, <0x180F0225>, <0x1C140225>,
>>> +				    <0x2C1D0225>, <0x38270335>, <0x402D0335>,
>>> +				    <0x4C330336>, <0x543A0446>;
>>> +	};
>>> +
>>> +The frequencies supported by the DMC are stored in OPP table v2.
>>> +
>>> +	dmc_opp_table: opp_table2 {
>>> +		compatible = "operating-points-v2";
>>> +
>>> +		opp00 {
>>> +			opp-hz = /bits/ 64 <165000000>;
>>> +			opp-microvolt = <875000>;
>>> +		};
>>> +		opp01 {
>>> +			opp-hz = /bits/ 64 <206000000>;
>>> +			opp-microvolt = <875000>;
>>> +		};
>>> +		opp02 {
>>> +			opp-hz = /bits/ 64 <275000000>;
>>> +			opp-microvolt = <875000>;
>>> +		};
>>> +		opp03 {
>>> +			opp-hz = /bits/ 64 <413000000>;
>>> +			opp-microvolt = <887500>;
>>> +		};
>>> +		opp04 {
>>> +			opp-hz = /bits/ 64 <543000000>;
>>> +			opp-microvolt = <937500>;
>>> +		};
>>> +		opp05 {
>>> +			opp-hz = /bits/ 64 <633000000>;
>>> +			opp-microvolt = <1012500>;
>>> +		};
>>> +		opp06 {
>>> +			opp-hz = /bits/ 64 <728000000>;
>>> +			opp-microvolt = <1037500>;
>>> +		};
>>> +		opp07 {
>>> +			opp-hz = /bits/ 64 <825000000>;
>>> +			opp-microvolt = <1050000>;
>>> +		};
>>> +	};
>>> +
>>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
