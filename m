Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73DCC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB72F21582
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfL0J70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 04:59:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:18292 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfL0J7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 04:59:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 01:59:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,362,1571727600"; 
   d="scan'208";a="223734275"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 27 Dec 2019 01:59:20 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 27 Dec 2019 11:59:20 +0200
Date:   Fri, 27 Dec 2019 11:59:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/37] watchdog: intel-mid_wdt: Convert to use new SCU
 IPC API
Message-ID: <20191227095920.GR2628@lahna.fi.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
 <20191223141716.13727-17-mika.westerberg@linux.intel.com>
 <0a488bbc-e101-0479-2968-1fb9acef69fc@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a488bbc-e101-0479-2968-1fb9acef69fc@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 07:46:50AM -0800, Guenter Roeck wrote:
> On 12/23/19 6:16 AM, Mika Westerberg wrote:
> > This converts the Intel MID watchdog driver over the new SCU IPC API
> > where the SCU IPC instance is passed to the functions.
> > 
> > While there drop useless print at the end of probe.
> 
> If you say that you drop the statement you should actually do so.

Oops. I did that originally but during internal review I ended up
removing that part. Will fix the changelog in the next version.
