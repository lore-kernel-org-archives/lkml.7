Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D5EC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B16218A0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560956934;
	bh=vZ0+xJAI7CBwpzuDTbuaMD+ACmVfW2tvCs/9eX1n/PI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZVwC9mfX2S31y7qc2BicpeLYml3FZxlhnzb8KA/VMAINTQYvjohwzYCn+9Tp/FCXr
	 G7eqs06YsR5bWErXC0bfJ3B85XiZnVzXfVzQTDg4QxhH+alwqvNvtPtMlubGy7ucZK
	 7PZFyajwSA9EDP+glnFh6EGPmJr4AbvWF0vdBsT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfFSPIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfFSPIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:08:52 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D785B2189D;
        Wed, 19 Jun 2019 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560956932;
        bh=vZ0+xJAI7CBwpzuDTbuaMD+ACmVfW2tvCs/9eX1n/PI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HuTH2bvLP9U2DK0N0nT/1h5Sx9UpyIT4SVdyDT+Z4r72jZzbZn9ZLE4POlrknhW9o
         aU9INYYc3Yjv0RmhBbU9DAdNtUkjDQTKhsts4pwIJPDdYx1tb5yd2ZLqkKJM657q9x
         SDxDztL0wmxoMfGkPKFMLYdTFFrWWUQdWHLLR3S4=
Date:   Thu, 20 Jun 2019 00:08:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: Re: [PATCH 2/6] docs: trace: add a missing blank line
Message-Id: <20190620000847.02211a70d161fbf5af1af5f7@kernel.org>
In-Reply-To: <91f90c10c12c6a2f6fb90fc0f9115fbd8dd73848.1560883872.git.mchehab+samsung@kernel.org>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
        <91f90c10c12c6a2f6fb90fc0f9115fbd8dd73848.1560883872.git.mchehab+samsung@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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

Looks good to me, thanks!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

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
> -- 
> 2.21.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
