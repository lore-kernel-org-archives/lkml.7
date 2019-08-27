Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264EFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBF02184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CzEbMpgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfH0PkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:40:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfH0PkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qh8rh0bTRxSEaLaDm6S5fDCIPC9oDkBUdVF+H+ju/yk=; b=CzEbMpgdBBJ0q/C3p4FdRALir
        Z33NMdefWNTlQMjbkH2/ySyCCKNKmid5eM6p36IhIIuH5khhjilohDxJIxoiJIQIFvgsRsqby/oHg
        JfTHiupVFjgbqOUQbdojQ4J9j0Sp+xkOEvssVt677PszvjRqNF6fGe59DFn40cWT4GwsW4NmrzKr7
        tbCquhIB4IflF6D7V8bOBag52uSHBYLi/cIIc0zItahxXRLOjm+eDRfQWXSm3Y1KPcaTgB76GV0GA
        oRxqa6F5n1zPkWIv2WK081IIAr91cg/gTZzjIg0RZWHIUpwIAugtmqmJdolkNC4WLNc84/Y6bTLQQ
        GaPcLbKYg==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2dZn-0007kh-Ix; Tue, 27 Aug 2019 15:40:07 +0000
Subject: Re: linux-next: Tree for Aug 27 (objtool)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190827190526.6f27e763@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6c42e32f-901d-be78-e69b-cb9ff8703932@infradead.org>
Date:   Tue, 27 Aug 2019 08:40:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827190526.6f27e763@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 2:05 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190826:
> 

on x86_64:

arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_handle_exit_irqoff()+0x33: unreachable instruction

> gcc --version
gcc (SUSE Linux) 7.4.0


want more info?

-- 
~Randy
