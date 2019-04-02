Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451FEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078E42084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554235435;
	bh=nWIzEIQerNDb48vgC2nwFPOJT7EYYU3hn092JK5R+ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j00Bed66Tkn7wjYXwJ6UNuGCBfHbBJW7NJr6OowyJscm2l3y13tPQynbpaHROh+wc
	 SVkfog8M5MT5L9fkhepk3DZOaqDE8V0lrmx8uGmuqrFCnIvGPF1iCMjy3O7YBx7AIr
	 WoZzoyWNmvg19LC7MGrziZazu5M8PY1z8nyoL9mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDBUDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfDBUDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:03:53 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EBF2082C;
        Tue,  2 Apr 2019 20:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554235432;
        bh=nWIzEIQerNDb48vgC2nwFPOJT7EYYU3hn092JK5R+ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDrasPwg09SsKK1q9ZLg9A6mABL2ia2p8KJhvij3y3ZmZuttuXdpyL3jmMcW105h4
         TOfzXrR58qr4Ydy8If1GlTnBydXM8P5eM382nxj9eGXt1/PTbv/5geNThgCr1dFaAL
         CBZJfR6+s0Lf8QIAc2eVF5CEQ6roHKkrd4jnzP6c=
Date:   Tue, 2 Apr 2019 16:03:51 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-kernel@microsoft.com, bryankel@microsoft.com,
        thiruan@microsoft.com, suredd@microsoft.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] ftpm: dt-binding: add dts documentation for fTPM
 driver
Message-ID: <20190402200351.GC19373@sasha-vm>
References: <20190402193316.15144-1-sashal@kernel.org>
 <20190402193732.GA26193@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190402193732.GA26193@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 09:37:32PM +0200, Greg KH wrote:
>On Tue, Apr 02, 2019 at 03:33:15PM -0400, Sasha Levin wrote:
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>
>I know I don't take patches without any changelog text :)

I honestly don't have anything meaningful to add in the changelog, and
looking at similar commits under Documentation/devicetree/bindings/ that
just add a new binding, they have a very similar changelog as well (see
204d94e63e22, 772bf73ed4dc, and b805c403c859 for example).

While I could add meaningless text which basically copies the subject
line, I don't think it will solve the concern you're pointing out here.

There is a lot of documentation for the fTPM driver which is listed in
the following patch, but it's not relevant to this patch at all.

--
Thanks,
Sasha
