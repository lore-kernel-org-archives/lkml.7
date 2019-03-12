Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF54C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B73E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfCLPrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:47:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:58077 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfCLPrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:47:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 08:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="210177185"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 12 Mar 2019 08:46:48 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h3jc7-0008TK-KO; Tue, 12 Mar 2019 17:46:47 +0200
Date:   Tue, 12 Mar 2019 17:46:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/5] auxdisplay: Introduce charlcd_free()
Message-ID: <20190312154647.GK9224@smile.fi.intel.com>
References: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com>
 <CANiq72mmeCv+mVGjE39OMxaJH9CDmDSDuDkdXo7aG+edxo3ekg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mmeCv+mVGjE39OMxaJH9CDmDSDuDkdXo7aG+edxo3ekg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 04:11:36PM +0100, Miguel Ojeda wrote:
> On Tue, Mar 12, 2019 at 3:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > I have found a memory leak in hd44780 and it becomes that we have no
> > counterpart to charlcd_alloc() that developers can easily miss.
> 
> Side-note now that I see these patches: I forgot to CC you in a series
> for charlcd that we got from Mans a week or two ago -- please take a
> chance to review them if you want! Also pinging Geert & Willy again in
> case they want to take a look.

Done.

It seems these two series are orthogonal to each other, so, can be applied
separately.

-- 
With Best Regards,
Andy Shevchenko


