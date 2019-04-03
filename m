Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28314C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DE92084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDCRu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:50:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:16381 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfDCRuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:50:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 10:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,305,1549958400"; 
   d="scan'208";a="139717290"
Received: from oakcakay-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.144])
  by orsmga003.jf.intel.com with ESMTP; 03 Apr 2019 10:50:20 -0700
Date:   Wed, 3 Apr 2019 20:50:19 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     tomas.winkler@intel.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
Subject: Re: Add support for TCG2 log format on UEFI systems
Message-ID: <20190403175019.GB13396@linux.intel.com>
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190401235245.GA29282@linux.intel.com>
 <CACdnJutCC7n++Nz5qy1YzmsSchEApDUvMH9-qpxYXckh-Dzf-Q@mail.gmail.com>
 <20190402130704.GA3916@linux.intel.com>
 <CACdnJuvFxKCwP3XftqacFiLTmTZzCGHkc9DzrJu2u6vwy5_o-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuvFxKCwP3XftqacFiLTmTZzCGHkc9DzrJu2u6vwy5_o-w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:15:39AM -0700, Matthew Garrett wrote:
> On Tue, Apr 2, 2019 at 6:07 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> > I'll apply all patches soonish and include them to the next PR.
> 
> Thanks! Looks like I need some fixes to deal with non-x86
> architectures, I'll get on that today.

Great thanks. I'll check them tomorrow (Thu).

/Jarkko
