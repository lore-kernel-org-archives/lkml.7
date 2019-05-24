Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6ABC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CE02075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbfEXD1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:27:50 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:39778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729972AbfEXD1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:27:49 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 3D7A1350DA8E8166CC16;
        Fri, 24 May 2019 11:27:47 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 May 2019 11:27:47 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 24 May 2019 11:27:46 +0800
Subject: Re: [PATCH v6 1/1] f2fs: ioctl for removing a range from F2FS
To:     Sahitya Tummala <stummala@codeaurora.org>
CC:     sunqiuyang <sunqiuyang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190524015555.12622-1-sunqiuyang@huawei.com>
 <e7cfed52-0212-834f-aed8-0c5abc07f779@huawei.com>
 <20190524030958.GB10043@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d298c4a5-4ba7-df8c-5bbe-74ce4ce9604e@huawei.com>
Date:   Fri, 24 May 2019 11:28:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190524030958.GB10043@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/24 11:09, Sahitya Tummala wrote:
> I am okay with merging.

Thank you, it looks Qiuyang has confirmed before v2. :)

Thanks,

