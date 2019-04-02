Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E4DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807232084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KoBsxA5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDBUrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:47:53 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47755 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfDBUrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oBJR/bNNBHYIF9IjnPYVI4ILSwHSltK1bt5P2XyWLNw=; b=KoBsxA5jOCojkXDdwRElXIdck3
        x9jlKo82dqaBfC51D/JYo4hCzIq0aY8eG8qoVlIYDebj+3e9iIF4DA8FaMgIMXAHTvdB8FSl8KKoa
        w8u8+uGLoz4ilKSlhEZX1Y67Y1vdsd5LOy1wcC/BeNgDEkKikne3gkcsHKuY2VbTHnDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hBQJy-0000gb-IT; Tue, 02 Apr 2019 22:47:50 +0200
Date:   Tue, 2 Apr 2019 22:47:50 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        georg.waibel@sensor-technik.de
Subject: Re: [PATCH net-next 04/17] net: dsa: mt7530: Use vlan_filtering
 property from dsa_port
Message-ID: <20190402204750.GE22349@lunn.ch>
References: <20190331174232.22060-1-olteanv@gmail.com>
 <20190331174232.22060-5-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331174232.22060-5-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 08:42:19PM +0300, Vladimir Oltean wrote:
> This field was recently introduced, so keeping state inside the driver
> is no longer necessary.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
