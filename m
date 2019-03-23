Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3E1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F83F21841
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="FpCSt/bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfCWRhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:37:13 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:38812 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbfCWRhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:37:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id C5C4D40D4E;
        Sat, 23 Mar 2019 18:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1553362630; x=1555177031; bh=hcoSLnFTed5870JLH0jswjjIXWV/K5qViVe
        JIv73MKY=; b=FpCSt/bHrTUSfPsHllT6XDyqfyJI/Gywf3FQMo+0qpeEuvnaLLn
        i09A43O9iGE1LeO8gjwh0uCdkccRMKENMhpyI+r08nRuhnhJNrHS8seeK5SfyvaL
        rEhheawEIFrb9ToUe29kY7mtg16ArdLRSssSehFz8i1GyMBc3SDw3pQZ8nZTI3RR
        mS2Y/HTGmwLB2ghcy1mQQfdkwIIglhMOVvLRjs7q67ryMkhcp8kepSj4n3VfC9PI
        9XOxDv92TFknXT9HYI2cIArhSX2IwDeQB2YT4idhJnrgxlR7yDTLmkRCWiqH8Y31
        S1dyYukXZOpCh4qUS61rXUz0lDbE0pWl1x2pRqYiuIIZBJcZodCgWLlBoLTCW3Yc
        I5exOy+DNdbmRtugMhiNgDNMqqK2ec/yf2SJi4lHK9d7aoFPQVSndH7p+87pEqBS
        R6VjBZP0TInFDsVSS2z2FPvvsKnGPlnJJSEr/YdhUCp4Xbq2ulP4qksVqZmf0Sp5
        eFOeAQZecz2Jwy92DakXn/DAm/WE6bGZaNo7sFF+NwpfYdJOcmGsq2/Le3/mHYED
        Fc/7jjfQ/Hz64/gGfTk8TMtVldP9OvF1FCeCE+h7QPNVFn83aKgp0M1sbe3pCIvm
        /3wf1VO2lfzqUSYn5ZIaZVrd5YnoBxFads0HO4if2qxh5GKFfpEPwaP0=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 97qysaN6vrOG; Sat, 23 Mar 2019 18:37:10 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id D41D6404B7;
        Sat, 23 Mar 2019 18:37:10 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id ABDE02C7;
        Sat, 23 Mar 2019 18:37:10 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: add translation disclaimer
Date:   Sat, 23 Mar 2019 18:37:09 +0100
Message-ID: <2719899.4lLstzLvQ9@harkonnen>
In-Reply-To: <20190319073539.1f16831a@lwn.net>
References: <20190314204516.10890-1-federico.vaga@vaga.pv.it> <14381941.zoZXB8H0OD@pcbe13614> <20190319073539.1f16831a@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 19, 2019 2:35:39 PM CET Jonathan Corbet wrote:
> On Tue, 19 Mar 2019 09:03:53 +0100
> 
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > > Oh well, I went ahead and applied it.  I do think that it might make
> > > sense
> > > to move the TOC *above* the disclaimer, though, since that's what
> > > readers
> > > are really going to be interested in.
> > 
> > No, problem I can do it and send a new version
> 
> Note that I said I applied the patch, so "a new version" isn't quite
> what's needed here.  

Actually I've sent the V2 patch with fixes suggested by Rasmus Villemoes
before you applied this (V1) patch. And in that patch the TOC is, indeed, 
above.

https://lkml.org/lkml/2019/3/15/714

When I answered you talking about a new version I forgot that it was done 
already (V2 patch above) ^_^'

> If you feel so inclined, a patch to reorder that file
> would be good, though.

I will send a patch that fixes this misunderstanding

> Thanks,
> 
> jon




