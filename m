Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CCBCA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D87620856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfJ3Cxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 22:53:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2499 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbfJ3Cxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 22:53:33 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id ABC11E8EFFF4978B46A9;
        Wed, 30 Oct 2019 10:53:31 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 10:53:31 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 30 Oct 2019 10:53:31 +0800
Date:   Wed, 30 Oct 2019 10:56:16 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>
CC:     Pratik Shinde <pratikshinde320@gmail.com>,
        <linux-erofs@lists.ozlabs.org>, Gao Xiang <xiang@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] erofs: support superblock checksum
Message-ID: <20191030025616.GB161610@architecture4>
References: <20191028134405.GA186556@architecture4>
 <20191028143202.133428-1-gaoxiang25@huawei.com>
 <d604526a-70dd-0a44-f001-33c84be99084@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d604526a-70dd-0a44-f001-33c84be99084@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 10:33:47AM +0800, Chao Yu wrote:
> On 2019/10/28 22:32, Gao Xiang wrote:
> > From: Pratik Shinde <pratikshinde320@gmail.com>
> > 
> > Introduce superblock checksum feature in order to verify
> > a number of given blocks at mounting time.
> > 
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks for reviewing, I just noticed the commit message isn't
fixed as well, let me resend v6...

Thanks,
Gao Xiang

> 
> Thanks,
