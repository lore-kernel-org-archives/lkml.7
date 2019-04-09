Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB8C282DE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209C32070D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfDINoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:44:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:29265 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfDINoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:44:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 06:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="335177821"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.55.112])
  by fmsmga006.fm.intel.com with ESMTP; 09 Apr 2019 06:44:22 -0700
Date:   Tue, 9 Apr 2019 16:44:21 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Thibaut Sautereau <thibaut.sautereau@clip-os.org>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>, grawity@gmail.com,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] tpm: fix an invalid condition in tpm_common_poll
Message-ID: <20190409134421.GD9759@linux.intel.com>
References: <155371155820.17863.10580533125620125669.stgit@tstruk-mobl1.jf.intel.com>
 <20190328123428.GF7094@linux.intel.com>
 <b29aaf62-2ea0-d6c6-32ee-44bc3fe8f03f@intel.com>
 <20190408120138.GA951@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408120138.GA951@gandi.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 02:01:38PM +0200, Thibaut Sautereau wrote:
> Hello Jarkko,
> 
> On Thu, Mar 28, 2019 at 09:34:18AM -0700, Tadeusz Struk wrote:
> > On 3/28/19 5:34 AM, Jarkko Sakkinen wrote:
> > > Thank you, it is applied.
> > 
> > Thank you Jarkko.
> 
> What's the status of this patch now? It's needed in linux-5.0.y as TPM
> 2.0 support is currently broken with those stable kernels without this
> commit.

part of a PR.

https://lore.kernel.org/linux-integrity/20190329115544.GA27351@linux.intel.com/

/Jarkko
