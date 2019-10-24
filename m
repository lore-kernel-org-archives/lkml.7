Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75726CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FA7205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393029AbfJXJPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:15:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727900AbfJXJPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:15:40 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 186384BD7B90497BB337;
        Thu, 24 Oct 2019 17:15:39 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 24 Oct
 2019 17:15:35 +0800
Subject: Re: [PATCH 1/2] f2fs: delete duplicate information on sysfs nodes
To:     Hridya Valsaraju <hridya@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     <kernel-team@android.com>
References: <20191023214821.107615-1-hridya@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <edc52873-b40d-5047-dba0-d693548eb16d@huawei.com>
Date:   Thu, 24 Oct 2019 17:15:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191023214821.107615-1-hridya@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/24 5:48, Hridya Valsaraju wrote:
> This patch merges the sysfs node documentation present in
> Documentation/filesystems/f2fs.txt and
> Documentation/ABI/testing/sysfs-fs-f2fs
> and deletes the duplicate information from
> Documentation/filesystems/f2fs.txt. This is to prevent having to update
> both files when a new sysfs node is added for f2fs.
> The patch also makes minor formatting changes to
> Documentation/ABI/testing/sysfs-fs-f2fs.

Jaegeuk, any particular reason to add duplicated description on f2fs.txt previously?

Thanks,
