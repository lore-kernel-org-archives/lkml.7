Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393CBC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D3121883
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="hJFEuuou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfIBTTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 15:19:30 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:9496 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfIBTT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:19:29 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id D8D61812;
        Mon,  2 Sep 2019 21:19:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1567451966; x=1569266367; bh=WvO6w1JGeAzjzBoBNy70PSLAMWZ4kpESBOV
        SCmJ5cok=; b=hJFEuuou+AtpNPsgyNRb45DU+uP9v/aBuQuu9LZDTt1Mv1suhkz
        QQmFt6nP+Rff6Ka38Tf+OoXlbLGBI34A0moEeLBIPAoGXU9U5e3MgIz9l5v3GYh8
        HelD6pZbl5ly6Ydqf9FaxugLIeUfdY05lNTyWIjHTHQieICXIZI/rSITzJMu8uRF
        KNMaBnA1P2XIW5OM9GSDvAk4MZP5W8oRJdwrdVlBcK8iV5de/pc/9taetKNC8D43
        BRrnvJTzrrjMpX+GRx7kOUMv1NZArx75NeOcQ0Tp+jesddLCSTtnVoLxsXu0GGMf
        9Gw2UWb97Q8Dn1c6W3sPtVAgIWiHgPrIUtF1APza8RPYXeAT6DkqsmMCG+eSn5Ca
        SlbC9zx5DMtAWfZl/4i1yHVIYMyShs7DSIz0TeANHBAWVpMAMbdPHNO2xofbt29q
        0rC++mnpuCZVZuGl8bWCcvpqHJB8QQhnnFizYBHlTTW9/YhQU9UkVplg9ewbOFVS
        zH8Kg4CREJ5iA0CUp4FEpqrLwZ/yM8O6Q/aMSLBJqtqwNK8KzMvj740V3x9LkHF3
        nHSMzQDjrWRx/js4kaW+XEK46kiazH8eXKfv0JiRyH6SUleF0SlOqY6g+Wc6/mzx
        rbBOmidoi4EWp4AVzQ2iYDMEZp+sxpIBF18KQDd+IFQgZJgCPNP7/nJo=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MIjW3ZdQ02Xb; Mon,  2 Sep 2019 21:19:26 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 677BF3AE;
        Mon,  2 Sep 2019 21:19:26 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id E79CA4ECD;
        Mon,  2 Sep 2019 21:19:25 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc:lock: remove reference to clever use of read-write lock
Date:   Mon, 02 Sep 2019 21:19:24 +0200
Message-ID: <4627860.yBeiQmOknq@harkonnen>
In-Reply-To: <20190902181010.GA35858@gmail.com>
References: <20190831134116.25417-1-federico.vaga@vaga.pv.it> <2216492.xyESGPMPG3@pcbe13614> <20190902181010.GA35858@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 2, 2019 8:10:10 PM CEST Ingo Molnar wrote:
> * Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > On Saturday, August 31, 2019 4:43:44 PM CEST Jonathan Corbet wrote:
> > > On Sat, 31 Aug 2019 15:41:16 +0200
> > > 
> > > Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > > >  several CPU's and you want to use spinlocks you can potentially use
> > > > 
> > > > -cheaper versions of the spinlocks. IFF you know that the spinlocks
> > > > are
> > > > +cheaper versions of the spinlocks. If you know that the spinlocks are
> > > > 
> > > >  never used in interrupt handlers, you can use the non-irq versions::
> > > I suspect that was not actually a typo; "iff" is a way for the
> > > mathematically inclined to say "if and only if".
> > > 
> > > jon
> > 
> > I learned something new today :)
> > 
> > I am not used to the mathematical English jargon. It make sense, but then
> > I
> > would replace it with "If and only if": for clarity.
> 
> While it's used in a number of places and it's pretty common wording
> overall in the literature, I agree that we should probably change this in
> locking API user facing documentation.

I would say not only in locking/. The argument is valid for the entire 
Documentation/. I wait for Jon's opinion before proceeding.

> If you change it, please do it in both places it's used.
> 
> Thanks,
> 
> 	Ingo




