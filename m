Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42C7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EDB2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLCPlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:41:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50118 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLCPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:41:18 -0500
Received: from [81.92.17.147] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1icAIW-0004j9-RQ; Tue, 03 Dec 2019 15:41:09 +0000
Date:   Tue, 3 Dec 2019 16:41:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Adrian Reber <areber@redhat.com>
Subject: Re: [PATCH 19/23] perf beauty: Add CLEAR_SIGHAND support for clone's
 flags arg
Message-ID: <20191203154106.7kio25pcank6p2a3@wittgenstein>
References: <20191203135606.24902-1-acme@kernel.org>
 <20191203135606.24902-20-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191203135606.24902-20-acme@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:56:02AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Add support for the recently added CLONE_CLEAR_SIGHAND flag.
> 
> This takes advantage of the copy of the uapi/linux/sched.h we have in
> tools/include, which allows us to build tools/perf in older systems and
> have the binary support printing that flag whenever that system gets its
> kernel updated to one where this feature is present.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Adrian Reber <areber@redhat.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org
> Link: https://lkml.kernel.org/n/tip-1vnz497ubtu5oz16ygdcul0e@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
