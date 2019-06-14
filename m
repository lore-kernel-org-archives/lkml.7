Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D0DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FC92168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFNPPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:15:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:63556 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfFNPPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:15:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 08:15:14 -0700
X-ExtLoop1: 1
Received: from mdumitrx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.32.245])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2019 08:15:07 -0700
Date:   Fri, 14 Jun 2019 18:15:05 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Guenter Roeck <groeck@chromium.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        apronin@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Luigi Semenzato <semenzato@chromium.org>
Subject: Re: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM
 operations
Message-ID: <20190614151451.GA11241@linux.intel.com>
References: <20190610220118.5530-1-dianders@chromium.org>
 <20190612191618.GC3378@linux.intel.com>
 <20190613135858.GB12791@linux.intel.com>
 <CAD=FV=UoSV9LKOTMuXKRfgFir+7_qPkuhSLN6XJEKPiRPuJJwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UoSV9LKOTMuXKRfgFir+7_qPkuhSLN6XJEKPiRPuJJwg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 08:20:41AM -0700, Doug Anderson wrote:
> Found the patch in your tree at
> <http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/41f15a4f02092d531fb34b42a06e9a1603a7df27>.
> I'm decidedly a non-expert here, mostly just wrangling a patch that
> someone else came up with.  :-)  ...but let's see...
> 
> I think you're asking if the "Fixes" looks sane.  I guess it depends
> on what you're trying to accomplish.  Certainly what you've tagged in
> "Fixes" marks the point where it would be easiest to backport this fix
> to.  ...but I think the problem is much older than that patch.
> 
> As I understand it, this problem has existed for much longer.  I
> believe that ${SUBJECT} patch evolved from an investigation that Luigi
> Semenzato did back in 2013 when we got back some Chromebooks whose
> TPMs claimed that they had been "attacked".  Said another way, I
> believe it is an evolution of the patch <https://crrev.com/c/57988>
> ("CHROMIUM: workaround for Infineon TPM broken defensive timeout").
> 
> ...so technically someone ought to want this on all old kernels.
> Maybe keep the "Cc: stable" but remove the "Fixes"?

I guess that is what we have to do then.

/Jarkko
