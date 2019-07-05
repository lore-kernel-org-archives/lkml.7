Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAAAC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD3921721
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mrFX3QZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfGEEt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 00:49:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55400 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfGEEt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=A6liZoln6V6W++MOwX//cUbgTZ2llyxlu+xBN9ffRZo=; b=mrFX3QZqj9vt5Lzg7Sw2jZDk3t
        fI7iWPwcdm05PwDHMYSisUItWqhJlddyuitVLKjpAd/ECw8KjF7yeFxRNAyUJXtg+wMwClwOPZadH
        qQNRETUm6z4YPC2d+KVtyc4pAkkr//eiKteDG1Ne7ECm/g47/j9AgkzMJvt2TzniYID4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hjGAL-0007vd-P9; Fri, 05 Jul 2019 06:49:45 +0200
Date:   Fri, 5 Jul 2019 06:49:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Allan W. Nielsen" <allan.nielsen@microchip.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next 4/6] arm64: dts: fsl: ls1028a: Add Felix switch
 port DT node
Message-ID: <20190705044945.GA30115@lunn.ch>
References: <1561131532-14860-1-git-send-email-claudiu.manoil@nxp.com>
 <1561131532-14860-5-git-send-email-claudiu.manoil@nxp.com>
 <20190621164940.GL31306@lunn.ch>
 <VI1PR04MB4880D8F90BBCD30BF8A69C9696E00@VI1PR04MB4880.eurprd04.prod.outlook.com>
 <20190624115558.GA5690@piout.net>
 <20190624142625.GR31306@lunn.ch>
 <20190624152344.3bv46jjhhygo6zwl@lx-anielsen.microsemi.net>
 <20190624162431.GX31306@lunn.ch>
 <20190624182614.GC5690@piout.net>
 <CA+h21hqGtA5ou7a3wjSuHxa_4fXk4GZohTAxnUdfLZjV3nq5Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hqGtA5ou7a3wjSuHxa_4fXk4GZohTAxnUdfLZjV3nq5Eg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir

> - DSA is typically used for discrete switches, switchdev is typically
> used for embedded ones.

Typically DSA is for discrete switches, but not exclusively. The
b53/SF2 is embedded in a number of Broadcom SoCs. So this is no
different to Ocelot, except ARM vs MIPS. Also, i would disagree that
switchdev is used for embedded ones. Mellonex devices are discrete, on
a PCIe bus. I believe Netronome devices are also discrete PCIe
devices. In fact, i think ocelot is the only embedded switchdev
switch.

So embedded vs discrete plays no role here at all.

> - The D in DSA is for cascaded switches. Apart from the absence of
> such a "Ocelot SoC" driver (which maybe can be written, I don't know),
> I think the switching core itself has some fundamental limitations
> that make a DSA implementation questionable:

There is no requirement to implement D in DSA. In fact, only Marvell
does. None of the other switches do. And you will also find that most
boards with a Marvell switch use a single device. D in DSA is totally
optional. In fact, DSA is built from the ground up that nearly
everything is optional. Take a look at mv88e6060, as an example. It
implements nearly nothing. It cannot even offload a bridge to the
switch.

> So my conclusion is that DSA for Felix/Ocelot doesn't make a lot of
> sense if the whole purpose is to hide the CPU-facing netdev.

You actually convinced me the exact opposite. You described the
headers which are needed to implement DSA. The switch sounds like it
can do what DSA requires. So DSA is the correct model.

     Andrew
