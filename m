Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5431CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8AD20872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfJRVzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 17:55:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:20350 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfJRVzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:55:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 14:55:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,313,1566889200"; 
   d="scan'208";a="371587819"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2019 14:55:52 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1ABF5300481; Fri, 18 Oct 2019 14:55:52 -0700 (PDT)
Date:   Fri, 18 Oct 2019 14:55:52 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Lars Poeschel <poeschel@lemonage.de>,
        Vadim Bendebury <vbendeb@chromium.org>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: Make charlcd.[ch] more general
Message-ID: <20191018215552.GX9933@tassilo.jf.intel.com>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <CANiq72=uXWpEWHixM+wwyxZfzQ41WYvQsoV8B3+JLRharDjC0w@mail.gmail.com>
 <20191017080741.GA17556@lem-wkst-02.lemonage>
 <CANiq72m0V5CBxp97Q4h70Gup1DCoZj4ZFa6VWQLk0jyurxeztQ@mail.gmail.com>
 <5348febc85ad3460f4e06ff11bf58ec70f6b3a48.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5348febc85ad3460f4e06ff11bf58ec70f6b3a48.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 08:33:26AM -0700, Joe Perches wrote:
> On Fri, 2019-10-18 at 17:08 +0200, Miguel Ojeda wrote:
> > On Thu, Oct 17, 2019 at 10:07 AM Lars Poeschel <poeschel@lemonage.de> wrote:
> []
> > > Oh by the way: Do you know what I can do to make checkpatch happy with
> > > its describing of the config symbol ? I tried writing a help paragraph
> > > for the config symbols in Kconfig, but that did not help.
> > 
> > CC'ing Joe.
> 
> add
> 	--ignore=CONFIG_DESCRIPTION
> or
> 	--min-conf-desc-length=1 (default is 4)
> 
> to the checkpatch command line, or just ignore it.
> 
> AK: I guess there's still some debate as to the proper
> minimum length of a Kconfig help section paragraph.

I still think four lines is a good minimum

If it's not worth writing 4 lines for, perhaps the Kconfig
symbol is not needed at all?

-Andi
