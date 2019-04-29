Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3294C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28452147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556515063;
	bh=ixlp8faVULPqoz7AQFI/ayiv4/X8aSrogRx7Yh9KaNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MB3+ZX5UMH/raSYU6D7FAPwn9xsSXv5UeT7psipmEn0nOO35Att6sxAlDs3R+QLbQ
	 CxGgi46+S7zykt1sLM6/roPO6JqGVEC2u5btD65SQZT4TahmkdWk9nUDhhLXj6eWKL
	 QWLC8Gx2HMgtAv56apRqT4NV0DWYAVsKyfo7QpgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfD2FRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 01:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfD2FRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:17:42 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C03B92075E;
        Mon, 29 Apr 2019 05:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556515061;
        bh=ixlp8faVULPqoz7AQFI/ayiv4/X8aSrogRx7Yh9KaNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajMZtxB4YEVcYflbT3RmhdDR7AZhBsP5/LeiQ06Op17iFNvXc5dWXH6DTrFj01Qc1
         j8dIc1+/LMLRjOPzAEHbkj7s+mAbCueaFDWgFb/m9MSh0G5qe2UxuOy0WL5sQLzAEG
         KpGu91L2AEgTO/EdWmm3KL8ezGIDxYaLy4SCkps8=
Date:   Mon, 29 Apr 2019 10:47:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH next v2 1/2] dmaengine: bcm-sba-raid: Use
 dev_get_drvdata()
Message-ID: <20190429051736.GE3845@vkoul-mobl.Dlink>
References: <20190426115235.GX28103@vkoul-mobl>
 <20190428040025.142181-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428040025.142181-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-04-19, 12:00, Kefeng Wang wrote:
> Using dev_get_drvdata directly.
> 

Applied both, thanks

-- 
~Vinod
