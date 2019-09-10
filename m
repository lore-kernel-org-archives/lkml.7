Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E98CC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B7821479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S9XVl9ZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfIJSbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:31:04 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38760 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfIJSbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uWImonlZTirG53m0bJiDqQCpCDjtF16S/XlrxleM03M=; b=S9XVl9ZN6salg75A1Im7RrPWNX
        0aVe7Yto2lZ8YUWgZsq6aKvh6FrEr/f2zwwGHI+eaPb26T8r5BHjaPMgWTLHu3rvAwpaRG5MqfI64
        ufDr4+Gfm7JSAsegiaxpfyDfp5UHabGZ07VGqpi5cOFpatKEBIGUguS6XEdA73xi1WHc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i7kul-0002wi-RJ; Tue, 10 Sep 2019 20:30:55 +0200
Date:   Tue, 10 Sep 2019 20:30:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     George McCollister <george.mccollister@gmail.com>
Cc:     netdev@vger.kernel.org, Woojung Huh <woojung.huh@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: dsa: microchip: add ksz9567 to
 ksz9477 driver
Message-ID: <20190910183055.GB9761@lunn.ch>
References: <20190910131836.114058-1-george.mccollister@gmail.com>
 <20190910131836.114058-3-george.mccollister@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910131836.114058-3-george.mccollister@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 08:18:35AM -0500, George McCollister wrote:
> Add support for the KSZ9567 7-Port Gigabit Ethernet Switch to the
> ksz9477 driver. The KSZ9567 supports both SPI and I2C. Oddly the
> ksz9567 is already in the device tree binding documentation.
> 
> Signed-off-by: George McCollister <george.mccollister@gmail.com>
> Reviewed-by: Marek Vasut <marex@denx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
