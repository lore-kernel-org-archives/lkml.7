Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA4EC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD912187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbfKFTCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:02:14 -0500
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:36857 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732219AbfKFTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:02:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D8FA918021E46;
        Wed,  6 Nov 2019 19:02:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pipe51_86cd89710ff50
X-Filterd-Recvd-Size: 1661
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Nov 2019 19:02:06 +0000 (UTC)
Message-ID: <7b6295e48dbb4b5b9c578516f40b61ad2afd115b.camel@perches.com>
Subject: Re: s390/pkey: Use memdup_user() rather than duplicating its
 implementation
From:   Joe Perches <joe@perches.com>
To:     Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     Christian =?ISO-8859-1?Q?Borntr=E4ger?= <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 06 Nov 2019 11:01:53 -0800
In-Reply-To: <cba4068c-0d63-fc0a-44bb-2664b690f126@web.de>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
         <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
         <0f90b278-7b3e-6509-1633-301d16513c5d@web.de>
         <47c55ab899aafe10898e6581582363aa446b2091.camel@perches.com>
         <cba4068c-0d63-fc0a-44bb-2664b690f126@web.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 19:55 +0100, Markus Elfring wrote:
> > There is no bug here.
> 
> Do you find duplicated source code questionable?

No.  It is something that can be improved through
code consolidation though.

> Is this also an error item?

Definitely not.  It is _only_ an error if there is
some logic defect.  There is no logic defect here.


