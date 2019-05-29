Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BA9C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C9A242F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S6T5BQS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE2XGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:06:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40304 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfE2XGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ps67TD8ahAPdgY6AYZQgGLpnp1EOf+TqZXRQc2Y/I2w=; b=S6T5BQS5Y1fouDKzFCiapkZpIA
        xmxfgcCvE7ZpSx/cmatBjwhPBBjZDWuYBdgEqd3FxtvjUqm4/2luyB83ikO03mWLfpvpJ0o3o6B/U
        bzd7P4n2cw57GBI/TVnlePzaoT1N1Dpe55bUCYVDL1eeVY+kn9uSCX2rtK4bGu/lQ/PM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hW7eb-00031S-TW; Thu, 30 May 2019 01:06:41 +0200
Date:   Thu, 30 May 2019 01:06:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Voon, Weifeng" <weifeng.voon@intel.com>
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        biao huang <biao.huang@mediatek.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
Subject: Re: [PATCH net-next v4 1/5] net: stmmac: enable clause 45 mdio
 support
Message-ID: <20190529230641.GD18059@lunn.ch>
References: <1559149107-14631-1-git-send-email-weifeng.voon@intel.com>
 <1559149107-14631-2-git-send-email-weifeng.voon@intel.com>
 <78EB27739596EE489E55E81C33FEC33A0B9333BC@DE02WEMBXB.internal.synopsys.com>
 <D6759987A7968C4889FDA6FA91D5CBC814707D32@PGSMSX103.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6759987A7968C4889FDA6FA91D5CBC814707D32@PGSMSX103.gar.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 05:39:44PM +0000, Voon, Weifeng wrote:
> > > +static void stmmac_mdio_c45_setup(struct stmmac_priv *priv, int phyreg,
> > > +				  u32 *val, u32 *data)
> > > +{
> > > +	unsigned int reg_shift = priv->hw->mii.reg_shift;
> > > +	unsigned int reg_mask = priv->hw->mii.reg_mask;
> > 
> > Reverse christmas tree here. You also should align the function variables with
> > the opening parenthesis of the function here and in the remaining series.
> > 
> > Otherwise this patch looks good to me.
> 
> It is already reversed Christmas tree.

Yes.

> Somehow each of the character's width in the
> email is not equal.

Sounds like somebody is using a proportional font in there email
client. Bad idea.

	Andrew
