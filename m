Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B221ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8937021872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571807709;
	bh=NSP5YHXNLaXyRHpxdaRvfUgyBpL8uBQa0WGnzY8pm0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vb8vKR4YWegoYAt/UJK//+5ZoFUFPMHBBpv9GCf4rQ6zB41D63gHqLr6qgtPPI09C
	 FEEjcf88jec/V1JddhRK1S7YK1nSALPg9BkgmVF0xSyBuDsAfgJO+FUg/1d3XykJQ4
	 tEuZ6W+Hy8wHdFK+nFmrLDNm0PtZA4BLEKBo9pSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbfJWFPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbfJWFPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:15:07 -0400
Received: from localhost (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30AA4214B2;
        Wed, 23 Oct 2019 05:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571807707;
        bh=NSP5YHXNLaXyRHpxdaRvfUgyBpL8uBQa0WGnzY8pm0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkAVFsBjDO6oumrJtx4ytUMuTnFS5lKv0WgSSX+skgmzxhviGrhyYsV2bIgIMaHdp
         C0dDdecNWu3Mwipm6YDQNbANc0S03iIURXQjKuO1RCzbHitT7APyppyZtin+xpeyjH
         DVt6+W666/SkHTYzE3C7YWCDJ/M/37IDrOkz+41Y=
Date:   Wed, 23 Oct 2019 10:45:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Subject: Re: DMA: JZ4780: Add DMA driver for X1000.
Message-ID: <20191023051501.GQ2654@vkoul-mobl>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-19, 11:05, Zhou Yanjie wrote:
> 1.Add the DMA bindings for the X1000 SoC from Ingenic.
> 2.Add support for probing the dma-jz4780 driver on the
>   X1000 SoC from Ingenic.

The subsystem in dmaengine and not dma

Please resend with correct tags!

Thanks
-- 
~Vinod
