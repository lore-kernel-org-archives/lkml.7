Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386AFC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 10:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188B020CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 10:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfL0KQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 05:16:18 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:58786 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbfL0KQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 05:16:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id BFBBBFB03;
        Fri, 27 Dec 2019 11:16:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LOpDKjPcq13w; Fri, 27 Dec 2019 11:16:14 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 6CF2E49799; Fri, 27 Dec 2019 11:16:14 +0100 (CET)
Date:   Fri, 27 Dec 2019 11:16:14 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: bindings: lm3692x: Document new properties
Message-ID: <20191227101614.GB2716@bogon.m.sigxcpu.org>
References: <cover.1576499103.git.agx@sigxcpu.org>
 <35a23315938909c80e7772838e1de0d2d46302f2.1576499103.git.agx@sigxcpu.org>
 <20191226191906.GA13331@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191226191906.GA13331@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Dec 26, 2019 at 12:19:06PM -0700, Rob Herring wrote:
> On Mon, Dec 16, 2019 at 01:28:05PM +0100, Guido Günther wrote:
> > We allow configuration of brightness mode and over voltage
> > protection.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> > index 4c2d923f8758..f195e8b45d85 100644
> > --- a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> > +++ b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> > @@ -18,6 +18,10 @@ Required properties:
> >  Optional properties:
> >  	- enable-gpios : gpio pin to enable/disable the device.
> >  	- vled-supply : LED supply
> > +	- ti,brightness-mapping-exponential: Whether to use exponential
> > +	    brightness mapping
> > +	- ti,overvoltage-volts: Overvoltage protection in Volts, can
> > +	    be 0 (unprotected), 21, 25 or 29V
> 
> '-microvolt' is the standard unit suffix.

Fixed in v2:

   https://lore.kernel.org/linux-leds/20191226100615.GA4033@amd/T/#u

Cheers,
 -- Guido

> 
> >  
> >  Required child properties:
> >  	- reg : 0 - Will enable all LED sync paths
> > -- 
> > 2.23.0
> > 
> 
