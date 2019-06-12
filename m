Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D97C31E4B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FD52053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfFMRQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:16:32 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:54062 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfFLV3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:29:41 -0400
Received: from faui03f.informatik.uni-erlangen.de (faui03f.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:118])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id D788F24098F;
        Wed, 12 Jun 2019 23:29:35 +0200 (CEST)
Received: by faui03f.informatik.uni-erlangen.de (Postfix, from userid 30501)
        id C1DE7341CD4; Wed, 12 Jun 2019 23:29:35 +0200 (CEST)
Date:   Wed, 12 Jun 2019 23:29:35 +0200
From:   Thomas Preisner <linux@tpreisner.de>
To:     asdf@asdf.de
Cc:     linux@tpreisner.de, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ftrace: add simple oneshot function tracer
Message-ID: <20190612212935.4xq6dyua5d5vrrvj@stud.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529104552.146fa97c@oasis.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 17:52:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> What do you mean? The function profile has its own file to enable it:
> 
>  echo 1 > /sys/kernel/tracing/function_profile_enabled
>  
>  And disable it:
>  
>   echo 0 > /sys/kernel/tracing/function_profile_enabled
>   
>   -- Steve

Yes, I am aware of the function profiler providing a file operation for
enabling and disabling itself. However, my oneshot profiler as of [PATCH
v2] is a separate tracer/profiler without this file operation.

As this oneshot profiler is intended to be used for coverage/usage
reports I want it to be able to record functions as soon as possible
during bootup. Therefore, I just permanently activated the oneshot
profiler since as of now there is no means to activate it or the
function profiler via kernel commandline just like the normal tracers.

Still, if you want to I can add the file operation for
enabling/disabling this new profiler together with a new kernel
commandline argument for this profiler?

Or what would be your prefered way?

Greetings,
Thomas Preisner

