Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A67C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E09C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HJthI4nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFUNRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:17:39 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47180 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfFUNRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HUxAfHiJ4rcWPTGwSZjfJwlTk7FCjqGwRViYiS38CRs=; b=HJthI4nwXViEdh1zIWFgA8x1yY
        cKBo86NlXux5JVMb4gIrU9qafdU22pOvo9RbI5Qcqb6VcrhiRPkBf9MErUbzHeFBjNUpvtt0aOYlh
        jPD42AqN0huOA8Q+PneZxlwfdFq1iS4V+wJTuf9yqO1e1utDxvh3roAPJw8Kz5zJd51U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1heJQ5-0005pX-Ke; Fri, 21 Jun 2019 15:17:33 +0200
Date:   Fri, 21 Jun 2019 15:17:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        f.fainelli@gmail.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, rafalc@cadence.com,
        aniljoy@cadence.com, piotrs@cadence.com
Subject: Re: [PATCH v3 3/5] net: macb: add support for c45 PHY
Message-ID: <20190621131733.GC21188@lunn.ch>
References: <1561106037-6859-1-git-send-email-pthombar@cadence.com>
 <1561106099-8803-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561106099-8803-1-git-send-email-pthombar@cadence.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 09:34:59AM +0100, Parshuram Thombare wrote:
> This patch modify MDIO read/write functions to support
> communication with C45 PHY.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
