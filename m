Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A517C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65622087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfC0Omi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:42:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:49005 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfC0Omi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:42:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 07:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="144330923"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2019 07:42:22 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 248173015ED; Wed, 27 Mar 2019 07:42:22 -0700 (PDT)
Date:   Wed, 27 Mar 2019 07:42:22 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH V4 04/23] perf/x86/intel: Support adaptive PEBSv4
Message-ID: <20190327144222.GT18020@tassilo.jf.intel.com>
References: <20190326160901.4887-1-kan.liang@linux.intel.com>
 <20190326160901.4887-5-kan.liang@linux.intel.com>
 <20190326222441.GP18020@tassilo.jf.intel.com>
 <9d267395-fda8-d111-52a2-e7cdcdf7d24b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d267395-fda8-d111-52a2-e7cdcdf7d24b@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We need to call perf_event_overflow() for the last record of each event.
> It's hard to detect which record is the last record of the event with one
> pass walking.
> 
> Also, I'm not sure how much we can save with one pass walking. The
> optimization should only benefit large PEBS. The total number of records for
> large PEBS should not be huge.
> I will evaluate the performance impact of one pass walking. If there is
> observed performance improvement, I will submit a separate patch later.
> 
> For now, I think we can still use the mature two pass walking method.

Okay sounds reasonable to keep it then.

Thanks,

-Andi
