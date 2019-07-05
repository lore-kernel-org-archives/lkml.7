Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73C7C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 06:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8156218BB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562308380;
	bh=O0Y1hTv/2k9oNDwA5XMXcT5tyOAMyI4oyPL8FuGxUVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D6rmy3i33AWbJk6enADDxfDVzdShtzWUNpJy67rPCbGJn+Du6WN3nH1lQZ3jR8Wma
	 eviO9MWBmWhV4r/u8xnhCgO+0wHFYQy7dQD5c68HSgyZQK4hCGGGjSSJ9Zt2TsCfjz
	 jgBug/0KGiGZ6AjE/ZoPCbe11vEC4/gzAVZYNPCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfGEGc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 02:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfGEGc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 02:32:59 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CCC3218BB;
        Fri,  5 Jul 2019 06:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562308378;
        bh=O0Y1hTv/2k9oNDwA5XMXcT5tyOAMyI4oyPL8FuGxUVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2fw7wDVQqCrmxOQ3yvjwbuCL4INZOcv3OK78jbVH9x/JftnIov3ShGPE/Q6j5vyQ
         mxrzNuLJWZGWhVZ9MK2IlLQiA+vu6kieHx/XGsT8TJ+1Mp73bwnLQ3tik0gwY51jFX
         EUuTsELhrB9en9mZHjD8PyEpDnBc8VtM/b/lalXQ=
Date:   Fri, 5 Jul 2019 11:59:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Sameer Pujar <spujar@nvidia.com>, dan.j.williams@intel.com,
        thierry.reding@gmail.com, ldewangan@nvidia.com,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra210-adma: remove PM_CLK dependency
Message-ID: <20190705062945.GW2911@vkoul-mobl>
References: <1561046059-15821-1-git-send-email-spujar@nvidia.com>
 <1f21a03d-4cb9-c0e3-588e-8183d6f31cae@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f21a03d-4cb9-c0e3-588e-8183d6f31cae@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-19, 17:02, Jon Hunter wrote:
> 
> On 20/06/2019 16:54, Sameer Pujar wrote:
> > Tegra ADMA does not use pm-clk interface now and hence the dependency
> > is removed from Kconfig.

Applied, thanks

-- 
~Vinod
