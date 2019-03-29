Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A297C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D3F21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553829970;
	bh=IC5BfJOufShh51MkTnnFjhOeVWOPKuHi3RRMEyOgNiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rLHuQi97ZYgRFhFyB9SVanBbj+MTE+XOSc8594xJqilh0AT5v4dGOmDenkO1RX+SV
	 V+t+0dnP11Hke7IDhbQtrsm+eUGQMgB+pk8IdXZLmueglRowr0CUpvkVVX0KrY1kB2
	 wDHtHTW0quPnV3auB/KSssPd40iagjqHj3PGDHPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfC2D0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfC2D0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:26:08 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729D521850;
        Fri, 29 Mar 2019 03:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553829967;
        bh=IC5BfJOufShh51MkTnnFjhOeVWOPKuHi3RRMEyOgNiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=teR08dNsMgnry1C8du1WQtwGJ2vKBwWTrKLcga/UPNefIqkJJ5LF1dHad2RSQW/Qt
         E1BMi97hnA5872TsFJhTwBgE+w2zT0sO3I2Iare8NX/hPDyNBtkKIj3OqGI+iLLCoT
         rIF3JR138vNZ1Ho+BoVOStGWLFK13OX8EYm11G7Y=
Date:   Fri, 29 Mar 2019 11:25:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610-zii-cfu1: Disable NOR flash/SPI
 controller
Message-ID: <20190329032522.GQ12513@dragon>
References: <20190325183017.22278-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325183017.22278-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:30:17AM -0700, Andrey Smirnov wrote:
> Only a certain number of CFU1's come with NOR flash populated. Disable
> it by default to avoid trying to probe NOR flash on devices that don't
> have it. Devices that do have it can rely on the bootloader to enable
> this node.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied, thanks.
