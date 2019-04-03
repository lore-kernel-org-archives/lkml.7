Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3F2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770E120882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfDCS1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:27:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:46016 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfDCS1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:27:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 11:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,305,1549958400"; 
   d="scan'208";a="131200390"
Received: from oakcakay-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.144])
  by orsmga008.jf.intel.com with ESMTP; 03 Apr 2019 11:27:29 -0700
Date:   Wed, 3 Apr 2019 21:27:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-kernel@microsoft.com, bryankel@microsoft.com,
        thiruan@microsoft.com, suredd@microsoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ftpm: firmware TPM running in TEE
Message-ID: <20190403182728.GA17451@linux.intel.com>
References: <20190402193316.15144-1-sashal@kernel.org>
 <20190402193316.15144-2-sashal@kernel.org>
 <20190403181827.GB17006@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403181827.GB17006@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 09:18:27PM +0300, Jarkko Sakkinen wrote:
> On Tue, Apr 02, 2019 at 03:33:16PM -0400, Sasha Levin wrote:
> > This patch adds support for a software-only implementation of a TPM
> > running in TEE.
> > 
> > There is extensive documentation of the design here:
> > https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/ .
> > 
> > As well as reference code for the firmware available here:
> > https://github.com/Microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM
> > 
> > Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> What is the context anyway? I mean tpm_crb already supports fTPM running
> in TZ.

Might take 2-3 weeks before I have time to go through ftpm1.pdf with
full concentration. I did search through the PDF for CRB and found
zero hits.

The commit message should absolutely better explain what is going on
and preferably there should be some more broad documentation in
Documentation/security/tpm.

Now this is just a random code dump and nothing else.

Also, I have zero idea how to test this. Any recommendations on ARM
board that can be easily used to test custom TZ applications would be
nice.

/Jarkko
