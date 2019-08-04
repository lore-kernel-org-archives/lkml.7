Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86353C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 14:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD0A2070D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 14:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Is4vaZOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfHDO4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 10:56:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59790 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfHDO4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 10:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d+LVZkgH3Dav+T8rDXfYDLpuIoUZWpjKyJMv58cmkPE=; b=Is4vaZOK+vPYo0ifs+N46054DQ
        2d4ZsHo/WAClb/RX5eCYCyNENurJRhDBidkKfXsMjRpVp4E3Y55Q5UGEUXc0X0mH0yw16x6wPLOBh
        N0xRxgihvNA6+Zrc9Yct/8+1uTZY80TYg/UxsebP7QnJQygsJK2grZBFCZlfltrzRKLE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1huHw1-0001xt-Qr; Sun, 04 Aug 2019 16:56:33 +0200
Date:   Sun, 4 Aug 2019 16:56:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        claudiu.beznea@microchip.com, robh+dt@kernel.org,
        mark.rutland@arm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: net: macb: Add new property for PS
 SGMII only
Message-ID: <20190804145633.GB6800@lunn.ch>
References: <1564566033-676-1-git-send-email-harini.katakam@xilinx.com>
 <1564566033-676-2-git-send-email-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564566033-676-2-git-send-email-harini.katakam@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 03:10:32PM +0530, Harini Katakam wrote:
> Add a new property to indicate when PS SGMII is used with NO
> external PHY on board.

Hi Harini

What exactly is you use case? Are you connecting to a Ethernet switch?
To an SFP cage with a copper module?

   Andrew
