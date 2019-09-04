Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4CCC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DE123404
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567576625;
	bh=vHzjJabvLNobLJbAo+1Q1mNco/nbArtdiV86fXt8HaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DpnEHfBFSxPEKfTWwPsUOH2jOYFcdR8pWtDoAj7OBn0CDnW5bneQb0Z37kH7d/bcC
	 wXOl5dEbZi0nBcEex6IHSZO0emy8TussTRpOWh/e7yDdu02Y+elw4s6NbNYBQDuLpw
	 quHiCmV+qZZQ+gfOcMRLMjQ3jX990+C9w5trDArM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfIDF5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 01:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfIDF5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:57:04 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2FB23400;
        Wed,  4 Sep 2019 05:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567576623;
        bh=vHzjJabvLNobLJbAo+1Q1mNco/nbArtdiV86fXt8HaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n97BL6VG/PiUpyRJrrHJrNi8SJ1v7450/uyMdXvkaqFJ2S47p6welwcU+R6u8OViV
         1bMaGux6SPNAokx6QEGp3U4w4V6fp22ozmM2ebl7sUKNsC4U3EBLwR+qmsT+djwXWg
         9nBzebhPlFtAzd18kU+v6fZ2bhOJDKdqV+FZgFmA=
Date:   Wed, 4 Sep 2019 11:25:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com
Subject: Re: [PATCH] dmaengine: sprd: Fix the DMA link-list configuration
Message-ID: <20190904055555.GD2672@vkoul-mobl>
References: <77868edb7aff9d5cb12ac3af8827ef2e244441a6.1567150471.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77868edb7aff9d5cb12ac3af8827ef2e244441a6.1567150471.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-19, 15:37, Baolin Wang wrote:
> For the Spreadtrum DMA link-list mode, when the DMA engine got a slave
> hardware request, which will trigger the DMA engine to load the DMA
> configuration from the link-list memory automatically. But before the
> slave hardware request, the slave will get an incorrect residue due
> to the first node used to trigger the link-list was configured as the
> last source address and destination address.
> 
> Thus we should make sure the first node was configured the start source
> address and destination address, which can fix this issue.

Applied, thanks

-- 
~Vinod
