Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD4C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8248C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gb/tU24g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfHMTyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:54:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58128 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfHMTyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eCtVIbBq+z3k7xDHRnLS/xAv9L0Z1B/uFTCv0oXtN/Q=; b=gb/tU24ga3nKXREajEae0az41D
        wb2iiie007qNzSr1q3RZ2kIRd0a2zHLG6Zuv9krR0roFf6RG6bh/VHkVJ2xzRkOBuutE7MOxI70Sk
        06/BAcrs5Bm63v8pHhO1syf0UnLdY9akZlzg6nVRTylZ8B9LISvBtt/OQSkmWJKPsJaE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hxcsI-00049m-Ct; Tue, 13 Aug 2019 21:54:30 +0200
Date:   Tue, 13 Aug 2019 21:54:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 1/4] dt-bindings: net: phy: Add subnode for LED
 configuration
Message-ID: <20190813195430.GI15047@lunn.ch>
References: <20190813191147.19936-1-mka@chromium.org>
 <20190813191147.19936-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813191147.19936-2-mka@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:11:44PM -0700, Matthias Kaehlcke wrote:
> The LED behavior of some Ethernet PHYs is configurable. Add an
> optional 'leds' subnode with a child node for each LED to be
> configured. The binding aims to be compatible with the common
> LED binding (see devicetree/bindings/leds/common.txt).
> 
> A LED can be configured to be:
> 
> - 'on' when a link is active, some PHYs allow configuration for
>   certain link speeds
>   speeds
> - 'off'
> - blink on RX/TX activity, some PHYs allow configuration for
>   certain link speeds
> 
> For the configuration to be effective it needs to be supported by
> the hardware and the corresponding PHY driver.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
