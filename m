Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09EEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7950D20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDHLSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:18:50 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2473 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfDHLSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:18:49 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id E62357260ADFDE7C78A0;
        Mon,  8 Apr 2019 19:18:47 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 8 Apr 2019 19:18:47 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 8 Apr 2019 19:18:47 +0800
Subject: Re: [PATCH] f2fs: data: fix warning Using plain integer as NULL
 pointer
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190406105936.GA30585@hari-Inspiron-1545>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d0d855ca-a7cd-9dcb-d7b1-b9fe03fffcc8@huawei.com>
Date:   Mon, 8 Apr 2019 19:18:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190406105936.GA30585@hari-Inspiron-1545>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme716-chm.china.huawei.com (10.1.199.112) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/6 18:59, Hariprasad Kelam wrote:
> changed passing function argument "0 to NULL" to fix below sparse
> warning
> 
> fs/f2fs/data.c:426:47: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
