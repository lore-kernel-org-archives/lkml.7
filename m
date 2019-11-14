Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2803BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD53206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573706051;
	bh=SGpk8140mUhxZXo2Ev8/kpQcKWP15GUUxAEbXYtBsWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1yHZz/+8jnqNl5anmxUOlePgn6UJCXU7Gpasg2a06e7BuAXNfpinJwxrvxIhfQKA+
	 KERWyUVpG6hepChjUaQnRpV0zhooNYZ0rQNVFfoDDc7JpcWkD84iH7XMiaASNIb0WJ
	 M9lElLJuLn4qMaeTVRjopVlIHHysoIrgMwc9cjjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKNEeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 23:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfKNEeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 23:34:09 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2795B206D7;
        Thu, 14 Nov 2019 04:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573706048;
        bh=SGpk8140mUhxZXo2Ev8/kpQcKWP15GUUxAEbXYtBsWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oIZMhJ5K+XBwp8GAEXboiBikxQp5szBN6TknjOfPpaKNIiBWpdQj9+xk1dUSFN3CO
         M5nt2P2K6hqPKsJaGo5KHebPPDw7nn5onk9YuLLi6NAavR2EG+UYqdfUSW0VUH1020
         WwhMLv+4OlRupxihhZ33Vrft41g3F9JPywjQXxDQ=
Date:   Thu, 14 Nov 2019 10:04:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     ludovic.desroches@microchip.com, agross@kernel.org,
        wsa+renesas@sang-engineering.com, ldewangan@nvidia.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, digetx@gmail.com,
        linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, bjorn.andersson@linaro.org
Subject: Re: [PATCH 0/4] i2c: Use dma_request_chan() directly for channel
 request
Message-ID: <20191114043404.GG952516@vkoul-mobl>
References: <20191113092235.30440-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113092235.30440-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-11-19, 11:22, Peter Ujfalusi wrote:
> Hi,
> 
> I'm going through the tree to remove dma_request_slave_channel_reason() as it
> is just:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
