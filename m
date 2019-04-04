Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62CAC10F06
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4652147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554338953;
	bh=kZ7mofqlHEEPgUYC2lVmPI0G5budo55mNRSZQHP7BCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MkHH7c9ibyDnYBHkIGBd3P/MMHrfl9Iaz1pIsavk6gePl9jIhxNFPdW46EGqZuQgn
	 Q2vxJuDdz5K940EnL22Pl3sN8rn+/JbzL7wvvp1I4JL8G0lwIjgs/RQ664P8sP87Z5
	 8DylYCIFLfm6BPVmgr2HrcMvLlJUnkym6ebI5+Cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDDAtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDDAtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:49:12 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24FA22133D;
        Thu,  4 Apr 2019 00:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554338951;
        bh=kZ7mofqlHEEPgUYC2lVmPI0G5budo55mNRSZQHP7BCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+j0wtjxPTjGCo/mSIY/BW2m9VfZugmP50qi8LqDEcMWPLczgrWLFMvQAJi3lOIHs
         nqJ+5qarqTu7H11qwEB2JTr5nmlSDFtkaWu9H1imyrFzEXoK/MLG2k4jkiKPrf2Xkk
         7OcfcJaE/yxJvWz7ASENn/Rz36uHDlIKahxpYfbg=
Date:   Wed, 3 Apr 2019 20:49:10 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.0 152/262] x86/kprobes: Prohibit probing on IRQ
 handlers directly
Message-ID: <20190404004910.GH16241@sasha-vm>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-152-sashal@kernel.org>
 <20190328095119.e78ffbf9db138a24fbe18c69@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190328095119.e78ffbf9db138a24fbe18c69@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 09:51:19AM +0900, Masami Hiramatsu wrote:
>Hi Sasha,
>
>Could you drop this?
>This prevents probing too much functions, and we will drop it
>from upstream. Anyway, commit a50480cb6d61 ("kprobes/x86:
>Blacklist non-attachable interrupt functions") fixes same issue.
>So please pick it instead of this.

I've replaced the commits, thanks!

--
Thanks,
Sasha
