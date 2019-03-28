Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B13C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E60217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfC1M2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:28:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:21411 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfC1M2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:28:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="126616710"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.182])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 05:27:57 -0700
Date:   Thu, 28 Mar 2019 14:27:57 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linuxibm.com>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] KEYS: trusted: allow trusted.ko to initialize w/o a
 TPM
Message-ID: <20190328122757.GB7094@linux.intel.com>
References: <20190326121158.13499-1-jarkko.sakkinen@linux.intel.com>
 <CAA9_cmfFpkBLz6TU0sLSV1JYE43sDtfi29Xw4R5Xt-RaWm8ZLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA9_cmfFpkBLz6TU0sLSV1JYE43sDtfi29Xw4R5Xt-RaWm8ZLA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 10:15:50AM -0700, Dan Williams wrote:
> On Tue, Mar 26, 2019 at 5:13 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > Allow trusted.ko to initialize w/o a TPM. This commit adds checks to the
> > key type callbacks and exported functions to fail when a TPM is not
> > available.
> >
> > Cc: James Morris <jmorris@namei.org>
> > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > Tested-by: Dan Williams <dan.j.williams@intel.com>
> > Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> > v3:
> > - remove unnecessary check for chip in init_trusted()
> 
> v3 also tests ok here.

Thank you.

/Jarkko
