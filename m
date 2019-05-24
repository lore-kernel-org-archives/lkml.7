Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BD3C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB4B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="54q42ja2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404137AbfEXUXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:23:36 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57128 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403773AbfEXUXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bDsqxALkxYQxXBvbrK01Y5BlnfSQ+RN3jo811XTmmO8=; b=54q42ja2NlfDNGqztWs/Z93ghp
        og9BN7MpDq6doBjHZIysXr+fOhtRDpVndBSEh53BL58wZttpsVNNpF/okJ4bc9wXD/1DzppZAoIfM
        eUyFsZZNS8eTC90nUQ02LYd898DL/rr58WDaGAssoN2vxirDz7NbYPtzhKHPjXn2+it0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hUGip-0004Ys-P6; Fri, 24 May 2019 22:23:23 +0200
Date:   Fri, 24 May 2019 22:23:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Ruslan Babayev (fib)" <fib@cisco.com>
Cc:     "20190505220524.37266-2-ruslan@babayev.com" 
        <20190505220524.37266-2-ruslan@babayev.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [PATCH RFC v2 net-next 2/2] net: phy: sfp: enable i2c-bus
 detection on ACPI based systems
Message-ID: <20190524202323.GS21208@lunn.ch>
References: <20190505220524.37266-2-ruslan@babayev.com>
 <20190507003557.40648-3-ruslan@babayev.com>
 <20190507023812.GA12262@lunn.ch>
 <BYAPR11MB3383B74F06254EDA7157D314AD310@BYAPR11MB3383.namprd11.prod.outlook.com>
 <BYAPR11MB33837495646A3A0BB23AD1B4AD000@BYAPR11MB3383.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB33837495646A3A0BB23AD1B4AD000@BYAPR11MB3383.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 07:29:06PM +0000, Ruslan Babayev (fib) wrote:
> Hi Andrew,
> 
> Just wanted to follow up on the patch. Does it look good? Do you have any other feedback, concerns with this patch?

Hi Ruslan

From what i remember, it is O.K.

I will review it again when you repost it.

  Andrew
