Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A9C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00F82190F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 20:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfIBUVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 16:21:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:56534 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfIBUVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 16:21:35 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4487530D;
        Mon,  2 Sep 2019 20:21:34 +0000 (UTC)
Date:   Mon, 2 Sep 2019 14:21:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc:lock: remove reference to clever use of read-write
 lock
Message-ID: <20190902142133.37e106af@lwn.net>
In-Reply-To: <4627860.yBeiQmOknq@harkonnen>
References: <20190831134116.25417-1-federico.vaga@vaga.pv.it>
        <2216492.xyESGPMPG3@pcbe13614>
        <20190902181010.GA35858@gmail.com>
        <4627860.yBeiQmOknq@harkonnen>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Sep 2019 21:19:24 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> > > I am not used to the mathematical English jargon. It make sense, but then
> > > I
> > > would replace it with "If and only if": for clarity.  
> > 
> > While it's used in a number of places and it's pretty common wording
> > overall in the literature, I agree that we should probably change this in
> > locking API user facing documentation.  
> 
> I would say not only in locking/. The argument is valid for the entire 
> Documentation/. I wait for Jon's opinion before proceeding.

I don't really have a problem with "iff"; it doesn't seem like *that*
obscure a term to me.  But if you want spell it out, I guess I don't have
a problem with that.  We can change it - iff you send a patch to do it :)

Thanks,

jon
