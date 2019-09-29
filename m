Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9590BC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659CD218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569741973;
	bh=qNz+Cnv6TdVqdmpeMyTKkjjYUS0H7A80uvIVx+HZCiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XJ94jsh2jhmYc/HhmkOekShFcipwCZ2wnuchPIqNRrvTwnV1Jczy8IaWJCsLfwOHp
	 asNzAfCEURxBy3QyYpf8H8CTl0GGqigQPnrn0T4grayk1E/Ji9l6+IK4TxwgiPRyts
	 YT5alqihzNAa3rU5h0Lq3npQepUw77viu/QXHhrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfI2H0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 03:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfI2H0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 03:26:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA3C2086A;
        Sun, 29 Sep 2019 07:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569741971;
        bh=qNz+Cnv6TdVqdmpeMyTKkjjYUS0H7A80uvIVx+HZCiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LO5rQTup5CZFY2P05/QSr0GbH43PHarvkFsLeI9VGcccOuhwYyfyaclDceynm4jwF
         R+sD0trtAVy+goOYd7ICPeXDgGz9Q0OkqOXDoW3DD4aryiXZWVgrA1F3/kMtrZXF++
         AvIETheztFkTC91oJYLIHXq1rTsmSGCmGM4H+aKU=
Date:   Sun, 29 Sep 2019 09:26:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jesse Barton <jessebarton95@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Staging: exfat: exfat_super.c Fixed coding style
 issues.
Message-ID: <20190929072606.GA1879787@kroah.com>
References: <20190929002119.20689-1-jessebarton95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929002119.20689-1-jessebarton95@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 07:21:19PM -0500, Jesse Barton wrote:
> Fixed Coding Style issues

You need to be specific as to _what_ exactly you did here.  What you
wrote is very vague :)

thanks,

greg k-h
