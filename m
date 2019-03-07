Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B54C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E3620675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WT0UuWgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCGNlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:41:10 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:14484 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGNlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:41:10 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190307134105epoutp03953747e364b43d4198d57ae7e397493c~JsOn_C2oC1547415474epoutp03f;
        Thu,  7 Mar 2019 13:41:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190307134105epoutp03953747e364b43d4198d57ae7e397493c~JsOn_C2oC1547415474epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551966065;
        bh=tuY0V2hQ0xnL8MZ2fYDm3YQA10+gIrw7uUknKZUCN4M=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=WT0UuWgPTNgeZzSjUyj1w2O6/n4guIIDulC6f/cLZodOBedRrD+1y89JpsOjwW0DH
         wlwiwTGehRDsysqKsnyvnSOwX21fEY8H55Mp1ZCOaxYTrAi8/bQ0pyvivAfIjhAVy1
         1gcD1g5Pk3Bq1zFuPRc0DiNLguWZN+a6yuFSn6ds=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190307134104epcas1p47fff26b92bdb80be28e3e396fa43f686~JsOmy83pU0933709337epcas1p4o;
        Thu,  7 Mar 2019 13:41:04 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.28.04206.07F118C5; Thu,  7 Mar 2019 22:41:04 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190307134104epcas1p20dcaeca23c8c0ffcce95338b7f72e58f~JsOmmj7ti3124431244epcas1p2N;
        Thu,  7 Mar 2019 13:41:04 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-89-5c811f701a84
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 9D.C6.04015.F6F118C5; Thu,  7 Mar
        2019 22:41:04 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PO0002NU0OAVD60@mmp2.samsung.com>; Thu, 07 Mar 2019 22:41:03 +0900 (KST)
Subject: Re: [PATCH v5 4/8] dt-bindings: devfreq: add Exynos5422 DMC device
 description
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-samsung-soc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        myungjoo.ham@samsung.com, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <921009e2-ab0b-b024-4400-b60e96eab81b@samsung.com>
Date:   Thu, 07 Mar 2019 14:40:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-version: 1.0
In-reply-to: <1551781151-5562-5-git-send-email-l.luba@partner.samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7bCmnm6BfGOMQf9FUYuNM9azWlz/8pzV
        Yv6Rc6wW/Y9fM1ucP7+B3eJs0xt2i1sNMhaXd81hs/jce4TRYsb5fUwWa4/cZbdYev0ik8Xt
        xhVsFv/37GB34PNYM28No8emVZ1sHgff7WHy6NuyitHj8ya5ANYoLpuU1JzMstQifbsEroxz
        93vZCrYaVDxr/cbWwPhftYuRk0NCwESi4ddr1i5GLg4hgR2MEq2rL0E53xklFnZtZ4epmjz/
        FAtEYgOjxOblz6Cq7jNK3Hp3jBGkSlggUmLNsQY2EFtEIFCiYe4ysCJmgaNMEquXTWMGSbAJ
        GEr0Hu0Da+AVsJP4snkT2AoWAVWJCze7wGpEBSIk3j/dzQJRIyjxY/I9MJtTwEvi0dqFTCA2
        s4CmxIsvk1ggbHGJY/dvMkLY8hKb17xlBlksIdDMLvH19zWoH1wkzp7dB9TAAWRLS1w6agsR
        rpbYtb0bqr6DUaLlwnZmiIS1xOHjF1khhvJJvPvawwrRyyvR0SYEUeIhMWdCO9gNQgJ3GSV+
        PWGdwCgzC8nZs5CcOgvJqbOQnLqAkWUVo1hqQXFuemqxYYGpXnFibnFpXrpecn7uJkZwqtGy
        3MF47JzPIUYBDkYlHl6Gk/UxQqyJZcWVuYcYJTiYlUR4/0k1xgjxpiRWVqUW5ccXleakFh9i
        lOZgURLnXe/gHCMkkJ5YkpqdmlqQWgSTZeLglGpgnPFi32T7Bp3NMR8KWkTDb7DZ3ZyUfOjT
        Df7EkvoN7yv6Lhzq7Nm3tj33zkJxFrPfUYw7mYXCBbZtlzD6cI1Jit372ZaPr5K9NF789V6Z
        8idQTs/qb1ZOSsg873oOoz05/Ps/VKT/0GDM4V1/9/6L2Ja+oAhpu4ooPbfPr5fvs7DZJnpK
        5rStEktxRqKhFnNRcSIA/rtYOzEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e+xoG6BfGOMwc0bTBYbZ6xntbj+5Tmr
        xfwj51gt+h+/ZrY4f34Du8XZpjfsFrcaZCwu75rDZvG59wijxYzz+5gs1h65y26x9PpFJovb
        jSvYLP7v2cHuwOexZt4aRo9NqzrZPA6+28Pk0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBnn
        7veyFWw1qHjW+o2tgfG/ahcjJ4eEgInE5PmnWEBsIYF1jBKXG+27GLmA7IeMErNvzmIGSQgL
        REqsOdbABmKLCPhLbJp7lQWkiFngKJPE7zW7GCE67jJKnH8OMYpNwFCi92gfI4jNK2An8WXz
        JnYQm0VAVeLCzS6wqaICERJ3L75ggagRlPgx+R6YzSngJfFo7UKmLkYOoA3qElOm5IKEmQXE
        JY7dv8kIYctLbF7zlnkCo8AsJN2zEDpmIemYhaRjASPLKkbJ1ILi3PTcYqMCw7zUcr3ixNzi
        0rx0veT83E2MwEjadlirbwfj/SXxhxgFOBiVeHgTLtXHCLEmlhVX5h5ilOBgVhLh/SfVGCPE
        m5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QDY+8hRluP3cKh
        dW+Ed0V222juerC4xs/Nrf+Ms1a06mSjfb87V0qrGTr+d7zBevuX7P0vTgw3jrWw3Pxz+VJS
        Wzj/zAVOx3SuV6xdbfxRQGXd8QyO2E/9pU2Sx91SlrX4+s563i17ZZJmnikDx6R731JXsYf/
        bJbcfNpR8tWr6BYtBifuKK6XSizFGYmGWsxFxYkAbFcw36ACAAA=
X-CMS-MailID: 20190307134104epcas1p20dcaeca23c8c0ffcce95338b7f72e58f
CMS-TYPE: 101P
X-CMS-RootMailID: 20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101926eucas1p2eee36b9cb50cbcf511fab7bae59e24bb@eucas1p2.samsung.com>
        <1551781151-5562-5-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding DT maintainers at Cc)

On 3/5/19 11:19, Lukasz Luba wrote:
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

I would avoid talking about "driver" and would focus more on describing actual
hardware here. 

> +Required properties for DMC device for Exynos5422:
> +- compatible: Should be "samsung,exynos5422-bus".
> +- clock-names : the name of clock used by the bus, "bus".
> +- clocks : phandles for clock specified in "clock-names" property.
> +- devfreq-events : phandles for PPMU devices connected to this DMC.

Couldn't this simply be arm,ppmus or samsung,ppmus? devfreq-events sounds like
a Linux or software specific term rather than a hardware description.

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

Couldn't this "bypass" case be included on the list within the "timing node"
(row/data/power values) and (freq-hz, volt-uv) as an OPP in dmc_opp_table
or new table?

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

We should have the meaning of each property described here and as these are
vendor specific properties there should be vendor prefix in the names.

However, I would rather see real DRAM timing parameters listed in DT and 
the driver deriving those register values from such parameters. Until that's
possible it might be better to keep this raw data in the driver and avoid 
pushing it to DT.

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

--
Regards, 
Sylwester
