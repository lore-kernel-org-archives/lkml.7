Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D10FA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ED721D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440354AbfJQOqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:46:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:25615 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440344AbfJQOqr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:46:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 07:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,308,1566889200"; 
   d="scan'208";a="208694484"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga001.fm.intel.com with ESMTP; 17 Oct 2019 07:46:44 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A50403002D7; Thu, 17 Oct 2019 07:46:44 -0700 (PDT)
Date:   Thu, 17 Oct 2019 07:46:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v2] perf list: Separate the deprecated events
Message-ID: <20191017144644.GV9933@tassilo.jf.intel.com>
References: <20191017135214.18620-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017135214.18620-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  v2:
>  ---
>  In v1, the deprecated events are hidden by default but they can be
>  displayed when option "--deprecated" is enabled. In v2, we don't use
>  the new option "--deprecated". Instead, we just display the deprecated
>  events under the title "--- Following are deprecated events ---".

It's redundant with what the event description already says.
If we always want to show it we don't need to do anything.

I really would much prefer to hide it. What's the point of showing
something that people are not supposed to use?

The only reason for keeping the deprecated events is to not
break old scripts, but those don't care about perf list output.

So I think the only sane option is to hide it by default.

-Andi
