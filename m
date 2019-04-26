Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E0BC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA8B206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556282877;
	bh=Z6ULejNUNVbPN+kGDhh078TUTsx/3cjJ2E/JQmrHYIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QRhynAPre/2DYMx/amyS3MS1P1XrFZXwPWaUOIp3wGskvYB8ecilhvuzVqzLLLvOU
	 eaHSVH8aZIauzKZvHhUc1ayOxndJcHszs9X3bI92P8/coPvxkwjxrpn+/eoKbzTiJs
	 uqcBE8LhCZfLo+EtXNvJqO71BC/9nYaZGNXdamwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfDZMr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfDZMrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:47:55 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24950206C1;
        Fri, 26 Apr 2019 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556282874;
        bh=Z6ULejNUNVbPN+kGDhh078TUTsx/3cjJ2E/JQmrHYIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmMx9GeNaaNzMTlwYFxqS6Xr51Zgoq0LKFKKk1W6wmfmNulRAMQPhWzUIcumq9k+G
         5KGDF2vy7kghsy/RpSgvjW2QH50D9daTCw8DUiC7DkcIZA5jzgf6a3p7FZPXlchvTk
         q731RFfvLMQIEcxqC+eL94PQWz8P8gVKh9AFWHA0=
Date:   Fri, 26 Apr 2019 18:17:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: tegra: Use relaxed versions of readl/writel
Message-ID: <20190426124748.GF28103@vkoul-mobl>
References: <20190424231708.21219-1-digetx@gmail.com>
 <20190426120148.GB28103@vkoul-mobl>
 <68c342e2-5662-5632-82aa-659da0381f54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68c342e2-5662-5632-82aa-659da0381f54@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-04-19, 15:19, Dmitry Osipenko wrote:
> 26.04.2019 15:01, Vinod Koul пишет:
> > On 25-04-19, 02:17, Dmitry Osipenko wrote:
> >> The readl/writel functions are inserting memory barrier in order to
> >> ensure that memory stores are completed. On Tegra20 and Tegra30 this
> >> results in L2 cache syncing which isn't a cheapest operation. The
> >> tegra20-apb-dma driver doesn't need to synchronize generic memory
> >> accesses, hence use the relaxed versions of the functions.
> > 
> > Subsystem name is **dmaengine** not dma! Please fix that
> > 
> 
> Looks like you answered to a wrong email.

Yes looks like I did, apologies for that :(

-- 
~Vinod
