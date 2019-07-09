Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9E0C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDDE216E3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfGIR7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 13:59:39 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:39464 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726133AbfGIR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 13:59:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A73A7100E86C5;
        Tue,  9 Jul 2019 17:59:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: earth64_192839cbcd232
X-Filterd-Recvd-Size: 1636
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jul 2019 17:59:32 +0000 (UTC)
Message-ID: <ff4ce6a96a922cff2dd929560b9167207b4899e9.camel@perches.com>
Subject: Re: [PATCH v2 2/4] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hanna Hawa <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Date:   Tue, 09 Jul 2019 10:59:31 -0700
In-Reply-To: <20190709173229.0000135f@huawei.com>
References: <1562500658-14717-1-git-send-email-hhhawa@amazon.com>
         <1562500658-14717-3-git-send-email-hhhawa@amazon.com>
         <20190709173229.0000135f@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 17:32 +0800, Jonathan Cameron wrote:
> On Sun, 7 Jul 2019 14:57:36 +0300
[]
> > +#define ARM_CA57_CPUMERRSR_REPEAT		GENMASK(39, 32)
> > +#define ARM_CA57_CPUMERRSR_OTHER		GENMASK(47, 40)
> > +#define ARM_CA57_CPUMERRSR_FATAL		GENMASK(63, 63)

GENMASK_ULL


