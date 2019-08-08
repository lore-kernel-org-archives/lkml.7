Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80804C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCDE2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbfHHMqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:46:03 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:47603 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbfHHMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:46:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9E96F18225E01;
        Thu,  8 Aug 2019 12:46:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jewel76_347d3c036ea1e
X-Filterd-Recvd-Size: 1590
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 12:46:00 +0000 (UTC)
Message-ID: <fe704b1c159849037e394283b6318fdbc981ca0e.camel@perches.com>
Subject: Re: [PATCH] scripts/checkpatch.pl - fix *_NOTIFIER_HEAD handling
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 08 Aug 2019 05:45:59 -0700
In-Reply-To: <56763.1565244495@turing-police>
References: <33485.1565228181@turing-police>
         <33e3b8748959b2f56b906b0bfd790df322f1ed3c.camel@perches.com>
         <56763.1565244495@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 02:08 -0400, Valdis Klētnieks wrote:
> On Wed, 07 Aug 2019 22:50:47 -0700, Joe Perches said:
> > On Wed, 2019-08-07 at 21:36 -0400, Valdis Kltnieks wrote:
> > >  				^.DEFINE_$Ident\(\Q$name\E\)|
> > >  				^.DECLARE_$Ident\(\Q$name\E\)|
> > >  				^.LIST_HEAD\(\Q$name\E\)|
> > > -				^.{$Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
> > > +				^.${Ident}_NOTIFIER_HEAD\(\Q$name\E\)|

oops.

I did reply with the correct form for Gilad's original patch.
https://lore.kernel.org/lkml/613b7f1dd7244df22f677777cc946758cbd7e61c.camel@perches.com/

My mistake not noticing again in Gilad's v2.
Oh well.

