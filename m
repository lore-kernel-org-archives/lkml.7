Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5833BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 09:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CA321738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552816507;
	bh=OCNn2EmkvhvpiigKamu0ZgE4qk9PH5OHugO+Wgry3O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F4jhmalgcnNKsRw9iN+D9XhW6aZfagQfc7pLMcGmIp/MO7v0fh1R62uJ/pWyMOyid
	 QsZiQDZkHGecygvJ1rILOuEFVroaatCJTKTM+DdKCHSFXPdMxq61BDcnhxAWl2+aGG
	 tdAJDz1Pyed3hlMtaY2yahVvPBCeS4eAzn3S0PZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfCQJzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 05:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfCQJzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 05:55:05 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9251E2148D;
        Sun, 17 Mar 2019 09:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552816505;
        bh=OCNn2EmkvhvpiigKamu0ZgE4qk9PH5OHugO+Wgry3O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIKW66LQhX3qDkAJPdydw6u/7pTNofQneGq+Yc7LnsMP1Cr5Z0PiMyJA9LUi/VHjE
         wII5wurNKngKfDzDuPuwMHT36pbN49CifexO3RGpEyZXEn8zZwyR0BLC3KPA+Igcv8
         tyNWRUW2YOOSjvoPLRv56gThXXbODEBbkxRoLsXI=
Date:   Sun, 17 Mar 2019 10:55:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emanuel Bennici <benniciemanuel78@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vc04_services: Add blank line after struct
 declaration
Message-ID: <20190317095502.GC6906@kroah.com>
References: <20190317015930.GA1747@p200300EEEE2F.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317015930.GA1747@p200300EEEE2F.fritz.box>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 02:59:32AM +0100, Emanuel Bennici wrote:
> Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchi/vchi.h | 1 +
>  1 file changed, 1 insertion(+)

I can not take patches without any changelog information, sorry.
