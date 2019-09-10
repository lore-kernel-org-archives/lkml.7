Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250F3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7F12084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="o+8f00MB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbfIJNRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:17:35 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:62004 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfIJNRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 09:17:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id E54CA40434;
        Tue, 10 Sep 2019 15:17:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1568121451; x=1569935852; bh=a5pnmPm8nIxY3zzJSRLdaWsreRl6h7wiA3V
        rT0lIx44=; b=o+8f00MBmpBBxslrWIFlLHd/L7TyhEz6fLH3x+Ycf7F0hmyzpuC
        ZkLuE192s7eahT1OVeav3IBNpT8wfvXM0nYR3FF9ilCd5FqBIvbMAQyruLaGaAsD
        QCPNdZNmDorqeZaJtn7SZUN4nvy/wRDRrD3QVKW9mh9L/yQVP5Mr/yUtNeKjn87h
        uBea4ubwinzXI7yLW8erF5/9E1Uyxd8blmOerQD8kogIXxpti6ub+DDAe9sAY/bu
        0zEz4T300MdxeInU3povnM3qE96Rp5zVPHRM5HhGKKumCewrgXcpCDCXcR58WpBf
        PfRf9TqsIJWKNOXtVlxxqZL4E165Hm7bTxbAQ3ohrx7o4tfGn4T3kgOyBGQQLDMe
        5kLXuoJ0yqR36uwHiD1ClxNqtIa0sJzF3T1RcXyHs9M9EE1ABt6yeOQYcTGcJQW+
        8IXIjQnjSUF3XUGZ9SEr4t502bX0fHRCia/32w/FGJkkzYI7PCIr3/lSuSf1CDQW
        skZ51+uPClhupdoaSiefXdD28WikX2hPX4rCOR3hYA7jzQWdGrQSoUjjj/P9rDub
        KCoV2fCfnyCGBcFzVdfx0jWRda8AyGbvOvtkeL8QSh8qnDKiIdwQG6H3E9BPnDNx
        qtS/n3xfklkxE/Maa/PlO/EzBjNqw/wBDOr+OzW3nLpUrdFEfiqhrTxg=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mG2EcvuXIwJl; Tue, 10 Sep 2019 15:17:31 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 5CCF8403A2;
        Tue, 10 Sep 2019 15:17:31 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 008561B2B;
        Tue, 10 Sep 2019 15:17:30 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: replace IFF abbreviation  with 'if and only if'
Date:   Tue, 10 Sep 2019 15:17:29 +0200
Message-ID: <4450664.oKrbQx5eeJ@harkonnen>
In-Reply-To: <20190910063510.GA4267@infradead.org>
References: <20190907105116.19183-1-federico.vaga@vaga.pv.it> <20190910063510.GA4267@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 10, 2019 8:35:10 AM CEST Christoph Hellwig wrote:
> On Sat, Sep 07, 2019 at 12:51:16PM +0200, Federico Vaga wrote:
> > In a normal piece of text the use of 'iff' does not guarantee a correct
> > interpretation because it is easy to confuse it for a typo (if or iff?).
> > 
> > I believe that IFF should not be used outside a logical/mathematical
> > expression. For this reason with this patch I am replacing 'iff' with
> > 'if an only if' in text, and I am leaving it as it is in logical formulae.
> 
> Hell no.  If you want to avoid the usage in your own docs please go for
> it, but as seen in your patch we commonly use 

The usage of 'iff' is as common as the usage of  'if and only if'

> and that is a good thing
> as it brings the information across  in a very compact way.

It is not a piece of code that has to run on an embedded system and it needs 
to be compact. It is a piece of text that people must understand.

Generally speaking compactness does not bring any value if then the text is 
unclear or open to interpretation.


