Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B723FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D6021900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RNxR82Pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfCVLAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:00:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34712 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfCVLAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4k5KAupz7pwgpj6lNzwyP25KrQTmJSaJfQVrIUcDfEM=; b=RNxR82PkzZdnMvuUAEzOpikWIA
        AuL/YISQf2KB2wpQIw2gJ9N2LWCnxvO9U7REEns9Ukh4BS3Ya3IyStEJ1QTNwdNEQUufuCgSJnHNn
        b6txliNM8Z54n+dO9PbBN5wVbCM3bOqBhIEstD9Hqi1kAu3idfdk7NwY1TG56o0mMU8s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h7Hu3-0008Ja-DN; Fri, 22 Mar 2019 11:59:59 +0100
Date:   Fri, 22 Mar 2019 11:59:59 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Message-ID: <20190322105959.GD24801@lunn.ch>
References: <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
 <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
 <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
 <20190322011155.GO12513@dragon>
 <CAOMZO5CBjG_xZWjZof_VOKaLLOCxFz3g7Gz1uTVzD=D5GeQb4g@mail.gmail.com>
 <20190322021521.GY12513@dragon>
 <CAOMZO5CRRg9XD9VovcO5+fdM1DBp12P33T9xgW=cEvTES8yDPA@mail.gmail.com>
 <db0a3a96-d836-f7bd-4773-81fcb7984835@ysoft.com>
 <DB7PR10MB2348358D285E2560F5B5E699FE430@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR10MB2348358D285E2560F5B5E699FE430@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a way of doing this to preserve backwards compatibility I think.
> Maybe deprecating the previous DTS phy-mode and replacing it with a new one,
> phy-mode-v2 instead?

Hi Steve

It needs to be a vendor specific property, atheros,phy-mode, for
example.

   Andrew
