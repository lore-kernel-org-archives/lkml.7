Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F226C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7810C22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567572425;
	bh=4Wc8zu44ehKn0LN004gKoAumbuKF6m36swIrvTq4kBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Y5ZqtPgiCMJMgOR5yG7p47oL2pHzYnvqJL4ZIBSNdYjP5Tiijz/KM/LITYlZHj5e
	 Ek5cEk4N3KFh9nQfhW883QvO/toqeCYQts7bcqnjocIhbLJEqIOx65FXyj56KMQDJF
	 HDoxYYD9yoDnotFj5RqvuBy2NulKcJZwRcEB56iY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfIDErE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfIDErE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:47:04 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B466F22CED;
        Wed,  4 Sep 2019 04:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567572423;
        bh=4Wc8zu44ehKn0LN004gKoAumbuKF6m36swIrvTq4kBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xswxHmETRa93evKef/avocoeWfs/zdXhUztIU6wrs+WYN4mNzKEbwOOtH8gE7F6DV
         rTb2033XQ9jOymqBcRNGoXrkXU1pLPhWgBJKtyntyL+s3twTd0i3ICon/En+nLCn8l
         IOgM9zJ0b9cqhszIseZp+2rNlNXrV1n2JA4v+WbM=
Date:   Wed, 4 Sep 2019 10:15:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dan.j.williams@intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: iop-adma: remove set but not used
 variable 'slots_per_op'
Message-ID: <20190904044555.GW2672@vkoul-mobl>
References: <20190821121908.7468-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821121908.7468-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-19, 20:19, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/dma/iop-adma.c: In function iop_adma_tx_submit:
> drivers/dma/iop-adma.c:367:6: warning:
>  variable slots_per_op set but not used [-Wunused-but-set-variable]
> 
> It is never used, so can be removed.

Applied, thanks

-- 
~Vinod
