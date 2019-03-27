Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39A5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD782075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfC0Nyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:54:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:27040 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfC0Nyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:54:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 06:54:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="145679114"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga002.jf.intel.com with ESMTP; 27 Mar 2019 06:54:39 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 5C93E301327; Wed, 27 Mar 2019 06:54:39 -0700 (PDT)
Date:   Wed, 27 Mar 2019 06:54:39 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf, tools: Implement duration_time as a proper
 event
Message-ID: <20190327135439.GS18020@tassilo.jf.intel.com>
References: <20190326221823.11518-1-andi@firstfloor.org>
 <20190326221823.11518-3-andi@firstfloor.org>
 <20190327085813.GB24156@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327085813.GB24156@krava>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> so now that we have time in a separate event, we could
> get rid of the isolated update_stats(&walltime_nsecs_stats) calls
> and move them to perf_stat__update_shadow_stats?

In theory yes, but it would require perf stat always setting up
the duration_time event implicitely and then special handling.

For stat it would need to be hidden to keep the same output.

It's probably simpler to keep the old way for that.

-Andi

