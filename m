Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C56C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7BF21848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfJBOa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:30:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:47660 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfJBOaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:30:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 07:30:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,574,1559545200"; 
   d="scan'208";a="205353422"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 02 Oct 2019 07:30:21 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 02 Oct 2019 17:30:20 +0300
Date:   Wed, 2 Oct 2019 17:30:20 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Mario.Limonciello@dell.com,
        Andreas Noever <andreas.noever@gmail.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC PATCH 06/22] thunderbolt: Add support for lane bonding
Message-ID: <20191002143020.GG2819@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-7-mika.westerberg@linux.intel.com>
 <20191001123808.GA2954373@kroah.com>
 <20191001125320.GN2714@lahna.fi.intel.com>
 <1570026066.2472.15.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570026066.2472.15.camel@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 04:21:06PM +0200, Oliver Neukum wrote:
> Am Dienstag, den 01.10.2019, 15:53 +0300 schrieb Mika Westerberg:
> > > 
> > > Are we only going to be allowed to "bond" two links together?  Or will
> > > we be doing more than 2 in the future?  If more, then we might want to
> > > think of a different way to specify these...
> > 
> > AFAICT only two lanes are available in USB4. This goes over USB type-C
> > using the two lanes there.
> > 
> > Of course I don't know if in future there will be USB4 1.1 or something
> > that adds more lanes so if you think there is a better way to specify
> > these, I'm happy to implement that instead :) 
> 
> If this ever can become asymmetric this interface is going to turn
> around and bite.

Don't think it can be asymmetric but I'm open to all ideas how to make
it more flexible :-)
