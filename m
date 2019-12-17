Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4941C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8452082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfLRUAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:00:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:47580 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfLRUAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:00:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 12:00:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="248005702"
Received: from jtreacy-mobl1.ger.corp.intel.com ([10.251.82.127])
  by fmsmga002.fm.intel.com with ESMTP; 18 Dec 2019 12:00:30 -0800
Message-ID: <10be346c204016547fee0323cbf2ab4688dd2859.camel@linux.intel.com>
Subject: Re: [PATCH] KEYS: trusted: fix type warnings in ntohl/nthos
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191217110939.2067979-1-ben.dooks@codethink.co.uk>
References: <20191217110939.2067979-1-ben.dooks@codethink.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 17 Dec 2019 16:35:58 +0200
User-Agent: Evolution 3.34.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-17 at 11:09 +0000, Ben Dooks (Codethink) wrote:
> The ntohl takes a __be32 and ntohs takes __be16, so cast to
> those types before passing it to the byte swapping functions.

Thanks!

> Note, would be32_to_cpu and be16_to_cpu be better here?

Yes, I think that should work too.

/Jarkko

