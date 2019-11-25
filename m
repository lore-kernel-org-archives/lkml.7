Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE36C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FCB207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574692204;
	bh=Loxbei+/wF8o2t/Zu+zb0KsSMDFBMQpKXug7BnMfUhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pt//dEWry6Pt8g1mQnM4g4gLws6fPrscnzBmtbsDrHVCilzD6cFoPBNUkkhJEE2cD
	 qeNnNTzzyVgZmJZglfb2WVRQ7SgIP6+JUMq965aJptGQjd/lCtLcg+5kkMlmaWVTff
	 pV5nRU6gDuXfI0jK5LYiHOrtG02MqmwLAVCN7tTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfKYOaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfKYOaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:30:02 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0211920740;
        Mon, 25 Nov 2019 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574692202;
        bh=Loxbei+/wF8o2t/Zu+zb0KsSMDFBMQpKXug7BnMfUhc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F6mGMI290qILU4nDfAiJJLjt/ENDJFUA+B/hzJZ6ARz7XFvmIdI4F0qXYe5hYYK8i
         ZSWVTAlCirsZGc2im+bUZaReXOcvFVvQ9FqCGPzMLvqVPWsjJiki61I9NWyKqRszQG
         nWBp88/COSR8bvNu5k5hW/awtfFz1RqB6IIh1e+s=
Date:   Mon, 25 Nov 2019 23:29:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 0/2] x86/insn: Add some more Intel instructions to the
 opcode map
Message-Id: <20191125232956.455b5773c5cbdbfa94d0fc81@kernel.org>
In-Reply-To: <20191125125044.31879-1-adrian.hunter@intel.com>
References: <20191125125044.31879-1-adrian.hunter@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, 25 Nov 2019 14:50:42 +0200
Adrian Hunter <adrian.hunter@intel.com> wrote:

> Hi
> 
> Here is a patch to update the x86 opcode map, and a patch to update the
> perf tools' "new instructions" test accordingly.
> 
> There are still CET instructions to add, which Yu-cheng is doing.

Both looks good (and great!) to me :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> 
> Adrian Hunter (2):
>       x86/insn: perf tools: Add some more instructions to the new instructions test
>       x86/insn: Add some more Intel instructions to the opcode map
> 
>  arch/x86/lib/x86-opcode-map.txt              |  44 +-
>  tools/arch/x86/lib/x86-opcode-map.txt        |  44 +-
>  tools/perf/arch/x86/tests/insn-x86-dat-32.c  | 366 +++++++++++++++
>  tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 484 ++++++++++++++++++++
>  tools/perf/arch/x86/tests/insn-x86-dat-src.c | 655 +++++++++++++++++++++++++++
>  5 files changed, 1569 insertions(+), 24 deletions(-)
> 
> 
> Regards
> Adrian


-- 
Masami Hiramatsu <mhiramat@kernel.org>
