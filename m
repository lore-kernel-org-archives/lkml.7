Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4C9C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC992084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i9fgqJgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfDMQp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:45:26 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60347 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfDMQp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5tIkeSkjWvtkzE0/b2LQvNZhtmCspDbrRcaAOxaTZTQ=; b=i9fgqJgHKFz9BK6jlcMisNZwrm
        EqsAimpqGvFaUqPj/rfvKq4QT6PEPKPKnB5dCiPL/SRvw5AD/jgEp0AEj7hWbNfrPOpZKT7Sdja2J
        +NJ0NXhbPc3fyicE1ult+gqGlWc89a2sxRhXsyrJjwzT5rh81AgDJajtUE/jXq/QlLF8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFLlj-0005Sq-FP; Sat, 13 Apr 2019 18:44:43 +0200
Date:   Sat, 13 Apr 2019 18:44:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Subject: Re: [PATCH v3 net-next 14/24] net: dsa: Introduce driver for NXP
 SJA1105 5-port L2 switch
Message-ID: <20190413164443.GI17901@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-15-olteanv@gmail.com>
 <20190413154245.GF17901@lunn.ch>
 <CA+h21hrPHmzxAqdcd455qvzv0KqO93Tf-Cagy7BxMXW9DsH0CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hrPHmzxAqdcd455qvzv0KqO93Tf-Cagy7BxMXW9DsH0CQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 06:46:57PM +0300, Vladimir Oltean wrote:
> Hi Andrew,
> 
> All I'm saying is that at this point in time (patch 14/24), the driver
> is being introduced with DSA_TAG_PROTO_NONE. Then support for traffic
> and switch tagging is added later on (18/24). I was just explaining
> what can be done with the driver up to this point in the patchset.

O.K. So at this point in time, the driver is unusable. Too much other
stuff is missing. So i don't see any point in mentioning this.

      Andrew
