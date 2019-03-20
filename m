Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE2DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553E32175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCTBrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:47:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:25227 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfCTBrl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:47:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 18:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,246,1549958400"; 
   d="scan'208";a="330163025"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2019 18:47:40 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id BECAF301F16; Tue, 19 Mar 2019 18:47:40 -0700 (PDT)
Date:   Tue, 19 Mar 2019 18:47:40 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v3] perf annotate/report: Remove hist__account_cycles
 from callback
Message-ID: <20190320014740.GZ24002@tassilo.jf.intel.com>
References: <1552684577-29041-1-git-send-email-yao.jin@linux.intel.com>
 <9bf3bdff-1b7f-e471-5b35-9d788248eeb9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf3bdff-1b7f-e471-5b35-9d788248eeb9@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 08:35:17AM +0800, Jin, Yao wrote:
> Nobody like this patch? :)
> 
> In my test, for a 72MB perf.data (with LBR data), the perf annotate
> processing speed:
> 
> Before: 10.2s
> After: 2.2s

That's great!

-Andi
