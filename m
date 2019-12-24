Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C04C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 03:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98913206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 03:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TM5MC1gC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfLXDkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 22:40:45 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:46556 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbfLXDkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 22:40:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577158844; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=o055qUdsHAkYGzC5Rt1tvCMt0HqkxRXhNMtFmQh+Wu8=; b=TM5MC1gCreZBMGSGvvXAcZsiE5Ry7dL8BPxMLTjTHEOQo637MnFKjf4R67i98fPdyqseNjtd
 YvxSZq5Rkjmx7h/6b/tc6HJUzd43baMW2+pl8WziBjG3L9650XrJeOW+ScjAZHOJDwQgyvs1
 dtLk1q1tD83vUae3FOfGhkpt/xQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0188b8.7f70b32e3ce0-smtp-out-n03;
 Tue, 24 Dec 2019 03:40:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 672D7C447AF; Tue, 24 Dec 2019 03:40:39 +0000 (UTC)
Received: from [10.206.24.214] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7946C447A2;
        Tue, 24 Dec 2019 03:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7946C447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v3 4/4] phy: qcom-qmp: Add SW reset register
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20191223143046.3376299-1-vkoul@kernel.org>
 <20191223143046.3376299-5-vkoul@kernel.org>
From:   Manu Gautam <mgautam@codeaurora.org>
Message-ID: <a963192f-b3e1-0254-d380-79604f10e09f@codeaurora.org>
Date:   Tue, 24 Dec 2019 09:10:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191223143046.3376299-5-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/23/2019 8:00 PM, Vinod Koul wrote:
> For V4 QMP UFS Phy, we need to assert reset bits, configure the phy and
> then deassert it, so add the QPHY_SW_RESET register which does this.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index ce5e18f188c3..7db2a94f7a99 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -168,6 +168,7 @@ static const unsigned int sdm845_ufsphy_regs_layout[] = {
>  static const unsigned int sm8150_ufsphy_regs_layout[] = {
>  	[QPHY_START_CTRL]		= QPHY_V4_PHY_START,
>  	[QPHY_PCS_READY_STATUS]		= QPHY_V4_PCS_READY_STATUS,
> +	[QPHY_SW_RESET]			= QPHY_V4_SW_RESET,
>  };
>  
>  static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {

Reviewed-by: Manu Gautam <mgautam@codeaurora.org>


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
