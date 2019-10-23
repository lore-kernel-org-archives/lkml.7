Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABEBCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F182086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SuNIEyeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406820AbfJWPiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:38:50 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59828 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403912AbfJWPis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0cvTpUnaxKKb0CU3kk4fW7rGKy//Ku36OCjzv7ST2L0=; b=SuNIEyeEy29E71Dn/VP7F9YuFv
        /HRkDJuPaKXM6twRRNxd6+k+z1z+w79xxril5Es38ITgO16euWY1i+dKFt9pHtXD6nNDZpXNVk+aP
        zQ0pyI6djIzQiWPeRVbyVgQeb1ommAUugulp4gGcz66EO5Du2WcXphe6qmxMHSkgYtH4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iNIij-0007Ml-Fq; Wed, 23 Oct 2019 17:38:45 +0200
Date:   Wed, 23 Oct 2019 17:38:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: dp83867: enable robust auto-mdix
Message-ID: <20191023153845.GB13748@lunn.ch>
References: <20191023144846.1381-1-grygorii.strashko@ti.com>
 <20191023144846.1381-2-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023144846.1381-2-grygorii.strashko@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 05:48:45PM +0300, Grygorii Strashko wrote:
> The link detection timeouts can be observed (or link might not be detected
> at all) when dp83867 PHY is configured in manual mode (speed/duplexity).
> 
> CFG3[9] Robust Auto-MDIX option allows significantly improve link detection
> in case dp83867 is configured in manual mode and reduce link detection
> time.
> As per DM: "If link partners are configured to operational modes that are
> not supported by normal Auto MDI/MDIX mode (like Auto-Neg versus Force
> 100Base-TX or Force 100Base-TX versus Force 100Base-TX), this Robust Auto
> MDI/MDIX mode allows MDI/MDIX resolution and prevents deadlock."
> 
> Hence, enable this option by default as there are no known reasons
> not to do so.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
