Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815A5C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD8820652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556817298;
	bh=58kgeTvNAwTn6DXw7BdMdqSpsZyBdfuvDAuxf//UEYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zbtg3wlDDJzrICTFmqbWNyNYnq/wJWDsO+7w2Q73nYnBVuOXGcE0uHk3alhr1lGe2
	 FZs3onHllSOKA+f+r+tD/Gp7n/zBZsBXSi9wqtED7iyrQT37Fk82gCCbmvpN/ZeDhW
	 /7Mqqxn++TCp9mJ0lcRVRV3G668OL/HaLWzaQ3iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfEBRO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 13:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfEBRO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:14:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DE6820675;
        Thu,  2 May 2019 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556817296;
        bh=58kgeTvNAwTn6DXw7BdMdqSpsZyBdfuvDAuxf//UEYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NEd6H7BUxehxi3tX0dJdbTDZo0ALEWIZKflD/2Cg8E7hDjzhyo40r5eeGSWBgwksR
         TfpAsRSZs+V4xsLmDzx3p3vqEmojEV5jGnaIDnp008hdA98rH6gieXJeuX9esJrzu5
         yrje3UkM4Qt3iFYNixYjwEG0HJLrsA9k4Hy5ee8I=
Date:   Thu, 2 May 2019 19:14:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] coresight: next v5.1-rc7
Message-ID: <20190502171450.GA1794@kroah.com>
References: <20190502165405.31573-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502165405.31573-1-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 10:54:01AM -0600, Mathieu Poirier wrote:
> Hi Greg,
> 
> Please see if you can add these to your tree for the coming merge window.
> They are confined to the CoreSight subsystem and have been in linux-next for
> a week now.
> 
> We can simply wait for the next cycle if you think it is too late for this one.

Snuck them in right now :)

thanks,

greg k-h
