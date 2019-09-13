Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B37C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2315520830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbfIMRgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:36:20 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:55010 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728811AbfIMRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:36:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 73C7218225E0A;
        Fri, 13 Sep 2019 17:36:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: part18_19b2e2b09e449
X-Filterd-Recvd-Size: 1675
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Sep 2019 17:36:16 +0000 (UTC)
Message-ID: <33da71451cbc5836efd61ccf125be89c6e946253.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add a git and a maintainer entry to
 keyring subsystems
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 13 Sep 2019 10:36:15 -0700
In-Reply-To: <11580.1568387033@warthog.procyon.org.uk>
References: <20190910143228.30305-1-jarkko.sakkinen@linux.intel.com>
         <11580.1568387033@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-13 at 16:03 +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > Subject: [PATCH] MAINTAINERS: Add a git and a maintainer entry to keyring subsystems
> 
> I would recommend splitting the patch in two and putting something like:
> 
> 	keys: Add Jarkko Sakkinen as co-maintainer
> 
> as the subject of the keyrings maintainership one.

Why is there utility in micro splitting such a trivial patch?


