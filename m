Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0D3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B42020821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfDPLu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:50:59 -0400
Received: from [110.188.70.11] ([110.188.70.11]:58199 "EHLO spam2.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728706AbfDPLu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:50:58 -0400
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id x3GBlH8h075780;
        Tue, 16 Apr 2019 19:47:17 +0800 (GMT-8)
        (envelope-from fenghao@hygon.cn)
Received: from cncheex02.Hygon.cn ([172.23.18.12])
        by MK-DB.hygon.cn with ESMTP id x3GBl6I2045113;
        Tue, 16 Apr 2019 19:47:06 +0800 (GMT-8)
        (envelope-from fenghao@hygon.cn)
Received: from [172.30.20.134] (172.23.18.44) by cncheex02.Hygon.cn
 (172.23.18.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 16 Apr
 2019 19:47:12 +0800
Subject: Re: [PATCH 5/6] KVM: SVM: Add support for KVM_SEV_GM_GET_DIGEST
 command
To:     Borislav Petkov <bp@alien8.de>
CC:     "'Joerg Roedel '" <joro@8bytes.org>,
        "'Paolo Bonzini '" <pbonzini@redhat.com>,
        =?UTF-8?B?JyBSYWRpbSBLcsSNbcOhxZkgJw==?= <rkrcmar@redhat.com>,
        "'Thomas Gleixner '" <tglx@linutronix.de>,
        "'Ingo Molnar '" <mingo@redhat.com>,
        "' H. Peter Anvin '" <hpa@zytor.com>,
        Zhaohui Du <duzhaohui@hygon.cn>,
        Zhiwei Ying <yingzhiwei@hygon.cn>, Wen Pu <puwen@hygon.cn>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1555329868-17895-1-git-send-email-fenghao@hygon.cn>
 <1555329868-17895-6-git-send-email-fenghao@hygon.cn>
 <20190415150910.GE29317@zn.tnic> <896956377bf441c3bfd911716418ce7e@hygon.cn>
 <20190416081545.GA27892@zn.tnic>
From:   Hao Feng <fenghao@hygon.cn>
Message-ID: <d147506f-0183-f242-24ee-412bd72f99a4@hygon.cn>
Date:   Tue, 16 Apr 2019 19:47:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416081545.GA27892@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex02.Hygon.cn
 (172.23.18.12)
X-MAIL: spam2.hygon.cn x3GBlH8h075780
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 4:15 PM, Borislav Petkov wrote:
> Yes, as long as you realize that having the From: you makes you the
> author of the patch and Pu Wen is fine with that.

Ok, will modify in next patch series.

> 
> Btw, you should fix your mailer to send plain text only and not add
> those <mailto: > crap tags above.
> 

Sorry about that, there was some incorrect configuration in my email
client, already corrected it, thanks.


-- 
Thanks
Harry
