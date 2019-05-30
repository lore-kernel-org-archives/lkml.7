Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D23C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110D82593D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfE3NEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:04:07 -0400
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:35238 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725919AbfE3NEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:04:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8215F3AB9;
        Thu, 30 May 2019 13:04:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: need41_405f0fead5e31
X-Filterd-Recvd-Size: 2102
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 May 2019 13:04:02 +0000 (UTC)
Message-ID: <8bc749161a8b8640ebdf78d693111d5350514638.camel@perches.com>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
From:   Joe Perches <joe@perches.com>
To:     hhhawa@amazon.com, Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 30 May 2019 06:04:00 -0700
In-Reply-To: <0ebfe8d7-3e0c-e0be-abd5-5e10b7d4b6aa@amazon.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
         <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
         <20190530115732.GB14088@kroah.com>
         <0ebfe8d7-3e0c-e0be-abd5-5e10b7d4b6aa@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-30 at 15:52 +0300, hhhawa@amazon.com wrote:
> On 5/30/19 2:57 PM, Greg KH wrote:
> > On Thu, May 30, 2019 at 01:15:29PM +0300, Hanna Hawa wrote:
> > > +static void al_a57_edac_cpumerrsr(void *arg)
> > > +{
> > > +	struct edac_device_ctl_info *edac_dev =
> > > +		(struct edac_device_ctl_info *)arg;
> > No need for casting anything here, just assign it.  Doesn't checkpatch
> > catch this type of thing these days?  You did run it, right?
> 
> I did, but checkpatch didn't catch this. I'll fix in next patch-set.
> 
> Thanks for your review.

checkpatch is brainless about the types of variables/arguments.

coccinelle is another very useful tool so you could also run
scripts/coccicheck on your sources.

see: Documentation/dev-tools/coccinelle.rst


