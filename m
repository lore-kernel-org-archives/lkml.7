Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32D8C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BB4214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfDZS7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:59:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:5933 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfDZS7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:59:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 11:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,398,1549958400"; 
   d="scan'208";a="168268245"
Received: from dlevy1-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.47.21])
  by fmsmga001.fm.intel.com with ESMTP; 26 Apr 2019 11:58:59 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 1/2] Docs: An initial automarkup extension for sphinx
In-Reply-To: <20190426105209.1e414eae@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190425200125.12302-1-corbet@lwn.net> <20190425200125.12302-2-corbet@lwn.net> <87tvelrv8d.fsf@intel.com> <20190426105209.1e414eae@lwn.net>
Date:   Fri, 26 Apr 2019 21:58:58 +0300
Message-ID: <87zhoch9u5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> I am not at all opposed to a more proper solution that might, in the
> long term, produce more deterministic results.  I can even try to work in
> that direction.  But this is something that can be done now that, IMO,
> doesn't in any way close off a better implementation in the future.  If we
> agree that we should automatically generate references for occurrences of
> "function()", we can change how that is actually done later.
>
> I'll look into this further, but my inclination is to go forward with what
> I have now.  It's simple and easy to understand, and doesn't seem to screw
> up anywhere in the current body of kernel docs as far as I can tell.

Fair enough. It's most important that this doesn't block us from
switching to a different implementation later once someone figures it
out.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
