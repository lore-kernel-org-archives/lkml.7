Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EA0C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93E1206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfDVLPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 07:15:54 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfDVLPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 07:15:54 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id D23B9B76F70C0EB8CDC3;
        Mon, 22 Apr 2019 19:15:41 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 22 Apr 2019 19:15:41 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 22 Apr 2019 19:15:41 +0800
Subject: Re: [PATCH 1/2] fs: f2fs: Replace spaces with tab.
To:     Youngjun Yoo <youngjun.willow@gmail.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190420135040.GA7404@willow72>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e1b670e4-6969-06e8-e180-dd63aac3dd60@huawei.com>
Date:   Mon, 22 Apr 2019 19:15:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190420135040.GA7404@willow72>
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

On 2019/4/20 21:50, Youngjun Yoo wrote:
> Modify coding style
> ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Youngjun Yoo <youngjun.willow@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
