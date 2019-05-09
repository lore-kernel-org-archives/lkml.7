Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A3C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3836F2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557404969;
	bh=BljvyTbE81ovLkzFUTjNgjLZsjG8lFpQTfmvRrZPXek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=trWfAMS8mi9PZfCJ8nzvVRwOW47Z/FnCrZUTIdIPeXtzl31oUNqGXHgTCw71l4+R1
	 vZ2irTIm6wyDkfTHzwFPmpmojm/PhQWvwGeedJzhNv7BLul6Xu80FJAWgd3I3YKgs7
	 5l71Kb5Dzk5IR8n6xVIQYC3F+qPZLbOAryl5VAhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEIM32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfEIM32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:29:28 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3C4F216C4;
        Thu,  9 May 2019 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557404967;
        bh=BljvyTbE81ovLkzFUTjNgjLZsjG8lFpQTfmvRrZPXek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTvOjxvBZDMGzX2U1AU2dZ2kfxkkcAXvnlJ1tHarIuVUJ+cR/GkjyCXO1RQiAckCN
         SzGpifmThizFaXtA4MtEV3cfxECx4KoGKn4zcZ7CSt/0gvEyHugRkwigo765hJ30rL
         jf3C00g2v7XCOjhdCdcsXXTdfu715jUe0m5fxRkg=
Date:   Thu, 9 May 2019 17:59:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] arm64: dts: qcom: qcs404: Enable PCIe
Message-ID: <20190509122922.GD16052@vkoul-mobl>
References: <20190508224309.5744-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508224309.5744-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-05-19, 15:43, Bjorn Andersson wrote:
> This series defines the PCIe PHY and controller on QCS404 and enable them for
> EVB. This was 1 commit, but per Vinod's request its split up in its individual
> pieces.

Thanks for doing that, all:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
