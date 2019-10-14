Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DFAECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144E320663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfJNKjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:39:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:35291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731305AbfJNKj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:39:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 03:39:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,295,1566889200"; 
   d="scan'208";a="199368456"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.126])
  by orsmga006.jf.intel.com with ESMTP; 14 Oct 2019 03:39:26 -0700
Date:   Mon, 14 Oct 2019 13:39:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-stable@vger.kernel.org, linux-integrity@vger.kernel.org,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] tpm: Fix TPM 1.2 Shutdown sequence to prevent
 future TPM operations
Message-ID: <20191014103926.GB12301@linux.intel.com>
References: <20191009212831.29081-1-jarkko.sakkinen@linux.intel.com>
 <20191010082822.GD326087@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010082822.GD326087@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:28:22AM +0200, Greg KH wrote:
> On Thu, Oct 10, 2019 at 12:28:28AM +0300, Jarkko Sakkinen wrote:
> > commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream
> > 
> > This backport is for v4.14 and v4.19 The backport requires non-racy
> > behaviour from TPM 1.x sysfs code. Thus, the dependecies for that
> > are included.
> > 
> > NOTE: 1/3 is only needed for v4.14.
> 
> How can a 0/X have a git commit id?
> 
> :)
> 
> greg k-h

It cannot. I just mentioned it here because the whole purpose
of two other dependecies is to support the backport of that
upstream commit.

/Jarkko.
