Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACB8C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4998121D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391794AbfIYPv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:51:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41995 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387835AbfIYPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:51:59 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iD9a4-0003aB-SQ; Wed, 25 Sep 2019 17:51:52 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iD9a3-00075g-RB; Wed, 25 Sep 2019 17:51:51 +0200
Date:   Wed, 25 Sep 2019 17:51:51 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
Message-ID: <20190925155151.75uaxfiiei3i23tz@pengutronix.de>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-3-m.felsch@pengutronix.de>
 <AM5PR1001MB0994ABEF9C32BFB7BEA099B680840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB0994ABEF9C32BFB7BEA099B680840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:42:18 up 130 days, 22:00, 84 users,  load average: 0.12, 0.07,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 19-09-24 09:23, Adam Thomson wrote:
> On 17 September 2019 13:43, Marco Felsch wrote:
> 
> > Add the documentation which describe the voltage selection gpio support.
> > This property can be applied to each subnode within the 'regulators'
> > node so each regulator can be configured differently.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/mfd/da9062.txt | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt
> > b/Documentation/devicetree/bindings/mfd/da9062.txt
> > index edca653a5777..9d9820d8177d 100644
> > --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> > +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> > @@ -66,6 +66,15 @@ Sub-nodes:
> >    details of individual regulator device can be found in:
> >    Documentation/devicetree/bindings/regulator/regulator.txt
> > 
> > +  Optional regulator device-specific properties:
> > +  - dlg,vsel-sense-gpios : The GPIO reference which should be used by the
> > +    regulator to switch the voltage between active/suspend voltage settings. If
> > +    the signal is active the active-settings are applied else the suspend
> > +    settings are applied. Attention: Sharing the same gpio for other purposes
> > +    or across multiple regulators is possible but the gpio settings must be the
> > +    same. Also the gpio phandle must refer to to the dlg,da9062-gpio device
> > +    other gpios are not allowed and make no sense.
> > +
> 
> Should we not use the binding names that are defined in 'gpio-regulator.yaml' as
> these seem to be generic and would probably serve the purpose here?

Hm.. as the description says:

8<--------------------------------------------------
gpios:
   description: Array of one or more GPIO pins used to select the
   regulator voltage/current listed in "states".
8<--------------------------------------------------

But we don't have a "states" property and we can't select between
voltage or current.

Regards,
  Marco

> >  - rtc : This node defines settings required for the Real-Time Clock associated
> >    with the DA9062. There are currently no entries in this binding, however
> >    compatible = "dlg,da9062-rtc" should be added if a node is created.
> > --
> > 2.20.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
