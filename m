Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2FAC04AAC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556BA208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557040139;
	bh=vOEOtv07I8ZAy07O+GJLQkeqZ8Wq7P4eDyAWwVcKeY8=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=QO6xOW2DQRhpAtUm7UY7qOBWh+6u8LtWXuSkfYX1sSpSgCdWEjdJ01hi+G63HCYQI
	 z9C2YT4fz8moMjuSatWH8MJjra5KHgODSlq9GdSgTUsbXNqhpzuckNw4paxbs6ersU
	 Y+nLGaUyt9DgRDvFlvonqOAGXlCt2n+AKTKYfnAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfEEHI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 03:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfEEHI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 03:08:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 489642087F;
        Sun,  5 May 2019 07:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557040137;
        bh=vOEOtv07I8ZAy07O+GJLQkeqZ8Wq7P4eDyAWwVcKeY8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=r+SCcBCGOtCu3MqJ9KoVg2EQxoKRZYTmw9bFAHCivGZK2hiMhcNHzHDQ2QaQTXeLi
         u1UlW45D5KvZTO429yKLpMvw9RRylsktlSWisSewxOMGxstqzageW/R1nDV60cPRlt
         A4h7nZzwW7byW3x3b771eVe7//llHgc7qyWmzTHc=
Date:   Sun, 5 May 2019 09:08:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/23] 4.19.40-stable review
Message-ID: <20190505070854.GA3895@kroah.com>
References: <20190504102451.512405835@linuxfoundation.org>
 <20190505030044.q3dlgd5bhfx5txmf@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190505030044.q3dlgd5bhfx5txmf@xps.therub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 10:00:44PM -0500, Dan Rue wrote:
> On Sat, May 04, 2019 at 12:25:02PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.40 release.
> > There are 23 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon 06 May 2019 10:24:19 AM UTC.
> > Anything received after that time might be too late.
> 
> 
> Results from Linaro’s test farm.
> Regressions detected.

Really?  Where?
