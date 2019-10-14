Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EDDECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913E920854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571039535;
	bh=ignFur/lxY/kv9qZzaXR8PTSNxFtkv4s29WCnImYBGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G+UPsL1456557ZsOCs79kn9o/OkUlp24iSVmQh8x0zRzXuPMIE57+AvlYXXATbYgq
	 i+yTSrsMlrQWYS7i3Ddy2UySr5DOqG+857fblewe4znRTOYLMuKLjZDBDON8MvtcL+
	 O/eFoCGwr4JLEXP/YLVDAqwWkv1XcRcaQ/wH8/d4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfJNHwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbfJNHwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:52:14 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEE0520673;
        Mon, 14 Oct 2019 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571039533;
        bh=ignFur/lxY/kv9qZzaXR8PTSNxFtkv4s29WCnImYBGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLjLMzVcJISGJHlhTTqgFRvGeIfuhlSlJwCVMIsOTWeEDhKBzlB42dAdIpP+uBEmr
         NWYorLpF++xyxLDVBLsy9zDBDv3d43M4pLBiuywbVY0HeVQ1aRtrE81RJjgubCQQRu
         U0x0vUEPD8UndEevSvKjUgEAmEaMVt0Rin8d/gX4=
Date:   Mon, 14 Oct 2019 13:22:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Shun-Chih Yu <shun-chih.yu@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mediatek: Use
 devm_platform_ioremap_resource() in mtk_cqdma_probe()
Message-ID: <20191014075209.GF2654@vkoul-mobl>
References: <c7e3bbae-44fa-9019-18ee-c6cdfd7c2a14@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e3bbae-44fa-9019-18ee-c6cdfd7c2a14@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-19, 13:00, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 12:52:25 +0200
> 
> Simplify this function implementation a bit by using
> a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.

Applied, thanks

-- 
~Vinod
