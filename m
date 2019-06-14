Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AB0C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BC521537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560498880;
	bh=PvLi/3uJKuqXnNjSGw++iphQUNXLUGBA4QDUp5FLBLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CEWU5m4p2MN8EfMA/4/yN4lrxP5uPtiZMr5KhX4125gEotxdhPJCLWW2wNJVzS3z4
	 Q1jwtrPIaWMqGGR2BVWXvQQvkV/So4WoViNqYpzPaqGvHsboEhk6SAYIuqOKAaHcrj
	 cKGlK7imjVrtbPM/SXuI3Ukow0b2LW/IAlzjRIu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfFNHyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfFNHyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:54:39 -0400
Received: from linux-8ccs (unknown [92.117.145.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5719B2133D;
        Fri, 14 Jun 2019 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560498878;
        bh=PvLi/3uJKuqXnNjSGw++iphQUNXLUGBA4QDUp5FLBLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JpY++WnUzAw3IJDTvRBUKK2iIPX3b97pKYzjW9Ei2V0Cavtbn7tXHUm5i72OZxKbp
         aaW6RaewocjHEJyMnB+01m6sLhNFazPaVvsTBPZmFn92HVG5g5c4ym8eLd9o1+FIP1
         Uzr7ERt11Q9jS8IIFNsTFIcil5R60M9fJixk+lr4=
Date:   Fri, 14 Jun 2019 09:54:33 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gregkh@linuxfoundation.org, mbenes@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
Message-ID: <20190614075433.GA5820@linux-8ccs>
References: <20190603144554.18168-1-yuehaibing@huawei.com>
 <20190611150007.21064-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190611150007.21064-1-yuehaibing@huawei.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ YueHaibing [11/06/19 23:00 +0800]:
>In module_add_modinfo_attrs if sysfs_create_file
>fails, we forget to free allocated modinfo_attrs
>and roll back the sysfs files.
>
>Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.

Jessica

