Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26164C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC0520856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfDAO2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:28:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbfDAO2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:28:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [10.3.19.201])
        by Forcepoint Email with ESMTP id BE7AC32D2DE989B1C6DE;
        Mon,  1 Apr 2019 22:28:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 1 Apr 2019
 21:55:52 +0800
To:     <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>
From:   Heyi Guo <guoheyi@huawei.com>
Subject: MSI number limit for PCI hotplug under PCI bridge on ARM platform
Message-ID: <327ba551-2cbd-08bb-d4c1-107c3ff7d45d@huawei.com>
Date:   Mon, 1 Apr 2019 21:55:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

In current kernel implementation for ARM platform, all devices under one PCI bridge share a same device ID and the total number of MSI interrupts is fixed at the first time any child device is allocating MSI. However, this may cause failure of allocating MSI if the system supports device hot-plug under the PCI bridge, which is possible for ARM virtual machine with generic pcie-to-pci-bridge and kernel config HOTPLUG_PCI_SHPC enabled.

Does it make sense to add support for the above scenario? If it does, any suggestion for how to do that?

Thanks,

Heyi


