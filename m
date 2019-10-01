Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749FCECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CE6218DE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbfJANse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:48:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:60933 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfJANse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:48:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 06:48:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205065386"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 06:48:29 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 16:48:28 +0300
Date:   Tue, 1 Oct 2019 16:48:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, rajmohan.mani@intel.com,
        nicholas.johnson-opensource@outlook.com.au, lukas@wunner.de,
        stern@rowland.harvard.edu, anthony.wong@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/22] thunderbolt: Introduce tb_switch_is_icm()
Message-ID: <20191001134828.GU2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-2-mika.westerberg@linux.intel.com>
 <20191001121005.GA2951658@kroah.com>
 <20191001124638.GL2714@lahna.fi.intel.com>
 <bc3be927d5fd41efa6e0828f78a41d7a@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc3be927d5fd41efa6e0828f78a41d7a@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 01:36:49PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Tuesday, October 1, 2019 7:47 AM
> > To: Greg Kroah-Hartman
> > Cc: linux-usb@vger.kernel.org; Andreas Noever; Michael Jamet; Yehezkel Bernat;
> > Rajmohan Mani; Nicholas Johnson; Lukas Wunner; Alan Stern; Limonciello, Mario;
> > Anthony Wong; linux-kernel@vger.kernel.org
> > Subject: Re: [RFC PATCH 01/22] thunderbolt: Introduce tb_switch_is_icm()
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Tue, Oct 01, 2019 at 02:10:05PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Oct 01, 2019 at 02:38:09PM +0300, Mika Westerberg wrote:
> > > > We currently differentiate between SW CM and ICM by looking directly at
> > >
> > > You should spell out what "SW CM" and "ICM" means please :)
> > 
> > Indeed, sorry about that. I will spell them out in next version.
> > 
> > SW CM is Software Connection manager, essentially
> > drivers/thunderbolt/tb.c.
> 
> In some of the documentation I've seen non-internal connection manager referred to
> as ECM, which I guess is an external connection manager?  To be consistent with various
> documentations maybe that would be better than "SW CM".

That's the first time I hear about ECM ;-)

Here at Intel we use term "SW CM" and "FW CM" and IMHO they are better
than ECM/ICM. But if people insist I can change them.
