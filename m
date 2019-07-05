Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5485C4649A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C01218BB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562313166;
	bh=sGsMo32UVw8Di9Jyj88e7Hy+JqyP8yaKWl3j6/DAklU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dEoY+6pdmVNm35d3XaxCzdDUnkD5xuxPM0REuP+DwbSJMq5A/N22su8PljkjHxXuV
	 i5GvymIH3iqNvSCGzABKwsDL7tfmFBX3v94ObPAhfUrYhkeld/gA9nP8U6Sxa5S09y
	 DglNyGN8GIcRd1em0AVy0PE66iUpq5xLERyTZVMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfGEHwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbfGEHwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:52:44 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7C23218BC;
        Fri,  5 Jul 2019 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562313163;
        bh=sGsMo32UVw8Di9Jyj88e7Hy+JqyP8yaKWl3j6/DAklU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBuV2J+/X9w5ItEQfBpdv+PDrQrTDmz/Nj0ie+AdJnshP4tvn9GJeeeu84BfSIXbK
         eE8t4k0+W6rjkjsegnPIbImjO7Sz+OPuOsrqXaGPYDgrEyaaMsTnUe6IPO59Y7Q2GF
         a1z9ckXsqsD9IzTs2vEeUOqTRXS/hW6BGAdZxduY=
Date:   Fri, 5 Jul 2019 13:19:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     agross@kernel.org, david.brown@linaro.org,
        dan.j.williams@intel.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Fix completed descriptors count
Message-ID: <20190705074927.GC2911@vkoul-mobl>
References: <1561723786-22500-1-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561723786-22500-1-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-06-19, 17:39, Sricharan R wrote:
> One space is left unused in circular FIFO to differentiate
> 'full' and 'empty' cases. So take that in to account while
> counting for the descriptors completed.
> 
> Fixes the issue reported here,
> 	https://lkml.org/lkml/2019/6/18/669

Applied, thanks

-- 
~Vinod
