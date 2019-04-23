Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C360C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75322206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfDWJNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:13:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:44724 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDWJNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:13:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 02:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,385,1549958400"; 
   d="scan'208";a="167065298"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 23 Apr 2019 02:08:17 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 23 Apr 2019 12:08:16 +0300
Date:   Tue, 23 Apr 2019 12:08:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     hotwater438@tutanota.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hdegoede <hdegoede@redhat.com>,
        Linux Gpio <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: intel: Clear interrupt status in unmask callback
Message-ID: <20190423090816.GN2654@lahna.fi.intel.com>
References: <20190422044539.16085-1-kai.heng.feng@canonical.com>
 <Ld5HCy5--3-1@tutanota.com>
 <EA207DE8-E89A-427B-B910-A36170A76031@canonical.com>
 <Ld8QGex--3-1@tutanota.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ld8QGex--3-1@tutanota.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:00:48AM +0200, hotwater438@tutanota.com wrote:
>    Hi.
> 
>    Honestly, I can't find any information about my acpi suspend type.
>    There are no options in my BIOS to change it, and I can't determine
>    which exactly I have. But I suppose I have a S3 because I have suspend
>    issue.
> 
>    Can I somehow determine it in Linux? I did a research but found nothing
>    on the internet.

You can read the default mode from /sys/power/mem_sleep. "s2idle" means,
well suspend-to-idle and "deep" means S3.
