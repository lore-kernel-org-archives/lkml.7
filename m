Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743E6C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413D52171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfDEKgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:36:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:39212 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730400AbfDEKgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:36:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 03:36:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,312,1549958400"; 
   d="scan'208";a="159003900"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2019 03:36:06 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] stm class: Fix channel free in stm output free path
In-Reply-To: <20190405102442.25718-1-saiprakash.ranjan@codeaurora.org>
References: <20190405102442.25718-1-saiprakash.ranjan@codeaurora.org>
Date:   Fri, 05 Apr 2019 13:36:05 +0300
Message-ID: <87v9zsd9ii.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> writes:

> From: Tingwei Zhang <tingwei@codeaurora.org>
>
> Number of free masters is not set correctly in stm
> free path. Fix this by properly adding the number
> of output channels before setting them to 0 in
> stm_output_disclaim().
>
> Currently it is equivalent to doing nothing since
> master->nr_free is incremented by 0.

Good catch, thank you!
