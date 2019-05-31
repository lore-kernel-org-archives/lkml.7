Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE10C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F7026743
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfEaK06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:26:58 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:55409 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726240AbfEaK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:26:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4FC471F1D;
        Fri, 31 May 2019 10:26:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shock41_3c61640e46f43
X-Filterd-Recvd-Size: 1699
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 May 2019 10:26:54 +0000 (UTC)
Message-ID: <82dcf6a5726da3bfa39f756a46d2fcf248796150.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch.pl: Warn on duplicate sysctl local
 variable
From:   Joe Perches <joe@perches.com>
To:     Matteo Croce <mcroce@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 31 May 2019 03:26:53 -0700
In-Reply-To: <B6174D2A-C9E8-438D-A042-C39CAAA35728@redhat.com>
References: <20190531011227.21181-1-mcroce@redhat.com>
         <e41c7ff9ae38363fe8c32346fea0f7efe551d162.camel@perches.com>
         <B6174D2A-C9E8-438D-A042-C39CAAA35728@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-31 at 10:44 +0200, Matteo Croce wrote:
> On May 31, 2019 5:06:58 AM GMT+02:00, Joe Perches <joe@perches.com> wrote:
> > On Fri, 2019-05-31 at 03:12 +0200, Matteo Croce wrote:
> > > +
> > > +# check for sysctl duplicate constants
> > > +		if ($line =~ /\.extra[12]\s*=\s*&(zero|one|int_max|max_int)\b/) {
> > 
> > why max_int, there isn't a single use of it in the kernel ?
> 
> Because you can never know how a local variabile will be called.
> I wanted to add intmax and maxint too, bit it seemed too much.

I think that checkpatch should not speculate about things like this.


