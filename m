Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4BEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2860C21A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfJCIBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:01:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:19445 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfJCIBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:01:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 01:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="205561070"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Oct 2019 01:01:49 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 03 Oct 2019 11:01:48 +0300
Date:   Thu, 3 Oct 2019 11:01:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Jamet, Michael" <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 19/22] thunderbolt: Add support for Time Management
 Unit
Message-ID: <20191003080148.GL2819@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-20-mika.westerberg@linux.intel.com>
 <6F87890CF0F5204F892DEA1EF0D77A599B3F3DEC@fmsmsx122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F87890CF0F5204F892DEA1EF0D77A599B3F3DEC@fmsmsx122.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 04:52:06PM +0000, Mani, Rajmohan wrote:
> > +	/* Enable TMU if it is off */
> > +	if (!tb_switch_tmu_is_enabled(tb->root_switch))
> 
> To be consistent with the implementation of tb_switch_tmu_disable(), should we
> move the above check inside tb_switch_tmu_enable()?

Yes, I think it makes sense.
