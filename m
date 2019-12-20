Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C0EC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF819206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576815756;
	bh=Puza4F4qgk4RDqbJT+7VKvoL6ZDUdD3ktZeuxippD+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZU0t0kCnqT/zRiefNN5OAHtTy9ZWcFLaR8MlBYmgqKHfOepb7llkuPG5P1NJ58Awp
	 8vzgD+MPYeXsBVGxl8OzshdyDs7mGlNwqt9C+2kSs2mAk66VhODDZkTaADre8AwFWe
	 r9V7n2TndyeUNkuPi4Jt0cysbfpgRFNBGrGJo58o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLTEWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfLTEWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:22:35 -0500
Received: from localhost (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B7E4206EF;
        Fri, 20 Dec 2019 04:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576815755;
        bh=Puza4F4qgk4RDqbJT+7VKvoL6ZDUdD3ktZeuxippD+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ET2sPU5JjID/dzNdAzf1z7ndYsmcMj8DBAIlQd2GKmYG/avJxf3XEo084C8klnvy7
         bGR/dq/Tg4MxsUnhhgVsndHPd46UxPO2O9dvA5Sju+J22paAea/kF4TP90Yrk4WvyC
         K1LNwjwricLkJ2ekjHuFZHm9tbmKyC1PeiPSc+YM=
Date:   Fri, 20 Dec 2019 09:52:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cang@codeaurora.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] phy: qcom-qmp: Use register defines
Message-ID: <20191220042230.GD2536@vkoul-mobl>
References: <20191219150433.2785427-1-vkoul@kernel.org>
 <20191219150433.2785427-3-vkoul@kernel.org>
 <9e69d0b803cdbfe69d6edb62b8aa9b24@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e69d0b803cdbfe69d6edb62b8aa9b24@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-19, 08:44, cang@codeaurora.org wrote:
> On 2019-12-19 23:04, Vinod Koul wrote:
> > We already define register offsets so use them in register layout.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > index c2e800a3825a..06f971ca518e 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > @@ -166,8 +166,8 @@ static const unsigned int
> > sdm845_ufsphy_regs_layout[] = {
> >  };
> > 
> >  static const unsigned int sm8150_ufsphy_regs_layout[] = {
> > -	[QPHY_START_CTRL]		= 0x00,
> > -	[QPHY_PCS_READY_STATUS]		= 0x180,
> > +	[QPHY_START_CTRL]		= QPHY_V4_PHY_START,
> > +	[QPHY_SW_RESET]			= QPHY_V4_SW_RESET,
> >  };
> > 
> >  static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {
> 
> Why is the QPHY_PCS_READY_STATUS removed here? Then what "status" are we
> polling here for UFS PHY?
> 
> <snip>
>      if (cfg->type == PHY_TYPE_UFS) {
>          status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
>          mask = PCS_READY;
>          ready = PCS_READY;
>      } else {
> <snip>

Good catch Can, I dont think I intended it that way. Will fix it up!

Thanks
-- 
~Vinod
