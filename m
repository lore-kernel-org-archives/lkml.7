Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6641EC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435C42085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfFZNrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfFZNrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:47:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D77CF8830F;
        Wed, 26 Jun 2019 13:47:52 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-10.phx2.redhat.com [10.3.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE2365C205;
        Wed, 26 Jun 2019 13:47:50 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 6470211A; Wed, 26 Jun 2019 10:47:46 -0300 (BRT)
Date:   Wed, 26 Jun 2019 10:47:46 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     ak@linux.intel.com, kan.liang@intel.com,
        linux-kernel@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH] perf vendor events intel: Fix typos in
 floating-point.json
Message-ID: <20190626134746.GA2227@redhat.com>
References: <20190626110436.22563-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626110436.22563-1-standby24x7@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 26 Jun 2019 13:47:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 26, 2019 at 08:04:36PM +0900, Masanari Iida escreveu:
> This patch fix some spelling typo in x86/*/floating-point.json

These are auto-generated files, glad that you CCed your fixes to the
Intel folks, hopefully they will in turn send it internally so that next
time we get an update with the fixes, ok?

Thanks,

- Arnaldo
 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json    | 2 +-
>  tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json    | 2 +-
>  .../perf/pmu-events/arch/x86/westmereep-dp/floating-point.json  | 2 +-
>  .../perf/pmu-events/arch/x86/westmereep-sp/floating-point.json  | 2 +-
>  tools/perf/pmu-events/arch/x86/westmereex/floating-point.json   | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
> index 7d2f71a9dee3..6b9b9fe74f3b 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
> @@ -15,7 +15,7 @@
>          "UMask": "0x4",
>          "EventName": "FP_ASSIST.INPUT",
>          "SampleAfterValue": "20000",
> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
>      },
>      {
>          "PEBS": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
> index 7d2f71a9dee3..6b9b9fe74f3b 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
> @@ -15,7 +15,7 @@
>          "UMask": "0x4",
>          "EventName": "FP_ASSIST.INPUT",
>          "SampleAfterValue": "20000",
> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
>      },
>      {
>          "PEBS": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> index 7d2f71a9dee3..6b9b9fe74f3b 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> @@ -15,7 +15,7 @@
>          "UMask": "0x4",
>          "EventName": "FP_ASSIST.INPUT",
>          "SampleAfterValue": "20000",
> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
>      },
>      {
>          "PEBS": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
> index 7d2f71a9dee3..6b9b9fe74f3b 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
> @@ -15,7 +15,7 @@
>          "UMask": "0x4",
>          "EventName": "FP_ASSIST.INPUT",
>          "SampleAfterValue": "20000",
> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
>      },
>      {
>          "PEBS": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
> index 7d2f71a9dee3..6b9b9fe74f3b 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
> @@ -15,7 +15,7 @@
>          "UMask": "0x4",
>          "EventName": "FP_ASSIST.INPUT",
>          "SampleAfterValue": "20000",
> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)"
> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)"
>      },
>      {
>          "PEBS": "1",
> -- 
> 2.22.0.214.g8dca754b1e87
