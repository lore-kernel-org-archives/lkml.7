Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD87C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7078E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLJTlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:41:25 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:38726 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfLJTlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:41:25 -0500
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 14:41:24 EST
Received: from darkstar.musicnaut.iki.fi (85-76-143-83-nat.elisa-mobile.fi [85.76.143.83])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 7D47230056;
        Tue, 10 Dec 2019 21:31:54 +0200 (EET)
Date:   Tue, 10 Dec 2019 21:31:54 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        David Daney <ddaney.cavm@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Sumit Pundir <pundirsumit11@gmail.com>,
        Laura Lazzati <laura.lazzati.15@gmail.com>
Subject: Re: [PATCH 2/2] staging: octeon-usb: delete the octeon usb host
 controller driver
Message-ID: <20191210193153.GB18225@darkstar.musicnaut.iki.fi>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <20191210091509.3546251-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210091509.3546251-2-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 10, 2019 at 10:15:09AM +0100, Greg Kroah-Hartman wrote:
> This driver was merged back in 2013 and shows no progress toward every
> being merged into the "correct" part of the kernel.

Do you mean all the patches since 2013 were "no progress"? Thanks.

> The code doesn't even build for anyone unless you have the specific
> hardware platform selected, so odds are it doesn't even work anymore.

I used it in production almost a decade with no issues with unpatched
mainline kernel. All reported issues were fixed. Last kernel I ran
was v5.3.

> Remove it for now and is someone comes along that has the hardware and
> is willing to fix it up, it can be reverted.

Probably the next one who tries it, should try add support in
dwc2. Originally the maintainer of that driver did not prefer this,
maybe the current one does not mind...

A.
