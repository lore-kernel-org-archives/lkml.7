Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1E2C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296362075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfECIMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:12:13 -0400
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:35864 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbfECIMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:12:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 709E1837F27B;
        Fri,  3 May 2019 08:12:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: silk87_12ba163999c4b
X-Filterd-Recvd-Size: 1189
Received: from XPS-9350 (unknown [84.16.30.4])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 May 2019 08:12:08 +0000 (UTC)
Message-ID: <cf6948fb8ab8e395e139a3440f3600a6050c1efa.camel@perches.com>
Subject: Re: [PATCH] powerpc/powernv/ioda2: Add __printf format/argument
 verification
From:   Joe Perches <joe@perches.com>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 03 May 2019 01:12:05 -0700
In-Reply-To: <44wNKc0KZFz9sPd@ozlabs.org>
References: <44wNKc0KZFz9sPd@ozlabs.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-03 at 16:59 +1000, Michael Ellerman wrote:
> On Thu, 2017-03-30 at 10:19:25 UTC, Joe Perches wrote:
> > Fix fallout too.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/1e496391a8452101308a23b7395cdd49

2+ years later.


