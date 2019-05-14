Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F659C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114D720850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lM2INjEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfENMfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 08:35:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:35137 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfENMfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=931qFPLgGkTX5B8UVoqi1RHkcr6VEe5RWP7gqhbFW2I=; b=lM2INjEyoCovQvFD8CW1nSUQ6q
        ykF4K72YY0KZivnaAgELsem2MfX/y8GYLC6vbVQlo+tLyEqwmbRrc4+1KIX9cfBkgIQG9kjFH2Pr4
        XUZS7zsdyoxf07cdmJvB/GFtyTNzc7E/gX8YEm8/A/x7UXNr2T+/IeJmWgJfKdbYOesw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hQWeE-00024v-Mt; Tue, 14 May 2019 14:35:10 +0200
Date:   Tue, 14 May 2019 14:35:10 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     netdev@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: macb: fix error format in dev_err()
Message-ID: <20190514123510.GA5892@lunn.ch>
References: <20190514071450.27760-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514071450.27760-1-luca@lucaceresoli.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 09:14:50AM +0200, Luca Ceresoli wrote:
> Errors are negative numbers. Using %u shows them as very large positive
> numbers such as 4294967277 that don't make sense. Use the %d format
> instead, and get a much nicer -19.

Hi Luca

Do you consider this a fix? If so, it should be against David net
tree, and have [PATCH net] in the subject. It would also be good to
add a Fixes: tag.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
