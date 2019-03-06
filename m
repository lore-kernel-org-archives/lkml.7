Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06123C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4239206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eL4wSCFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfCFHPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:15:03 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50473 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbfCFHPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:15:01 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190306071459euoutp019ce0a6474dbaba6503f330c691642da9~JTUOpKd3D1580915809euoutp01m
        for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2019 07:14:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190306071459euoutp019ce0a6474dbaba6503f330c691642da9~JTUOpKd3D1580915809euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551856499;
        bh=2Vp5Su1aejLRO7gL1QYmoYAYjCNLauRaJSt3asUz014=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eL4wSCFZCUDC/MByKDvP46PDcbzFTd05U+q02nCBgaiRg8th3eeWz4mlef0NXjPX8
         qjgqmPTt00Ev/VSXdcZ1nukbF8637ob50qO/mNkHIc4bWICXqc7WDcQWpjn6ALSZYC
         dwN49UQ8egEQuRKgs/jESx/Kc29mBJ539jjJkk3A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190306071458eucas1p1be64464c08951f29d255421726517a68~JTUNzqyc_0106301063eucas1p1m;
        Wed,  6 Mar 2019 07:14:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D6.9A.04806.2737F7C5; Wed,  6
        Mar 2019 07:14:58 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190306071457eucas1p17f62f1ed8ed3304e7db7f0d20416f1f3~JTUMzcZrc0106401064eucas1p1O;
        Wed,  6 Mar 2019 07:14:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190306071457eusmtrp248d15a28c8cfeeb65505ac813349bc2d~JTUMkh7XM0539305393eusmtrp2T;
        Wed,  6 Mar 2019 07:14:57 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-10-5c7f7372b37e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8E.D0.04284.1737F7C5; Wed,  6
        Mar 2019 07:14:57 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190306071456eusmtip1077561c3ef1ba02c76ab68a43a7ddfac~JTUMAQ8Gi1829518295eusmtip1j;
        Wed,  6 Mar 2019 07:14:56 +0000 (GMT)
Subject: Re: [PATCH v5 4/8] dt-bindings: devfreq: add Exynos5422 DMC device
 description
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <1800b874-75c3-420d-71df-9b9a8e7ad1c8@partner.samsung.com>
Date:   Wed, 6 Mar 2019 08:14:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3f413631-1a6f-61f7-58aa-38df3e2ffea4@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7pFxfUxBk/XSVtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVmsPXKX3eJ24wo2i8Nv2lkd
        eDw2repk8+jbsorR4/MmuQDmKC6blNSczLLUIn27BK6MaW0P2Qtu2lbsvTmZtYFxsUEXIyeH
        hICJxJVJfYxdjFwcQgIrGCW+tj5mhXC+MErs6b3EBFIlJPCZUWLSf9MuRg6wjnOzVSFqljNK
        dB2YDtXwllFie895RpAGYYFIiTXHGthAEiICixklpq78zQTiMAusYpTYPHUVI8goNgE9iR2r
        CkEaeAXcJP72PgFrZhFQkdh4eB8ziC0qECFxuPcdI0SNoMTJmU9YQGxOAXuJ3mlvwWqYBcQl
        bj2ZzwRhy0s0b53NDLJLQuAcu8Tvv7PZIB51kdjYvpYJwhaWeHV8CzuELSPxf+d8qHixxNmO
        VVD1NRLtJ3dA1VhLHD5+kRXkZmYBTYn1u/Qhwo4SX18cYoWECp/EjbeCECfwSUzaNp0ZIswr
        0dEmBFGtIbGl5wLUIjGJ5WumsU9gVJqF5LFZSJ6ZheSZWQh7FzCyrGIUTy0tzk1PLTbOSy3X
        K07MLS7NS9dLzs/dxAhMT6f/Hf+6g3Hfn6RDjAIcjEo8vBNa62KEWBPLiitzDzFKcDArifB6
        ZtXHCPGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCUamBMdbEV
        efhke5Vi0uy/yTvqDW3Lwyscl33/Jv1rVqBMh9yinpnr4o9v3q+V/mat+gU53/wdHEYbvyeu
        S3gYEL7rppaLc7WWsV+4q+es0mNHYhjDXi05w+762VWdy1WpabOjtOXdpc132mKVJxhXXzr5
        bfqy3YWLb+zO+t7+cePn0xEVn1MUxAKVWIozEg21mIuKEwG0nTA+SwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7qFxfUxBr1NghYbZ6xntbj+5Tmr
        xfwj51gt+h+/ZrY4f34Du8XZpjfsFpd3zWGz+Nx7hNFixvl9TBZrj9xlt7jduILN4vCbdlYH
        Ho9NqzrZPPq2rGL0+LxJLoA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ
        384mJTUnsyy1SN8uQS9jWttD9oKbthV7b05mbWBcbNDFyMEhIWAicW62ahcjF4eQwFJGiTnL
        7jJ3MXICxcUkJu3bzg5hC0v8udbFBmILCbxmlFg4pQzEFhaIlFhzrAEsLiKwmFHia2s1yCBm
        gVWMEu/+zmWGmDqJSeLl9XUsINvYBPQkdqwqBGngFXCT+Nv7hBHEZhFQkdh4eB/YYlGBCImP
        T/cxQdQISpyc+YQFxOYUsJfonfYWrIZZwExi3uaHULa4xK0n85kgbHmJ5q2zmScwCs1C0j4L
        ScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERiR24793LyD8dLG4EOMAhyM
        Sjy8E1rrYoRYE8uKK3MPMUpwMCuJ8Hpm1ccI8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4w
        WeSVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamCcNT/weMlpZpUf
        MZYbHKO8Kss/ebFe5PRZrPyMwb1tc+jenI1Lw1+3SjZp8bifYNts/OWb9nKb10Wxf0zawusZ
        Jv1NXlZ/Nc639HJ8qfn0bb9Fzd+eFCos0P2dsHv6lFx11ldRC/fkbDz5nElm1fOuTV8cXs/s
        vL4iYD37qpgrM1OP+aoYVoUqsRRnJBpqMRcVJwIADU1wEt4CAAA=
X-CMS-MailID: 20190306071457eucas1p17f62f1ed8ed3304e7db7f0d20416f1f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb@eucas1p2.samsung.com>
        <1551781151-5562-5-git-send-email-l.luba@partner.samsung.com>
        <3f413631-1a6f-61f7-58aa-38df3e2ffea4@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 3/6/19 5:18 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 3. 5. 오후 7:19, Lukasz Luba wrote:
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
> 
> 
> I already replied with following comments on v4 patch[1].
> But, you didn't reply anything. We can reduce the duplicate
> review by keeping the basic review rule.
I have lost these changes while I was adding the OPPs, timings into the
dt-binding.
> 
> - Re: [PATCH v4 5/8] dt-bindings: devfreq: add Exynos5422 DMC device description
> [1] https://do-db2.lkml.org/lkml/2019/2/3/64
> 
> 
> [Following comments were replied on v4 patch[1]]
> 
>> +- compatible: Should be "samsung,exynos5422-bus".
> 
> The compatible name is wrong.
> - exynos5422-bus -> exynos5422-dmc
> 
>> +- clock-names : the name of clock used by the bus, "bus".
> 
> 'bus' is right?
right
> 
>> +- clocks : phandles for clock specified in "clock-names" property.
>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
> 
> The dt-binging file doesn't contain the any description for 'reg' properties.
There are 3 regs: cdrex0, cdrex1, chip_id. I will add this description.

The patch set has this OPPs and timings coming from DT as you requested
but I am not sure if it is in the right place in the DT.
Thus dt-binding you may consider as 'in-progress' till the DT entries
are fixed

Regards,
Lukasz
> 
> 
> 
>> +
>> +The example definition of a DMC and PPMU devices declared in DT is shown below:
>> +
>> +	ppmu_dmc0_0: ppmu@10d00000 {
>> +		compatible = "samsung,exynos-ppmu";
>> +		reg = <0x10d00000 0x2000>;
>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
>> +		clock-names = "ppmu";
>> +		status = "okay";
>> +		events {
>> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
>> +				event-name = "ppmu-event3-dmc0_0";
>> +			};
>> +		};
>> +	};
>> +
>> +
>> +	ppmu_dmc0_1: ppmu@10d10000 {
>> +		compatible = "samsung,exynos-ppmu";
>> +		reg = <0x10d10000 0x2000>;
>> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
>> +		clock-names = "ppmu";
>> +		status = "okay";
>> +		events {
>> +			ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
>> +				event-name = "ppmu-event3-dmc0_1";
>> +			};
>> +		};
>> +	};
>> +
>> +	ppmu_dmc1_0: ppmu@10d10000 {
>> +		compatible = "samsung,exynos-ppmu";
>> +		reg = <0x10d60000 0x2000>;
>> +		clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
>> +		clock-names = "ppmu";
>> +		status = "okay";
>> +		events {
>> +			ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
>> +				event-name = "ppmu-event3-dmc1_0";
>> +			};
>> +		};
>> +	};
>> +
>> +	ppmu_dmc1_1: ppmu@10d70000 {
>> +		compatible = "samsung,exynos-ppmu";
>> +		reg = <0x10d70000 0x2000>;
>> +		clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
>> +		clock-names = "ppmu";
>> +		status = "okay";
>> +		events {
>> +			ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
>> +				event-name = "ppmu-event3-dmc1_1";
>> +			};
>> +		};
>> +	};
>> +
>> +	dmc: memory-controller@10c20000 {
>> +		compatible = "samsung,exynos5422-dmc";
>> +		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
>> +			<0x10000000 0x1000>;
>> +		clocks = 	<&clock CLK_FOUT_SPLL>,
>> +				<&clock CLK_MOUT_SCLK_SPLL>,
>> +				<&clock CLK_FF_DOUT_SPLL2>,
>> +				<&clock CLK_FOUT_BPLL>,
>> +				<&clock CLK_MOUT_BPLL>,
>> +				<&clock CLK_SCLK_BPLL>,
>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
>> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
>> +				<&clock CLK_MOUT_MCLK_CDREX>,
>> +				<&clock CLK_DOUT_CLK2X_PHY0>,
>> +				<&clock CLK_CLKM_PHY0>,
>> +				<&clock CLK_CLKM_PHY1>,
>> +				<&clock CLK_CDREX_PAUSE>,
>> +				<&clock CLK_CDREX_TIMING_SET>;
>> +		clock-names =	"fout_spll",
>> +				"mout_sclk_spll",
>> +				"ff_dout_spll2",
>> +				"fout_bpll",
>> +				"mout_bpll",
>> +				"sclk_bpll",
>> +				"mout_mx_mspll_ccore",
>> +				"mout_mx_mspll_ccore_phy",
>> +				"mout_mclk_cdrex",
>> +				"dout_clk2x_phy0",
>> +				"clkm_phy0",
>> +			        "clkm_phy1",
>> +			        "clk_cdrex_pause",
>> +			        "clk_cdrex_timing_set";
>> +		status = "okay";
>> +		operating-points-v2 = <&dmc_opp_table>;
>> +		devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
>> +				<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
>> +	};
>> +
>> +The needed timings of DRAM memory are stored in dedicated nodes.
>> +There are two nodes with regular timings and for bypass mode.
>> +
>> +	dmc_bypass_mode: bypass_mode {
>> +		compatible = "samsung,dmc-bypass-mode";
>> +
>> +		freq-hz = <400000000>;
>> +		volt-uv = <887500>;
>> +		dram-timing-row = <0x365a9713>;
>> +		dram-timing-data = <0x4740085e>;
>> +		dram-timing-power = <0x543a0446>;
>> +	};
>> +
>> +	dram_timing: timing {
>> +		compatible = "samsung,dram-timing";
>> +
>> +		dram-timing-names = "165MHz", "206MHz", "275MHz", "413MHz",
>> +				    "543MHz", "633MHz", "728MHz", "825MHz";
>> +		dram-timing-row = <0x11223185>, <0x112331C6>, <0x12244287>,
>> +				  <0x1B35538A>, <0x244764CD>, <0x2A48758F>,
>> +				  <0x30598651>, <0x365A9713>;
>> +		dram-timing-data = <0x2720085E>, <0x2720085E>, <0x2720085E>,
>> +				   <0x2720085E>, <0x3730085E>, <0x3730085E>,
>> +				   <0x3730085E>, <0x4740085E>;
>> +		dram-timing-power = <0x140C0225>, <0x180F0225>, <0x1C140225>,
>> +				    <0x2C1D0225>, <0x38270335>, <0x402D0335>,
>> +				    <0x4C330336>, <0x543A0446>;
>> +	};
>> +
>> +The frequencies supported by the DMC are stored in OPP table v2.
>> +
>> +	dmc_opp_table: opp_table2 {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp00 {
>> +			opp-hz = /bits/ 64 <165000000>;
>> +			opp-microvolt = <875000>;
>> +		};
>> +		opp01 {
>> +			opp-hz = /bits/ 64 <206000000>;
>> +			opp-microvolt = <875000>;
>> +		};
>> +		opp02 {
>> +			opp-hz = /bits/ 64 <275000000>;
>> +			opp-microvolt = <875000>;
>> +		};
>> +		opp03 {
>> +			opp-hz = /bits/ 64 <413000000>;
>> +			opp-microvolt = <887500>;
>> +		};
>> +		opp04 {
>> +			opp-hz = /bits/ 64 <543000000>;
>> +			opp-microvolt = <937500>;
>> +		};
>> +		opp05 {
>> +			opp-hz = /bits/ 64 <633000000>;
>> +			opp-microvolt = <1012500>;
>> +		};
>> +		opp06 {
>> +			opp-hz = /bits/ 64 <728000000>;
>> +			opp-microvolt = <1037500>;
>> +		};
>> +		opp07 {
>> +			opp-hz = /bits/ 64 <825000000>;
>> +			opp-microvolt = <1050000>;
>> +		};
>> +	};
>> +
>>
> 
> 
