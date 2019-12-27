Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95234C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE9320CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfL0MRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 07:17:05 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:60900 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfL0MRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 07:17:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5C2E4FB03;
        Fri, 27 Dec 2019 13:17:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TI76RAkMDfvm; Fri, 27 Dec 2019 13:17:01 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9B10049799; Fri, 27 Dec 2019 13:17:00 +0100 (CET)
Date:   Fri, 27 Dec 2019 13:17:00 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt: bindings: lm3692x: Add ti,ovp-microvolt
 property
Message-ID: <20191227121700.GA18032@bogon.m.sigxcpu.org>
References: <cover.1577271823.git.agx@sigxcpu.org>
 <f45e30f43b7d20ac14f93309a006249fdb351ddd.1577271823.git.agx@sigxcpu.org>
 <20191226100615.GA4033@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191226100615.GA4033@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Dec 26, 2019 at 11:06:15AM +0100, Pavel Machek wrote:
> On Wed 2019-12-25 12:07:14, Guido Günther wrote:
> > This allows to set the overvoltage protection to 17V, 21V, 25V or 29V.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> Acked-by: Pavel	 Machek <pavel@ucw.cz>

Thanks!

> I will need Rob's Ack.
> 
> > @@ -44,6 +48,7 @@ led-controller@36 {
> >  
> >  	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> >  	vled-supply = <&vbatt>;
> > +	ti,ovp-microvolt = <25000000>;
> 
> Wed often put the default values here.

Makes sense, thanks.
 -- Guido

> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


