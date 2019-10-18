Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E31CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDB220640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443031AbfJRSqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:46:32 -0400
Received: from www62.your-server.de ([213.133.104.62]:55790 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfJRSqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:46:32 -0400
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iLXGf-00048I-Mt; Fri, 18 Oct 2019 20:46:29 +0200
Date:   Fri, 18 Oct 2019 20:46:29 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yonghong Song <yhs@fb.com>, YueHaibing <yuehaibing@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "ast@kernel.org" <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Fix build error without CONFIG_NET
Message-ID: <20191018184629.GD26267@pc-63.home>
References: <20191018090344.26936-1-yuehaibing@huawei.com>
 <ee9a06ec-33a0-3b39-92d8-21bd86261cc2@fb.com>
 <20191018142025.244156f8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018142025.244156f8@gandalf.local.home>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25606/Fri Oct 18 10:58:40 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 02:20:25PM -0400, Steven Rostedt wrote:
> On Fri, 18 Oct 2019 18:11:07 +0000
> Yonghong Song <yhs@fb.com> wrote:
> > On 10/18/19 2:03 AM, YueHaibing wrote:
> > > If CONFIG_NET is n, building fails:
> > > 
> > > kernel/trace/bpf_trace.o: In function `raw_tp_prog_func_proto':
> > > bpf_trace.c:(.text+0x1a34): undefined reference to `bpf_skb_output_proto'
> > > 
> > > Wrap it into a #ifdef to fix this.
> > > 
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Fixes: a7658e1a4164 ("bpf: Check types of arguments passed into helpers")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>  
> > 
> > Acked-by: Yonghong Song <yhs@fb.com>
> 
> I'm getting ready for another push to Linus. Want me to pull this into
> my tree?

It's related to bpf-next, so only bpf-next is appropriate here. We'll
take it.

Thanks,
Daniel
