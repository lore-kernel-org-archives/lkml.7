Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB71EFC6195
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F8C2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i7quXKN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388781AbfKGMzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:55:51 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54116 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388369AbfKGMzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6crDeBV71tB57uG0XSgtv/iBquw2Z6TwVlRm1/HaHSY=; b=i7quXKN40BxHA/oeJKUeiIKost
        pMt1n+9n1KV6VJri4A6Xw4jo4oKf4IM0gRKDzQgfLNnkkGZVdO90GSPC5GILLzjf46SoiwABy1MYV
        1syUbYuMVkpqClQ+xm/6bprK9vvy3fPMUlTtcJO0OkD5epuIsgqkrPK5UcW6t9TPSEF8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iShKF-00063A-4s; Thu, 07 Nov 2019 13:55:47 +0100
Date:   Thu, 7 Nov 2019 13:55:47 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, Rob Herring <robh@kernel.org>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 4/6] net: phy: at803x: mention AR8033 as same as AR8031
Message-ID: <20191107125547.GB22978@lunn.ch>
References: <20191106223617.1655-1-michael@walle.cc>
 <20191106223617.1655-5-michael@walle.cc>
 <20191107020436.GD8978@lunn.ch>
 <1DE4295A-1D25-4FAD-8DAB-45BD97E511C9@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1DE4295A-1D25-4FAD-8DAB-45BD97E511C9@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael

> I tried that actually.. There is a PTP enable bit. It's default is 1
> (according to the AR8031 datasheet). Now guess what it's value is on
> the AR8033.. its also 1. Not enough.. I also tried to enable the
> realtime counter. well that worked too.

> And yes. I've double checked the package marking. It definitely was
> an AR8033. So either I was just lucky, or maybe.. the AR8033 is just
> a relabled AR8031 ;)

O.K, thanks for trying. We really only need to solve this mystery if
anybody actually tries to make use of PTP.

	Andrew
