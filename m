Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A1BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AF522312
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfKTIaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:30:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:46857 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfKTIaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:30:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 00:30:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="215720148"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2019 00:30:17 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Nov 2019 10:30:17 +0200
Date:   Wed, 20 Nov 2019 10:30:17 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt change for v5.5 part 2
Message-ID: <20191120083017.GU11621@lahna.fi.intel.com>
References: <20191119130751.GK11621@lahna.fi.intel.com>
 <20191119160022.GA2027670@kroah.com>
 <20191119162018.GN11621@lahna.fi.intel.com>
 <20191119163650.GA2031621@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119163650.GA2031621@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 05:36:50PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 19, 2019 at 06:20:18PM +0200, Mika Westerberg wrote:
> > On Tue, Nov 19, 2019 at 05:00:22PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Nov 19, 2019 at 03:07:51PM +0200, Mika Westerberg wrote:
> > > > Hi Greg,
> > > > 
> > > > There is one more Thunderbolt driver improvement that I would like to
> > > > get into v5.5 merge window. Please consider pulling.
> > > 
> > > Hey, that sounds like the problem my laptop was having!  :)
> > > 
> > > Should this also go to stable for 5.4.y?
> > 
> > Yes, I think it makes sense to have it there. Do you want me to mark it
> > for stable or you do it?
> 
> I've now done it.  I had to rebase/rewrite the description, so watch out
> for that if you pull from my tree.

Thanks Greg!
