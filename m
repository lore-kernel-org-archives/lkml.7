Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E525C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB632173E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbfHOMEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:04:40 -0400
Received: from esa01.kjsl.com ([198.137.202.87]:11415 "EHLO esa01.kjsl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731520AbfHOMEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:04:35 -0400
Received: from unknown (HELO people.danlj.org) ([IPv6:2607:7c80:54:5:7609:68e3:940d:b47c])
  by esa01.kjsl.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 12:04:34 +0000
Received: from people.danlj.org (localhost [127.0.0.1])
        by people.danlj.org (8.14.7/8.14.7) with ESMTP id x7FC4X59020504
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 08:04:33 -0400
Received: (from johnsonm@localhost)
        by people.danlj.org (8.14.7/8.15.2/Submit) id x7FC4X5Z020503;
        Thu, 15 Aug 2019 08:04:33 -0400
Date:   Thu, 15 Aug 2019 08:04:32 -0400
From:   "Michael K. Johnson" <johnsonm@danlj.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: Re: [PATCH v3 1/3] mmc: sdhci: Add PLL Enable support to internal
 clock setup
Message-ID: <20190815120432.GA20438@people.danlj.org>
References: <20190726020746.GB12042@people.danlj.org>
 <acc74e9e-ca41-a5dd-780a-615745d70101@intel.com>
 <20190812225611.GA30758@people.danlj.org>
 <d6432410-6431-efdb-4e28-a601493e4916@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6432410-6431-efdb-4e28-a601493e4916@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 02:27:44PM +0300, Adrian Hunter wrote:
> On 13/08/19 1:56 AM, Michael K. Johnson wrote:
> > The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
> > setup as part of the internal clock setup as described in 3.2.1 Internal
> > Clock Setup Sequence of SD Host Controller Simplified Specification
> > Version 4.20.  This changes the timeouts to the new specification of
> > 150ms for each step and is documented as safe for "prior versions which
> > do not support PLL Enable."
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> 
> Did you mean for this patch to be "From:" Ben Chuang because otherwise
> "Co-developed-by" the author is redundant.

Ben wrote the code and is the primary author. I helped with some
changes to bring it closer to normal style, so I have definitely
been a secondary co-developer. Ben's corporate email server adds a
generic confidentiality notice outside his control, and we were
informed that with that header on the email the patches could not
be accepted.  We developed it in a git repository, so that I have
not been "tainted" by the automatic confidentiality notice, and
at Ben's request I have posted the work. To credit me as primary
author would be fundamentally incorrect.

Are you saying that this work cannot be accepted until Ben chooses
an alternative email provider besides his corporate email in order
to avoid the spurious confidentiality notice, such that he is the
sender of the email?
