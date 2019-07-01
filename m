Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A09FC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C03B206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfGALX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:23:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:7164 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfGALX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:23:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 04:09:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,439,1557212400"; 
   d="scan'208";a="154047824"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2019 04:09:04 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, will.deacon@arm.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1] perf: Fix exclusive events' grouping
In-Reply-To: <20190701110053.23761-1-alexander.shishkin@linux.intel.com>
References: <20190701110053.23761-1-alexander.shishkin@linux.intel.com>
Date:   Mon, 01 Jul 2019 14:09:04 +0300
Message-ID: <87y31it3jj.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> So far, we tried to disallow grouping exclusive events for the fear of
> complications they would cause with moving between contexts. Specifically,
> moving a software group to a hardware context would violate the exclusivity
> rules if both groups contain matching exclusive events.

This one is bad, please disregard. v2 incoming.

Regards,
--
Alex
