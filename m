Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15547C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC262077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556279928;
	bh=YqFqQmwEejQETrkmodn0e21QBKZPRzIzdLWkCBzS2sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rIVxnhmwj/rXZUepimujgTITVgAzSJla2/TGeA4ZGX3slujRt3jGdtMIljwu1aTQB
	 kHNql1ZY4xSAzgQYmIX4KYN3aslVeUbdpPAG9IEMMVNQWblila5iVcs8/dxD4GZGOK
	 0GWqGJLyOaTkXLw1nw8tAd3n9T2anjo2LXx3A2PA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfDZL6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfDZL6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:58:47 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00D12206C1;
        Fri, 26 Apr 2019 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556279926;
        bh=YqFqQmwEejQETrkmodn0e21QBKZPRzIzdLWkCBzS2sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wHjR0azsZg+RlaXu00W7bvlF05QT6L+HOB1+CgzFvt7NeF6Sh89V6+StqkUcCLy8Q
         lxNhVf80gpdXU6yR/p83h70rzB11J7A+vhLbpK+NQi7stUGys1YVPPQ1is9GwAtTJ8
         IDVZLyKthRMnttwQrSZ7qAtwXEnKWAIBwDkeXJcE=
Date:   Fri, 26 Apr 2019 17:28:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     shun-chih.yu@mediatek.com
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srv_wsdupstream@mediatek.com
Subject: Re: [PATCH 1/1] dmaengine: mediatek-cqdma: fix wrong register usage
 in mtk_cqdma_start
Message-ID: <20190426115840.GA28103@vkoul-mobl>
References: <1556164430-30724-1-git-send-email-shun-chih.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556164430-30724-1-git-send-email-shun-chih.yu@mediatek.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-04-19, 11:53, shun-chih.yu@mediatek.com wrote:
> From: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> 
> This patch fixes wrong register usage in the mtk_cqdma_start. The
> destination register should be MTK_CQDMA_DST2 instead.

Applied and cced stable, thanks
-- 
~Vinod
