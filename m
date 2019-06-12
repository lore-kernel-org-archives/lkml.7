Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FDAC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A1020874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408995AbfFLLMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:12:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:55642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408962AbfFLLMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:12:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04579B019;
        Wed, 12 Jun 2019 11:12:10 +0000 (UTC)
Date:   Wed, 12 Jun 2019 13:12:10 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
cc:     jeyu@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
In-Reply-To: <20190611150007.21064-1-yuehaibing@huawei.com>
Message-ID: <alpine.LSU.2.21.1906121311470.10335@pobox.suse.cz>
References: <20190603144554.18168-1-yuehaibing@huawei.com> <20190611150007.21064-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019, YueHaibing wrote:

> In module_add_modinfo_attrs if sysfs_create_file
> fails, we forget to free allocated modinfo_attrs
> and roll back the sysfs files.
> 
> Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
