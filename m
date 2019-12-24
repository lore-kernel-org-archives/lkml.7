Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E33C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 03:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958C0206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 03:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NXrPG4sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLXDlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 22:41:42 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:59330 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbfLXDlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 22:41:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577158902; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=dYhwXDr0EF7Rb2PsNAa3MjNox3b+pr5E1/iA4TJHggs=; b=NXrPG4sbzrwTe+GjIzeFeYOi7EPCEak6FlCrsvGCGo3jl/SrFEzBvnLGS23LjnrxBSAvJaja
 usxO5wxThf9IpD5gYmTCnjhfiYAD+GPHe6YqqU4GsdDopFBg/rdpX/sbd7QAeupffkU7N+Xq
 Cv6lPpqgo7vbL2oMUXUR0hdEc4Q=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0188f4.7f5a48758228-smtp-out-n01;
 Tue, 24 Dec 2019 03:41:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B93E2C43383; Tue, 24 Dec 2019 03:41:39 +0000 (UTC)
Received: from [10.206.24.214] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C941C433CB;
        Tue, 24 Dec 2019 03:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C941C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v3 1/4] phy: qcom-qmp: Use register defines
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20191223143046.3376299-1-vkoul@kernel.org>
 <20191223143046.3376299-2-vkoul@kernel.org>
From:   Manu Gautam <mgautam@codeaurora.org>
Message-ID: <fa7f3be0-aa25-a185-0344-aa1341a4a6cc@codeaurora.org>
Date:   Tue, 24 Dec 2019 09:11:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191223143046.3376299-2-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/23/2019 8:00 PM, Vinod Koul wrote:
> We already define register offsets so use them in register layout.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 66f91726b8b2..1196c85aa023 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -166,8 +166,8 @@ static const unsigned int sdm845_ufsphy_regs_layout[] = {
>  };
>  
>  static const unsigned int sm8150_ufsphy_regs_layout[] = {
> -	[QPHY_START_CTRL]		= 0x00,
> -	[QPHY_PCS_READY_STATUS]		= 0x180,
> +	[QPHY_START_CTRL]		= QPHY_V4_PHY_START,
> +	[QPHY_PCS_READY_STATUS]		= QPHY_V4_PCS_READY_STATUS,
>  };
>  
>  static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {

Reviewed-by: Manu Gautam <mgautam@codeaurora.org>


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
