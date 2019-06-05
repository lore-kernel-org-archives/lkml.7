Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC3C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D61B20693
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfFEOGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:06:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:53436 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfFEOGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:06:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 07:06:09 -0700
X-ExtLoop1: 1
Received: from araresx-wtg1.ger.corp.intel.com (HELO localhost) ([10.252.46.102])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jun 2019 07:06:06 -0700
Date:   Wed, 5 Jun 2019 17:06:01 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v4 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190605140539.GA11331@linux.intel.com>
References: <20190530152758.16628-1-sashal@kernel.org>
 <20190603202815.GA4894@linux.intel.com>
 <20190603211648.GV12898@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603211648.GV12898@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 05:16:48PM -0400, Sasha Levin wrote:
> On Mon, Jun 03, 2019 at 11:28:15PM +0300, Jarkko Sakkinen wrote:
> > On Thu, May 30, 2019 at 11:27:56AM -0400, Sasha Levin wrote:
> > > Changes since v3:
> > > 
> > >  - Address comments by Jarkko Sakkinen
> > >  - Address comments by Igor Opaniuk
> > > 
> > > Sasha Levin (2):
> > >   fTPM: firmware TPM running in TEE
> > >   fTPM: add documentation for ftpm driver
> > 
> > I think patches start to look proper but I wonder can anyone test
> > these? I don't think before that I can merge these.
> 
> They're all functionally tested by us on actual hardware before being
> sent out.
> 
> The reference implementation is open and being kept updated, and an
> interested third party should be able to verify the correctness of these
> patches. However, it doesn't look like there's an interested third party
> given that these patches have been out for a few months now.

So can they be tagged with your tested-by?

/Jarkko
