Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AA2C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD202075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDVLQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 07:16:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2987 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfDVLQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 07:16:16 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id D02601D721F174893883;
        Mon, 22 Apr 2019 19:16:06 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 22 Apr 2019 19:16:06 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 22 Apr 2019 19:16:06 +0800
Subject: Re: [PATCH 2/2] fs: f2fs: insert space before the open parenthesis
 '('
To:     Youngjun Yoo <youngjun.willow@gmail.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devl@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190420135136.GA7426@willow72>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9c5c8ddc-1ab4-f49b-eacb-d27501301e8a@huawei.com>
Date:   Mon, 22 Apr 2019 19:16:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190420135136.GA7426@willow72>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/20 21:51, Youngjun Yoo wrote:
> Modify coding style
> ERROR: space required before the open parenthesis '('
> 
> Signed-off-by: Youngjun Yoo <youngjun.willow@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
