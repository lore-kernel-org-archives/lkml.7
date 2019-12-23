Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F280FC2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBBF2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jJySLMSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLWKvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:51:31 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:38000 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfLWKvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 05:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/DTQxIbay1uFfyTtbDDMhcJeiM44m1AZ6nMQEnPdLFk=; b=jJySLMSqQyOlVCNk8nKOctP+wx
        Ifqb1tLhqPyFVRwFXbGgaJ2hbwIjd4oq5co+RgpAYDCILpYw5bcKWH0l64vX2Aa833TBUhlm1l+Gt
        H79Vaohh9B1ImNyOvqf8yMwJq+tmuookqwDS1RZWIdUS3lOXUz5vfIY4G+ombolejvJY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1ijLJ5-0001kE-Pr; Mon, 23 Dec 2019 11:51:23 +0100
Date:   Mon, 23 Dec 2019 11:51:23 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: mdio: Add missing inline to
 of_mdiobus_child_is_phy() dummy
Message-ID: <20191223105123.GG32356@lunn.ch>
References: <20191223100321.7364-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191223100321.7364-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 11:03:21AM +0100, Geert Uytterhoeven wrote:
> If CONFIG_OF_MDIO=n:
> 
>     drivers/net/phy/mdio_bus.c:23:
>     include/linux/of_mdio.h:58:13: warning: ‘of_mdiobus_child_is_phy’ defined but not used [-Wunused-function]
>      static bool of_mdiobus_child_is_phy(struct device_node *child)
> 		 ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix this by adding the missing "inline" keyword.
> 
> Fixes: 0aa4d016c043d16a ("of: mdio: export of_mdiobus_child_is_phy")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
