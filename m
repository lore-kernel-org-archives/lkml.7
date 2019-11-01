Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB5FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE77217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfKALKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:10:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfKALKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:10:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B7F6864B63363F51DE27;
        Fri,  1 Nov 2019 19:10:52 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 19:10:46 +0800
Subject: Re: [PATCH v2 14/36] irqchip/gic-v4.1: Implement the v4.1 flavour of
 VMOVP
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Andrew Murray" <Andrew.Murray@arm.com>,
        Jayachandran C <jnair@marvell.com>,
        "Robert Richter" <rrichter@marvell.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-15-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <287222d4-5506-d252-c76a-88ecbcf84c87@huawei.com>
Date:   Fri, 1 Nov 2019 19:10:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-15-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/10/27 22:42, Marc Zyngier wrote:
> With GICv4.1, VMOVP is extended to allow a default doorbell to be
> specified, as well as a validity bit for this doorbell. As an added
> bonus, VMOPVP isn't required anymore of moving a VPE between
         ^^^^^^
VMOVP

> redistributors that share the same affinity.
> 
> Let's add this support to the VMOVP builder, and make sure we don't
> issuer the command if we don't really need to.

issue

> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

