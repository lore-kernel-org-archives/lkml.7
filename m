Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313BBC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055D02084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfDBOAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:00:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:45614 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbfDBOAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:00:51 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 37A7E9B5;
        Tue,  2 Apr 2019 14:00:51 +0000 (UTC)
Date:   Tue, 2 Apr 2019 08:00:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: translation for maintainer-pgp-guide
Message-ID: <20190402080050.7a18caee@lwn.net>
In-Reply-To: <3213581.2fMHWIHKnX@pcbe13614>
References: <20190330211956.3935-1-federico.vaga@vaga.pv.it>
        <20190401150421.5524ea2d@lwn.net>
        <3213581.2fMHWIHKnX@pcbe13614>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Apr 2019 09:05:46 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> > I do wonder, though, given this:  
> > > +:Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>  
> > 
> > Should this patch have had a From: line to get the proper name into the
> > changelog?  
> 
> True, sorry

I hadn't pushed my tree yet, so I was able to tweak that first.

Thanks,

jon
