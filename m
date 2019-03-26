Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7167C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD822070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfCZQKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:10:32 -0400
Received: from ns.iliad.fr ([212.27.33.1]:37364 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCZQKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:10:32 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 8CF8A20A8D;
        Tue, 26 Mar 2019 17:10:30 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 71BE9208E6;
        Tue, 26 Mar 2019 17:10:30 +0100 (CET)
Subject: Re: [PATCH v2 1/2] phy: qcom-qmp: Add msm8998 PCIe QMP PHY support
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
References: <a897277d-23b3-9746-81dc-28f8925a9992@free.fr>
 <136857e7-0fe1-6fc6-729e-2cbf6ea72386@ti.com>
 <3e9f0a18-0e0f-3790-fbbe-650bf8536ad9@free.fr>
Message-ID: <8358b1d4-a479-2c2f-13b3-411832a13278@free.fr>
Date:   Tue, 26 Mar 2019 17:10:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3e9f0a18-0e0f-3790-fbbe-650bf8536ad9@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Mar 26 17:10:30 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 14:24, Marc Gonzalez wrote:

> +static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
> +	.type			= PHY_TYPE_PCIE,
> +	.nlanes			= 1,
> +
> +	.serdes_tbl		= msm8998_pcie_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(msm8998_pcie_serdes_tbl),
> +	.tx_tbl			= msm8998_pcie_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(msm8998_pcie_tx_tbl),
> +	.rx_tbl			= msm8998_pcie_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(msm8998_pcie_rx_tbl),
> +	.pcs_tbl		= msm8998_pcie_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(msm8998_pcie_pcs_tbl),
> +	.clk_list		= msm8996_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
> +	.reset_list		= msm8996_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(msm8996_pciephy_reset_l),

Looking more closely at the code downstream, it looks like the
reset situation is slightly different. Let me spin a v3.

Regards.
