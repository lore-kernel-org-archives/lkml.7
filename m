Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07FCCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C111020830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfJ2RZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:25:01 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:59860 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726416AbfJ2RZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:25:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C4978181D3039;
        Tue, 29 Oct 2019 17:24:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: honey62_829271995af5b
X-Filterd-Recvd-Size: 2690
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 29 Oct 2019 17:24:57 +0000 (UTC)
Message-ID: <9dd814577107edc42c4469ee7c923e062a2b5368.camel@perches.com>
Subject: Re: [PATCH 2/4] thermal: stm32: fix IRQ flood on low threshold
From:   Joe Perches <joe@perches.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Pascal Paillet <p.paillet@st.com>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rui.zhang@intel.com, edubezval@gmail.com,
        amit.kucheria@verdurent.com, david.hernandezsanchez@st.com,
        wsa+renesas@sang-engineering.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>
Date:   Tue, 29 Oct 2019 10:24:50 -0700
In-Reply-To: <026e676e-0a6c-81ca-3af4-2832118b9ddf@linaro.org>
References: <20191029164537.1561-1-p.paillet@st.com>
         <20191029164537.1561-3-p.paillet@st.com>
         <8952e975-3bad-4b7d-49ff-b74af942008c@linaro.org>
         <f668de19e156bd7a1bf599d9ce1f9d4f4fca4095.camel@perches.com>
         <026e676e-0a6c-81ca-3af4-2832118b9ddf@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-29 at 18:21 +0100, Daniel Lezcano wrote:
> On 29/10/2019 18:15, Joe Perches wrote:
> > On Tue, 2019-10-29 at 18:11 +0100, Daniel Lezcano wrote:
> > > On 29/10/2019 17:45, Pascal Paillet wrote:
> > > > Fix IRQ flood on low threshold by too ways:
> > > 
> > > Can you state the issue first ?
> > > 
> > > > - improve temperature reading resolution,
> > > > - add an hysteresis to the low threshold: on low threshold interrupt,
> > > > it is not possible to get the temperature value that has fired the
> > > > interrupt. The time to acquire a new value is enough for the CPU to
> > > > become hotter than the current low threshold.
> > []
> > > > Signed-off-by: Pascal Paillet <p.paillet@st.com>
> > > > Change-Id: I3b63b8aab38fd651a165c4e69a2d090b3c6f5db3
> > > 
> > > Please remove the Change-Id tag.
> > > 
> > > Joe, Andy? checkpatch does not see the Change-Id, is it the expected
> > > behavior?
> > 
> > Yes.  It's after a sign-off so checkpatch doesn't care.
> 
> Ah, I guess it is for Gerrit but we don't want those Change-Id in the
> kernel history, right?

So remove it from the patch.

checkpatch is not a perfect tool.
checkpatch will never be a perfect tool.
It's not possible for checkpatch to be a perfect tool.


