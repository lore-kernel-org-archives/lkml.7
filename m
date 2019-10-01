Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354B8ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0980E21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569970161;
	bh=xB9IwsMj/fScYg2XiwPqGatgL6Aty5pZqlqJ/wiTtZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cDFD1myvmqwDcxD/IC+gPGnvJaWisW0/bQYVVJK82Had3X3/8rOhL+CbXcRuda2Oy
	 RN2y6XwwRJYoJAJBW/M1AVlEXTP5zN4ItpDX4YbhC1L2BDbteDg81sDklVWsDlIa+E
	 zjuUnrJ34esOFAasEvbRB9ZkaZwqzvyLte2sEheo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfJAWtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbfJAWtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:49:14 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CB5621D81;
        Tue,  1 Oct 2019 22:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569970154;
        bh=xB9IwsMj/fScYg2XiwPqGatgL6Aty5pZqlqJ/wiTtZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHsqcGBXq0Nawrs7C3od9Zz1F+ZC53m7bZEuO/J64qljqanzDioDLSARWOdEL3qf8
         nxq9cpsNNWVvQZTARDpUkjZPzahQb30Cld1mYuVG+yqCiIhpTbIOJHC2zVtsYEEfSo
         g53ifhLnU64BlLmk3ydnVHqn7BCXiZE0nDMwDwvY=
Date:   Tue, 1 Oct 2019 18:49:13 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Shilovskiy <pshilov@microsoft.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steven French <Steven.French@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: Re: [PATCH 5.2 02/45] smb3: fix unmount hang in open_shroot
Message-ID: <20191001224913.GE17454@sasha-vm>
References: <20190929135024.387033930@linuxfoundation.org>
 <20190929135025.151404151@linuxfoundation.org>
 <BY5PR21MB13958939EBDEB4122A29675EB69D0@BY5PR21MB1395.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <BY5PR21MB13958939EBDEB4122A29675EB69D0@BY5PR21MB1395.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 08:41:43PM +0000, Pavel Shilovskiy wrote:
>Hi Greg,
>
>Are you going to apply this patch to the 5.3.y stable kernel? The patch is applicable there too.

I will, yes.

--
Thanks,
Sasha
