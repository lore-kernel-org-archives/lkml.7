Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532B0C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35574206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfJKQPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:15:44 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:44292 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbfJKQPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:15:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 338A68368F0B;
        Fri, 11 Oct 2019 16:15:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: oil02_4ec6eab431f26
X-Filterd-Recvd-Size: 1758
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Oct 2019 16:15:41 +0000 (UTC)
Message-ID: <168ca7e087da28527134816b7a4dabac043a0796.camel@perches.com>
Subject: Re: [PATCH] ipmi: Convert ipmi_debug_msg to pr_debug and use %*ph
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Oct 2019 09:15:39 -0700
In-Reply-To: <20191011160541.GG32742@smile.fi.intel.com>
References: <20191011145213.65082-1-andriy.shevchenko@linux.intel.com>
         <4eaca9a1bcbf9d87c1fb3c9135876c3ecb72a91b.camel@perches.com>
         <20191011151220.GB32742@smile.fi.intel.com>
         <e0b24ff49eb69a216b11f97db1fc26c5d3b971b4.camel@perches.com>
         <7831759661d9f3d47bd304b2e98e65e5d6c5d167.camel@perches.com>
         <20191011160541.GG32742@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 19:05 +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2019 at 08:46:41AM -0700, Joe Perches wrote:
> > Using %*ph format to print small buffers as hex string reduces
> > overall object size and allows the removal of the two variants
> > of ipmi_debug_msg.
> > 
> > This also removes unnecessary duplicate colons from output when
> > enabled by #DEBUG or newly possible CONFIG_DYNAMIC_DEBUG.
> 
> I have sent v2 with slightly better approach (no need to have %s).

Great, yours has the advantage of actually compiling properly.
I did not reverse the arguments after the format.  oops.


