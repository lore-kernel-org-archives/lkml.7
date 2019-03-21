Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C22218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iWEPTvkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfCULpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:45:53 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33166 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbfCULpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nXwxvZcGtcjuDQ8IJpMKqrLzV5vePZUyKAJAsBh9ArU=; b=iWEPTvkYko0ZkPy+wN5Me9qK/4
        duBtldgq54stHiIN1NAK+qlr8IonmsGla2W5RmYbBNUjbVAU6+RMkeNxFIoYng57pDIID6lnxWXEJ
        zPmEjNGy6vzIVLNl2cWJI8HKeyud7doUAmx+jczUuBcsQx0CFNMLNxcGWLXbqF4E1NGU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h6w8m-0003We-21; Thu, 21 Mar 2019 12:45:44 +0100
Date:   Thu, 21 Mar 2019 12:45:44 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Message-ID: <20190321114544.GG2900@lunn.ch>
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
 <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
 <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
 <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 08:17:01AM -0300, Fabio Estevam wrote:
> Hi Abel,
> 
> On Thu, Mar 21, 2019 at 5:42 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> 
> > > It seems we have other boards that need to be fixed and we can not
> > > have an old dtb with functional Ethernet with a new kernel.
> > >
> > > Does anyone know if this issue is AR8031 specific?
> >
> > I can confirm the same fix is works on imx6sx too.
> 
> imx6sx-sabresd also uses an AR8031 Ethernet PHY.
> 
> I also tested that changing the phy-mode to "rgmii-id" fixes Ethernet
> on pico-imx7d with AR8035.
> 
> So yes, we currently have lots of broken dtb's in mainline and I am
> wondering what is the proper fix here.
> 
> Does anyone know what was the kernel commit that introduced such regressions?

Hi Fabio

The problem here is, all the DTs were broken since day 0. However,
because the PHY driver was also broken, nobody noticed and it
worked. Now that the PHY driver has been fixed, all the bugs in the
DTs now become an issue.

There is also a need to fix the PHY driver, because there is at least
one board which needs it fixed in order to work.

When we discussed fixing the PHY driver, we had no idea how many
boards would break. So we said, lets try it, and fix up whatever
breaks. We can however discuss this again. We can declare both the PHY
driver and the DTs terminally broken, and add a vendor proprietary
property for the phy-mode, which takes preference over the standard
phy-mode if present, and that does the correct thing.

    Andrew

