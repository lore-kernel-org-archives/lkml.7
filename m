Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD116C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779AD20851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SGqQLzdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbfCANoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:44:46 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:43188 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbfCANop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=S6EXwIIQbHnrpi/gvuKtmPkcyXjQenQGfYdnYrFs4M8=; b=SGqQLzdMJaep083FU0W6/bjgKf
        eqOoohEvXbC+lCjP6ajDsam4sW0Ow+dNNg8w/b3qtWbliVqA1M/QiVqIJHkFJBsDxglWes0/WXbgQ
        LNQogwEifL/yqmqa5AyR+puouuQ0yGiDz1rVtT1/EbGPKOK/FN9lH0A1zoJqMJ+K02Ao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gziSw-0005Sl-9M; Fri, 01 Mar 2019 14:44:42 +0100
Date:   Fri, 1 Mar 2019 14:44:42 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: Re: [PATCH net 0/2] Use C45 Helpers when possible
Message-ID: <20190301134442.GA19813@lunn.ch>
References: <cover.1551437561.git.joabreu@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551437561.git.joabreu@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:54:22AM +0100, Jose Abreu wrote:
> For -net. Please review!

Hi Jose

Patches for net should have fixes: tags, making it clear what they
fix, and how far back the patches should be ported.

Thanks
	Andrew
