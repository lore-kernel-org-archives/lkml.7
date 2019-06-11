Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31EAC0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18352086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ldEwDixk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406613AbfFKRxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:53:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406097AbfFKRxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZwlPQb/tjk9f8fVri2mY645X65ytbNW01O1ld43ydTI=; b=ldEwDixkQ95IJz3vn/uo7qF29
        NjB52ltMb13JZhpdNyWlPJ1VSXtEKdTID2oZVUmxeRFEdlEAdEEg1eTbEvzczcQ6Tlu577+4kdANC
        5eLvHUv7DoFmYv+rZXzW2KdIuwXFX5BaIvZ8XFuLYthfRi4g4nmSNxJqh1czW3y+ajPfIbHv//eiA
        Dk2WgUorzN/23+l2l8jWuSQ/2/pjalbE2Ieu/W2txvWkx6cFQQVMLPi8EdybrR7mswAQY+j1HwjC7
        lrDJ1taCa0ZQxdK4W0T0gZayKRDz3wg+x6A6Xuij7nTvpW8h6iBaxytq6xAnqQlxjiTA0giwR9HSi
        /QbY6mbDQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hakxS-0004og-S8; Tue, 11 Jun 2019 17:53:18 +0000
Subject: Re: linux-next: Tree for Jun 11 (kernel/sysctl.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <20190611192432.1d8f11b2@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a35f64a7-4593-da2f-4d6d-81e870a8f3b5@infradead.org>
Date:   Tue, 11 Jun 2019 10:53:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190611192432.1d8f11b2@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/19 2:24 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190607:
> 

on i386:

when CONFIG_SYSCTL is not set/enabled:

../kernel/sysctl.c: In function '_proc_do_string':
../kernel/sysctl.c:2003:7: error: 'sysctl_writes_strict' undeclared (first use in this function); did you mean 'sysctl_schedstats'?
   if (sysctl_writes_strict == SYSCTL_WRITES_STRICT) {
       ^~~~~~~~~~~~~~~~~~~~
       sysctl_schedstats
../kernel/sysctl.c:2003:7: note: each undeclared identifier is reported only once for each function it appears in
../kernel/sysctl.c:2003:31: error: 'SYSCTL_WRITES_STRICT' undeclared (first use in this function); did you mean 'SPECTRE_V2_USER_STRICT'?
   if (sysctl_writes_strict == SYSCTL_WRITES_STRICT) {
                               ^~~~~~~~~~~~~~~~~~~~
                               SPECTRE_V2_USER_STRICT
  CC      mm/mmu_gather.o
../kernel/sysctl.c: In function 'proc_first_pos_non_zero_ignore':
../kernel/sysctl.c:2079:10: error: 'sysctl_writes_strict' undeclared (first use in this function); did you mean 'sysctl_schedstats'?
  switch (sysctl_writes_strict) {
          ^~~~~~~~~~~~~~~~~~~~
          sysctl_schedstats
../kernel/sysctl.c:2080:7: error: 'SYSCTL_WRITES_STRICT' undeclared (first use in this function); did you mean 'SPECTRE_V2_USER_STRICT'?
  case SYSCTL_WRITES_STRICT:
       ^~~~~~~~~~~~~~~~~~~~
       SPECTRE_V2_USER_STRICT
../kernel/sysctl.c:2082:7: error: 'SYSCTL_WRITES_WARN' undeclared (first use in this function); did you mean 'SYSCTL_WRITES_STRICT'?
  case SYSCTL_WRITES_WARN:
       ^~~~~~~~~~~~~~~~~~
       SYSCTL_WRITES_STRICT
  AR      arch/x86/hyperv/built-in.a
  CC      kernel/capability.o
../kernel/sysctl.c:2088:1: warning: control reaches end of non-void function [-Wreturn-type]
 }
 ^
At top level:
../kernel/sysctl.c:3116:12: warning: 'proc_do_cad_pid' defined but not used [-Wunused-function]
 static int proc_do_cad_pid(struct ctl_table *table, int write,
            ^~~~~~~~~~~~~~~
../kernel/sysctl.c:2816:12: warning: 'proc_dointvec_minmax_coredump' defined but not used [-Wunused-function]
 static int proc_dointvec_minmax_coredump(struct ctl_table *table, int write,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../kernel/sysctl.c:2795:12: warning: 'proc_dopipe_max_size' defined but not used [-Wunused-function]
 static int proc_dopipe_max_size(struct ctl_table *table, int write,
            ^~~~~~~~~~~~~~~~~~~~
../kernel/sysctl.c:2629:12: warning: 'proc_dointvec_minmax_sysadmin' defined but not used [-Wunused-function]
 static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../kernel/sysctl.c:2597:12: warning: 'proc_taint' defined but not used [-Wunused-function]
 static int proc_taint(struct ctl_table *table, int write,
            ^~~~~~~~~~


-- 
~Randy
