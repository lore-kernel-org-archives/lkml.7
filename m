Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F21C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413D32075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554217010;
	bh=hclZDBgxp9QJ7c8nzh9OJopvW3c47Cyce5/5oPk9NGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KQst8MR+4rL7EX2R9kuJLlTb4/QZ/J1RJuacc06neKYZhM6gmKzsUELw510pxvzdP
	 Vk1jm+7ksprEEveJv3caH6lBTuHnrrV1zzYKmBJGv3hSSpupGbN4CNziB8uR2bAarE
	 zxtYXCR8iNLv/c/H7Q8inXsj0awgvJxRLFjg1f6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbfDBO4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfDBO4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:56:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C08A320857;
        Tue,  2 Apr 2019 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554217008;
        bh=hclZDBgxp9QJ7c8nzh9OJopvW3c47Cyce5/5oPk9NGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hK6ppKR5KX3Usy0NaR0c6bIEUr63tJXZzCkxAYs3mbW4b0jPaYAunIZCmBoq/KjZP
         OPa+XHDhvXa4uvXwQBg9PcMApE5YW1SlUku3SRX2HVz1fTprPcVdsaV/BLeWzJ/xT3
         RuLteiGUc76suQJLF1t1uBvVyvdBWiJFm5zrTyik=
Date:   Tue, 2 Apr 2019 16:56:28 +0200
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
Message-ID: <20190402145628.GA16110@kroah.com>
References: <20190311205606.11228-1-keith.busch@intel.com>
 <20190315175049.GA18389@localhost.localdomain>
 <20190316030407.GA1607@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316030407.GA1607@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 08:04:07PM -0700, Greg Kroah-Hartman wrote:
> On Fri, Mar 15, 2019 at 11:50:57AM -0600, Keith Busch wrote:
> > Hi Greg,
> > 
> > Just wanted to check with you on how we may proceed with this series.
> > The main feature is exporting new sysfs attributes through driver core,
> > so I think it makes most sense to go through you unless you'd prefer
> > this go through a different route.
> > 
> > The proposed interface has been pretty stable for a while now, and we've
> > received reviews, acks and tests on all patches. Please let me know if
> > there is anything else you'd like to see from this series, or if you
> > just need more time to get around to this.
> 
> I can't do anything with patches until after -rc1 is out, sorry.  Once
> that happens I'll work to dig through my pending queue and will review
> these then.

Sorry for the delay, all now queued up, thanks!

greg k-h
