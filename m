Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAB5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7FD22CED
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfHSP60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:58:26 -0400
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:33308 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726390AbfHSP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:58:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E04462C3A;
        Mon, 19 Aug 2019 15:58:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: day21_2c37cb083520c
X-Filterd-Recvd-Size: 1950
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 19 Aug 2019 15:58:23 +0000 (UTC)
Message-ID: <0f1487356ae2e9ff185ede2359381630007538c7.camel@perches.com>
Subject: Re: [PATCH 1/2] PTP: introduce new versions of IOCTLs
From:   Joe Perches <joe@perches.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Christopher S Hall <christopher.s.hall@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 19 Aug 2019 08:58:22 -0700
In-Reply-To: <20190819154320.GB2883@localhost>
References: <20190814074712.10684-1-felipe.balbi@linux.intel.com>
         <20190817155927.GA1540@localhost>
         <a146c1356b4272c481e5cc63666c6e58b8442407.camel@perches.com>
         <20190818201150.GA1316@localhost>
         <83075553a61ede1de9cbf77b90a5acdeab5aacbf.camel@perches.com>
         <20190819154320.GB2883@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-19 at 08:43 -0700, Richard Cochran wrote:
> On Sun, Aug 18, 2019 at 03:07:18PM -0700, Joe Perches wrote:
> > Also the original patch deletes 2 case entries for
> > PTP_PIN_GETFUNC and PTP_PIN_SETFUNC and converts them to
> > PTP_PIN_GETFUNC2 and PTP_PIN_SETFUNC2 but still uses tests
> > for the deleted case label entries making part of the case
> > code block unreachable.
> > 
> > That's at least a defect:
> > 
> > -	case PTP_PIN_GETFUNC:
> > +	case PTP_PIN_GETFUNC2:
> > 
> > and
> >  
> > -	case PTP_PIN_SETFUNC:
> > +	case PTP_PIN_SETFUNC2:
> 
> Good catch.  Felipe, please fix that!
> 
> (Regarding Joe's memset suggestion, I'll leave that to your discretion.)

Not just how declarations are done or memset.

Minimizing unnecessary stack consumption is generally good.


