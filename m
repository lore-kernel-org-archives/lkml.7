Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381BDC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EE421773
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YQxnBb4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfDETU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:20:28 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51875 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731183AbfDETU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OiX4NUlc/aMwjPCe6kwnCaBRQK6bpkCgIdpR9OpQivE=; b=YQxnBb4GoOZCju3ApLvVQURKVx
        cbx9JIE1v8s+OTve+CrWPOBBXHbg8JIFq5dI21fWBLT6JVrx0rjmZ9+IVVDNpcw5vek3gJB7IZ1ru
        PSzv9Sv7QuG53y0IOXgs1KBqR52ESYBGkxVOLSoB4nRJyWtuMT7kouGEqNkkAqspR+ns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hCUNx-0006G7-TU; Fri, 05 Apr 2019 21:20:21 +0200
Date:   Fri, 5 Apr 2019 21:20:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 09/12] i2c: ocores: enable atomic xfers
Message-ID: <20190405192021.GH23536@lunn.ch>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403124019.8947-10-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403124019.8947-10-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 02:40:16PM +0200, Wolfram Sang wrote:
> The driver already has the routine in place, tie it to the new callback.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Andrew Lunn <andrew@lunn.ch>

The polling function was not really designed with the intention to be
used in atomic context. But it does appear to be safe to use in that
context.

So

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
