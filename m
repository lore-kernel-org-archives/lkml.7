Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127C2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6232077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfCNKUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:20:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47943 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCNKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:20:13 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4NT8-0008GJ-8F; Thu, 14 Mar 2019 11:20:10 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4NT7-00037L-M0; Thu, 14 Mar 2019 11:20:09 +0100
Date:   Thu, 14 Mar 2019 11:20:09 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/4] leds: netdev trigger: factor out middle part of
 device_name_store
Message-ID: <20190314102009.o3zsxtcobuahkp7r@pengutronix.de>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-3-linux@rasmusvillemoes.dk>
 <20190314093111.7ivkdg7ozk4vylio@pengutronix.de>
 <20190314101528.GB14455@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190314101528.GB14455@amd>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Mar 14, 2019 at 11:15:28AM +0100, Pavel Machek wrote:
> On Thu 2019-03-14 10:31:11, Uwe Kleine-König wrote:
> 1;2802;0c> Hello,
> > 
> > On Wed, Mar 13, 2019 at 09:26:13PM +0100, Rasmus Villemoes wrote:
> > > +static void set_device(struct led_netdev_data *trigger_data,
> > > +		       const char *buf, size_t size)
> > 
> > "set_device" is a very generic name. Can you please prefix it with
> > "ledtrig_netdev_"?
> 
> Its static.

Still it pollutes the name space for tools like ctags. Currently there
is no other driver that provides "set_device" but there are symbol names
that are used for different purposes and that's annoying. Right, for
global names that might even be used from other source files, this is
worse. But IMHO it's still annoying enough in cases like this to not do
it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
