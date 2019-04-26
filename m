Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D28208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556279562;
	bh=nwQMSKMNPZP3gD5kTTc7TwCsM2mY9q1ZGGkm86V2sCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CuXEN2U/rnTM9RrRRMiLt2XJRv/KnsLDg6wjlAZVPHCIRtvn35lgupufNwoJRzQoV
	 PI+wjPNxwPV/DYxOma8mtjG+Psa9y0SjP7e3QcqM4/tCIdxQbQhGpcCt3gwsuDvsdW
	 cGRgr60r4RQ3srBWSKa7H9t0QNSad8IIoqQtuu20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfDZLwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZLwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:52:41 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E162520656;
        Fri, 26 Apr 2019 11:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556279560;
        bh=nwQMSKMNPZP3gD5kTTc7TwCsM2mY9q1ZGGkm86V2sCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q358pT/w5MkAVnDrTX3wssHnK7mFsPMLvvh+u2/nourawWmZYf35YYqe/M8wRTU6t
         ksPbpRjQh7lytaWDbFGbhfZ3KTirXsmABsdZhSOsvlHJfX8g1+6JL5/Mw9+1rr4qO7
         CHRcsuN5iOPMskMeuGPGmbphHQY21NfStZ/4W1CA=
Date:   Fri, 26 Apr 2019 17:22:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH next 03/25] dmaengine: Use dev_get_drvdata()
Message-ID: <20190426115235.GX28103@vkoul-mobl>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
 <20190423075020.173734-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423075020.173734-4-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-19, 15:49, Kefeng Wang wrote:
> Using dev_get_drvdata directly.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/dma/bcm-sba-raid.c | 3 +--
>  drivers/dma/nbpfaxi.c      | 4 ++--

I would prefer these to be two patches, one for each driver

-- 
~Vinod
