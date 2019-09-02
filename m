Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493F0C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4DC21881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="VCF2ypNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfIBHBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:01:34 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:51738 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729476AbfIBHBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:01:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 62EDC403F1;
        Mon,  2 Sep 2019 09:01:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1567407688; x=1569222089; bh=gQTLlnjxfU5wtu5rW3AqaO/cAFjAnpJ6Tai
        mExqVlFA=; b=VCF2ypNoGc6gj2VcDTY24Hgpz+lWZfLUIwGuDVaTH2dk8CjuYdy
        PqP027/8lXWoQebo018ZCqKWLFF4wmd1BdeVfKKtYesRPuH8sCamcr2I+uO7Ysc6
        M8VPVcCkPDPusHFVwrk7Kj1RmBJzsyW6XI7EFreglZTbrWRJ2x02YP5HnSHBhHqU
        PutOUzRcRy5OOLxh8UGRrwh+4JgzoO+hSg/hqchg09deRUYPMvVe28GEpFGJaffG
        JALreoIdoPGxjoNKYkHxypBKyKa4+ffAf3EGHEz4MO4/2dYIkyyN/dD6gsf7MjcK
        h7E7OptnHnpT1iM0ppnaasbLl/GIgq6j7RNuErVznwJo57uJTgm0IMIvS7jvPd+G
        c8TVtDXHNisDazOBHcIw2cfVyRPlJeUhuHrw+4B89Lht3g4HQmFov8O6ozqSgJ+8
        1pWH+fg6aCs5siLh8AlUojKM0k3tlWdtD4XT6bnq0rj+Mw7RnUW8SS/mNRnOPCKw
        NXINYsYLo0S7FWX93skgQxa3IHsA5KPRuadPByqGPJKmQfaP6xESJp25hmyznCML
        IB/SC1gm3RFk+lop2kjIUqLWgaOqI0e+KvZH7P0M5LN8231ZPoJhAkWL69985gmk
        iIpMAWbEt16S87XUWeBP6MFIJwFJRzU21nmJUVg4WnyQaHwrIIG5Zz6M=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MvEp27HjTeVe; Mon,  2 Sep 2019 09:01:28 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 96D4E403C8;
        Mon,  2 Sep 2019 09:01:28 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 1B4F43964;
        Mon,  2 Sep 2019 09:01:28 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc:lock: remove reference to clever use of read-write lock
Date:   Mon, 02 Sep 2019 09:01:26 +0200
Message-ID: <2216492.xyESGPMPG3@pcbe13614>
In-Reply-To: <20190831084344.6fd7c039@lwn.net>
References: <20190831134116.25417-1-federico.vaga@vaga.pv.it> <20190831084344.6fd7c039@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 31, 2019 4:43:44 PM CEST Jonathan Corbet wrote:
> On Sat, 31 Aug 2019 15:41:16 +0200
> 
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> >  several CPU's and you want to use spinlocks you can potentially use
> > 
> > -cheaper versions of the spinlocks. IFF you know that the spinlocks are
> > +cheaper versions of the spinlocks. If you know that the spinlocks are
> > 
> >  never used in interrupt handlers, you can use the non-irq versions::
> I suspect that was not actually a typo; "iff" is a way for the
> mathematically inclined to say "if and only if".
> 
> jon

I learned something new today :)

I am not used to the mathematical English jargon. It make sense, but then I 
would replace it with "If and only if": for clarity.


-- 
Federico Vaga



