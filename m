Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB21C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DE0206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="nu3TsHsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfDBHFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:05:53 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:4244 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfDBHFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:05:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id A42EC3150;
        Tue,  2 Apr 2019 09:05:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1554188748; x=1556003149; bh=b6eO4TwzGAy4B3rvMjp/ptDWgPhTColToc9
        6uD6RF3M=; b=nu3TsHsVfyiCL3pf4fdRavwcCJsTDUuq/Z6kFZQPggcchDWdmH6
        Mg9rexwx1F02KCjhtiAp6Anz+mih9XcmvRanlWYZYV/jBPj/AaEmtQidkjOgdR2W
        h5CtVNzXmQjGKOBCPBKBpqJHwkE8TwfZe7CQWVf7mFWwlzUxf+OX3aQ7tS1tBpIb
        anUMLHCdyONrGu8FqwKt0v1JVmdxi5uwsuDP0mT/llPWIuN7uj9l5v/yGVKDiW72
        E6jEwOanBAWygpM2w2svURkMYtCH90N43WwLRrbveEkcCeW+ttSA0jmPDYgH9P6n
        XKKum3kIjzP+03eqaTZyM6bapV2nlD09pmdSWueYOztCc77JflHhkobuq0COac6k
        20A/hP0qSB7gLOLjJfioFFC287J2PDWN4RPd9MEBhuQiteCRHJCcYf0vhrc2ybrf
        eTW3uLzK8jU1PNwbBKQL9rtNaJnbYJY8ZGxpZfF1zxdF5ViaRWkbsW2oCvmrgfd0
        A3qAK95kmJBGzf9KQbTdigWfx9GyTnVXNvPgYwXsmJunqVdY1ZbclZSvhTistLlk
        s4OkvqSU5FkOAMyEqZXNACc33IIpKL8iurZQ0odq8tYShEhbGk6pNiid7afuYTna
        8wf/zfSof/SIW3xh1KCWhQjMb0uBsg26EMxJFwt4oo+/LGu+gyGqrLkk=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w_dAtHRl7-X5; Tue,  2 Apr 2019 09:05:48 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 35D04314F;
        Tue,  2 Apr 2019 09:05:48 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 0BADDB05;
        Tue,  2 Apr 2019 09:05:48 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: translation for maintainer-pgp-guide
Date:   Tue, 02 Apr 2019 09:05:46 +0200
Message-ID: <3213581.2fMHWIHKnX@pcbe13614>
In-Reply-To: <20190401150421.5524ea2d@lwn.net>
References: <20190330211956.3935-1-federico.vaga@vaga.pv.it> <20190401150421.5524ea2d@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 1, 2019 11:04:21 PM CEST Jonathan Corbet wrote:
> On Sat, 30 Mar 2019 22:19:56 +0100
> 
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > It translates the maintainer-pgp-guide in Italian.
> > 
> > Signed-off-by: Alessia Mantegazza <amantegazza@vaga.pv.it>
> > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> 
> Applied, thanks.
> 
> I do wonder, though, given this:
> > +:Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
> 
> Should this patch have had a From: line to get the proper name into the
> changelog?

True, sorry

> 
> Thanks,
> 
> jon


-- 
Federico Vaga
http://www.federicovaga.it/


