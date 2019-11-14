Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FB0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8018A206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573706146;
	bh=XXtgTZ4OEPc1u9sOqHO1E+/XMQxUS++8/6bKljEvio4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xzyIuwUZhhuXBDUOLdFI0Auk9KwmHQXj7c5SM1ThA1UC/ny39lPZ/7x2LIF2M7B+b
	 wmMjlJn6cVCKXsZ9htOJGVPd1mYTxj2O3eIhHi185/lRcSznVk/7aZlt9aVJPgcVUE
	 ZjdP2Ch9w6NZMR/CiBZSnZ3t1TfEOE3IPs8Sp7wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKNEfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 23:35:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:32992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfKNEfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 23:35:45 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3830206D7;
        Thu, 14 Nov 2019 04:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573706144;
        bh=XXtgTZ4OEPc1u9sOqHO1E+/XMQxUS++8/6bKljEvio4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHYQbgIfWGnmtFOTLHka3zN9n1yqzgXJqyG60zxfjYCWHLmapzA9f9sbRg+Zry4p5
         3fPQ6cn28wHKXeH5QX0pG9Kd+JQhhmCgZUVYfLAVx9jmV9fzpIf/kZN1vT6E4LEa/A
         flvoaPShl0QTLwlJnVsBHYzwhYWrcvQ4gGN0yKy8=
Date:   Thu, 14 Nov 2019 10:05:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     broonie@kernel.org, radu_nicolae.pirea@upb.ro, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linus.walleij@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, andi@etezian.org,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, linux-arm-msm@vger.kernel.org,
        kgene@kernel.org, krzk@kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/9] spi: Use dma_request_chan() directly for channel
 request
Message-ID: <20191114043540.GH952516@vkoul-mobl>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113094256.1108-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-11-19, 11:42, Peter Ujfalusi wrote:
> Hi,
> 
> I'm going through the tree to remove dma_request_slave_channel_reason() as it
> is just:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
