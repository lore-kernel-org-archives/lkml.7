Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC10C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 07:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0CC21707
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560669284;
	bh=TsEIfqrLetJOZ1J+ofJiABOKfbOjLk50JJQme18BgQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GCkULtqW8mGzRpURjDgRjqLPwGzshjy2iWnOIibE8wDAnZKLCL56SQc+eJ147xZVp
	 jKLR6BoWcU6AJkTdw3U95l5WXcuYz2TKEkVqYr9p+wBe9fMID3Jd/PVlhPxF4IcstE
	 50HNNHMyz7/UCcR7fuoRCEXBcn+4AW/Pg1DERGvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFPHOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 03:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfFPHOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 03:14:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95789216C8;
        Sun, 16 Jun 2019 07:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560669282;
        bh=TsEIfqrLetJOZ1J+ofJiABOKfbOjLk50JJQme18BgQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nM3sukd611tDM48gnQkh0krGzYijVO4UchfAxNp5bo89tXxJ7mkqsgZ688zODdf7J
         hBrV7qnyTvk86W4otao3xudQX+G6dQc7mTSbjWL8c3kzfFAxb9MNZT0On+7vI05b4h
         +JMSHwCs3TYT2HwFk5MzFR/hPqPB8LWPSvaRZhSQ=
Date:   Sun, 16 Jun 2019 09:14:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH v3 1/2] staging: erofs: add requirements field in
 superblock
Message-ID: <20190616071439.GA11880@kroah.com>
References: <20190611024220.86121-1-gaoxiang25@huawei.com>
 <20190613083541.67091-1-gaoxiang25@huawei.com>
 <a4d587eb-c4f0-b9e5-7ece-1ac38c2735f3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d587eb-c4f0-b9e5-7ece-1ac38c2735f3@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 03:00:38PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> Sorry for annoying... Could you help merge these two fixes? Thanks in advance...

It was only 3 days, please give me at the very least, a week or so for
staging patches.

> decompression inplace optimization needs these two patches and I will integrate
> erofs decompression inplace optimization later for linux-next 5.3, and try to start 
> making effort on moving to fs/ directory on kernel 5.4...

You can always send follow-on patches, I apply them in the correct
order.  I will get to these next week, thanks.

greg k-h
