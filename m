Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA66C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 04:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8024F20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 04:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l/7sd0jP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfCFESo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 23:18:44 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:53223 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfCFESn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 23:18:43 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190306041837epoutp02bd0abf524596613e5349dcf1c24eaab2~JQ6O6gYUV2267922679epoutp02A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2019 04:18:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190306041837epoutp02bd0abf524596613e5349dcf1c24eaab2~JQ6O6gYUV2267922679epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551845917;
        bh=NpvKN9p/JuZ4HbpTzqncgCux2kvV3pnCRROy2nQo34c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l/7sd0jP8AbI28R5WNx1TsZqJipjk+KnfpPiw1TpTvq++6LviqIkFVsr+U8RArafV
         lkmS9IjoHlp4ITp9FkN7nt0vt2EOfiBT8cdJNllbrode0Ke/CVL2BCq58aJON7UBV6
         xNX/p7wVR5rrBgcVqvQkGNqcaKJ6DAjv43B5dlWk=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190306041833epcas1p1fcf9e9976bf095dde863139e55e16a54~JQ6LqOBok2848628486epcas1p1R;
        Wed,  6 Mar 2019 04:18:33 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.35.04074.91A4F7C5; Wed,  6 Mar 2019 13:18:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190306041832epcas1p4e952ce8934e9cd61b62031e95743b1b4~JQ6LEG9n82262022620epcas1p4g;
        Wed,  6 Mar 2019 04:18:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190306041832epsmtrp2ad29172b371bb09c6381814f1f21f2b2~JQ6LCmDfL2501725017epsmtrp2q;
        Wed,  6 Mar 2019 04:18:32 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-90-5c7f4a19997f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.EE.03971.81A4F7C5; Wed,  6 Mar 2019 13:18:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190306041832epsmtip2909e1f4fec4974e3ebfc78ab4f3f9c0c~JQ6Kx4lfB2314223142epsmtip2i;
        Wed,  6 Mar 2019 04:18:32 +0000 (GMT)
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
Message-ID: <3f413631-1a6f-61f7-58aa-38df3e2ffea4@samsung.com>
Date:   Wed, 6 Mar 2019 13:18:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551781151-5562-5-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeUwTQRTGne52WxqrYwF54IWriUoEWZfiagTxTOMRSdB4BIMburZIr3SL
        iiaKouCFooBBJGpivAoGQbzFRqxoNYjRGI1YVBRjPFBbvBITbbsY+e83b76Z731zKAnNZSpG
        mWNxCHYLb6IpFXnh5riE+Oi5mzITfz8fztVX1sm5I+77cm7v6w8E19Z2VsG1bvmo4J4VDOUe
        XammOH+JG3GVbddl3Bm3V8G1bz5FcTc/FsvT+usanDso3Y3uazLdnkYn0vkbhqeTy3OnGgVe
        L9hjBUu2VZ9jMaTQ8zKyZmZpkxOZeGYyN4mOtfBmIYWeNT89fk6OKdAZHbuGN+UFSum8KNIT
        UqfarXkOIdZoFR0ptGDTm2yTbQkibxbzLIaEbKt5CpOYOFEbEK7MNXr83yibh1v3q6uHLEDF
        43eiMCXgJCiqq5HvRCqlBl9CUFnrQdLAh8BbVKGQBt8RHPjqk/9bcvjECzLIGtyEwF8fJ4k+
        B0TlJbLgRDheBrUtBVRwIgKfRHC9whval8BOBOcqnCioonAcuN49pYI8EI+Exz9fh+pqnArt
        DU2hOolHw66HLSGOxEvhc9dVUtIMAs/BNyEOw3PhwcXykIbAUfDszRGZxCOg8PwhQmp7rwLc
        WxdLPAva/1xVSBwO72839nIM+LslX8Ab4LTHHUoAeDuCRteD3vwsuI6XBQyUAYNxUHdlguQ1
        ALq/7ZYHy4DVsL1II6lHwaOXXpnE0XCseEfv9jqoLi0mS9HIqj5pqvokqOqToOq/2VFEOtFg
        wSaaDYLI2Ji+192AQs82TnsJld+f34ywEtH91aXbNmZq5PwaMd/cjEBJ0BHqjLRNmRq1ns9f
        L9itWfY8kyA2I23gsPcRMZHZ1sAnsDiyGO1ElmW5JCZZyzB0lLoubWamBht4h5ArCDbB/m+d
        TBkWU4CMQ9jpvtufRs9wtboyFt6J/vJ2duGIkhpfz4vkiGNsurGx9vurs756/YGjhedqxl7s
        jPLmPilb7b5FvwpfNCZV1UYYwqZ03B11uiwpsvtM/q5FLZ0dP4ax4o+u6gUstbH17ZJy1dqm
        fq2djv2UV3W5ht/g7mC9q1aYK9z3ZvQsm2ajSdHIM3GEXeT/Amwa7sPMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvK6EV32MwaGHBhYbZ6xntZh/5Byr
        Rf/j18wW589vYLc42/SG3eJWg4zF5V1z2Cw+9x5htJhxfh+Txdojd9ktbjeuYLM4/Kad1YHH
        Y9OqTjaPg+/2MHn0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxsnPX9kKTlpU/Hz6haWBsV2n
        i5GTQ0LARGLesvssXYxcHEICuxkl/n+5wgqRkJSYdvEocxcjB5AtLHH4cDFEzVtGiTMLLzOB
        1AgLREqsOdbABpIQEVjOKDH371KwScwCqxgl3v2dywzRcpdR4vzzUywgLWwCWhL7X9xgA7H5
        BRQlrv54zAhi8wrYSdzetBcsziKgItF96RiYLSoQIXH34gsWiBpBiZMzn4DZnAJeEhe2TwGr
        YRZQl/gz7xIzhC0ucevJfCYIW16ieets5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTnpucW
        GxYY5qWW6xUn5haX5qXrJefnbmIER56W5g7Gy0viDzEKcDAq8fBOaK2LEWJNLCuuzD3EKMHB
        rCTCG+xQHyPEm5JYWZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QD
        o++NmW6xGzcGzQlg/mB+riZMx5Hr8/E922pMr7+smjYrToR3eWl7pop22bMS3UALE/6tEbVx
        Ky9N6G/6p2LaWuW20FYz/PPy/d9cw1yW/q+/uvd70/varAy73bfERXKbd8bctN2pvyz6yHU7
        6Ykcm74q7mf6d/rB6afyNQFH0vQu3GFYIlPkpMRSnJFoqMVcVJwIABeSyv24AgAA
X-CMS-MailID: 20190306041832epcas1p4e952ce8934e9cd61b62031e95743b1b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb@eucas1p2.samsung.com>
        <1551781151-5562-5-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 3. 5. 오후 7:19, Lukasz Luba wrote:
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


I already replied with following comments on v4 patch[1].
But, you didn't reply anything. We can reduce the duplicate
review by keeping the basic review rule.

- Re: [PATCH v4 5/8] dt-bindings: devfreq: add Exynos5422 DMC device description
[1] https://do-db2.lkml.org/lkml/2019/2/3/64


[Following comments were replied on v4 patch[1]]

> +- compatible: Should be "samsung,exynos5422-bus".

The compatible name is wrong.
- exynos5422-bus -> exynos5422-dmc

> +- clock-names : the name of clock used by the bus, "bus".

'bus' is right?

> +- clocks : phandles for clock specified in "clock-names" property.
> +- devfreq-events : phandles for PPMU devices connected to this DMC.

The dt-binging file doesn't contain the any description for 'reg' properties.



> +
> +The example definition of a DMC and PPMU devices declared in DT is shown below:
> +
> +	ppmu_dmc0_0: ppmu@10d00000 {
> +		compatible = "samsung,exynos-ppmu";
> +		reg = <0x10d00000 0x2000>;
> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +		clock-names = "ppmu";
> +		status = "okay";
> +		events {
> +			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +				event-name = "ppmu-event3-dmc0_0";
> +			};
> +		};
> +	};
> +
> +
> +	ppmu_dmc0_1: ppmu@10d10000 {
> +		compatible = "samsung,exynos-ppmu";
> +		reg = <0x10d10000 0x2000>;
> +		clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
> +		clock-names = "ppmu";
> +		status = "okay";
> +		events {
> +			ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
> +				event-name = "ppmu-event3-dmc0_1";
> +			};
> +		};
> +	};
> +
> +	ppmu_dmc1_0: ppmu@10d10000 {
> +		compatible = "samsung,exynos-ppmu";
> +		reg = <0x10d60000 0x2000>;
> +		clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
> +		clock-names = "ppmu";
> +		status = "okay";
> +		events {
> +			ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
> +				event-name = "ppmu-event3-dmc1_0";
> +			};
> +		};
> +	};
> +
> +	ppmu_dmc1_1: ppmu@10d70000 {
> +		compatible = "samsung,exynos-ppmu";
> +		reg = <0x10d70000 0x2000>;
> +		clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
> +		clock-names = "ppmu";
> +		status = "okay";
> +		events {
> +			ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
> +				event-name = "ppmu-event3-dmc1_1";
> +			};
> +		};
> +	};
> +
> +	dmc: memory-controller@10c20000 {
> +		compatible = "samsung,exynos5422-dmc";
> +		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +			<0x10000000 0x1000>;
> +		clocks = 	<&clock CLK_FOUT_SPLL>,
> +				<&clock CLK_MOUT_SCLK_SPLL>,
> +				<&clock CLK_FF_DOUT_SPLL2>,
> +				<&clock CLK_FOUT_BPLL>,
> +				<&clock CLK_MOUT_BPLL>,
> +				<&clock CLK_SCLK_BPLL>,
> +				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +				<&clock CLK_MOUT_MCLK_CDREX>,
> +				<&clock CLK_DOUT_CLK2X_PHY0>,
> +				<&clock CLK_CLKM_PHY0>,
> +				<&clock CLK_CLKM_PHY1>,
> +				<&clock CLK_CDREX_PAUSE>,
> +				<&clock CLK_CDREX_TIMING_SET>;
> +		clock-names =	"fout_spll",
> +				"mout_sclk_spll",
> +				"ff_dout_spll2",
> +				"fout_bpll",
> +				"mout_bpll",
> +				"sclk_bpll",
> +				"mout_mx_mspll_ccore",
> +				"mout_mx_mspll_ccore_phy",
> +				"mout_mclk_cdrex",
> +				"dout_clk2x_phy0",
> +				"clkm_phy0",
> +			        "clkm_phy1",
> +			        "clk_cdrex_pause",
> +			        "clk_cdrex_timing_set";
> +		status = "okay";
> +		operating-points-v2 = <&dmc_opp_table>;
> +		devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
> +				<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
> +	};
> +
> +The needed timings of DRAM memory are stored in dedicated nodes.
> +There are two nodes with regular timings and for bypass mode.
> +
> +	dmc_bypass_mode: bypass_mode {
> +		compatible = "samsung,dmc-bypass-mode";
> +
> +		freq-hz = <400000000>;
> +		volt-uv = <887500>;
> +		dram-timing-row = <0x365a9713>;
> +		dram-timing-data = <0x4740085e>;
> +		dram-timing-power = <0x543a0446>;
> +	};
> +
> +	dram_timing: timing {
> +		compatible = "samsung,dram-timing";
> +
> +		dram-timing-names = "165MHz", "206MHz", "275MHz", "413MHz",
> +				    "543MHz", "633MHz", "728MHz", "825MHz";
> +		dram-timing-row = <0x11223185>, <0x112331C6>, <0x12244287>,
> +				  <0x1B35538A>, <0x244764CD>, <0x2A48758F>,
> +				  <0x30598651>, <0x365A9713>;
> +		dram-timing-data = <0x2720085E>, <0x2720085E>, <0x2720085E>,
> +				   <0x2720085E>, <0x3730085E>, <0x3730085E>,
> +				   <0x3730085E>, <0x4740085E>;
> +		dram-timing-power = <0x140C0225>, <0x180F0225>, <0x1C140225>,
> +				    <0x2C1D0225>, <0x38270335>, <0x402D0335>,
> +				    <0x4C330336>, <0x543A0446>;
> +	};
> +
> +The frequencies supported by the DMC are stored in OPP table v2.
> +
> +	dmc_opp_table: opp_table2 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <165000000>;
> +			opp-microvolt = <875000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <206000000>;
> +			opp-microvolt = <875000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <275000000>;
> +			opp-microvolt = <875000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <413000000>;
> +			opp-microvolt = <887500>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <543000000>;
> +			opp-microvolt = <937500>;
> +		};
> +		opp05 {
> +			opp-hz = /bits/ 64 <633000000>;
> +			opp-microvolt = <1012500>;
> +		};
> +		opp06 {
> +			opp-hz = /bits/ 64 <728000000>;
> +			opp-microvolt = <1037500>;
> +		};
> +		opp07 {
> +			opp-hz = /bits/ 64 <825000000>;
> +			opp-microvolt = <1050000>;
> +		};
> +	};
> +
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
