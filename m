Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72764C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485922187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573060100;
	bh=wmLHBRowqgj8WO8cDFITDoAKnZVvMcJ9OldphjgPD9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O9E1Kkl0QHR7dLES4rjxEb1JqNG7JHa6ABLv2j0Xr4qPdTbBlwxEEfckoaz37RcZc
	 hLulalAsjcOT72xF7hEWJHD+3BTyuO1c2/oGIyPyNlartvejA2dD9tfbYyjRatyrDH
	 HQRvdPhPf01j0gTUp8BiPowqx1wAjqH28YrLAeio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfKFRIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbfKFRIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:08:19 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C557521848;
        Wed,  6 Nov 2019 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573060098;
        bh=wmLHBRowqgj8WO8cDFITDoAKnZVvMcJ9OldphjgPD9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOzB3YCAvxO7BCN5xbbDWRCHUSwUsYcyvGPJQzkp2KUBOjXgUx1XVPaEPnMI4BL9Q
         LG96b93FUgz3iNrvsaeY6SwQeqeZX55kBGReH5/PA/gn48iB16gp8fFSVkUYEqOE6N
         nu+p48MBCtkSW6R0ii1gH+LeOjLZ2e9U07Hs8duM=
Date:   Wed, 6 Nov 2019 22:38:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dan.j.williams@intel.com,
        michal.simek@xilinx.com, anirudha.sarangi@xilinx.com,
        nick.graumann@gmail.com, andrea.merello@gmail.com,
        appana.durga.rao@xilinx.com, mcgrof@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH -next 0/6] dmaengine: xilinx_dma: Add Xilinx AXI MCDMA
 Engine driver support
Message-ID: <20191106170813.GJ952516@vkoul-mobl>
References: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 22:30, Radhey Shyam Pandey wrote:
> This patchset adds Xilinx AXI MCDMA IP support. The AXI MCDMA provides
> high-bandwidth direct memory access between memory and AXI4-Stream target
> peripherals. It supports up to 16 independent read/write channels.
> 
> MCDMA IP supports per channel interrupt output but driver support one
> interrupt per channel for simplification. IP specification/programming
> sequence and register description is mentioned in PG [1].
> 
> The driver is tested with xilinx internal dmatest client. In end usecase
> MCDMA will be used by xilinx axiethernet driver using dma API's.

Applied, thanks

-- 
~Vinod
