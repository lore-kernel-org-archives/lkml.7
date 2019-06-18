Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFABC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E5A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfFRS75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730231AbfFRS75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:59:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38CDA206BA;
        Tue, 18 Jun 2019 18:59:56 +0000 (UTC)
Date:   Tue, 18 Jun 2019 14:59:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: Re: [PATCH 2/6] docs: trace: add a missing blank line
Message-ID: <20190618145954.308e8ec3@gandalf.local.home>
In-Reply-To: <91f90c10c12c6a2f6fb90fc0f9115fbd8dd73848.1560883872.git.mchehab+samsung@kernel.org>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
        <91f90c10c12c6a2f6fb90fc0f9115fbd8dd73848.1560883872.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 15:51:18 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Sphinx expects a blank line after a literal block markup.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

For the two tracing patches (1 and 2).

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  Documentation/trace/kprobetrace.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> index 3d162d432a3c..caa0a8ba081e 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst
> @@ -228,6 +228,7 @@ events, you need to enable it.
>  
>  Use the following command to start tracing in an interval.
>  ::
> +
>      # echo 1 > tracing_on
>      Open something...
>      # echo 0 > tracing_on

