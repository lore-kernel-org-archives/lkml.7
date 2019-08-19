Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93034C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C54A22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfHSVuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:50:07 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:53388 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728014AbfHSVuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:50:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id DE9FE181D33FC;
        Mon, 19 Aug 2019 21:50:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rail53_3ae65148ed028
X-Filterd-Recvd-Size: 1653
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 19 Aug 2019 21:50:04 +0000 (UTC)
Message-ID: <40b5fa3133c223d64050feb5ec530ce6f86d1601.camel@perches.com>
Subject: Re: [PATCH] afs: Move comments after /* fallthrough */
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 19 Aug 2019 14:50:03 -0700
In-Reply-To: <30555.1566248610@warthog.procyon.org.uk>
References: <af4cbaaeb54589a5255bd39baf6bacc2b07bf7b5.camel@perches.com>
         <d98d1f0150bec8b69a886f77fc375b8ca9d24262.camel@perches.com>
         <e77b0f32a2ce97c872eede52c88b84aa78094ae5.1565836130.git.joe@perches.com>
         <12308.1565876416@warthog.procyon.org.uk>
         <13106.1565951791@warthog.procyon.org.uk>
         <30555.1566248610@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-19 at 22:03 +0100, David Howells wrote:
> Joe Perches <joe@perches.com> wrote:
> 
> >                 /* extract the FID array and its count in two steps */
> > -               /* fall through */
> > +               fallthrough;
> >         case 1:
> 
> Okay, that doesn't look too bad.  I thought you might be going to combine it
> with the case inside a macro in some way.

Does that mean you will apply this?


