Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F214C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8B4206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556215513;
	bh=yUJq/aB17BfZlq7oE6e0TlGjHuO2zeTkbukTGZEyQ20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I3J3NTXWi7fjYR6RArcpG4JtuEXw7qXucXK4aI2pdsPHrby1dGXICszo1vf9r4S2D
	 A0mweuw0XnGzsLNy54uP8CMyqzKVeyPxTW+zsOCfqnt0Cg0FXT1Hz0iVQTCJU3Qs5e
	 ynmw/ZDdXTIWbvUAs2iUDIsGqmFkI7g8zicfKJMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfDYSFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfDYSFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:05:10 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 345C1206BF;
        Thu, 25 Apr 2019 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556215510;
        bh=yUJq/aB17BfZlq7oE6e0TlGjHuO2zeTkbukTGZEyQ20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNYGSEKzJ4AM7735w74DmGjzXzreBEi9O/mxQSAMQmJZwVeAqgD0Qy0YxgfksOraY
         Fg7HyY7+PlSaRPfQmFWqaAiDsLVX6D4UuGfkK7z4xPizIrdzSYN/Nr3jjQRPQr2r6Q
         dh+PWakibHEYKD1Oa2PqyN6F5pBlgN48keHrNDOk=
Date:   Thu, 25 Apr 2019 20:05:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] drivers: base: regmap: add proper SPDX identifiers
 on files that did not have them.
Message-ID: <20190425180507.GA8998@kroah.com>
References: <20190402133203.5463-1-gregkh@linuxfoundation.org>
 <20190403033227.GG2059@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403033227.GG2059@sirena.org.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:32:27AM +0700, Mark Brown wrote:
> On Tue, Apr 02, 2019 at 03:32:00PM +0200, Greg Kroah-Hartman wrote:
> 
> > --- a/drivers/base/regmap/regcache-flat.c
> > +++ b/drivers/base/regmap/regcache-flat.c
> > @@ -1,13 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> 
> Please make the whole header a C++ header so that things look more
> consistent and intentional.

Ok, fair enough, will do so now.

greg k-h
