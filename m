Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E1CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C4721D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404063AbfJRJpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:45:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:50601 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388377AbfJRJpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:45:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 02:45:11 -0700
X-IronPort-AV: E=Sophos;i="5.67,311,1566889200"; 
   d="scan'208";a="202654583"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 02:45:09 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 5B46B20773; Fri, 18 Oct 2019 12:45:07 +0300 (EEST)
Date:   Fri, 18 Oct 2019 12:45:07 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Petr Mladek <pmladek@suse.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: linux-next: manual merge of the pm tree with the printk tree
Message-ID: <20191018094507.GH5433@paasikivi.fi.intel.com>
References: <20191018101938.0947d0b2@canb.auug.org.au>
 <2158297.kSde27ogMe@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2158297.kSde27ogMe@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 11:34:08AM +0200, Rafael J. Wysocki wrote:
> On Friday, October 18, 2019 1:19:38 AM CEST Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the pm tree got a conflict in:
> > 
> >   lib/test_printf.c
> > 
> > between commit:
> > 
> >   57f5677e535b ("printf: add support for printing symbolic error names")
> > 
> > from the printk tree and commit:
> > 
> >   f1ce39df508d ("lib/test_printf: Add tests for %pfw printk modifier")
> > 
> > from the pm tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> The resolution looks good to me, thank you!
> 
> Sakari, please double check.

Yes, it's fine.

Thanks.

-- 
Sakari Ailus
