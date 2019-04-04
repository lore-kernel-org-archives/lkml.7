Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5195FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2440120882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554394795;
	bh=G78JqYgq7n3sCHNgjQhR8RqmephFQJg6/G2R/ZkCSjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LtmD0nBHDqRHM5IuJ2t793pgYKSEDQAmriUvG3E/PI8ntjXwnVCskgXB9CTfAHrYF
	 aNk4yp8DXtP20Bv8/eWvJF6VmyANGE0VHeViQ9Np9R3irG7jtuSkuA1zXhcM1wtV2C
	 nkbu6MhPi5JkyHr8UJjY6PGyvNGcy9eQoD+L1qOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfDDQTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbfDDQTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:19:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B5D5206DD;
        Thu,  4 Apr 2019 16:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554394792;
        bh=G78JqYgq7n3sCHNgjQhR8RqmephFQJg6/G2R/ZkCSjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfyXZ/XmNiy/nizy/vkPJ/XW9NqvKQjlMQNShPP7dYCCeM0cOYbZK6HQ9edn0b1BN
         XG/cjVkyL073x2qsETHzjYIoCapj5DwZOWeailb5mn+3hTw9Mm8W2m52A7IpgihQVx
         N2oM5usf0yeYmxJJSercNVohO1zhh+cw/gd5blOE=
Date:   Thu, 4 Apr 2019 18:19:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nilesh Hase <nilhase25@gmail.com>
Cc:     matthias.bgg@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        sankalpnegi2310@gmail.com, neil@brown.name, sr@denx.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MT7621-SPI: spi-mt7621: Fix alignment and style problems
 Fixed Coding function and style issues
Message-ID: <20190404161948.GA9440@kroah.com>
References: <20190403193107.23873-1-nilhase25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403193107.23873-1-nilhase25@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 01:01:07AM +0530, Nilesh Hase wrote:
> Signed-off-by: Nilesh Hase <nilhase25@gmail.com>
> ---
>  drivers/staging/mt7621-spi/spi-mt7621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can't take patches without any changelog content, sorry.
