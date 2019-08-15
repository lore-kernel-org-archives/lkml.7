Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E445D2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565855497;
	bh=Tintz3vghWwVDNj/Taqq8DXHpRr/OtzG9jCOqlpQMew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G/tr/+IECsGNMJ50MwS9VzpVFEKymBIYOugLEuR4YSB8E9G0APVorE8j1iQ7eA80Z
	 sM0M3tEYCADpabIdSN2iIHuTQcqVwEDvgfsmwy95sebemZgs2Ko00a/pL18wwgF+g1
	 pMZYbJUtzLIuabrR1EiRm91DnavV9kp+c+EDNGS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfHOHvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfHOHvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:51:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363212084D;
        Thu, 15 Aug 2019 07:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565855494;
        bh=Tintz3vghWwVDNj/Taqq8DXHpRr/OtzG9jCOqlpQMew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQ62F4RyeEIyg7Jz33C0vT5zcKzrKvHRUUlQwxSUj38TxDyvKBYj0MoC61ocOpBmW
         SPx54eAW19M/+D7ccg4OGM3rAdjgXjxklzrFuEyF9deg8Rmbku9etI3ogW8dMQ2TwJ
         eE7zIXUO9V749AZDnE2+DijAgNAVmV1icb4tSWNI=
Date:   Thu, 15 Aug 2019 09:51:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>, stable@kernel.org,
        matthias.bgg@gmail.com, neil@brown.name,
        thirtythreeforty@gmail.com, christian@lkamp.de,
        nishadkamdar@gmail.com, ser.perschin@gmail.com, blogic@openwrt.org,
        jan.kiszka@siemens.com
Subject: Re: [stable] Deleting "mt7621-mmc" with "interesting" license?
Message-ID: <20190815075132.GA30284@kroah.com>
References: <20190815071350.GB3906@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815071350.GB3906@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 09:13:50AM +0200, Pavel Machek wrote:
> Hi!
> 
> I realize that "interesting" license is not on a list of bugs suitable
> for -stable, but on the other hand, this tends to scare corporate
> lawyers... so perhaps we should remove the driver in -stable, too?
> 
> Upstream commit id is 441bf7332d55c4d34afae9ffc3bbec621093f4d1.
> 
> 4.19 has the problematic driver, 4.4 does not.

If a lawyer has issues with this, please just upgrade to the latest
kernel release :)

thanks,

greg k-h
