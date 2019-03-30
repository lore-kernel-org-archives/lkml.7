Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C092C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58ADA218AE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553905576;
	bh=1bhsFjWAK6lh/uCPFObZCtZRp0Km0Vkrns4w9q2CIYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=areD7X9Ka35SP4Oq42lsUkbSyRH4x006rTDWr9jDY8xZaZQkGVzUh6Qquq5R9lrhf
	 PwoU0GdnVJEVZsc6nhMDgleW5kwhbm1xozbj7ZXJnK+coxC3B9iR7y2eHUh1tCf2Ji
	 WGHJXKbAGqTkbMxbxmATKPdNtyRyINE6yJR8f8Bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfC3A0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730129AbfC3A0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:26:14 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68B12184C;
        Sat, 30 Mar 2019 00:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553905574;
        bh=1bhsFjWAK6lh/uCPFObZCtZRp0Km0Vkrns4w9q2CIYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXnVruruCipS55pPtOw8/S7k5sLQRYLPqZ+v6p7iBi2Hv7ssYw2BJ0m761ZOhX3VB
         irZ1k53Eg19XOxYMSqEnZX4DRTmOdwy/UjYOqbk/PxMbRh+QAgxwqyL7uD6zr7vCs7
         ZQdMBrtjy6faewlXaCVgmQM2oevmnU5pusaEbo2o=
Date:   Sat, 30 Mar 2019 08:26:06 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190330002606.GA14268@guoren-Inspiron-7460>
References: <20190329171221.GA32456@altlinux.org>
 <20190329131514.3e4ec93e@gandalf.local.home>
 <20190329181619.GB32651@altlinux.org>
 <20190329163337.7ae78cf9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329163337.7ae78cf9@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Dmitry & Steve,

On Fri, Mar 29, 2019 at 04:33:37PM -0400, Steven Rostedt wrote:
> On Fri, 29 Mar 2019 21:16:19 +0300
> "Dmitry V. Levin" <ldv@altlinux.org> wrote:
> 
> > This is fine with me.  If you are adding the fix for riscv,
> > please consider adding the fix for csky, too.
> 
> Yes of course. I mentioned both of these fixes in my reply to Linus.
The BUG is from this commit before upstream:
https://github.com/c-sky/csky-linux/commit/b167422869e6a76b31bda639413efa2ba7e60432#diff-cdc97efef2ab02d6828fa545698f9311

I reference the riscv code without my mind, thx for all.

Best Regards
 Guo Ren
