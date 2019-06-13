Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBFBC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C4E2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfFMQl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:41:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730546AbfFMGxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:53:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 518A76E69A3BD068B9B5;
        Thu, 13 Jun 2019 14:53:14 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 14:53:10 +0800
Subject: Re: [PATCH] f2fs: replace ktype default_attrs with default_groups
To:     Kimberly Brown <kimbrownkd@gmail.com>, <jaegeuk@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190607174041.11201-1-kimbrownkd@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <907b6488-e214-1543-28db-20f9f9d01557@huawei.com>
Date:   Thu, 13 Jun 2019 14:53:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190607174041.11201-1-kimbrownkd@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/8 1:40, Kimberly Brown wrote:
> The kobj_type default_attrs field is being replaced by the
> default_groups field. Replace the default_attrs fields in f2fs_sb_ktype
> and f2fs_feat_ktype with default_groups. Use the ATTRIBUTE_GROUPS macro
> to create f2fs_groups and f2fs_feat_groups.
> 
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
