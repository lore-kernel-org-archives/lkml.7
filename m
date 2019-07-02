Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACCDC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FAD2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGBMqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:46:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfGBMqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:46:23 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A9B451CA1EF58928B14B;
        Tue,  2 Jul 2019 20:43:26 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 20:43:22 +0800
To:     <arlin.r.davis@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "vlad@mellanox.com" <vlad@mellanox.com>,
        <robert.j.woodruff@intel.com>,
        "Rupert Dance (rsdance@soft-forge.com)" <rsdance@soft-forge.com>,
        "Rupert Dance (rsdance@soft-forge.com)" <rsdance@soft-forge.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   oulijun <oulijun@huawei.com>
Subject: =?UTF-8?Q?=e3=80=90Application=e3=80=91hns_RoCE_driver_integration?=
Message-ID: <d8c94914-e2a4-4135-f9ff-36da88db7a10@huawei.com>
Date:   Tue, 2 Jul 2019 20:43:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arlin Davis & Jason

    I am the maintainer of hns. I understand that hns is still not integrated into OFED. A long time ago I received a consultation email about hns integration into OFED.

    Sorry for the long time of reply.

   I am trying to push the support for the hns RoCE driver in the next version of OFED. If we want to land as soon as possible, how do we need to cooperate?

Thanks

Lijun Ou

