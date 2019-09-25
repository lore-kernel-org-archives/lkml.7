Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27469C4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9D221D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569443326;
	bh=rE3Bp+UoIT5tfW9FqIroPRLshqWYl9G6V3AQ0ixdge0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1SpaDysP4fd2eN6+rC2fK1q2Haud7fdhGC3N2f5b69ewLUPRwXqfWWkj9l8tlEEn7
	 hsBv/zRlDDn2Ns0bFAjEthOv4CeeJh2rwWzVm/E6npTharNUUI7xk+OAanODXgwTLW
	 XhYxBGaWB9WQhFwiMHbME1Bl1A1AVu5pYV+Z/NjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392571AbfIYU2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387869AbfIYU2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:28:44 -0400
Received: from localhost (unknown [12.206.46.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F8921D7A;
        Wed, 25 Sep 2019 20:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569443324;
        bh=rE3Bp+UoIT5tfW9FqIroPRLshqWYl9G6V3AQ0ixdge0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wnf7mfgVz/B4x6UJZYTYJRioxu9Bw+EJ3mnxGrBzSyenGOCbZL9WvmoNESNMZT25/
         R0EnDUJ5R95doogvxlFZmO8ZDBLY8Ie/vqTWB/w3fFq+PGV44O+oWLddIIi2G/r6aB
         B4sEwVP/YaljS7gMl8IZYP8pddUAxXIdsUEryFE0=
Date:   Wed, 25 Sep 2019 13:27:43 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dan.j.williams@intel.com, peter.ujfalusi@ti.com, arnd@arndb.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: ti: edma: remove unused code
Message-ID: <20190925202743.GJ3824@vkoul-mobl>
References: <20190905060249.23928-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905060249.23928-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-09-19, 14:02, YueHaibing wrote:
> drivers/dma/ti/edma.c: In function edma_probe:
> drivers/dma/ti/edma.c:2252:11: warning:
>  variable off set but not used [-Wunused-but-set-variable]
> 
> 'off' is not used now, so remove it.

Applied, thanks

-- 
~Vinod
