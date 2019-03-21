Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CF0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2138218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCUOFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:05:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:9519 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbfCUOFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:05:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 07:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="329355323"
Received: from dilu-mobl2.ccr.corp.intel.com (HELO localhost) ([10.249.254.184])
  by fmsmga006.fm.intel.com with ESMTP; 21 Mar 2019 07:04:57 -0700
Date:   Thu, 21 Mar 2019 16:04:56 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: fix an invalid condition in tpm_common_poll
Message-ID: <20190321140456.GG4603@linux.intel.com>
References: <155302749437.13955.651380639754310898.stgit@tstruk-mobl1.jf.intel.com>
 <CAPWNY8UmDAKeF+SNMKDxki=-=s+UPx9WXQvSoFqWmUCsNvv=1g@mail.gmail.com>
 <8f90121a-490c-6a44-1765-d232fcc93ce0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f90121a-490c-6a44-1765-d232fcc93ce0@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:18:42PM -0700, Tadeusz Struk wrote:
> On 3/20/19 11:51 AM, Mantas Mikulėnas wrote:
> > Thanks, this patch seems to work, and I apologize for not responding
> > to test the patches earlier.
> 
> Thanks for testing.
> 
> > 
> > Any chance it'll be submitted for stable 5.0.x as well?
> 
> Yes, it's a regression. I included the "Fixes" tag so
> it should be applied to all affected versions.
> In this case it's 5.0 only.
> Thanks,
> -- 
> Tadeusz

Add a tested-by for the next version.

/Jarkko
