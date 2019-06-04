Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBBAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A0F24AD6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559650766;
	bh=5mDhuWW9AhtrNyi3+kKWCarCqtJksnkX7XioSL9hjMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DUBLDJNmQp8fpR6qiqQfkpkWoJ3B8/lzGuzSw0pF/XHjY03ASvAT0qT/xeNs0uMXG
	 /lO2j4HsDSCRoV8JqtQEoU67nMrTobiGAoqyKtyPVErX6uKVwHaj+AlH65io5egqOF
	 ziBmS2nQYAtEVT3QWsDZvg0GZerbLsdMeUoMx3C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfFDMTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfFDMTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:19:24 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC95247F9;
        Tue,  4 Jun 2019 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559650764;
        bh=5mDhuWW9AhtrNyi3+kKWCarCqtJksnkX7XioSL9hjMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHCMyNsNztRQezlvHEmUk9aqrMCdYbMy0Mdyfos6pISt0WgXVGPcBTDQqAEruEflY
         BsWnL1h5qIH90UBz4tpmenjYSZYYgFGgYl+y4rxhPf1geZsPdf6rX2Ld0JToHN7uvP
         FaK2332k1zX7wk9PeLuoCWFNj79Ebqi+LQ1OZNeU=
Date:   Tue, 4 Jun 2019 17:46:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Error out if DMA_PREP_INTERRUPT
 flag is unset
Message-ID: <20190604121616.GX15118@vkoul-mobl>
References: <20190529214355.15339-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529214355.15339-1-digetx@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-19, 00:43, Dmitry Osipenko wrote:
> Apparently driver was never tested with DMA_PREP_INTERRUPT flag being
> unset since it completely disables interrupt handling instead of skipping
> the callbacks invocations, hence putting channel into unusable state.
> 
> The flag is always set by all of kernel drivers that use APB DMA, so let's
> error out in otherwise case for consistency. It won't be difficult to
> support that case properly if ever will be needed.

Applied, thanks

-- 
~Vinod
