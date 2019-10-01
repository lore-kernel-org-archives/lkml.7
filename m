Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF916ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71AF2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbfJAOVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:21:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:60321 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfJAOVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:21:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 07:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205071389"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 07:21:27 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 17:21:26 +0300
Date:   Tue, 1 Oct 2019 17:21:26 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     linux-usb@vger.kernel.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        rajmohan.mani@intel.com,
        nicholas.johnson-opensource@outlook.com.au, lukas@wunner.de,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        anthony.wong@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 21/22] thunderbolt: Update documentation with the
 USB4 information
Message-ID: <20191001142126.GX2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-22-mika.westerberg@linux.intel.com>
 <5d628533d75b4b00a26c868012d5e5df@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d628533d75b4b00a26c868012d5e5df@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:17:01PM +0000, Mario.Limonciello@dell.com wrote:
> 
> 
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Tuesday, October 1, 2019 6:38 AM
> > To: linux-usb@vger.kernel.org
> > Cc: Andreas Noever; Michael Jamet; Mika Westerberg; Yehezkel Bernat; Rajmohan
> > Mani; Nicholas Johnson; Lukas Wunner; Greg Kroah-Hartman; Alan Stern;
> > Limonciello, Mario; Anthony Wong; linux-kernel@vger.kernel.org
> > Subject: [RFC PATCH 21/22] thunderbolt: Update documentation with the USB4
> > information
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > Update user's and administrator's guide to mention USB4, how it relates
> > to Thunderbolt (it is public spec of Thunderbolt 3) and and how it is
> > supported in Linux.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  Documentation/admin-guide/thunderbolt.rst | 27 ++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/thunderbolt.rst b/Documentation/admin-
> > guide/thunderbolt.rst
> > index 898ad78f3cc7..4cbed319133d 100644
> > --- a/Documentation/admin-guide/thunderbolt.rst
> > +++ b/Documentation/admin-guide/thunderbolt.rst
> > @@ -1,6 +1,25 @@
> > -=============
> > - Thunderbolt
> > -=============
> > +======================
> > + Thunderbolt and USB4
> > +======================
> > +USB4 is the public spec of Thunderbolt 3 with some differences at the
> > +register level among other things. There are two different
> > +implementations available: firmware connection manager and software
> > +connection manager. Typically PCs come with a firmware connection
> > +manager for Thunderbolt 3 and early USB4 capable systems. Apple systems
> > +on the other hand use software connection manager and the future USB4
> > +compliant PCs follow the suit.
> 
> Future isn't going to age very well.  Perhaps refer instead to "later" USB4 compliant
> PCs.

Yup.

> Also, we should be seeing this stuff pop-up outside of PCs.  So maybe better
> to just call out "devices".

Indeed, I'll update this accordingly.
