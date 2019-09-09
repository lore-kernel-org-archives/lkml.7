Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F77C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66622086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389957AbfIIJgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:36:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:12883 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbfIIJgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:36:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 02:36:39 -0700
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="383923999"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 02:36:38 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Louis Taylor <louis@kragniz.eu>
Subject: Re: [PATCH] docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]
In-Reply-To: <a68114afb134b8633905f5a25ae7c4e6799ce8f1.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <a68114afb134b8633905f5a25ae7c4e6799ce8f1.camel@perches.com>
Date:   Mon, 09 Sep 2019 12:36:35 +0300
Message-ID: <87k1ah3j6k.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Sep 2019, Joe Perches <joe@perches.com> wrote:
> Link: https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/

I thought Link: was for referencing the patch on the mailing list that
became the commit in git.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
