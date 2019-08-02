Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDBEC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 00:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB1C2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 00:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390564AbfHBAs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 20:48:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388597AbfHBAsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 20:48:55 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 380B879A79CC01A16C7;
        Fri,  2 Aug 2019 08:48:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 08:48:46 +0800
Subject: Re: [PATCH v3 00/10] implement KASLR for powerpc/fsl_booke/32
To:     Diana Madalina Craciun <diana.craciun@nxp.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "yebin10@huawei.com" <yebin10@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "jingxiangfeng@huawei.com" <jingxiangfeng@huawei.com>,
        "fanchengyang@huawei.com" <fanchengyang@huawei.com>,
        "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>
References: <20190731094318.26538-1-yanaijie@huawei.com>
 <VI1PR0401MB2463844DD4A35EB3F0959C22FFDE0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <bc30b426-d7c6-c839-ebd2-a404465079a3@huawei.com>
Date:   Fri, 2 Aug 2019 08:48:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB2463844DD4A35EB3F0959C22FFDE0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/1 22:36, Diana Madalina Craciun wrote:
> Hi Jason,
> 
> I have tested these series on a P4080 platform.
> 
> Regards,
> Diana

Diana, thank you so much.

So can you take a look at the code of this version and give a 
Reviewed-by or Tested-by?

Thanks,
Jason

