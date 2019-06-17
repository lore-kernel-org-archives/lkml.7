Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643EEC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4278120657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfFQVVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:21:00 -0400
Received: from www62.your-server.de ([213.133.104.62]:47160 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbfFQVU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:20:58 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hcz3a-0001JJ-NN; Mon, 17 Jun 2019 23:20:50 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hcz3a-0002B3-Hm; Mon, 17 Jun 2019 23:20:50 +0200
Subject: Re: [PATCH bpf] bpf: fix the check that forwarding is enabled in
 bpf_ipv6_fib_lookup
To:     Anton Protopopov <a.s.protopopov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190615225348.2539-1-a.s.protopopov@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <afd146bd-2a6a-14ce-8ea2-8f928960736d@iogearbox.net>
Date:   Mon, 17 Jun 2019 23:20:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190615225348.2539-1-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25483/Mon Jun 17 09:56:00 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/2019 12:53 AM, Anton Protopopov wrote:
> The bpf_ipv6_fib_lookup function should return BPF_FIB_LKUP_RET_FWD_DISABLED
> when forwarding is disabled for the input device.  However instead of checking
> if forwarding is enabled on the input device, it checked the global
> net->ipv6.devconf_all->forwarding flag.  Change it to behave as expected.
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

Applied, thanks!
