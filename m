Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3708DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEE32086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfFLIqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:46:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfFLIqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:46:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAE913004425;
        Wed, 12 Jun 2019 08:46:04 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D5AD176C9;
        Wed, 12 Jun 2019 08:45:56 +0000 (UTC)
Date:   Wed, 12 Jun 2019 16:45:51 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        rppt@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, ebiederm@xmission.com, wangkefeng.wang@huawei.com,
        linux-mm@kvack.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org,
        horms@verge.net.au, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] x86: kdump: move reserve_crashkernel_low() into
 kexec_core.c
Message-ID: <20190612084551.GA24575@dhcp-128-65.nay.redhat.com>
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <20190507035058.63992-2-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507035058.63992-2-chenzhou10@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 12 Jun 2019 08:46:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 05/07/19 at 11:50am, Chen Zhou wrote:
> In preparation for supporting reserving crashkernel above 4G
> in arm64 as x86_64 does, move reserve_crashkernel_low() into
> kexec/kexec_core.c.

Other than the comments from James, can you move the function into
kernel/crash_core.c, we already have some functions moved there for
sharing.

Thanks
Dave
