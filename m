Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD27C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF5E2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sWjyWOy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfLDQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:20:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfLDQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UlzRRWNwiQzLelHuY1Hwa0hkmOKJfcQsspUvSd31HbY=; b=sWjyWOy5c7c4+1BFcfpb3Jvd0
        A4xD1usBzr+fSbuzXlnRTIUjBGObXY38syfJXxaHwQoAYu2GthAUefXyxppn/d6KmaMilbbD5RsWk
        m1aO1n2vXXEDsEcxIlvLLVE5WQ1FOYhClzKMN2y+nWo1Qg8EhhvcqdfhcapdZ+SFkqbc0mwVrhpgU
        h/Sfrf7qdLqrUSGrmBlgehbFU/Ei8dA/76qyhtM/feasK78ohc1XA9pujRcezk1hkVLYlbD51E+bE
        36/C/QnVAL+OMc5PFeHhkkBWeO2Ll3kiB/63xLEUz58nrUebTzlfdiyV3RZjGUjVTbIC7S2Tc8A0P
        1s05BW2Uw==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icXOD-0008RH-Ic; Wed, 04 Dec 2019 16:20:33 +0000
Subject: Re: linux-next: Tree for Dec 4 (objtool)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20191204160658.64a3dd1c@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <96ecee4e-a1a0-b3d6-8700-26dabbb364ef@infradead.org>
Date:   Wed, 4 Dec 2019 08:20:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191204160658.64a3dd1c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/19 9:06 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any material for v5.6 to your linux-next included
> trees until after v5.5-rc1 has been released.
> 
> Changes since 20191203:
> 


on x86_64:

drivers/pinctrl/pinctrl-ingenic.o: warning: objtool: ingenic_pinconf_set() falls through to next function ingenic_pinconf_group_set()


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
