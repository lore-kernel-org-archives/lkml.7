Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE7FC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF232084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfFQNpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:45:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18627 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbfFQNpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:45:22 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2E8C9E9969F150E33548;
        Mon, 17 Jun 2019 21:45:19 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Jun
 2019 21:45:09 +0800
Subject: Re: [PATCH] staging: erofs: clean up initialization of pointer de
To:     Colin King <colin.king@canonical.com>,
        Chao Yu <yuchao0@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190617125529.28327-1-colin.king@canonical.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <470b93fd-ef5e-0019-b58d-8e38e7944e13@huawei.com>
Date:   Mon, 17 Jun 2019 21:45:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190617125529.28327-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/17 20:55, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently pointer de is being initialized with a value that is
> never read and a few statements later de is being re-assigned. Clean
> this up by ininitialzing de and removing the re-assignment.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Loods good for me,

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang
