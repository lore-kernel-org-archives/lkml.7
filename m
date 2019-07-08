Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326E9C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0781B217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ikEvL6Yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404712AbfGHTqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:46:25 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33172 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbfGHTqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7uzdZ/IK3FH7mAIp0p/NryfuhGgzACHzKLTL6ohKmwk=; b=ikEvL6YwY3XHO++2Fxo3voV2lk
        RwN645AfLfAirXvn9mhWF6kSeCbf0lAML7Juf/sQODcI/f12ZY+WbJp5l3/UfAsqtEz5BQnreFkQz
        BVvlmR2xxcBBg4jBgHUS8CagXtMM2d3XTHLGzwqiOsHXMzn8Sj2BKdhaePd54FV8ETqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hkZaZ-0004Yg-Tk; Mon, 08 Jul 2019 21:46:15 +0200
Date:   Mon, 8 Jul 2019 21:46:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: net: Add bindings for Realtek PHYs
Message-ID: <20190708194615.GH9027@lunn.ch>
References: <20190708192459.187984-1-mka@chromium.org>
 <20190708192459.187984-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708192459.187984-2-mka@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 12:24:53PM -0700, Matthias Kaehlcke wrote:
> Add the 'realtek,eee-led-mode-disable' property to disable EEE
> LED mode on Realtek PHYs that support it.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> TODO: adapt PHY core to deal with optional compatible strings

Yes. Does this even work at the moment? I would expect
of_mdiobus_child_is_phy() to return false, indicating the device is
not actually a PHY.

    Andrew
