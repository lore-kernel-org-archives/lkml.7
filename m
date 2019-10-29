Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062AACA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99352067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390855AbfJ2RPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:15:48 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:39463 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727692AbfJ2RPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:15:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D0DAC18224D66;
        Tue, 29 Oct 2019 17:15:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheet91_31cdff6a4690a
X-Filterd-Recvd-Size: 2120
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 29 Oct 2019 17:15:42 +0000 (UTC)
Message-ID: <f668de19e156bd7a1bf599d9ce1f9d4f4fca4095.camel@perches.com>
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
Date:   Tue, 29 Oct 2019 10:15:35 -0700
In-Reply-To: <8952e975-3bad-4b7d-49ff-b74af942008c@linaro.org>
References: <20191029164537.1561-1-p.paillet@st.com>
         <20191029164537.1561-3-p.paillet@st.com>
         <8952e975-3bad-4b7d-49ff-b74af942008c@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-29 at 18:11 +0100, Daniel Lezcano wrote:
> On 29/10/2019 17:45, Pascal Paillet wrote:
> > Fix IRQ flood on low threshold by too ways:
> 
> Can you state the issue first ?
> 
> > - improve temperature reading resolution,
> > - add an hysteresis to the low threshold: on low threshold interrupt,
> > it is not possible to get the temperature value that has fired the
> > interrupt. The time to acquire a new value is enough for the CPU to
> > become hotter than the current low threshold.
[]
> > Signed-off-by: Pascal Paillet <p.paillet@st.com>
> > Change-Id: I3b63b8aab38fd651a165c4e69a2d090b3c6f5db3
> 
> Please remove the Change-Id tag.
> 
> Joe, Andy? checkpatch does not see the Change-Id, is it the expected
> behavior?

Yes.  It's after a sign-off so checkpatch doesn't care.



