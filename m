Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C251DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD4D21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="vp1c/pDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfCOKzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:55:21 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:61962 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbfCOKzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:55:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 99DEE674;
        Fri, 15 Mar 2019 11:55:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1552647318; x=1554461719; bh=K+crdeGwd5RFwjcAOPNQQfDlbxXH8LOLCDr
        byvQZR/Q=; b=vp1c/pDjRwc2dxHO6iB+qp0CkBD/9IM+qa1A5FuK62pfgnOMkQO
        kNJc1Ote/H7XIQdRcsaGOL26YwsmdHCbUowYmQQU++OfwZsMgo59blBEGjKeq1m4
        q426rX1YusV9WSfo97lPbAR2FONWlcH4slKnphBxLxaBmv8sVfeVKdz+9+SlmruI
        gllBLpR/JcrSwFRQrA5D/czt+jM6uYtU63S1wRzdZsSx+V35vSeMHbhqDgtAQFZO
        lvWb09wjHLlpRH78gWo0JntsKOUhLnSvhy2KFe+txbU4oZHLwbcJX51dueoVvOcO
        a2B6xKa1P+9Iy0bxtJKxc9DYo3LIpOvRaKPt+ZBrD3R/+UyT6yHdquHTk70Iv7gz
        ci148APurVSqbmS9cOGbAdzt6QXpbN0/Np7YSxpuip3GMAR7w9uxBPeQjraq/HWs
        hObsG7e43L7VDkOhTT3XvVbBExwjYtdhgT3gfX4mIQww5HVgck3VcPJhn3SXaj37
        vbco8VElI/hpNfOM/oTdQmf9kCzrNyCE12ourgbPOlRxjGu2gwSj26JQmdZ4V2xu
        LhUtM9aPKSN3rK8p1DZAp15fzXeTroHJRyKLDeQzFLZNMAHzVZ1MYEisgHeKYxiA
        15v8vPpWV6oEJ9kZPFyYhjpJ3e1uFeNYmhxBTaVSJjrVML0cecEY+ILQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JQwBAiDE8Zhl; Fri, 15 Mar 2019 11:55:18 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 7ED97517;
        Fri, 15 Mar 2019 11:55:18 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 5627C216;
        Fri, 15 Mar 2019 11:55:18 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: add translation disclaimer
Date:   Fri, 15 Mar 2019 11:55:17 +0100
Message-ID: <2230052.up2SEFjotJ@pcbe13614>
In-Reply-To: <78830124-9f65-354c-ed16-3f73f5ebe0b3@rasmusvillemoes.dk>
References: <20190314204516.10890-1-federico.vaga@vaga.pv.it> <78830124-9f65-354c-ed16-3f73f5ebe0b3@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 15, 2019 11:00:57 AM CET Rasmus Villemoes wrote:
> On 14/03/2019 21.45, Federico Vaga wrote:
> > diff --git a/Documentation/translations/index.rst
> > b/Documentation/translations/index.rst index 7f77c52d33aa..d7a38fd28b50
> > 100644
> > --- a/Documentation/translations/index.rst
> > +++ b/Documentation/translations/index.rst
> > @@ -4,6 +4,48 @@
> > 
> >  Translations
> >  ============
> > 
> > +.. _translations_disclaimer:
> > +
> > +Disclaimer
> > +----------
> > +
> > +Translation's purpose is to ease reading and understating in languages
> > other
> understanding, hopefully :)

ops, yes :D

> 
> > +If you need to communicate with the Linux community but you do not feel
> > +comfortable to write in English, you can ask to the translation's
> > +maintainers for help.
> > +
> 
> s/to write/writing/, s/ask to/ask/

ack
 
> > +Translations
> > +------------
> > +
> 
> Do you really mean to add that heading a second time? I know it's on
> another level, but it seems a bit odd.

You are right

> 
> Rasmus


-- 
Federico Vaga
http://www.federicovaga.it/


