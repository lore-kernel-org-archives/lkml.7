Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2193EC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAF1227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Icotu/xE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfLTAof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:44:35 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:28276 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbfLTAof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:44:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576802674; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6xe+Bi/b3YFf+5YXiGnceVZDQa8BVLlPiBIbPciKOWY=;
 b=Icotu/xE2tHdfZ50IIPyacxn5W9/1XcjPXBdNejKYF28KlZjYau5PD8xfoLsuKpJrBzN/ACT
 b2m7PGGh+X22kLvCNQBdA6IBYnUUuFJnHmgzc7+gT23kP64/24c/kwoPLbB0uKwYhuDlk8jL
 m7Rsu9MjqvJcLVOOsUzaglKN6Bw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfc196a.7f82852ae998-smtp-out-n02;
 Fri, 20 Dec 2019 00:44:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2475C4479D; Fri, 20 Dec 2019 00:44:25 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FCEBC43383;
        Fri, 20 Dec 2019 00:44:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Dec 2019 08:44:25 +0800
From:   cang@codeaurora.org
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] phy: qcom-qmp: Use register defines
In-Reply-To: <20191219150433.2785427-3-vkoul@kernel.org>
References: <20191219150433.2785427-1-vkoul@kernel.org>
 <20191219150433.2785427-3-vkoul@kernel.org>
Message-ID: <9e69d0b803cdbfe69d6edb62b8aa9b24@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-19 23:04, Vinod Koul wrote:
> We already define register offsets so use them in register layout.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c
> b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index c2e800a3825a..06f971ca518e 100644
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
> +	[QPHY_SW_RESET]			= QPHY_V4_SW_RESET,
>  };
> 
>  static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {

Why is the QPHY_PCS_READY_STATUS removed here? Then what "status" are we
polling here for UFS PHY?

<snip>
      if (cfg->type == PHY_TYPE_UFS) {
          status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
          mask = PCS_READY;
          ready = PCS_READY;
      } else {
<snip>

Can Guo.
