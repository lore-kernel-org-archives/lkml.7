Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C17C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0C320657
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfEWVCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:02:25 -0400
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:56005 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729797AbfEWVCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:02:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A6868182CED28;
        Thu, 23 May 2019 21:02:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brick10_31daacd83bf3d
X-Filterd-Recvd-Size: 1862
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 23 May 2019 21:02:22 +0000 (UTC)
Message-ID: <a3c036b12979ab7269917247a683eeb63df71d58.camel@perches.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add entry for fieldbus subsystem
From:   Joe Perches <joe@perches.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 23 May 2019 14:02:16 -0700
In-Reply-To: <CAGngYiUnRSSPLDhXeAg5E0pM_-ZbNV9qpOarSemDdpwLPRZeqA@mail.gmail.com>
References: <20190523195313.31008-1-TheSven73@gmail.com>
         <1b741b25b973e049948b3e490c13aad48716d5b0.camel@perches.com>
         <CAGngYiUnRSSPLDhXeAg5E0pM_-ZbNV9qpOarSemDdpwLPRZeqA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-23 at 16:23 -0400, Sven Van Asbroeck wrote:
> On Thu, May 23, 2019 at 4:00 PM Joe Perches <joe@perches.com> wrote:
> > trivia: anybuss looks like a misspelling.
> > It might be better as anybus-s.
> This came up as well during the review process. When we insert a separator,
> the include files start looking like anybus-s-controller.h, and the structs
> become like struct anybus_s_ops. It then no longer looks like a misspelling,
> but becomes harder to read?
> 
> An alternative solution is to get rid of the 's' suffix altogether. Anybus-S
> is the only flavour we support right now. Although that may obviously
> change in the future.

anybuss just looked odd to me.

Whatever you choose is up to you and
no doubt you'll choose well.

cheers, Joe


