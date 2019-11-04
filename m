Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF925CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D1B21D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfKDOol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:44:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:14504 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfKDOol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:44:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 06:44:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="212327439"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 04 Nov 2019 06:44:37 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 04 Nov 2019 16:44:36 +0200
Date:   Mon, 4 Nov 2019 16:44:36 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ck@xatom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: USB devices on Dell TB16 dock stop working after resuming
Message-ID: <20191104144436.GD2552@lahna.fi.intel.com>
References: <5d2b39bc-5952-c2b6-63b3-bce28122ffd5@molgen.mpg.de>
 <20191104142459.GC2552@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191104142459.GC2552@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:25:03PM +0200, Mika Westerberg wrote:
> Hi,
> 
> On Mon, Nov 04, 2019 at 02:13:13PM +0100, Paul Menzel wrote:
> > Dear Linux folks,
> > 
> > On the Dell XPS 13 9380 with Debian Sid/unstable with Linux 5.3.7
> > suspending the system, and resuming with Dell’s Thunderbolt TB16
> > dock connected, the USB input devices, keyboard and mouse,
> > connected to the TB16 stop working. They work for a few seconds
> > (mouse cursor can be moved), but then stop working. The laptop
> > keyboard and touchpad still works fine. All firmware is up-to-date
> > according to `fwupdmgr`.
> 
> What are the exact steps to reproduce? Just "echo mem >
> /sys/power/state" and then resume by pressing power button?

I tried v5.4-rc6 on my 9380 with TB16 dock connected and did a couple of
suspend/resume cycles (to s2idle) but I don't see any issues.

I may have older/different firmware than you, though.
