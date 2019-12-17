Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7B3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACBA2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfLQS2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:28:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37239 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:28:02 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ihHZb-0004GW-Ap; Tue, 17 Dec 2019 19:27:55 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ihHZa-0007ij-7F; Tue, 17 Dec 2019 19:27:54 +0100
Date:   Tue, 17 Dec 2019 19:27:54 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/3] tty: rename tty_kopen() and add new function
 tty_kopen_shared()
Message-ID: <20191217182754.rji5p3npzc2z4gv3@pengutronix.de>
References: <20191217165816.19324-1-u.kleine-koenig@pengutronix.de>
 <20191217165816.19324-2-u.kleine-koenig@pengutronix.de>
 <c83b364b-3494-cf3d-0429-61ec3b502be0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c83b364b-3494-cf3d-0429-61ec3b502be0@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jacek,

On Tue, Dec 17, 2019 at 07:08:47PM +0100, Jacek Anaszewski wrote:
> I wanted to test the set but unfortunately this
> patch does not apply. See below for the apparent reason.
>
> > [...]
> > -struct tty_struct *tty_kopen(dev_t device)
> > +static struct tty_struct *tty_kopen(dev_t device, int shared)
> >  {
> >  	struct tty_struct *tty;
> >  	struct tty_driver *driver;
> 
> In mainline, even in v5.5-rc2 we have here NULL assignment:
> 
> struct tty_driver *driver = NULL;

Yeah, if you don't want to wait for Greg's tree to appear in next, this
is the patch you're missing:

	https://lkml.org/lkml/2019/12/17/101

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
