Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD5EC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2FA214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L2oT6bLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfDMPn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:43:28 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60263 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfDMPn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 11:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NDBktHRE6JmtUHzkUUBQFbGpZ1d1+BpvzdbrZhNFt5w=; b=L2oT6bLVMQFNvY2y1iyfFuruaj
        jUBimCvJdis8bz//ugCfC2t6bcMI9V6LsGLbsXCNx8ADDN8B6xk6P73HReBxNisZd+99bGUzYaOL2
        hr3zkAvdT3Vqf4wpr2uJtOIBrCjUHghmsCgGKTVtmo2bKpglsHMLpw9vM1oSO9WjY/n0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFKnl-0004yx-SN; Sat, 13 Apr 2019 17:42:45 +0200
Date:   Sat, 13 Apr 2019 17:42:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, georg.waibel@sensor-technik.de
Subject: Re: [PATCH v3 net-next 14/24] net: dsa: Introduce driver for NXP
 SJA1105 5-port L2 switch
Message-ID: <20190413154245.GF17901@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-15-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413012822.30931-15-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 04:28:12AM +0300, Vladimir Oltean wrote:
> At this moment the following is supported:
> * Link state management through phylib
> * Autonomous L2 forwarding managed through iproute2 bridge commands. The
>   switch ports are initialized in a mode where they can only talk to the
>   CPU port. However, IP termination must be done currently through the
>   master netdevice.

Please could you explain that last sentence in more detail. Normally
the master device is just a dumb pipe. Nothing, except tcpdump,
uses it.

Thanks

     Andrew
