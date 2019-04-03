Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DB9C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFD2206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDCP3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:29:01 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56215 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCP3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:29:01 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 246621BF213;
        Wed,  3 Apr 2019 15:28:57 +0000 (UTC)
Date:   Wed, 3 Apr 2019 17:28:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add battery-low-hw-alarm property
Message-ID: <20190403152856.GP22216@piout.net>
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
 <20190403145709.GN22216@piout.net>
 <b45fc9a86a0d4126ad6d8dda9c883043@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b45fc9a86a0d4126ad6d8dda9c883043@asem.it>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 15:06:17+0000, Flavio Suligoi wrote:
> Hi Alexandre,
> 
> > Hi,
> > 
> > On 03/04/2019 16:52:44+0200, Flavio Suligoi wrote:
> > > Some RTC devices have a battery-low automatic detection circuit.
> > > The battery-low event is usually reported with:
> > >
> > > - a bit change in a RTC status register
> > > - a hw signaling (generally using an interrupt generation), changing
> > >   the hw level of a specific pin;
> > >
> > > The new property "battery-low-hw-alarm" enable the RTC to generate the
> > > hw signaling in case of battery-low event.
> > >
> > > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> > > ---
> > >  Documentation/devicetree/bindings/rtc/rtc.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt
> > b/Documentation/devicetree/bindings/rtc/rtc.txt
> > > index a97fc6a..f93a44d 100644
> > > --- a/Documentation/devicetree/bindings/rtc/rtc.txt
> > > +++ b/Documentation/devicetree/bindings/rtc/rtc.txt
> > > @@ -31,6 +31,9 @@ below.
> > >                              expressed in femto Farad (fF).
> > >                              The default value shall be listed (if
> > optional),
> > >                              and likewise all valid values.
> > > +- battery-low-hw-alarm :    Enable the "battery-low" output pin. This
> > function
> > 
> > I would name that voltage-low-alarm as not all the secondary voltages
> > are batteries.
> 
> You have right. So we can also name the property a: "voltage-low-hw-alarm". 
> I prefer to have the word "hw" in the property name, since the "sw" voltage
> low alarm is already present is some RTC drivers. 
> In this way, with the word "hw", is more clear that we are speaking about
> an hw pin signaling.
> 

Well, the device tree always describes the hardware so there is no point
in specifying hw.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
