Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BD9CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEDE2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390091AbfJWSqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:46:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:16608 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389979AbfJWSqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:46:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 11:46:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="197500453"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga007.fm.intel.com with ESMTP; 23 Oct 2019 11:46:16 -0700
Date:   Wed, 23 Oct 2019 11:46:16 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc/ia64: remove legacy efirtc driver
Message-ID: <20191023184616.GA17078@agluck-desk2.amr.corp.intel.com>
References: <20191023150311.844123-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023150311.844123-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 05:01:58PM +0200, Arnd Bergmann wrote:
> There are two EFI RTC drivers, the original drivers/char/efirtc.c
> driver and the more modern drivers/rtc/rtc-efi.c.
> 
> Both implement the same interface, but the new one does so
> in a more portable way.
> 
> Move everything over to that one and remove the old one.

The new one is more talkative that the old one. I see this extra
line on the console when I boot ia64:

rtc-efi rtc-efi: setting system clock to 2019-10-23T18:30:23 UTC (1571855423)

That seems somewhat useful & informative (though the repeated "rtc-efi"
at the start of the line is redundant).

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
