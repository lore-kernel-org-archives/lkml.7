Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0DDC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDC5206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgAHIFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:05:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:46218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAHIFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:05:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8CCDAAD31;
        Wed,  8 Jan 2020 08:05:37 +0000 (UTC)
Date:   Wed, 8 Jan 2020 09:05:36 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: Fix memleak in
 module_add_modinfo_attrs()
In-Reply-To: <20191228115455.24088-1-yuehaibing@huawei.com>
Message-ID: <alpine.LSU.2.21.2001080905110.13391@pobox.suse.cz>
References: <20191228115455.24088-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Dec 2019, YueHaibing wrote:

> In module_add_modinfo_attrs() if sysfs_create_file() fails
> on the first iteration of the loop (so i = 0), we forget to
> free the modinfo_attrs.
> 
> Fixes: bc6f2a757d52 ("kernel/module: Fix mem leak in module_add_modinfo_attrs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
