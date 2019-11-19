Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5159AC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E0D22384
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jw21mr9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfKSPiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:38:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfKSPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K+kVvT7tsBTbSnTMawe6RXRvGys013zzmPiihyV73Eg=; b=jw21mr9VbIGbwVBuUsJyltrrP
        7qAhno3zr5CTueQza+Ko8A8Jp06MN6AZDHmgrkNhQULmZt0MAAcpX84sX4MDcFj37i23OzHgPvq+f
        W+V5MgGFfbmAAxDEvoFUQVOegvmMaTRBJG5JvbIqgJIG4cs3FTQgeHVCk4RcX3C4VKhGL+CxLWxsN
        16kC0ihEjNAzoPonY/vnI9q77oqsu78dVMkesg+qUttKHO9KhVZsB32z8yQIlI9phVy5+6AENU8tx
        z0XJtzLCy+TxYHopDF/mIO51YTW3WBwmLtSxbhjUmfC+L+2dLEyWaOnHfj7hNT2AyDHPnkbZsROAm
        EUWRIkOWg==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iX5Zs-0003nO-57; Tue, 19 Nov 2019 15:38:04 +0000
Subject: Re: linux-next: Tree for Nov 19 (objtool)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20191119194658.39af50d0@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a5d9048b-2393-7a81-626f-c7aee8cf5730@infradead.org>
Date:   Tue, 19 Nov 2019 07:38:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119194658.39af50d0@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 12:46 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20191118:
> 

on x86_64:

arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_timed_out()+0x23: unreachable instruction
kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreachable instruction  [known]
kernel/cred.o: warning: objtool: prepare_creds()+0xf0: unreachable instruction
samples/ftrace/ftrace-direct.o: warning: objtool: .text+0x0: unreachable instruction
samples/ftrace/ftrace-direct-too.o: warning: objtool: .text+0x0: unreachable instruction
samples/ftrace/ftrace-direct-modify.o: warning: objtool: .text+0x0: unreachable instruction


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
