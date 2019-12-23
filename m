Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D93C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5108206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NWkMI6rv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfLWInh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:43:37 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:59585 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbfLWInh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:43:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577090617; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=DBAwlHo4z9mxlOrvHQaCfIjZ0sNHg6zZbxKTPb32waE=;
 b=NWkMI6rvOD/R7SrLzyl2O9+w7WMrpyNyUPZnZlWozp0XLq6HjHKyVU+EwJ0b/eS5B2VOfs/I
 RnuxBX0fprandLJWF4K290H/U1YfYb9IYDXQbqvDN3Qc6/Wn5igqCldNSOREpx6VbEOA9WWt
 ylWfu0CufPF7MkvUe3HNadIS/dA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e007e31.7f5339308378-smtp-out-n01;
 Mon, 23 Dec 2019 08:43:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59B31C4479D; Mon, 23 Dec 2019 08:43:28 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D29BC43383;
        Mon, 23 Dec 2019 08:43:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Dec 2019 16:43:27 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] phy: qcom-qmp: Use register defines
In-Reply-To: <20191220101719.3024693-3-vkoul@kernel.org>
References: <20191220101719.3024693-1-vkoul@kernel.org>
 <20191220101719.3024693-3-vkoul@kernel.org>
Message-ID: <341446449242684d4b5a0296d3331b0c@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-20 18:17, Vinod Koul wrote:
> We already define register offsets so use them in register layout.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
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

Missed QPHY_SW_RESET?

Regards,
Can Guo.

>  };
> 
>  static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {
