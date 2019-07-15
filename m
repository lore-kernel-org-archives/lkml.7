Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8432CC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640CE2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfGOMnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730080AbfGOMna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:43:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADB0B30C120E;
        Mon, 15 Jul 2019 12:43:30 +0000 (UTC)
Received: from treble (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B9005D9D6;
        Mon, 15 Jul 2019 12:43:29 +0000 (UTC)
Date:   Mon, 15 Jul 2019 07:43:27 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jann Horn <jannh@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/22] x86/paravirt: Fix callee-saved function ELF sizes
Message-ID: <20190715124327.lx6sdcnkf22wedtg@treble>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <b116e8bf2d3a4f703020e7911b6226ecc3ea34c5.1563150885.git.jpoimboe@redhat.com>
 <445aa72f-c5ba-635d-122b-6d082e9c115e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <445aa72f-c5ba-635d-122b-6d082e9c115e@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 15 Jul 2019 12:43:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 06:58:36AM +0200, Juergen Gross wrote:
> On 15.07.19 02:36, Josh Poimboeuf wrote:
> > The __raw_callee_save_*() functions have an ELF symbol size of zero,
> > which confuses objtool and other tools.
> > 
> > Fixes a bunch of warnings like the following:
> > 
> >    arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_pte_val() is missing an ELF size annotation
> >    arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_pgd_val() is missing an ELF size annotation
> >    arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_make_pte() is missing an ELF size annotation
> >    arch/x86/xen/mmu_pv.o: warning: objtool: __raw_callee_save_xen_make_pgd() is missing an ELF size annotation
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks!

BTW, Alok's email address from the MAINTAINERS file seems to be bouncing.

-- 
Josh
