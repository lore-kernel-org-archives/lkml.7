Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC7C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 05:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA7C2063A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 05:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kexs5sDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLXFt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 00:49:59 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:61516 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbfLXFt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 00:49:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577166598; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=CFnavtNpq98L4zVKbo5v3U5dZHO4SedTs2LixKWu2/0=;
 b=kexs5sDEhPQ/l8WC88LoKWsfPCuoaTQlrAWMIXc/id1m1XmG1EN3MbDenXvBHHucUsYD/OSi
 eGxSceaTmWcT7bmZph9YONEOb4waS8wSfp923zoW0487M0Cd37pzNMd/fS66RhoY65T1OU7N
 EBq7uNh/wxCHHVdigVy2vp2xidc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e01a701.7ff5e729db90-smtp-out-n02;
 Tue, 24 Dec 2019 05:49:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 081CAC447A3; Tue, 24 Dec 2019 05:49:53 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F13AC433CB;
        Tue, 24 Dec 2019 05:49:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Dec 2019 13:49:52 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] phy: qcom-qmp: Use register defines
In-Reply-To: <20191223143046.3376299-2-vkoul@kernel.org>
References: <20191223143046.3376299-1-vkoul@kernel.org>
 <20191223143046.3376299-2-vkoul@kernel.org>
Message-ID: <dd87f98b4dce29c4a509f03265b0a3aa@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-23 22:30, Vinod Koul wrote:
> We already define register offsets so use them in register layout.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Can Guo <cang@codeaurora.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c
> b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 66f91726b8b2..1196c85aa023 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -166,8 +166,8 @@ static const unsigned int 
> sdm845_ufsphy_regs_layout[] = {
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
