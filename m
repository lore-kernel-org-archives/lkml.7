Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC5DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DEE20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dj3rfq89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfHLOeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:34:18 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53646 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfHLOeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7pJ6mkpqW4c0AbMMIlDdCSTTELlLCE493p35+1hlG8s=; b=Dj3rfq899UcD2LYnB6mCZSBs7X
        SaGpEp5DtVlILEY4AbsADJzUMg2vfZCNOB9FYEL8brHiYvQ+xQ+/dl4Xf/Nf3I4MFhCfGL0KQGMao
        kMD7dBp7DQVqT+/BOgdCgXXBkHXwi8jdLXZUn/pGZr6foYp0K3JJdLVror9EVbWoiaug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hxBOq-0000xW-O0; Mon, 12 Aug 2019 16:34:16 +0200
Date:   Mon, 12 Aug 2019 16:34:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Subject: Re: [PATCH v4 14/14] dt-bindings: net: add bindings for ADIN PHY
 driver
Message-ID: <20190812143416.GT14290@lunn.ch>
References: <20190812112350.15242-1-alexandru.ardelean@analog.com>
 <20190812112350.15242-15-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812112350.15242-15-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:23:50PM +0300, Alexandru Ardelean wrote:
> This change adds bindings for the Analog Devices ADIN PHY driver, detailing
> all the properties implemented by the driver.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
