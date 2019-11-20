Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7336EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A1A20715
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfKTRnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:43:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:8323 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfKTRnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:43:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 09:43:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="215872717"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2019 09:43:02 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Nov 2019 19:43:01 +0200
Date:   Wed, 20 Nov 2019 19:43:01 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        pmenzel@molgen.mpg.de, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>, ck@xatom.net,
        LKML <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>
Subject: Re: USB devices on Dell TB16 dock stop working after resuming
Message-ID: <20191120174301.GO11621@lahna.fi.intel.com>
References: <20191104154446.GH2552@lahna.fi.intel.com>
 <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
 <20191104162103.GI2552@lahna.fi.intel.com>
 <f0257624-920e-eec4-a2ec-7adf8ecbcc9d@molgen.mpg.de>
 <20191120105048.GY11621@lahna.fi.intel.com>
 <ccfa5f1a1b5e475aa4ddcbed2297b9c4@AUSX13MPC105.AMER.DELL.COM>
 <20191120152351.GJ11621@lahna.fi.intel.com>
 <90daf5669f064057b3d0da5fc110b3a4@AUSX13MPC105.AMER.DELL.COM>
 <CA+CmpXubOwsradq=ObUF-h6WBpRF3tDx9TqaUO8TeJDqvdeGPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXubOwsradq=ObUF-h6WBpRF3tDx9TqaUO8TeJDqvdeGPg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 07:16:58PM +0200, Yehezkel Bernat wrote:
> On Wed, Nov 20, 2019 at 7:06 PM <Mario.Limonciello@dell.com> wrote:
> >
> >
> > But I mean this is generally an unsafe (but convenient) option, it means that you
> > throw out security pre-boot, and all someone needs to do is turn off your machine,
> > plug in a malicious device, turn it on and then they have malicious device all the way
> > into OS.
> 
> Only if the attacker found how to forge the device UUID (and knew what UUIDs
> are allowed), isn't it? Unless you take into account things like
> external GPU box,
> where it's pretty easy to replace the card installed inside it.

No need to forge UUID if you can "borrow" the laptop for a while so that
you boot your own OS there that then updates the Boot ACL with your
malicious device UUIDs. Then you return the laptop and now it suddenly
allows booting from those as well.
