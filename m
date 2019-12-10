Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA770C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F4F208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfLJV1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:27:51 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:59486 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLJV1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:27:48 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-143-83-nat.elisa-mobile.fi [85.76.143.83])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id E27983000B;
        Tue, 10 Dec 2019 23:27:44 +0200 (EET)
Date:   Tue, 10 Dec 2019 23:27:44 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Sumit Pundir <pundirsumit11@gmail.com>,
        linux-kernel@vger.kernel.org, David Daney <ddaney.cavm@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Laura Lazzati <laura.lazzati.15@gmail.com>
Subject: Re: [PATCH 2/2] staging: octeon-usb: delete the octeon usb host
 controller driver
Message-ID: <20191210212744.GD18225@darkstar.musicnaut.iki.fi>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <20191210091509.3546251-2-gregkh@linuxfoundation.org>
 <20191210193153.GB18225@darkstar.musicnaut.iki.fi>
 <20191210201957.GB4070187@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210201957.GB4070187@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:19:57PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 10, 2019 at 09:31:54PM +0200, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Tue, Dec 10, 2019 at 10:15:09AM +0100, Greg Kroah-Hartman wrote:
> > > This driver was merged back in 2013 and shows no progress toward every
> > > being merged into the "correct" part of the kernel.
> > 
> > Do you mean all the patches since 2013 were "no progress"? Thanks.
> 
> I have not seen any proposals to get it out of staging at all.  If the
> only thing left really is just those two simple TODO lines, then why has
> it taken 6 years to do that?

Do you mean you did not see the below thread when I asked for help;
it was a kind of propsal, no? Also things take time when you are just a
hobbyist reverse engineering undocumented hardware that you also run in
production. Yes, I'm slow, but the starting point wasn't also a very good.

https://marc.info/?t=155839354700002&r=1&w=2

I don't mind you deleting the driver, and if you think that "no progress"
is true then I'm very sorry for all those commits/noise.

A.
