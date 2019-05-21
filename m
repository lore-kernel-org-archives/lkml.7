Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7FAC04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183D221743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfEUAH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 20:07:26 -0400
Received: from smtprelay0201.hostedemail.com ([216.40.44.201]:58630 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726584AbfEUAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 20:07:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AC7CA837F24D;
        Tue, 21 May 2019 00:07:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: power90_2371a2faf914a
X-Filterd-Recvd-Size: 2784
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 May 2019 00:07:23 +0000 (UTC)
Message-ID: <1522228b6c9c7ec89ce14f3f3cf1fe221a315371.camel@perches.com>
Subject: Re: [EXT] Re: [PATCH] checkpatch: add test for empty line after
 Fixes statement
From:   Joe Perches <joe@perches.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Date:   Mon, 20 May 2019 17:07:22 -0700
In-Reply-To: <20190520135214.GM4573@mtr-leonro.mtl.com>
References: <20190520124238.10298-1-michal.kalderon@marvell.com>
         <ed26df86d7d0e12263404842895460b1611def61.camel@perches.com>
         <MN2PR18MB318292E37F3AB9383D9FBE0FA1060@MN2PR18MB3182.namprd18.prod.outlook.com>
         <60717bc4cdf327ffe671c328d47c315eefd385c8.camel@perches.com>
         <20190520135214.GM4573@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-20 at 16:52 +0300, Leon Romanovsky wrote:
> On Mon, May 20, 2019 at 06:34:49AM -0700, Joe Perches wrote:
> > On Mon, 2019-05-20 at 13:16 +0000, Michal Kalderon wrote:
> > > > From: Joe Perches <joe@perches.com>
> > > > Sent: Monday, May 20, 2019 3:57 PM
> > > > Subject: [EXT] Re: [PATCH] checkpatch: add test for empty line after Fixes
> > > > statement
> > > > 
> > > > External Email
> > > > 
> > > > ----------------------------------------------------------------------
> > > > On Mon, 2019-05-20 at 15:42 +0300, Michal Kalderon wrote:
> > > > > Check that there is no empty line after a fixes statement
> > > > 
> > > > why?
> > > > 
> > > This comment is given a lot on the netdev and rdma mailing lists when patches are submitted with
> > > an empty line between Fixes: tag and SOB tags. Since "Fixes:" is just another tag and should be kept
> > > together with the other ones.
> > 
> > So test that all signature blocks and Fixes do not have
> > blank lines between them instead of just the "Fixes:" line.
> > 
> > And if there is some specific ordering required, perhaps a
> > test for that ordering should be added as well.
> 
> I'm aware of only one request - Fixes above SOB.

Well, nack for the suggested patch.

If there are signature blocks, then there should not be blank lines
between entries and there should be a blank line before the
signature block.

The current documentation in Documentation/process/submitting-patches.rst
doesn't state anything about blank lines above or below Fixes: lines.


