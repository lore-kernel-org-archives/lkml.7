Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48689C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28523206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfLPKrP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:47:15 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40789 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:47:14 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 681B6E0017;
        Mon, 16 Dec 2019 10:47:11 +0000 (UTC)
Date:   Mon, 16 Dec 2019 11:47:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add Satoz SAT050AT40H12R2 panel
 support
Message-ID: <20191216114709.0fca7240@xps13>
In-Reply-To: <20191214100911.GA2967@ravnborg.org>
References: <20191213182325.27030-1-miquel.raynal@bootlin.com>
        <20191213182325.27030-2-miquel.raynal@bootlin.com>
        <20191214100911.GA2967@ravnborg.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Sam Ravnborg <sam@ravnborg.org> wrote on Sat, 14 Dec 2019 11:09:11
+0100:

> Hi Miquel.
> 
> On Fri, Dec 13, 2019 at 07:23:25PM +0100, Miquel Raynal wrote:
> > Add support for the Satoz SAT050AT40H12R2 RGB panel.  
> 
> Google failed to find this display - do you have any pointers to
> datasheet?
> 
> This turned up: SAT050AT40H12B2
> But I failed to find any data sheet.

I could not find the datasheet myself on the Internet, I found other
datasheets of other panels from the same vendor though.

I confirm I am talking about the R2 package (not B2 your find).

> 
> I wonder if there is any typical, min, max timings - so we could use
> display_timing rather than display_mode.

Yes there are min/typ/max timings in the datasheet, I didn't know about
display_mode (copied/pasted another random timing structure and adapted
it). I will try to adapt.

> 
> Before the compatible is documented the patch will not be applied.
> So you need to submit a binding document too,
> which must be in meta-schema syntax (.yaml).

Any reason to create one (almost empty) file by compatible? As
comparison, simple I2C/SPI devices with no singularities are
listed there:
Documentation/devicetree/bindings/trivial-devices.yaml

I'll create a bindings file for this panel though.

Thanks,
Miquèl
