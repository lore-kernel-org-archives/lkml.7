Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7360C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69C6223D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfKSVM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:12:26 -0500
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:48622 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726892AbfKSVM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:12:26 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D30B3180A5AED;
        Tue, 19 Nov 2019 21:12:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scene39_893a14c56c12e
X-Filterd-Recvd-Size: 2870
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Nov 2019 21:12:22 +0000 (UTC)
Message-ID: <1e9719feb8c650ea90dec41850fe9058eef59862.camel@perches.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Switch to Marvell addresses
From:   Joe Perches <joe@perches.com>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm soc <arm@kernel.org>,
        Jan Glauber <jglauber@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Nov 2019 13:12:00 -0800
In-Reply-To: <20191119202328.cqfzf5a4svn23h5a@rric.localdomain>
References: <20191119165549.14570-1-rrichter@marvell.com>
         <20191119165549.14570-4-rrichter@marvell.com>
         <64ace55545c028bc39b08370074aafd32e8fc5f5.camel@perches.com>
         <20191119185012.2fekd6f5gbpflpqe@rric.localdomain>
         <cb41a8956be6cf11e9d25c1790eeb8c935b9ab29.camel@perches.com>
         <20191119202328.cqfzf5a4svn23h5a@rric.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-19 at 20:23 +0000, Robert Richter wrote:
> Joe,
> 
> thanks for your review.
> 
> On 19.11.19 11:56:53, Joe Perches wrote:
> > Maybe make that change globally in all the files other
> > than MAINTAINERS as well eventually.
> > 
> > arch/arm64/mm/numa.c:6: * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
> > arch/mips/cavium-octeon/octeon-usb.c:551:MODULE_AUTHOR("David Daney <david.daney@cavium.com>");
> > arch/mips/include/asm/octeon/cvmx-coremask.h:6: * Copyright (c) 2016  Cavium Inc. (support@cavium.com).
> 
> [...]
> 
> This is a bit past the scope of this patch.

Yup, completely agree, as it seems I understated with "eventually".

>  I will leave that change to the driver's maintainers.

Fine by me.  btw:  There's also entries for @caviumnetworks.com
so those might change one day too.

> I also think that authorship does not
> change even if the author's email address changed or vanished later. I
> am not sure on the general handling of MODULE_AUTHOR(), should that
> always contain a valid email address? Seems not the case. I don't
> think somebody actually sends an email to the author, it is more to
> better identify the author.

Changelog identifies the author, MODULE_AUTHOR is actually
available via modinfo -a, which shows email if entered,
but that may also be rarely used in practice.


