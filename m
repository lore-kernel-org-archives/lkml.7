Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2C5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310AC21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558414638;
	bh=+F1RaQPyLQoUKj2KiELauROnCFp3WSac4XTprzkEDKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pVq8A3Y9a0bCaKsYVjUrfFxamcbwNsMKu/Uc68CLaFRGC+2gB2eFY4ZiO1/XMDSC4
	 9Xzf7AgeDaHQJr3nvdoaLwZ/jT7MGRwkoS664obdDumohvR034F5gvjtCv2T59gMTM
	 PU6DmFc1ZNV2sxl01EyxRDvCNXTvEcoqaFG7czOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfEUE5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbfEUE5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:57:17 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E80F121019;
        Tue, 21 May 2019 04:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558414636;
        bh=+F1RaQPyLQoUKj2KiELauROnCFp3WSac4XTprzkEDKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w0sWPD3A4HbS3o9rzEZ52B2DhgOpyXO/fkezQpQR6gma7jdIUTHPhD2lbCxpejL41
         jM+O6iECEs/Pnz15U90r3cF9FMnwha8fWXxZ75oi4swiU80TrkONAimFpxAEwKI2ku
         mtBsuuSAmut9qtBX4oU4xGuWRRve+8JOUPVJ4Zaw=
Date:   Tue, 21 May 2019 10:27:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Huang Shijie <sjhuang@iluvatar.ai>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: dw-axi-dmac: fix null dereference when pointer
 first is null
Message-ID: <20190521045713.GQ15118@vkoul-mobl>
References: <20190508223329.26796-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508223329.26796-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-05-19, 23:33, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the unlikely event that axi_desc_get returns a null desc in the
> very first iteration of the while-loop the error exit path ends
> up calling axi_desc_put on a null pointer 'first' and this causes
> a null pointer dereference.  Fix this by adding a null check on
> pointer 'first' before calling axi_desc_put.

Applied, thanks

-- 
~Vinod
