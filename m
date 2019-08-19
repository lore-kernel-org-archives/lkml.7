Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF94C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6630122CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566262504;
	bh=54/BT8SZJgAIMpAnqLxKslYwihrI9EqMeG7ckMwwug4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t2jBqUWN12yHiA+nKRE51RkzO4e+6xWj1VNzsX23Nv8pceYqFIqXot9kUkL8oiJCc
	 C8L58zXI3y0QaUl8319qw4XHcse3yxVojzhmFpHj1LvisWFawKcjGq0sJbW8XHcfa5
	 WUnqRHyDqo5MzVO1jEWBu6iNhF3mg7LWiA1hKHA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfHTAzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbfHTAzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:55:03 -0400
Received: from localhost (unknown [76.14.1.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1542622CE8;
        Tue, 20 Aug 2019 00:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566262502;
        bh=54/BT8SZJgAIMpAnqLxKslYwihrI9EqMeG7ckMwwug4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCajfvk6Dgv1W/dYd8Mxl+bCF5t07OaW61VP0BSgavB1mogw7ClwmszHPGLUphxcF
         rdqYfXRDwSRFQkNUNMYMgBuIMlb7eyjfudsVpBipU0uBwlZie+VikZNEVpO3Kd0Rnz
         gTOJFHCus0SeCnhvfVrOuv89wIpTL36sNFZpN0LY=
Date:   Mon, 19 Aug 2019 22:51:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org
Subject: Re: [PATCH v5 0/9] FPGA DFL updates
Message-ID: <20190819205124.GA28978@kroah.com>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
 <20190819053133.GA31244@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819053133.GA31244@hao-dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:31:33PM +0800, Wu Hao wrote:
> On Mon, Aug 12, 2019 at 10:49:55AM +0800, Wu Hao wrote:
> > Hi Greg,
> > 
> > This is v5 patchset which adds more features to FPGA DFL. Marjor changes
> > against v4 are sysfs related code rework to address comments on v4.
> > 
> > Please help to take a look. Thanks!
> 
> Hi Greg,
> 
> Did you get a chance to take a look at this new version patchset? :)

I'm not the FPGA maintainer, what about the review from the other one
first?  :)

thanks,

greg k-h
