Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4723EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA8A20840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565671076;
	bh=aPLKTjqm5AOkaw3kj/RI5hMxBP/0Xl0VJbc0FtVQthQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gbp84WdCmt9w3VUbDEpd9k30G1UmpTn9l+d7GO9oOL7piXfc9QHKk9C776DgzWxt1
	 S2t8+86FKgEgbfNrrNO0TVndvXV8oQXai0zEmfng6S9pwWNNYqoVULws3yShqvJPpV
	 tgE27cMGqVcaLwQsbCZ3d/7C3jm75vwIjeKdLBVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfHMEhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfHMEhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:37:55 -0400
Received: from localhost (unknown [106.201.103.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 244EE2054F;
        Tue, 13 Aug 2019 04:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565671074;
        bh=aPLKTjqm5AOkaw3kj/RI5hMxBP/0Xl0VJbc0FtVQthQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0ozBb7tQZvSqXd4AU5LVM1tOx1GTEyfRyCjKNa5+ax2ID05+0d6OypFXVRx8ZrFg
         8mTLevAy+8NdgryU+33eoJ7/4i4Zl1xlFoIb6wQlQ39SH334z5N0YzcUQnAOjp/i0E
         blaYR5hvf7Au1AHSDjsSe4vH2TADBMfHoN/gtmBc=
Date:   Tue, 13 Aug 2019 10:06:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] dma: ti: unexport filter functions
Message-ID: <20190813043642.GP12733@vkoul-mobl.Dlink>
References: <20190812101155.997721-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812101155.997721-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-08-19, 12:11, Arnd Bergmann wrote:
> The two filter functions are now marked static, but still exported,
> which triggers a coming build-time check:
> 
> WARNING: "omap_dma_filter_fn" [vmlinux] is a static EXPORT_SYMBOL_GPL
> WARNING: "edma_filter_fn" [vmlinux] is a static EXPORT_SYMBOL
> 
> Remove the unneeded exports as well, as originally intended.

Change title to: "dmaengine: ti: unexport filter functions"

and applied, thanks

-- 
~Vinod
