Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2288AC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EF021881
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wkDKne3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfIDO6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:58:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54316 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729773AbfIDO6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Q7YjRxMVBLW49pVZW335BT3nkbBU2QFciowm7uU04mE=; b=wkDKne3ilaCN6mH8SXsvMTKeWo
        gi7Moz1AorgBLU8+tpw/KXHRTS1vY/Yp3P0eufYXnqyqWmS2wiv7MqUvHw3TtMTGD3dc4WMdQh//e
        uEDOr4tGmLnSEx63Fp0V4FLgOyWrpEVTkGGU0gTqoDdWBhqVDKIgc9x13jGmAUM7URYk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i5WjU-000313-KS; Wed, 04 Sep 2019 16:58:04 +0200
Date:   Wed, 4 Sep 2019 16:58:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Voon Weifeng <weifeng.voon@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jose Abreu <joabreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Subject: Re: [PATCH v2 net-next] net: stmmac: Add support for MDIO interrupts
Message-ID: <20190904145804.GA9068@lunn.ch>
References: <1567605774-5500-1-git-send-email-weifeng.voon@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567605774-5500-1-git-send-email-weifeng.voon@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 10:02:54PM +0800, Voon Weifeng wrote:
> From: "Chuah, Kim Tatt" <kim.tatt.chuah@intel.com>
> 
> DW EQoS v5.xx controllers added capability for interrupt generation
> when MDIO interface is done (GMII Busy bit is cleared).
> This patch adds support for this interrupt on supported HW to avoid
> polling on GMII Busy bit.
> 
> stmmac_mdio_read() & stmmac_mdio_write() will sleep until wake_up() is
> called by the interrupt handler.
> 
> Reviewed-by: Voon Weifeng <weifeng.voon@intel.com>
> Reviewed-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>
> Reviewed-by: Ong Boon Leong <boon.leong.ong@intel.com>
> Signed-off-by: Chuah, Kim Tatt <kim.tatt.chuah@intel.com>
> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> Signed-off-by: Voon Weifeng <weifeng.voon@intel.com>

Hi Voon

It is normal to include a short description of what you changed
between the previous version and this version.

The formatting of this patch also looks a bit odd. Did you use 
git format-patch ; git send-email?

Thanks
	Andrew
