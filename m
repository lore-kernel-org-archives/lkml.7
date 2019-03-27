Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB8FC10F06
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D509420811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfC0E3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:29:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:44646 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfC0E3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:29:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 21:28:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="286204597"
Received: from yannluen-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.205])
  by orsmga004.jf.intel.com with ESMTP; 26 Mar 2019 21:28:55 -0700
Date:   Wed, 27 Mar 2019 06:28:54 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     grawity@gmail.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3] tpm: fix an invalid condition in
 tpm_common_poll
Message-ID: <20190327042854.GA15397@linux.intel.com>
References: <155326553839.17270.7997105682830234546.stgit@tstruk-mobl1.jf.intel.com>
 <20190322155917.GA6987@linux.intel.com>
 <20190325140954.GA13699@linux.intel.com>
 <dce01e51-7a1a-a5c7-0092-388889f334fd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce01e51-7a1a-a5c7-0092-388889f334fd@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 08:58:28AM -0700, Tadeusz Struk wrote:
> Hi Jarkko,
> On 3/25/19 7:09 AM, Jarkko Sakkinen wrote:
> > It is still missing the comment I asked to add. Otherwise, it is good.
> > 
> 
> Sorry, I didn't see your email with the suggestion earlier.
> To be honest I'm not sure if this comment adds much value, or if it is
> even correct. The poll doesn't "succeed" or "fail". It just returns
> a mask indicating if there is any data to read or if the user can write.
> 
> Isn't the commit message + 'git blame' enough to remember why it was
> done this way?

Comments in the code have also their time and place especially when
doing code reviews. Usually I like to have something in a site where
there has been a race even if it was for fairly trivial reason. If you
want to refine the comment to be more to the point, that is perfectly
fine.

/Jarkko
