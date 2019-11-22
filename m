Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD759C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD972067D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKVAss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:48:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfKVAss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:48:48 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 72CFF34094CB0FA7DA8E;
        Fri, 22 Nov 2019 08:48:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 22 Nov 2019
 08:48:39 +0800
Subject: Re: [PATCH -next] KVM: x86: remove set but not used variable 'called'
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     <rkrcmar@redhat.com>, <sean.j.christopherson@intel.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20191119030640.25097-1-maowenan@huawei.com>
 <87o8x8gjr5.fsf@vitty.brq.redhat.com> <20191119121423.GB5604@kadam>
 <61f534ca-7575-6716-10ec-ac5c92258452@redhat.com>
From:   maowenan <maowenan@huawei.com>
Message-ID: <c4f04d66-ca5c-e55c-777c-5091a099198e@huawei.com>
Date:   Fri, 22 Nov 2019 08:48:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <61f534ca-7575-6716-10ec-ac5c92258452@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shall we send v2 with fixes tag?

在 2019/11/21 17:13, Paolo Bonzini 写道:
> atch IMHO does.

