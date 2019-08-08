Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D63BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD162173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565267022;
	bh=pYsFBGP3kI4gJG4u1PJaSdrgvkRbRuJZQ/c/jwcwI2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lg4iNdYCM+ikqamfmRMC8hPIsEfdcIPM3/ujbyG9gsVFZwJ5cDlyRRP7xzB0ZdG9T
	 HYZxVQlOXcP7Q/H3nL0jDSemW10XFmbH0xcL9KDx2sj1HSQqjmAD/umNcH6Rl/u6Nx
	 4HC/j+4A/61fS9i5gp6faDk3yCCMbummCqdwPqUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbfHHMXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfHHMXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:23:41 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD18E2171F;
        Thu,  8 Aug 2019 12:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565267020;
        bh=pYsFBGP3kI4gJG4u1PJaSdrgvkRbRuJZQ/c/jwcwI2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZazE1taqA2r421KmDZVzNqPA+bSG3IjqBr4e1e/giVkNuwVgb3NEchPhztqU6QYfi
         GPj2QapJuzXJNzKKXvtyEycNJFqG3H7dunkUvVt9cZ3HNVHFePggOQ1fy+IpY3o9Xq
         C7ImPSlFTWh+CA67rXnQjQ9wy3ouO6RYu2i/nPpo=
Date:   Thu, 8 Aug 2019 17:52:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/24] dmaengine: imx-sdma: Remove call to memset
 after dma_alloc_coherent
Message-ID: <20190808122228.GP12733@vkoul-mobl.Dlink>
References: <20190715031716.6328-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715031716.6328-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-19, 11:17, Fuqian Huang wrote:
> In commit 518a2f1925c3
> ("dma-mapping: zero memory returned from dma_alloc_*"),
> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.

Applied, thanks

-- 
~Vinod
