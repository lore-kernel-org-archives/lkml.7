Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E744CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F17120874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572426656;
	bh=BBkyVo84pb7G9CEHKXU4JbNRkN/Aw5KwF4l59aHkfgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BMWklUvY5RZ6EKuLkUobiv1MNseHJMnO7HNGc1PwGSUJFF3VBsBdM60FiH1TQ7FVE
	 0rouGpi8g5QfsHsMWbFIvLOh8/cSJTAJjbx/tFqqxTX2AZiI/rhrL6+HcIFjdDTnVQ
	 wF8ISfgqkVF/Vq7/KTibOmcc/hwqCNYHkIrsSqQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfJ3JKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfJ3JKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:10:54 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD312083E;
        Wed, 30 Oct 2019 09:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572426654;
        bh=BBkyVo84pb7G9CEHKXU4JbNRkN/Aw5KwF4l59aHkfgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMGS2GhrPPx7bBEMl8e7OOF7nphCQOvhC+GsCIois89STIHrKC3ARt2/W/AxkIjOd
         r5N/UaQcS9tiaEcwXEXrDE4dES6uAn0eX5652yFELgO4gD/og0gAd3qWvi7Bb5vU/g
         XB6qwiapS6VwpowK50ceF2ut5uorCCFovJDhPcRE=
Date:   Wed, 30 Oct 2019 10:10:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     akinobu.mita@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fault-inject: use DEFINE_DEBUGFS_ATTRIBUTE to define
 debugfs fops
Message-ID: <20191030091051.GA634735@kroah.com>
References: <1572423756-59943-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572423756-59943-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 04:22:36PM +0800, zhong jiang wrote:
> It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
> operation rather than DEFINE_SIMPLE_ATTRIBUTE.

Why does this matter?  What does this change?  You are changing how some
of the file reference counting works now, are you sure this is ok?

thanks,

greg k-h
