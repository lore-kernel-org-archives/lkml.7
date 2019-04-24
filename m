Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74704C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1DB218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ooaM/nPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfDXNTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:19:04 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42624 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfDXNTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pQ0S2I+QjaMqQ9HpPTACZOnqVhW8xninciuCZtW8Rrg=; b=ooaM/nPgWF0hdGg8/S+dYrYoUO
        vptYf5qzSPjzjMce2X9Lx+Sqw6dS2xwIAkNQk6ZU6pw95d7bwBfZMpJLgfwsYrvGK+3HqplCwKuk8
        Pblae9QcaFWp7QoBV8omgPuEJUoTc2uKoPhN4+lVE9S7xRgIldODmySv5kP8NY9Cgl4c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJHnf-0000sO-VK; Wed, 24 Apr 2019 15:18:59 +0200
Date:   Wed, 24 Apr 2019 15:18:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Weifeng Voon <weifeng.voon@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Kweh Hock Leong <hock.leong.kweh@intel.com>
Subject: Re: [PATCH 2/7] net: stmmac: enable clause 45 mdio support
Message-ID: <20190424131859.GN28405@lunn.ch>
References: <1556126241-2774-1-git-send-email-weifeng.voon@intel.com>
 <1556126241-2774-3-git-send-email-weifeng.voon@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556126241-2774-3-git-send-email-weifeng.voon@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 01:17:16AM +0800, Weifeng Voon wrote:
> From: Kweh Hock Leong <hock.leong.kweh@intel.com>
> 
> DWMAC4 is capable to support clause 45 mdio communication.

Hi Weifeng

Is C45 a synthesis time option, or do all DWMAC4 have it?

Thanks
	Andrew
