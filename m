Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DC3C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97F6213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbfETNey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:34:54 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:55539 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728634AbfETNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:34:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0D1D818224BBB;
        Mon, 20 May 2019 13:34:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tooth67_2a5456d1fb301
X-Filterd-Recvd-Size: 2098
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 May 2019 13:34:50 +0000 (UTC)
Message-ID: <60717bc4cdf327ffe671c328d47c315eefd385c8.camel@perches.com>
Subject: Re: [EXT] Re: [PATCH] checkpatch: add test for empty line after
 Fixes statement
From:   Joe Perches <joe@perches.com>
To:     Michal Kalderon <mkalderon@marvell.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "apw@canonical.com" <apw@canonical.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Date:   Mon, 20 May 2019 06:34:49 -0700
In-Reply-To: <MN2PR18MB318292E37F3AB9383D9FBE0FA1060@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190520124238.10298-1-michal.kalderon@marvell.com>
         <ed26df86d7d0e12263404842895460b1611def61.camel@perches.com>
         <MN2PR18MB318292E37F3AB9383D9FBE0FA1060@MN2PR18MB3182.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-20 at 13:16 +0000, Michal Kalderon wrote:
> > From: Joe Perches <joe@perches.com>
> > Sent: Monday, May 20, 2019 3:57 PM
> > Subject: [EXT] Re: [PATCH] checkpatch: add test for empty line after Fixes
> > statement
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > On Mon, 2019-05-20 at 15:42 +0300, Michal Kalderon wrote:
> > > Check that there is no empty line after a fixes statement
> > 
> > why?
> > 
> This comment is given a lot on the netdev and rdma mailing lists when patches are submitted with
> an empty line between Fixes: tag and SOB tags. Since "Fixes:" is just another tag and should be kept
> together with the other ones.

So test that all signature blocks and Fixes do not have
blank lines between them instead of just the "Fixes:" line.

And if there is some specific ordering required, perhaps a
test for that ordering should be added as well.

