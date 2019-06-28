Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC129C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEDC2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfF1Pdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:33:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:43830 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1Pdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:33:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 08:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="185672927"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2019 08:33:44 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1B0513015ED; Fri, 28 Jun 2019 08:33:44 -0700 (PDT)
Date:   Fri, 28 Jun 2019 08:33:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tmricht@linux.ibm.com,
        brueckner@linux.ibm.com, kan.liang@linux.intel.com,
        ben@decadent.org.uk, mathieu.poirier@linaro.org,
        mark.rutland@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com
Subject: Re: [PATCH v3 1/4] perf pmu: Support more complex PMU event aliasing
Message-ID: <20190628153344.GZ31027@tassilo.jf.intel.com>
References: <1561732552-143038-1-git-send-email-john.garry@huawei.com>
 <1561732552-143038-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561732552-143038-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/*
> +	 * Match more complex aliases where the alias name is a comma-delimited
> +	 * list of tokens, orderly contained in the matching PMU name.
> +	 *
> +	 * Example: For alias "socket,pmuname" and PMU "socketX_pmunameY", we
> +	 *	    match "socket" in "socketX_pmunameY" and then "pmuname" in
> +	 *	    "pmunameY".

This needs to be documented in some manpage.

-Andi

