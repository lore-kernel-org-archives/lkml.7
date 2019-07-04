Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E962AC06514
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F5A21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562223763;
	bh=0oIb/xCT3XLGQm//gpuwzJhTfVxSSNj2HGbdu4q2mfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aSqVaGIkXZnugOBUcX5XQ9vhFk4sxZzxhEmJO2PyY3jCGheKRgNVMCpxEwLCBwVs0
	 8VE9scgiUKdPs5Xa9dnTRfzEkF9smbN0bUVcYvPT4INf+SIX0BKfDQQYwdhYAcMd/S
	 vn+Kg1tq4PZqL9+6WPQhTzR/2fSz5V7OVOFjrQRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfGDHCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfGDHCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:02:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9F8A2133F;
        Thu,  4 Jul 2019 07:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562223761;
        bh=0oIb/xCT3XLGQm//gpuwzJhTfVxSSNj2HGbdu4q2mfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kjkmVNUHh0i1R1QHDk14Ed8hJdp8t230pxRxwJn6cLt81ivp639YfvpxGTRi7tn0h
         /J/az8RDFGBthzhsjX6ZC/A/W8fGVcfRvEDa35V/zj0ML+uR/v7GTNksOtZd+31Wkp
         L//KiTeWpyM1eP0YTr9N/I570G2ubODK7xbbowhI=
Date:   Thu, 4 Jul 2019 09:02:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCHv5 1/2] dt-bindings: coresight: Change CPU phandle to
 required property
Message-ID: <20190704070239.GB32707@kroah.com>
References: <cover.1561659046.git.saiprakash.ranjan@codeaurora.org>
 <2afedb941294af7ba0658496b4aca3759a4e43ff.1561659046.git.saiprakash.ranjan@codeaurora.org>
 <CANLsYkxvh+qUDvqG45o7qh61Noq=a=BJ4-p68ipdzxYt6n5bNA@mail.gmail.com>
 <8fb5947e-acf8-faff-5594-2a32151ebee7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb5947e-acf8-faff-5594-2a32151ebee7@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:13:40PM +0530, Sai Prakash Ranjan wrote:
> On 7/4/2019 1:32 AM, Mathieu Poirier wrote:
> > Hi Greg,
> > 
> > On Thu, 27 Jun 2019 at 12:15, Sai Prakash Ranjan
> > <saiprakash.ranjan@codeaurora.org> wrote:
> > > 
> > > Do not assume the affinity to CPU0 if cpu phandle is omitted.
> > > Update the DT binding rules to reflect the same by changing it
> > > to a required property.
> > > 
> > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > 
> > I'm all good with this patch - can you pick this up for the coming
> > merge window?  If not I'll simply keep it in my tree for 5.4.
> > 
> > Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> 
> I think you missed adding Greg, adding him now ;)

I don't see any patch here for me to actually take :(
