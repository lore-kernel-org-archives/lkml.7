Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3C3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57ACC20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbfJ1IJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:09:47 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:42770 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729786AbfJ1IJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:09:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 596B3181D3052;
        Mon, 28 Oct 2019 08:09:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stew80_1ac8e633b015e
X-Filterd-Recvd-Size: 2274
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Oct 2019 08:09:43 +0000 (UTC)
Message-ID: <67386d9dec115d8eccaa6407a29c525eafd7811c.camel@perches.com>
Subject: Re: [RESEND PATCH 1/2] staging: rtl8712: Fix Alignment of open
 parenthesis
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Cristiane Naves <cristianenavescardoso09@gmail.com>,
        outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Date:   Mon, 28 Oct 2019 01:09:38 -0700
In-Reply-To: <20191028080113.GD1944@kadam>
References: <cover.1572051351.git.cristianenavescardoso09@gmail.com>
         <e3842148b6dd01c47678f517a07772c75046c50f.1572051351.git.cristianenavescardoso09@gmail.com>
         <25960b2a5dfe3f5f2c6579ef718f90a139ba84d7.camel@perches.com>
         <20191028080113.GD1944@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-28 at 11:01 +0300, Dan Carpenter wrote:
> On Fri, Oct 25, 2019 at 06:50:25PM -0700, Joe Perches wrote:
> > On Fri, 2019-10-25 at 22:09 -0300, Cristiane Naves wrote:
> > > Fix alignment should match open parenthesis.Issue found by checkpatch.
> > 
> > Beyond doing style cleanups, please always try
> > to make the code more readable.
> > 
> > > diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
> > []
> > > @@ -61,13 +61,13 @@ void r8712_init_recv_priv(struct recv_priv *precvpriv,
> > >  		precvbuf->ref_cnt = 0;
> > >  		precvbuf->adapter = padapter;
> > >  		list_add_tail(&precvbuf->list,
> > > -				 &(precvpriv->free_recv_buf_queue.queue));
> > > +			      &(precvpriv->free_recv_buf_queue.queue));
> > 
> > Please remove the unnecessary parentheses too
> > 
> 
> Removing the parentheses increases your chance of the patch being
> rejected on the one thing per patch rule...

Which for people that actually know how to
read and write code is a silly rule.


