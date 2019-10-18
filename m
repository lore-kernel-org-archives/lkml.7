Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A29ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D839E2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571385767;
	bh=Ntm+G7UaaAAt6/MZrn+mvHAfZaYTK61Q3hCldEAMCXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jvYdolzYdock5bT8YZZsDPPMVvXWOy5tLW23g8iOGphPJbEPgzWgGdKvzpw//pAjQ
	 BqkbR8EHpjT/f66R5hpX0IWk6ULq3YWjRJ5+SveGBTP2jKKOuqP0YU8Pr3WHwM1qjX
	 CBuYNdw0QUAQfW2aN4jEIaV/Zc9IoaWUEOXLxk+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442129AbfJRICq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbfJRICq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:02:46 -0400
Received: from localhost (unknown [106.200.243.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98542089C;
        Fri, 18 Oct 2019 08:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571385765;
        bh=Ntm+G7UaaAAt6/MZrn+mvHAfZaYTK61Q3hCldEAMCXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYDITSsAr18ZLEicyiGmnMITuZH5dimDuhrDrGRJnQmx5Jv6clGFtsQhOoI1zbNyX
         kSuaR1+xdgzJ1edTxqgrCvY1Iq1Uc/7mpsW73fxzWz2Q+k7KI//k9MvcjDKrgIVeMy
         DehetQMb+tjGg4ayL4sArL33nJXRrJ8QcudHohec=
Date:   Fri, 18 Oct 2019 13:32:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     jassisinghbrar@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v3 0/2] Add support for AXI DMA controller on Milbeaut
 series
Message-ID: <20191018080241.GQ2654@vkoul-mobl>
References: <20191015033116.14580-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015033116.14580-1-jassisinghbrar@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-10-19, 22:31, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> The following series adds AXI DMA (XDMAC) controller support on Milbeaut series.
> This controller is capable of only Mem<->MEM transfers. Number of channels is
> configurable {2,4,8}

Applied, thanks

-- 
~Vinod
