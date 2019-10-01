Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F91AC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5910E2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfJAXCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 19:02:19 -0400
Received: from www62.your-server.de ([213.133.104.62]:47688 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfJAXCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 19:02:19 -0400
Received: from 57.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.57] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iFR9j-0000wb-2V; Wed, 02 Oct 2019 01:02:07 +0200
Date:   Wed, 2 Oct 2019 01:02:06 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Brian Vazquez <brianvv@google.com>
Cc:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf 0/2] selftests/bpf: test_progs: don't leak fd in bpf
Message-ID: <20191001230206.GC10044@pc-63.home>
References: <20191001173728.149786-1-brianvv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001173728.149786-1-brianvv@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25589/Tue Oct  1 10:30:33 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:37:26AM -0700, Brian Vazquez wrote:
> This patch series fixes some fd leaks in tcp_rtt and
> test_sockopt_inherit bpf prof_tests.
> 
> Brian Vazquez (2):
>   selftests/bpf: test_progs: don't leak server_fd in tcp_rtt
>   selftests/bpf: test_progs: don't leak server_fd in
>     test_sockopt_inherit
> 
>  tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c | 2 +-
>  tools/testing/selftests/bpf/prog_tests/tcp_rtt.c         | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Applied, thanks!
