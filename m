Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C84ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A13C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571039568;
	bh=JSWw0MG1zhOv2LF9Y5gVdGsg3ajvM/sUAFV4xu8ey5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IecJgBb1aJZNJ4/Fyv6SKuG+cn0VRp2JkB2nl96XoWrjVz8hq6RcUrLGBkxsxhnco
	 ZhW3WAKavLhJWYc39cenTru7kWtDztlW4GIOEor3REca6KARbZHCZUP/rLcT56NM6Z
	 OtpdWgswf7nwWKqKvsozT2CBxDg/ziajKiSu0VLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfJNHwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfJNHwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:52:47 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB69B20854;
        Mon, 14 Oct 2019 07:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571039566;
        bh=JSWw0MG1zhOv2LF9Y5gVdGsg3ajvM/sUAFV4xu8ey5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjBy7oQwSrI6iB5Skbc/NvXxuVOSZHnCRV6aLMxsAkT7rduYJne12wOP5ljb5FgNA
         XFXyjnBIQtvE2iv5wTr1iQiVu9cDWEC3KgtEnhyu0ISHKyKZ6Jrz3aTqAwW4D+XhJg
         f6FlPvtKxR+5TbBHf9y6ODcqzcWsYSNVycKj90P8=
Date:   Mon, 14 Oct 2019 13:22:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: owl: Use devm_platform_ioremap_resource() in
 owl_dma_probe()
Message-ID: <20191014075242.GH2654@vkoul-mobl>
References: <d36b6a6c-2e3d-8d68-6ddc-969a377ca3b2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36b6a6c-2e3d-8d68-6ddc-969a377ca3b2@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-19, 13:30, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 13:23:54 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.

Applied, thanks

-- 
~Vinod
