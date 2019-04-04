Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DACC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8DE2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfDDO2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfDDO2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:28:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0941420855;
        Thu,  4 Apr 2019 14:28:06 +0000 (UTC)
Date:   Thu, 4 Apr 2019 10:28:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Drewry <wad@chromium.org>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 4/6 v3] csky: Fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190404102805.56f5f168@gandalf.local.home>
In-Reply-To: <20190404140200.GB4962@altlinux.org>
References: <20190401134104.676620247@goodmis.org>
        <20190401134421.121919570@goodmis.org>
        <20190404140200.GB4962@altlinux.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019 17:02:01 +0300
"Dmitry V. Levin" <ldv@altlinux.org> wrote:
> According to
> https://lore.kernel.org/lkml/20190330004949.GA15705@guoren-Inspiron-7460/
> the following tags could be added to this patch:
> 
> Tested-by: Guo Ren <ren_guo@c-sky.com>
> Acked-by: Guo Ren <ren_guo@c-sky.com>

Thanks! Added.

-- Steve

