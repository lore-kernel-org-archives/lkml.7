Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11222CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E379E2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfJUIyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:54:18 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:39391 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726977AbfJUIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:54:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BB416182CF665;
        Mon, 21 Oct 2019 08:54:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: plate39_8105bbb6e644
X-Filterd-Recvd-Size: 2086
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 21 Oct 2019 08:54:15 +0000 (UTC)
Message-ID: <c6d923e10359746095d820ef19bd82cacc523b79.camel@perches.com>
Subject: Re: [PATCH v1 1/5] staging: wfx: fix warnings of no space is
 necessary
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Date:   Mon, 21 Oct 2019 01:54:14 -0700
In-Reply-To: <alpine.DEB.2.21.1910210850080.2959@hadrien>
References: <20191019140719.2542-1-jbi.octave@gmail.com>
          <20191019140719.2542-2-jbi.octave@gmail.com>
         <20191019142443.GH24678@kadam>
          <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>
          <20191019180514.GI24678@kadam>
          <336960fdf88dbed69dd3ed2689a5fb1d2892ace8.camel@perches.com>
         <20191020191759.GJ24678@kadam>
         <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>
         <alpine.DEB.2.21.1910210850080.2959@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-21 at 08:52 +0200, Julia Lawall wrote:
> > btw2:
> > 
> > I really dislike all the code inconsistencies and
> > unnecessary code duplication with miscellaneous changes
> > in the rtl staging drivers....
> > 
> > Horrid stuff.
> 
> I'm not sure what you mean by "miscellaneous changes".  Do you mean that
> all issues should be fixed for one file before moving on to another one?
> 
> Or that there are code clones, and all of the clones should be updated at
> the same time?

Neither really.

But realtek drivers are basically code clones where
realtek should prefer to have a single library used
for multiple drivers.

And staging is basically a dumping ground for realtek
wireless drivers.

https://lkml.org/lkml/2019/5/15/1405


