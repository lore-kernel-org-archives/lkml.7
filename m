Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F941C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9C02168B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440413AbfIWSSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:18:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:53477 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438191AbfIWSSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:18:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 11:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,541,1559545200"; 
   d="scan'208";a="272368651"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga001.jf.intel.com with ESMTP; 23 Sep 2019 11:18:30 -0700
Message-ID: <44b6fd7a71d9e9f7dd82ac51473f45b48fa4679d.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] intel-speed-select: Convert output to tables
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 23 Sep 2019 11:18:30 -0700
In-Reply-To: <20190923131638.6668-1-prarit@redhat.com>
References: <20190923131638.6668-1-prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-23 at 09:16 -0400, Prarit Bhargava wrote:
> The turbo ratio limits and turbo frequencies add a large amount of
> lines to the output.  The output can be truncated into human and
> machine readable tables to reduce the number of lines of output.
> 
Unfortunately this breaks json output. The idea is that the software
should be able to parse json output using available json libraries and
consume information, without developing complex parser.
For example:
#intel-speed-select -o out.json -f json perf-profile info
Copy paste contents of out.json in any online json editor/tools, itshouldn't give error. 

Thanks,
Srinivas


> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Prarit Bhargava (2):
>   intel-speed-select: Display turbo-ratio-limits as a table
>   intel-speed-select: Display turbo frequencies in a table
> 
>  .../x86/intel-speed-select/isst-display.c     | 196 +++++++++-------
> --
>  1 file changed, 94 insertions(+), 102 deletions(-)
> 

