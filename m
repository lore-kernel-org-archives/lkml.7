Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172AEC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B2A206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfG2IZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:25:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42050 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfG2IZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:25:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EB43B3FB67D77D7B7A4A;
        Mon, 29 Jul 2019 16:25:08 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Jul 2019
 16:25:03 +0800
Date:   Mon, 29 Jul 2019 09:24:53 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Greg KH <greg@kroah.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Artur Rojek <contact@artur-rojek.eu>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: linux-next: Fixes tag needs some work in the staging.current
 tree
Message-ID: <20190729092453.00005d8b@huawei.com>
In-Reply-To: <20190728131355.GA5007@kroah.com>
References: <20190728230147.1925870f@canb.auug.org.au>
        <20190728131355.GA5007@kroah.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2019 15:13:55 +0200
Greg KH <greg@kroah.com> wrote:

> On Sun, Jul 28, 2019 at 11:01:47PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > In commit
> > 
> >   5a304e1a4ea0 ("IIO: Ingenic JZ47xx: Set clock divider on probe")
> > 
> > Fixes tag
> > 
> >   Fixes: 1a78daea107d ("iio: adc: probe should set clock divider")
> > 
> > has these problem(s):
> > 
> >   - Subject does not match target commit subject
> >     Just use
> > 	git log -1 --format='Fixes: %h ("%s")'
> > 
> > Did you mean
> > 
> > Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")  
> 
> Jonathan, I'm guessing this was your fault...
> 
> greg k-h

Indeed should have spotted that one.
Sorry about that, I'll check these more thoroughly.

Thanks for pointing it out Stephen!

Jonathan

