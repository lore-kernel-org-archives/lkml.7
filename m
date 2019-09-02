Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E755C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 21:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB5921881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 21:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="lli5Txam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfIBVHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 17:07:09 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:12090 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfIBVHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 17:07:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 67D68829;
        Mon,  2 Sep 2019 23:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1567458426; x=1569272827; bh=WuXCxjOvHNPIr4f4FJI2dIbj/gOBpQVskgt
        sRbojjiE=; b=lli5Txam2/ig+K9Eqk0TUyex2OEYzqaDfAazREZIKUxi0V1oZ2x
        LIuc4CoFrPa2cTCiLnu+B2dKkco8lLeZj+X/MC48C7fzU6LxYJ+tKQoBhQiagrgw
        vQ4HSTVxEKbgnp9NBVXKJnqpPtA24xpMsbc5buG1WY2Nobad0iIvKct1BlPaHTFx
        kt0osiY0f6QC9sK9y/jKs7fPM883xB0UV29xsJwMrhLKZ2vg+TYct6wwiMesvm8+
        xxWWoEJZmlzwb+ia+3+bhEg6DIlTu4YrUka5jKSn8KxSKHP2xh9I14+MwZNCX7DG
        1aBGd4g8ALzCE6SKVFWF+s2apb0cBdi6VCPcoX4B/BFA+fXrUQsWbSt71VOLXEW4
        R49/vuT14W0/IMA2UXseumSLacVQEReynC84aUD9O+lwxBdHHlVouz07Q4eQDXmP
        D68hNeY0AdN176XVQ5YHnXA72M9E8ZBJtVYvzRqEADGgKaH06xeeNEmXyKp9eBG2
        +vwMuZVel9yRI2kJYndY6SFikvTKajXs4riT8X/B5zFpUYBia3FG9NEO9Fd6BBOj
        TyiLC/8iK7RSOBuwDOa0tqwg9fj8VDh3gA1ufel6Bh2BwWQ+sUsVAe7VhoRClX8R
        LhjUQ7LewZWHLEiPrCj+wq4GpjRR9DikZgXwdc4Dq+OllSWgR+nwQ5DA=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FSSCfrSDwaJL; Mon,  2 Sep 2019 23:07:06 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 28EF1812;
        Mon,  2 Sep 2019 23:07:05 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id A70964EF3;
        Mon,  2 Sep 2019 23:07:05 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc:lock: remove reference to clever use of read-write lock
Date:   Mon, 02 Sep 2019 23:07:04 +0200
Message-ID: <2901443.IPKE8n5AsX@harkonnen>
In-Reply-To: <20190902142133.37e106af@lwn.net>
References: <20190831134116.25417-1-federico.vaga@vaga.pv.it> <4627860.yBeiQmOknq@harkonnen> <20190902142133.37e106af@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 2, 2019 10:21:33 PM CEST Jonathan Corbet wrote:
> On Mon, 02 Sep 2019 21:19:24 +0200
> 
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > > > I am not used to the mathematical English jargon. It make sense, but
> > > > then
> > > > I
> > > > would replace it with "If and only if": for clarity.
> > > 
> > > While it's used in a number of places and it's pretty common wording
> > > overall in the literature, I agree that we should probably change this
> > > in
> > > locking API user facing documentation.
> > 
> > I would say not only in locking/. The argument is valid for the entire
> > Documentation/. I wait for Jon's opinion before proceeding.
> 
> I don't really have a problem with "iff"; it doesn't seem like *that*
> obscure a term to me.  But if you want spell it out, I guess I don't have
> a problem with that.  We can change it - iff you send a patch to do it :)

I do not mind too, once I got the meaning of IFF to *me* is clear and 
translatable to SSE (i will not).

My opinion is that abbreviations should not be used in general. But it is a 
weak opinion. I can do, and send, a patch

> 
> Thanks,
> 
> jon




