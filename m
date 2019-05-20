Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91559C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6250921479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rL20EiVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbfETPuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:50:16 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40657 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731830AbfETPuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g/wrqCuLLhhDz2nYldxUBEOmT6fAFh5gc7dbLHDYUL4=; b=rL20EiVt9IJINO2QNFTNj8lNQY
        raa589+WCD32Et3eJ/+07xAiMdlzt0gDx7WBwHlXvvcPJmOZRiKRxZIuXDBr2Ah0Ute/qRBT3OdB3
        BC6vg7TqOQl3YGKWyx8nuzHM0VccaUxUmhY9uhnDgvlIY1oocJBjq4jM/yIf9YLYeEvA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hSkY5-0001Jn-I9; Mon, 20 May 2019 17:50:01 +0200
Date:   Mon, 20 May 2019 17:50:01 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>,
        info@freifunk-bad-gandersheim.net
Subject: Re: [PATCH v5 3/3] net: ethernet: add ag71xx driver
Message-ID: <20190520155001.GE22024@lunn.ch>
References: <20190520070716.23668-1-o.rempel@pengutronix.de>
 <20190520070716.23668-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520070716.23668-4-o.rempel@pengutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 09:07:16AM +0200, Oleksij Rempel wrote:
> Add support for Atheros/QCA AR7XXX/AR9XXX/QCA95XX built-in ethernet mac support
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

For the MDIO and PHY parts:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I've not looked at the rest.

    Andrew
