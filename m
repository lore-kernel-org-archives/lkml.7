Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81D5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC27921774
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575275938;
	bh=HPnBrd8TXP+68qZoG8LNSixiz/YCSXeBr6RQKOHtrC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GsmIOC1GXmVbGNlFD1tWhnGt0r5S6FQNda7q8CGpa0CAQWo/YH6Y4dkXBTIYvXIGa
	 xQ06o09XJNTvUtiIWIIOzUR5H0S5FWP8cXiRXKohVKmvqifsW5RriEnrH1z2GnN64n
	 6INsBirxRprtICDHn5XhrTdDLTTYiewxDgBSQv0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfLBIi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLBIi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:38:57 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD95215F1;
        Mon,  2 Dec 2019 08:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575275936;
        bh=HPnBrd8TXP+68qZoG8LNSixiz/YCSXeBr6RQKOHtrC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bp2RcZzGdf+enbmwVBjF09UI/+xWqNpE/kBrQ+kP6Av8dF6B57wiy2JseC9QVHQKk
         EQoT5TaOQ+Zn+ZhFs7iy/I5DFOwaXuwJJdW6ecPdxEWTL3GaoAllmhpFYuvk8R4+MT
         Yw3Qd7igkMRqLftK1TDF0Ir9Dv+cX2ZPmcy0WbS0=
Date:   Mon, 2 Dec 2019 16:38:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_AT803X_PHY from m to y
Message-ID: <20191202083838.GE9767@dragon>
References: <1572848275-30941-1-git-send-email-peng.fan@nxp.com>
 <20191126145450.GB5108@optiplex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126145450.GB5108@optiplex>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 03:54:50PM +0100, Oliver Graute wrote:
> On 04/11/19, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > With phy-reset-gpios are enabled for i.MX8MM-EVK board, phy
> > will be reset. Without CONFIG_AT803X_PHY as y, board will stop
> > booting in NFS DHCP, because phy is not ready. So mark
> > CONFIG_AT803X_PHY from m to y to make board boot when using nfs rootfs.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/configs/defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index c9a867ac32d4..cd778c9ea8a4 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -285,7 +285,7 @@ CONFIG_SNI_AVE=y
> >  CONFIG_SNI_NETSEC=y
> >  CONFIG_STMMAC_ETH=m
> >  CONFIG_MDIO_BUS_MUX_MMIOREG=y
> > -CONFIG_AT803X_PHY=m
> > +CONFIG_AT803X_PHY=y
> >  CONFIG_MARVELL_PHY=m
> >  CONFIG_MARVELL_10G_PHY=m
> >  CONFIG_MESON_GXL_PHY=m
> > -- 
> > 2.16.4
> 
> Hello Peng,
> 
> this patch broke my imx8qm nfs setup. With the generic phy driver my
> board is booting fine. But with the AT803X_PHY=y enabled  I'am running
> into the following phy issue. So on my side it looks inverse as on
> yours. What is the best proposal to fix this?

So you are saying your Atheros 8035 device works with generic phy
driver but not with AT803X_PHY driver?  That makes no sense.  Did you
add phy-reset-gpios property for your device?

Shawn

> 
> [    5.550442] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [    5.573206] Sending DHCP requests ...... timed out!
> [   95.339702] IP-Config: Retrying forever (NFS root)...
> [   95.348873] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
> [   99.438443] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [   99.461206] Sending DHCP requests ...... timed out!
> [  174.419639] IP-Config: Retrying forever (NFS root)...
> [  174.428834] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
> [  178.542418] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [  178.565206] Sending DHCP requests .....
> [  209.261271] random: crng init done
> [  230.565202] . timed out!
> [  260.577340] IP-Config: Retrying forever (NFS root)...
> [  260.586497] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
> [  264.686438] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [  264.709206] Sending DHCP requests ...... timed out!
> [  339.259701] IP-Config: Retrying forever (NFS root)...
> [  339.268835] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
> [  343.374422] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [  343.405206] Sending DHCP requests ...... timed out!
> [  433.171676] IP-Config: Retrying forever (NFS root)...
> [  433.180842] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
> [  437.294439] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [  437.317206] Sending DHCP requests ...... timed out!
> [  509.003660] IP-Config: Retrying forever (NFS root)...
> [  509.012836] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
> [  513.102416] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> 
> Best Regards,
> 
> Oliver
