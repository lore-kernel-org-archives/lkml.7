Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCE4C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238C720863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfDHLNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:13:46 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfDHLNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:13:46 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id ED0A2D5609EF16DF3179;
        Mon,  8 Apr 2019 19:13:43 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 8 Apr 2019 19:13:43 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 8 Apr 2019 19:13:43 +0800
Subject: Re: [PATCH 1/5] f2fs: clean up codes with op_is_write()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190402105222.28374-1-yuchao0@huawei.com>
 <20190405163137.GC51212@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d43af776-dc5e-24d0-dd48-3e74aca43943@huawei.com>
Date:   Mon, 8 Apr 2019 19:13:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190405163137.GC51212@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/6 0:31, Jaegeuk Kim wrote:
> On 04/02, Chao Yu wrote:
>> This patch uses generic function op_is_write() to instead private defined
>> macro is_read_io() for cleanup.
> 
> I don't see huge reason to clean up this, but do expect huge backporting issue.

Got it.

Thanks,
