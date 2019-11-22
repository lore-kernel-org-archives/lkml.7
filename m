Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759AEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 04:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414FD20704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 04:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574397253;
	bh=RbVhcnfxDZXYbq5FrYM2h68FLrNpgIh467ix1PTKw1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NbrTEgt5RVgL2KosW5ykA8KpCIETrclN6baMuxmadjXyJRBwgYmp5Rxot+w8By/aU
	 q7d4HzzFtxJOIbNIdTHgEpO8DGRmoqf0c7bSn4iUN+PYBhMNvMsGB4WP9QkZ5DswIy
	 IPbbD8QC+N+X9EXJ5LoVKyuwxR8NFqorw2V22ETY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKVEeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 23:34:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfKVEeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 23:34:06 -0500
Received: from localhost (unknown [171.61.94.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB4320704;
        Fri, 22 Nov 2019 04:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574397246;
        bh=RbVhcnfxDZXYbq5FrYM2h68FLrNpgIh467ix1PTKw1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avS4p66UA4nU92G88TOUa4dZerKvnZcw9sfXPjNIWCxyz78jSEoHODin8INeG3195
         7Wv0lY8ZkKRXZ80CdyM566gwHXKrjw9p4BySG+iNQFprnRi9xCF9b+Tdg/3u9l1rh3
         xOIB4eswglMDrpRZ9C4lg8A7sTCOIyNYWQvQmIpc=
Date:   Fri, 22 Nov 2019 10:04:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     broonie@kernel.org, geert@linux-m68k.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: pic32: Retire dma_request_slave_channel_compat()
Message-ID: <20191122043402.GJ82508@vkoul-mobl>
References: <20191121092703.30465-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121092703.30465-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-19, 11:27, Peter Ujfalusi wrote:
> There is no reason to use the dma_request_slave_channel_compat() as no
> filter function and parameter is provided.
> 
> Switch the driver to use dma_request_chan() instead and add support for
> deferred probing against DMA channel.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
