Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC4C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959DF206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 04:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573706004;
	bh=keNAqgUSBMIa/wGMMC9Ddn2w6xKFwebg23FDS0NmBz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HBqaOYc1jZqq5gJ5qBjbqcK5/bK8h0Q1Gg8dQtrkJaCLj+VXma3NoHp+bZJjcK3wM
	 hv/QLzUiMka4Oy0HN2RhQ+TggEkGDA5Z+og5H3CjUDq/tcS+SZEZ/j1xnoVoXy+4Ff
	 cOYPCl3bvXqBvTGa9/6TJShuNNQpUHbVqfgLaVUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKNEdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 23:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfKNEdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 23:33:22 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC3B206D7;
        Thu, 14 Nov 2019 04:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573706002;
        bh=keNAqgUSBMIa/wGMMC9Ddn2w6xKFwebg23FDS0NmBz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjqHjR/5F4OyXNJMOPhf+o6uAzqRn93mHzZaP3dQj0XAk77N7SSTTM4Fk8vwXu/i3
         gmUoZECz8UCcsaMglIwH1FYwr3ZHY0EmNBIMiXeR5mwgYFkVPglSNnJHM9nuOnTD9u
         fHP9eogqOtBoVkADF+eGM5bgbSow9NchOtX6rElk=
Date:   Thu, 14 Nov 2019 10:03:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net
Subject: Re: [PATCH] iio: buffer-dmaengine: Use dma_request_chan() directly
 for channel request
Message-ID: <20191114043318.GE952516@vkoul-mobl>
References: <20191113092453.30838-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113092453.30838-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-11-19, 11:24, Peter Ujfalusi wrote:
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
