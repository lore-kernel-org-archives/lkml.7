Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8449CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506FB20645
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552705461;
	bh=kHlO8sPVt6f18EIgoXLMolRqSxQ+DkKueBe7dfzK99Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DPh1XSqkw2Mjlqci95Wv/UJ1aRTe1C6Udf7yNHEfLbQNHKqAn7uIEjhiD3+M4BJvz
	 c+zXue4vAWOV6//M8U5HuasNoWNZAd946HSHzd8Pxyd6U/2mvLq11gEFV5x4NV9Nhk
	 Lbo7zkLJi6bEHnTNA6xEGSYJHx5nwyhLiSd5aemQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfCPDEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfCPDEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:04:16 -0400
Received: from localhost (unknown [104.153.224.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D52F218D0;
        Sat, 16 Mar 2019 03:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552705455;
        bh=kHlO8sPVt6f18EIgoXLMolRqSxQ+DkKueBe7dfzK99Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wjZA7/iCaiuQmLw9ClUnEIwhUPErtyXOYPsGpY5fT0XZjzyTHlVkTKEyznEKE43yP
         3tkcMKukhVnLgQ30r2m4U79QF5N+JaijdkMloCoQbU04jFc/I6ERWwbBXTaB/qqcE6
         EuiBabJUSXi5fV4YyOuEao/7D2g6/x2K4DJFgzh8=
Date:   Fri, 15 Mar 2019 20:04:07 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [PATCHv8 00/10] Heterogenous memory node attributes
Message-ID: <20190316030407.GA1607@kroah.com>
References: <20190311205606.11228-1-keith.busch@intel.com>
 <20190315175049.GA18389@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315175049.GA18389@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 11:50:57AM -0600, Keith Busch wrote:
> Hi Greg,
> 
> Just wanted to check with you on how we may proceed with this series.
> The main feature is exporting new sysfs attributes through driver core,
> so I think it makes most sense to go through you unless you'd prefer
> this go through a different route.
> 
> The proposed interface has been pretty stable for a while now, and we've
> received reviews, acks and tests on all patches. Please let me know if
> there is anything else you'd like to see from this series, or if you
> just need more time to get around to this.

I can't do anything with patches until after -rc1 is out, sorry.  Once
that happens I'll work to dig through my pending queue and will review
these then.

thanks,

greg k-h
