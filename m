Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C90CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F153220679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Es5p6ZnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfJ2SZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:25:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40780 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfJ2SZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RrTFIroBu9lPNwntdMkG+w1XY6/n6kgTXNLIm3VXF9A=; b=Es5p6ZnBD/axwzYIUw7jbZ5t32
        TzpQpVBtm8utmfFVKawYMpRZahyx+hhsBMteniZ/W4BPu33B4hmb6LghNCD5RG775oyLJA8zN579m
        cu2pAw9Lt6eMghSzy+hDAPvBLENqVfmS3yQJb+HeO/O0Pb8nJezNLWAHX4x1YFUVb6kI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iPWBk-0006ly-Ds; Tue, 29 Oct 2019 19:25:52 +0100
Date:   Tue, 29 Oct 2019 19:25:52 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/3] net: phy: initialize PHYs via device tree properties
Message-ID: <20191029182552.GB19662@lunn.ch>
References: <20191029174819.3502-1-michael@walle.cc>
 <519d52d2-cd83-b544-591b-ca9d9bb16dfa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519d52d2-cd83-b544-591b-ca9d9bb16dfa@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So just to be clear on the current approach: NACK.

Agreed.

And the Marvell one has only been used to set LEDs, as far as i
know. I would definitely push back on using it for anything else.

      Andrew
