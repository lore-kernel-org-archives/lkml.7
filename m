Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055A4C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 13:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBAB2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 13:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfINNuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 09:50:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:54261 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbfINNuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 09:50:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 06:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197877355"
Received: from krusocki-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.34])
  by orsmga002.jf.intel.com with ESMTP; 14 Sep 2019 06:50:19 -0700
Date:   Sat, 14 Sep 2019 14:50:18 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        Denis Kenzior <denkenz@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RESEND PATCH] MAINTAINERS: keys: Update path to trusted.h
Message-ID: <20190914135018.GA12579@linux.intel.com>
References: <20190815215712.tho3fdfk43rs45ej@linux.intel.com>
 <20190815221200.3465-1-efremov@linux.com>
 <20190816185823.kjuxqfegpsywulkn@linux.intel.com>
 <b1a3742e-4d35-ebf6-2127-bc857c09997d@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a3742e-4d35-ebf6-2127-bc857c09997d@linux.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 02:50:39PM +0300, Denis Efremov wrote:
> Hi,
> 
> On 8/16/19 9:58 PM, Jarkko Sakkinen wrote:
> > On Fri, Aug 16, 2019 at 01:12:00AM +0300, Denis Efremov wrote:
> >> Update MAINTAINERS record to reflect that trusted.h
> >> was moved to a different directory in commit 22447981fc05
> >> ("KEYS: Move trusted.h to include/keys [ver #2]").
> >>
> >> Cc: Denis Kenzior <denkenz@gmail.com>
> >> Cc: James Bottomley <jejb@linux.ibm.com>
> >> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >> Cc: Mimi Zohar <zohar@linux.ibm.com>
> >> Cc: linux-integrity@vger.kernel.org
> >> Signed-off-by: Denis Efremov <efremov@linux.com>
> > 
> > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > /Jarkko
> > 
> 
> Could someone take this fix through his tree?

I picked this up now to the tpmdd tree.

/Jarkko
