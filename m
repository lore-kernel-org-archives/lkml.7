Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF666C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57792173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565267163;
	bh=bK3z6ftR83i+lITMLOXKc0mEPPnm8V7ixfUTRNhwjwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cUQaM4nxI0+pqtylaVQHHIHRXGShC6BDWgFk5L68tTyjO1roi+HBnUyuvnEmlRYzC
	 pKvY6oSy78+LIOAiS26eGbEwhRKTAU2W8asQssPhvOC8waGcODspCgNmOC/nWMO1OR
	 BKMzvB6Mf4c4mQRakA2HojOPAHmA/Ta1+EXCcIfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbfHHM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbfHHM0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:26:00 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C92342171F;
        Thu,  8 Aug 2019 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565267159;
        bh=bK3z6ftR83i+lITMLOXKc0mEPPnm8V7ixfUTRNhwjwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HyVsH+WuONGqok87vzWDFSnxJWe3dQw6iEIwWCrrjpOPWEN9i2vEKLtT6Bx4jNoBc
         lY2TgNgfrUofVTuo3gtk17jT0JIwtQc7jfNcEqAQTvtIJQ65B3G1toqT8OxKoikxOg
         2LiwaApqvvjEDCtv3sbhQJH9OXhdCzR7KnFCSeTw=
Date:   Thu, 8 Aug 2019 17:54:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [RESEND PATCH v7] dmaengine: fsl-edma: add i.mx7ulp edma2
 version support
Message-ID: <20190808122448.GR12733@vkoul-mobl.Dlink>
References: <1563952834-7731-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563952834-7731-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-19, 15:20, Robin Gong wrote:
> Add edma2 for i.mx7ulp by version v3, since v2 has already
> been used by mcf-edma.
> The big changes based on v1 are belows:
> 1. only one dmamux.
> 2. another clock dma_clk except dmamux clk.
> 3. 16 independent interrupts instead of only one interrupt for
> all channels.

Applied, thanks

-- 
~Vinod
