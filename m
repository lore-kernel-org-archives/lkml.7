Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC693C10F03
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18CD2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfCECtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 21:49:04 -0500
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:40169 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbfCECtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 21:49:03 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 96096100E86C8;
        Tue,  5 Mar 2019 02:49:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toe73_1469bae26ef47
X-Filterd-Recvd-Size: 2507
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Mar 2019 02:49:00 +0000 (UTC)
Message-ID: <fafe78cbb34dc8acd31f873bcd55af879311d839.camel@perches.com>
Subject: Re: [PATCH v6 1/4] can: m_can: Create a m_can platform framework
From:   Joe Perches <joe@perches.com>
To:     Dan Murphy <dmurphy@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de,
        davem@davemloft.net
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 04 Mar 2019 18:48:58 -0800
In-Reply-To: <cc3d0c0c-f56f-0bb5-e90b-a09cdf761f3c@ti.com>
References: <20190301185043.9037-1-dmurphy@ti.com>
         <7ffc0639-de4a-87da-68e0-2d170c241824@grandegger.com>
         <5b0959b9-58b7-cc3c-7014-b7cdb883a7cf@ti.com>
         <2863c42d-065d-39e8-ed20-8279f76f00ae@grandegger.com>
         <cc3d0c0c-f56f-0bb5-e90b-a09cdf761f3c@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-04 at 13:12 -0600, Dan Murphy wrote:
> On 3/4/19 12:13 PM, Wolfgang Grandegger wrote:
> > Am 04.03.19 um 18:22 schrieb Dan Murphy:
> > > > > +	int pm_clock_support;
> > > > 
> > > > A "bool" would be more appropriate, I think.
> > > 
> > > I was abiding by this checkpatch warning I got on the is_peripherial.
> > > 
> > > CHECK: Avoid using bool structure members because of possible alignment issues - see: https://lkml.org/lkml/2017/11/21/384
> > > #94: FILE: drivers/net/can/m_can/m_can.h:94:
> > > +	bool is_peripherial;
> > > 
> > 
> > Ah, right! I was also surprised to get that warning. The kernel is full
> > of bool's, but well, we should make "checkpatch" happy (and Linus).

That check has been removed from checkpatch by

commit 7967656ffbfa493f5546c0f18bf8a28f702c4baa
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Fri Jan 18 15:50:47 2019 -0700

    coding-style: Clarify the expectations around bool
    
    There has been some confusion since checkpatch started warning about bool
    use in structures, and people have been avoiding using it.
    
    Many people feel there is still a legitimate place for bool in structures,
    so provide some guidance on bool usage derived from the entire thread that
    spawned the checkpatch warning.
    
    Link: https://lkml.kernel.org/r/CA+55aFwVZk1OfB9T2v014PTAKFhtVan_Zj2dOjnCy3x6E4UJfA@mail.gmail.com


