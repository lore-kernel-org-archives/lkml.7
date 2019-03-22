Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB46C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A83D21874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfCVNep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:34:45 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34749 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbfCVNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:34:44 -0400
X-Originating-IP: 90.88.33.153
Received: from aptenodytes (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AEAF760015;
        Fri, 22 Mar 2019 13:34:41 +0000 (UTC)
Message-ID: <bf2e01b54009e074140aedd0159503f14fdeb450.camel@bootlin.com>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Bin Liu <b-liu@ti.com>, Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 22 Mar 2019 14:34:41 +0100
In-Reply-To: <20190322132846.GD25852@uda0271908>
References: <20180328215213.29538-1-contact@paulk.fr>
         <20180329092326.dayuccomq5zrywqo@flea>
         <1522324644.1746.19.camel@bootlin.com> <20180420142524.GB29011@uda0271908>
         <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
         <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
         <20190321130133.zllt5pqbrhiecoch@flea> <20190321164138.GB11121@kroah.com>
         <20190322124622.GB25852@uda0271908> <20190322130953.kb4llrtz2nriyfbu@flea>
         <20190322132846.GD25852@uda0271908>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 22 mars 2019 à 08:28 -0500, Bin Liu a écrit :
> Again, think about an embedded product, if dr_mode is 'otg' which
> indicates the peripheral mode will be used at some point, when and how
> to load the gadget driver if it is not loaded automatically when Linux
> boots up? the end user doesn't have access to the console.

Why should we think of an embedded product where the end user doesn't
have access to the console? Unless I'm mistaken, the Linux kernel
doesn't target commercial products where users are powerless in
particular, and leaves out all other use cases (which may or may not be
commercial).

I don't think this assumption makes any sense in Linux as a project (or
that it's sane in any context of software development for that matter,
but that's beside the point).

> > Because no other controller requires it and therefore it's not
> > standard and violates the principle of least surprise?
> 
> I know no other controller does this, but this doesn't mean it is not
> standard.
> 
> > And even without taking this into account, there's also the fact that
> > while the *hardware* can do dual role, the software might decide
> > otherwise. If I don't want to have support for any gadget (at all) in
> > the end system, then why should I be forced to compile and load
> > something I don't even want to use in the first place?
> 
> then dr_mode should be set to 'host' instead, you don't have to load a
> gadget if peripheral mode will never be used.

I disagree: dr_mode describes the hardware capabilities, not what the
software does with it.

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

