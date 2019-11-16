Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55041C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3AE214DE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921388;
	bh=uGuhx40PSVACD1w2xbCF83UlRktCW3KrF5PatnpxlxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UCJaD90jmzkMoHUaHBqlucBQR1ckef6a8pcjt4P+RgGI5SBypnJH698A38OYZ57xx
	 Ln1f3eO4/k3hII3bK1/ODTTAC3rKqws0K3xZpbFJTu3U8fGS31SAlo5dDTUbBH6kvY
	 TNm6I2iBQRYJNJXkjAdY3/UuHNosP9WTklU0kuy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfKPQXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfKPQXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 11:23:03 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BABE21479;
        Sat, 16 Nov 2019 16:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573921382;
        bh=uGuhx40PSVACD1w2xbCF83UlRktCW3KrF5PatnpxlxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fxaPmIIPIPk2Nm0smKAbyYykUNypy9xrYa+I/tr604z7UBEBPjvxuSqbO0hrT1Eca
         ewm/cVlaVwg1YCwUWpANv9X4UwcizgD3TeEiuTW9FVig15TYdFNIM4bGH6S93H2zzO
         xB9HtSCDIiCyu0T5tswPQeYVixdJt+vsz6apnQEY=
Date:   Sat, 16 Nov 2019 16:22:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, knaack.h@gmx.de,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net
Subject: Re: [PATCH] iio: buffer-dmaengine: Use dma_request_chan() directly
 for channel request
Message-ID: <20191116162257.550f62d6@archlinux>
In-Reply-To: <20191114043318.GE952516@vkoul-mobl>
References: <20191113092453.30838-1-peter.ujfalusi@ti.com>
        <20191114043318.GE952516@vkoul-mobl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 10:03:18 +0530
Vinod Koul <vkoul@kernel.org> wrote:

> On 13-11-19, 11:24, Peter Ujfalusi wrote:
> > dma_request_slave_channel_reason() is:
> > #define dma_request_slave_channel_reason(dev, name) \
> > 	dma_request_chan(dev, name)  
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> 

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
