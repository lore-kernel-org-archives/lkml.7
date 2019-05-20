Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7085BC04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F00420644
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfETCTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 22:19:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfETCTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 22:19:33 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 33258A94430EA34FB044;
        Mon, 20 May 2019 10:19:31 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 May 2019 10:19:24 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 20 May 2019 10:19:23 +0800
Subject: Re: [PATCH v2] staging: erofs: fix Warning Use BUG_ON instead of if
 condition followed by BUG
To:     Gao Xiang <hsiangkao@aol.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>
References: <20190518173331.GA1069@hari-Inspiron-1545>
 <20190519093557.20982-1-hsiangkao@aol.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fbda7165-1276-1fca-0206-de603d48b309@huawei.com>
Date:   Mon, 20 May 2019 10:19:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190519093557.20982-1-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme720-chm.china.huawei.com (10.1.199.116) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/19 17:35, Gao Xiang wrote:
> From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> 
> fix below warning reported by  coccicheck
> 
> drivers/staging/erofs/unzip_pagevec.h:74:2-5: WARNING: Use BUG_ON
> instead of if condition followed by BUG.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> [ Gao Xiang: use DBG_BUGON instead of BUG_ON for eng version only. ]
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
