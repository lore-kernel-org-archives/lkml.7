Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A984C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1DF2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDAKCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:02:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:22931 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfDAKCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:02:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 03:02:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; 
   d="scan'208";a="136526778"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.96])
  by fmsmga008.fm.intel.com with ESMTP; 01 Apr 2019 03:02:03 -0700
Date:   Mon, 1 Apr 2019 13:02:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd fixes for Linux v5.1
Message-ID: <20190401100203.GC8483@linux.intel.com>
References: <20190329115544.GA27351@linux.intel.com>
 <alpine.LRH.2.21.1903300540530.2240@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1903300540530.2240@namei.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 05:41:19AM +1100, James Morris wrote:
> On Fri, 29 Mar 2019, Jarkko Sakkinen wrote:
> 
> > Hi James,
> > 
> > These are critical fixes for v5.1. Contains also couple of new selftests for
> > v5.1 features (partial reads in /dev/tpm0). I hope these could still reach
> > the release. Thanks.
> 
> Applied to 
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

Thank you.

/Jarkko
