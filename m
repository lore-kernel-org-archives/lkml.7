Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D665C5B57B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305BD205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 22:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfF2WRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 18:17:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:19062 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfF2WRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 18:17:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2019 15:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,433,1557212400"; 
   d="scan'208";a="168093690"
Received: from spandruv-mobl3.jf.intel.com ([10.254.24.202])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2019 15:17:00 -0700
Message-ID: <41765249d4384d48437eba9c8640ecf167e629d2.camel@linux.intel.com>
Subject: Re: [PATCH 10/10] tools/power/x86: A tool to validate Intel Speed
 Select commands
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alan Cox <alan@linux.intel.com>, Len Brown <lenb@kernel.org>,
        prarit@redhat.com, darcari@redhat.com,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Date:   Sat, 29 Jun 2019 15:17:00 -0700
In-Reply-To: <CAHp75VduxgJ6k4J2bB83Xbif0D0AGkxyDAdwvN64ybxdxXHXcw@mail.gmail.com>
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
         <20190626223851.19138-11-srinivas.pandruvada@linux.intel.com>
         <CAHp75VfMDpKyYnZkZw51dwcEt5neQwGuZUaB7yEFQW6fjRYCqg@mail.gmail.com>
         <1c4238f7d18d316df82d3ba1618fecdcf014f98a.camel@linux.intel.com>
         <CAHp75VduxgJ6k4J2bB83Xbif0D0AGkxyDAdwvN64ybxdxXHXcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-06-29 at 19:03 +0300, Andy Shevchenko wrote:
> On Sat, Jun 29, 2019 at 5:53 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Sat, 2019-06-29 at 17:31 +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 27, 2019 at 1:39 AM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > I need an Ack from tools/power maintainer(s) for this.
> > > Also see below.
> > 
> > MAINTAINER file doesn't call for any special name in this folder.
> 
> And this tells me perhaps this driver needs a MAINTAINER record?
I will submit a MAINTAINER file update. I was waiting for reviews.

Thanks,
Srinivas

> 
> > $./scripts/get_maintainer.pl 0010-tools-power-x86-A-tool-to-
> > validate-
> > Intel-Speed-Selec.patch
> > Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > (commit_signer:1/1=100%,authored:1/1=100%,added_lines:31/31=100%,ad
> > ded_
> > lines:231/231=100%,added_lines:1607/1607=100%,added_lines:721/721=1
> > 00%,
> > added_lines:479/479=100%)
> > linux-kernel@vger.kernel.org (open list)
> > 
> > Len and Rafael can you ACK this tool patch?
> 
> 

