Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090E5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA4A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfCKUY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:24:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfCKUY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:24:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB4A4E6A79;
        Mon, 11 Mar 2019 20:24:27 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-29.phx2.redhat.com [10.3.112.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A18F86013C;
        Mon, 11 Mar 2019 20:24:26 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 502954AB1; Mon, 11 Mar 2019 17:24:14 -0300 (BRT)
Date:   Mon, 11 Mar 2019 17:24:14 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, jolsa@kernel.org,
        namhyung@kernel.org, sdf@fomichev.me, acme@kernel.org
Subject: Re: [PATCH v8 perf,bpf 00/15] perf annotation of BPF programs
Message-ID: <20190311202414.GA3078@redhat.com>
References: <20190311195555.889995-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311195555.889995-1-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 11 Mar 2019 20:24:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 12:55:40PM -0700, Song Liu escreveu:
> ===================== Note on patch dependency  ========================
> This set has dependency in both bpf-next tree and tip/perf/core. Current
> version is developed on bpf-next tree with the following commits
> cherry-picked from tip/perf/core (or acme/perf/core):
> 
> (from 1/11 to 11/11)
> commit 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
> commit d764ac646491 ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
> commit 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
> commit df063c83aa2c ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
> commit 9aa0bfa370b2 ("perf tools: Handle PERF_RECORD_KSYMBOL")
> commit 45178a928a4b ("perf tools: Handle PERF_RECORD_BPF_EVENT")
> commit 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
> commit a40b95bcd30c ("perf top: Synthesize BPF events for pre-existing loaded BPF programs")
> commit 6934058d9fb6 ("bpf: Add module name [bpf] to ksymbols for bpf programs")
> commit 811184fb6977 ("perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT")
> comimt 94816add0005 ("perf tools: Add perf_exe() helper to find perf binary")
> ========================================================================

These csets are already upstream, i.e. already hit torvalds/master, i.e.
will be in 5.1, can you check that we still need doing this
cherry-picking?

- Arnaldo
