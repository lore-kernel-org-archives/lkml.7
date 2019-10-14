Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A4BECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7522089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571039597;
	bh=7ebQ8kTue/iy+/rFQ6iW23VOTWInv0+ZApP4SxVaAYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XX+vn33mX6o9CQXgCoGk4K4aUBocpXjRUeX97zuU5ySvPuqBo/XLmGRQpYXzbY/WZ
	 Ip7ANsUzKP5RLFubNzXEfiujC7wWq6m7CiNQZJMRcXcBFd3p8IPgbXHry8yQVxghDh
	 7MlnE6xKr/lRu2qf/B81HUwNW5UoJVvhZGhPmz5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfJNHxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfJNHxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:53:16 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8B820854;
        Mon, 14 Oct 2019 07:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571039595;
        bh=7ebQ8kTue/iy+/rFQ6iW23VOTWInv0+ZApP4SxVaAYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fr+KavdQrDOvFkyPt3NkhLK5ayBfbpX2bQzkoxok+TVIUuUoDC82MBC5uBVo01LM4
         hci88/NGW3fCtaVm/DaN4Gw/ift+Ek8hO8KElzDK7tFXfX7ahwe3qBvc0ax1BTJCM5
         EFDWog7UuV7m2N7CrRoFoUE7Mx4T7N5bG/vi/MV8=
Date:   Mon, 14 Oct 2019 13:23:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: zx: Use devm_platform_ioremap_resource() in
 zx_dma_probe()
Message-ID: <20191014075311.GJ2654@vkoul-mobl>
References: <85de79fa-1ca5-a1e5-0296-9e8a2066f134@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85de79fa-1ca5-a1e5-0296-9e8a2066f134@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-19, 14:37, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 14:32:12 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.

Applied, thanks

-- 
~Vinod
