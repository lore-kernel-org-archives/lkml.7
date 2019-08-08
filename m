Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF9CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1A62171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U6Y32oEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfHHLtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:49:22 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34183 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfHHLtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:49:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190808114919euoutp01517fb4a757ee7a7e0fa6d0242c96ae84~48DAViFEy1345413454euoutp01x
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 11:49:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190808114919euoutp01517fb4a757ee7a7e0fa6d0242c96ae84~48DAViFEy1345413454euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565264959;
        bh=YsMpHCm5oSSkQUQas18GRecP5vKok2vJziLlbC4ttVE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=U6Y32oEbeUYVWCYzrh3tSi/anPOr7hwilsH/krs+o71dKiCyfTtfgBQc3bhaFavC6
         B2uLdtKj9OXiLlslRSB/PclGY73rt0WhHXe0JXE0Ye/AzhYrecf+8q/Xm19GoCy/hq
         ZuELTLSklaywcoWpP7O54ShBwL6agtBZzGnJf8+w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190808114918eucas1p25adb8f5f5ea9734096a234864802677d~48C-dqJXQ2495324953eucas1p2O;
        Thu,  8 Aug 2019 11:49:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3B.E5.04309.E3C0C4D5; Thu,  8
        Aug 2019 12:49:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190808114918eucas1p27ba2ab7216aa55b8a9373e4e1f4bf524~48C_y8k-N2709427094eucas1p2R;
        Thu,  8 Aug 2019 11:49:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808114917eusmtrp265a90de2a25eb4d6de49e982b7e13d00~48C_k2qhc2808328083eusmtrp2c;
        Thu,  8 Aug 2019 11:49:17 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-c1-5d4c0c3e7979
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FF.F4.04166.D3C0C4D5; Thu,  8
        Aug 2019 12:49:17 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190808114917eusmtip17211362d52811c69e9fba44ee3c29593~48C_DFZ-B2373623736eusmtip1P;
        Thu,  8 Aug 2019 11:49:17 +0000 (GMT)
Subject: Re: [PATCH 1/2] clk: samsung: Change signature of
 exynos5_subcmus_init() function
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>, sboyd@kernel.org,
        mturquette@baylibre.com
Cc:     linux@armlinux.org.uk, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c879af19-befc-71a0-5691-38cd873560eb@samsung.com>
Date:   Thu, 8 Aug 2019 13:49:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807162456.28694-1-s.nawrocki@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djPc7p2PD6xBme3qlpsnLGe1eL6l+es
        FufPb2C3+Nhzj9Xi8q45bBYzzu9jsjg0dS+jxcVTrhaH37SzWvy7tpHFgcvj8rWLzB7vb7Sy
        e2xa1cnm0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBmzN7SwF7w3r1ix6DdrA+NivS5GTg4J
        AROJE2f6mLoYuTiEBFYwSvz+tpwNwvnCKLFow3aozGdGiXdnL7DCtOw428kEYgsJLGeUWPpH
        HaLoLaPE45azYEXCAjESN2ZsYwexRYDsCa97WUBsZoHdjBIHf6eA2GwChhJdb7vYQGxeATuJ
        lz+OgdWzCKhIXFzaxQhiiwL17nzTwwxRIyhxcuYToDkcHJwCNhIvX4ZCjJSX2P52DjOELS5x
        68l8Jog7j7FLzOtwgLBdJLq7fkPdLyzx6vgWdghbRuL/zvlgT0oINDNKPDy3lh3C6WGUuNw0
        gxGiylri8PGLrCCLmQU0Jdbv0ocIO0rc+nueDSQsIcAnceOtIMQNfBKTtk1nhgjzSnS0CUFU
        q0nMOr4Obu3BC5eYJzAqzULy2Cwk38xC8s0shL0LGFlWMYqnlhbnpqcWG+WllusVJ+YWl+al
        6yXn525iBCan0/+Of9nBuOtP0iFGAQ5GJR7eghPesUKsiWXFlbmHGCU4mJVEeO+VecYK8aYk
        VlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYAy79Up83+Gbjdxv
        a5m9H6/O1Ngn6qCQP7v88p5Orl+HJpVeF4xNdjl8N6YzfBe7f0u0/FaLD3Pdrjmu0X3IE7fu
        47r4jx0fZ+1UVw4Tn73uBJeV6qy1jTN8Xnd/XrWEp2Et9x7JhkuO8nfav6yL1lyV9kTz1/xd
        YTOibRoZ56SuW6GhPW/35gVKLMUZiYZazEXFiQCNGhHiSgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7q2PD6xBm23TCw2zljPanH9y3NW
        i/PnN7BbfOy5x2pxedccNosZ5/cxWRyaupfR4uIpV4vDb9pZLf5d28jiwOVx+dpFZo/3N1rZ
        PTat6mTz6NuyitHj8ya5ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYzZG1rYC96bV6xY9Ju1gXGxXhcjJ4eEgInEjrOdTF2MXBxCAksZJTau
        /80OkZCRODmtgRXCFpb4c62LDaLoNaPEgr0HGEESwgIxEjdmbANrEAGyf8/5xgRiMwvsZpT4
        9JMboqGfUeLV7Idgk9gEDCW63oJM4uTgFbCTePnjGFgzi4CKxMWlXWBDRYEG7TuznR2iRlDi
        5MwnLF2MHBycAjYSL1+GQsw3k5i3+SEzhC0vsf3tHChbXOLWk/lMExiFZiHpnoWkZRaSlllI
        WhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjMhtx35u3sF4aWPwIUYBDkYlHt6CE96x
        QqyJZcWVuYcYJTiYlUR475V5xgrxpiRWVqUW5ccXleakFh9iNAX6bSKzlGhyPjBZ5JXEG5oa
        mltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYHRexJm4adl9nV+p+put+E/M
        5upTCDvTniXqWFB6pOzqtldsRty5GzfLPvy+6FFHgmn/gcSFX0US1Xe3PeV4MFf756KVmzge
        3TUyrd6VrdlRtmWzZ5B0oMif0/c1zs87O1HnK5ff+7my01VLo+cqncyYdFjsKZtrqfDxHI7+
        79EzVhVkvu97G6XEUpyRaKjFXFScCAD1n3f03gIAAA==
X-CMS-MailID: 20190808114918eucas1p27ba2ab7216aa55b8a9373e4e1f4bf524
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190807162511eucas1p2eedb33bdee87f80528b59bb4e869daf1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190807162511eucas1p2eedb33bdee87f80528b59bb4e869daf1
References: <CGME20190807162511eucas1p2eedb33bdee87f80528b59bb4e869daf1@eucas1p2.samsung.com>
        <20190807162456.28694-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-08-07 18:24, Sylwester Nawrocki wrote:
> In order to make it easier in subsequent patch to create different subcmu
> lists for exynos5420 and exynos5800 SoCs the code is rewritten so we pass
> an array of pointers to the subcmus initialization function.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos5-subcmu.c | 16 +++----
>   drivers/clk/samsung/clk-exynos5-subcmu.h |  2 +-
>   drivers/clk/samsung/clk-exynos5250.c     |  7 ++-
>   drivers/clk/samsung/clk-exynos5420.c     | 60 ++++++++++++++----------
>   4 files changed, 49 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
> index 91db7894125d..65c82d922b05 100644
> --- a/drivers/clk/samsung/clk-exynos5-subcmu.c
> +++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
> @@ -14,7 +14,7 @@
>   #include "clk-exynos5-subcmu.h"
>   
>   static struct samsung_clk_provider *ctx;
> -static const struct exynos5_subcmu_info *cmu;
> +static const struct exynos5_subcmu_info **cmu;
>   static int nr_cmus;
>   
>   static void exynos5_subcmu_clk_save(void __iomem *base,
> @@ -56,17 +56,17 @@ static void exynos5_subcmu_defer_gate(struct samsung_clk_provider *ctx,
>    * when OF-core populates all device-tree nodes.
>    */
>   void exynos5_subcmus_init(struct samsung_clk_provider *_ctx, int _nr_cmus,
> -			  const struct exynos5_subcmu_info *_cmu)
> +			  const struct exynos5_subcmu_info **_cmu)
>   {
>   	ctx = _ctx;
>   	cmu = _cmu;
>   	nr_cmus = _nr_cmus;
>   
>   	for (; _nr_cmus--; _cmu++) {
> -		exynos5_subcmu_defer_gate(ctx, _cmu->gate_clks,
> -					  _cmu->nr_gate_clks);
> -		exynos5_subcmu_clk_save(ctx->reg_base, _cmu->suspend_regs,
> -					_cmu->nr_suspend_regs);
> +		exynos5_subcmu_defer_gate(ctx, (*_cmu)->gate_clks,
> +					  (*_cmu)->nr_gate_clks);
> +		exynos5_subcmu_clk_save(ctx->reg_base, (*_cmu)->suspend_regs,
> +					(*_cmu)->nr_suspend_regs);
>   	}
>   }
>   
> @@ -163,9 +163,9 @@ static int __init exynos5_clk_probe(struct platform_device *pdev)
>   		if (of_property_read_string(np, "label", &name) < 0)
>   			continue;
>   		for (i = 0; i < nr_cmus; i++)
> -			if (strcmp(cmu[i].pd_name, name) == 0)
> +			if (strcmp(cmu[i]->pd_name, name) == 0)
>   				exynos5_clk_register_subcmu(&pdev->dev,
> -							    &cmu[i], np);
> +							    cmu[i], np);
>   	}
>   	return 0;
>   }
> diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.h b/drivers/clk/samsung/clk-exynos5-subcmu.h
> index 755ee8aaa3de..9ae5356f25aa 100644
> --- a/drivers/clk/samsung/clk-exynos5-subcmu.h
> +++ b/drivers/clk/samsung/clk-exynos5-subcmu.h
> @@ -21,6 +21,6 @@ struct exynos5_subcmu_info {
>   };
>   
>   void exynos5_subcmus_init(struct samsung_clk_provider *ctx, int nr_cmus,
> -			  const struct exynos5_subcmu_info *cmu);
> +			  const struct exynos5_subcmu_info **cmu);
>   
>   #endif
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index f2b896881768..931c70a4da19 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -681,6 +681,10 @@ static const struct exynos5_subcmu_info exynos5250_disp_subcmu = {
>   	.pd_name	= "DISP1",
>   };
>   
> +static const struct exynos5_subcmu_info *exynos5250_subcmus[] = {
> +	&exynos5250_disp_subcmu,
> +};
> +
>   static const struct samsung_pll_rate_table vpll_24mhz_tbl[] __initconst = {
>   	/* sorted in descending order */
>   	/* PLL_36XX_RATE(rate, m, p, s, k) */
> @@ -843,7 +847,8 @@ static void __init exynos5250_clk_init(struct device_node *np)
>   
>   	samsung_clk_sleep_init(reg_base, exynos5250_clk_regs,
>   			       ARRAY_SIZE(exynos5250_clk_regs));
> -	exynos5_subcmus_init(ctx, 1, &exynos5250_disp_subcmu);
> +	exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5250_subcmus),
> +			     exynos5250_subcmus);
>   
>   	samsung_clk_of_add_provider(np, ctx);
>   
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 01bca5a498b2..fdb17c799aa5 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1281,32 +1281,40 @@ static struct exynos5_subcmu_reg_dump exynos5x_mfc_suspend_regs[] = {
>   	{ DIV4_RATIO, 0, 0x3 },			/* DIV dout_mfc_blk */
>   };
>   
> -static const struct exynos5_subcmu_info exynos5x_subcmus[] = {
> -	{
> -		.div_clks	= exynos5x_disp_div_clks,
> -		.nr_div_clks	= ARRAY_SIZE(exynos5x_disp_div_clks),
> -		.gate_clks	= exynos5x_disp_gate_clks,
> -		.nr_gate_clks	= ARRAY_SIZE(exynos5x_disp_gate_clks),
> -		.suspend_regs	= exynos5x_disp_suspend_regs,
> -		.nr_suspend_regs = ARRAY_SIZE(exynos5x_disp_suspend_regs),
> -		.pd_name	= "DISP",
> -	}, {
> -		.div_clks	= exynos5x_gsc_div_clks,
> -		.nr_div_clks	= ARRAY_SIZE(exynos5x_gsc_div_clks),
> -		.gate_clks	= exynos5x_gsc_gate_clks,
> -		.nr_gate_clks	= ARRAY_SIZE(exynos5x_gsc_gate_clks),
> -		.suspend_regs	= exynos5x_gsc_suspend_regs,
> -		.nr_suspend_regs = ARRAY_SIZE(exynos5x_gsc_suspend_regs),
> -		.pd_name	= "GSC",
> -	}, {
> -		.div_clks	= exynos5x_mfc_div_clks,
> -		.nr_div_clks	= ARRAY_SIZE(exynos5x_mfc_div_clks),
> -		.gate_clks	= exynos5x_mfc_gate_clks,
> -		.nr_gate_clks	= ARRAY_SIZE(exynos5x_mfc_gate_clks),
> -		.suspend_regs	= exynos5x_mfc_suspend_regs,
> -		.nr_suspend_regs = ARRAY_SIZE(exynos5x_mfc_suspend_regs),
> -		.pd_name	= "MFC",
> -	},
> +static const struct exynos5_subcmu_info exynos5x_disp_subcmu = {
> +	.div_clks	= exynos5x_disp_div_clks,
> +	.nr_div_clks	= ARRAY_SIZE(exynos5x_disp_div_clks),
> +	.gate_clks	= exynos5x_disp_gate_clks,
> +	.nr_gate_clks	= ARRAY_SIZE(exynos5x_disp_gate_clks),
> +	.suspend_regs	= exynos5x_disp_suspend_regs,
> +	.nr_suspend_regs = ARRAY_SIZE(exynos5x_disp_suspend_regs),
> +	.pd_name	= "DISP",
> +};
> +
> +static const struct exynos5_subcmu_info exynos5x_gsc_subcmu = {
> +	.div_clks	= exynos5x_gsc_div_clks,
> +	.nr_div_clks	= ARRAY_SIZE(exynos5x_gsc_div_clks),
> +	.gate_clks	= exynos5x_gsc_gate_clks,
> +	.nr_gate_clks	= ARRAY_SIZE(exynos5x_gsc_gate_clks),
> +	.suspend_regs	= exynos5x_gsc_suspend_regs,
> +	.nr_suspend_regs = ARRAY_SIZE(exynos5x_gsc_suspend_regs),
> +	.pd_name	= "GSC",
> +};
> +
> +static const struct exynos5_subcmu_info exynos5x_mfc_subcmu = {
> +	.div_clks	= exynos5x_mfc_div_clks,
> +	.nr_div_clks	= ARRAY_SIZE(exynos5x_mfc_div_clks),
> +	.gate_clks	= exynos5x_mfc_gate_clks,
> +	.nr_gate_clks	= ARRAY_SIZE(exynos5x_mfc_gate_clks),
> +	.suspend_regs	= exynos5x_mfc_suspend_regs,
> +	.nr_suspend_regs = ARRAY_SIZE(exynos5x_mfc_suspend_regs),
> +	.pd_name	= "MFC",
> +};
> +
> +static const struct exynos5_subcmu_info *exynos5x_subcmus[] = {
> +	&exynos5x_disp_subcmu,
> +	&exynos5x_gsc_subcmu,
> +	&exynos5x_mfc_subcmu,
>   };
>   
>   static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __initconst = {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

