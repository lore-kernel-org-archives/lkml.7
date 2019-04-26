Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED2EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E77D2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vHWqPAFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfDZN6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:58:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45475 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfDZN6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uF9JbU/4qZ7cxPBDHX2EQMipbgYm5jplX+Xg36xsS5M=; b=vHWqPAFFVe84j/lGWR+pv2Rvky
        CfRU9Rastk6A+w9yOKS9Iz+0ueNhtznV+tPDKvEVP2S87MpuaP195R0UymBLz3kotHlfOt0GHdf7b
        uIuTQupjdCt9peIhU1zioOQTIMSxqS8+BMCSdL6DDiWADYagaVYjxdpuDp2eMkW4v/k8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK1Mq-0000wp-9l; Fri, 26 Apr 2019 15:58:20 +0200
Date:   Fri, 26 Apr 2019 15:58:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Esben Haabendal <esben@geanix.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Yang Wei <yang.wei9@zte.com.cn>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/12] net: ll_temac: Extend support to non-device-tree
 platforms
Message-ID: <20190426135820.GE14432@lunn.ch>
References: <20190426073231.4008-1-esben@geanix.com>
 <20190426073231.4008-3-esben@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426073231.4008-3-esben@geanix.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:32:21AM +0200, Esben Haabendal wrote:
> Support initialization with platdata, so the driver can be used on
> non-device-tree platforms.
> 
> For currently supported device-tree platforms, the driver should behave
> as before.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/net/ethernet/xilinx/ll_temac.h      |   3 +
>  drivers/net/ethernet/xilinx/ll_temac_main.c | 187 +++++++++++++++++++---------
>  drivers/net/ethernet/xilinx/ll_temac_mdio.c |  23 +++-
>  include/linux/xilinx_ll_temac.h             |  18 +++

Hi Esben

Please place platform data include files in include/linux/platform_data/

Thanks
	Andrew
