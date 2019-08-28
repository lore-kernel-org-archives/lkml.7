Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2200C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839F622DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfH1NBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:01:37 -0400
Received: from ozlabs.org ([203.11.71.1]:53577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfH1NBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:01:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46JQqK61lWz9sBF;
        Wed, 28 Aug 2019 23:01:33 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Scott Wood <oss@buserror.net>
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com,
        zhaohongjiang@huawei.com, Jason Yan <yanaijie@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        christophe.leroy@c-s.fr, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6 00/12] implement KASLR for powerpc/fsl_booke/32
In-Reply-To: <827cc152757906a0ebc04bbe56cdf44683721eb4.camel@buserror.net>
References: <20190809100800.5426-1-yanaijie@huawei.com> <ed96199d-715c-3f1c-39db-10a569ba6601@huawei.com> <529fd908-42d6-f96f-daa2-9010f3035879@huawei.com> <878srf4cjk.fsf@concordia.ellerman.id.au> <827cc152757906a0ebc04bbe56cdf44683721eb4.camel@buserror.net>
Date:   Wed, 28 Aug 2019 23:01:28 +1000
Message-ID: <87h861v3yv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Wood <oss@buserror.net> writes:
> On Tue, 2019-08-27 at 11:33 +1000, Michael Ellerman wrote:
>> Jason Yan <yanaijie@huawei.com> writes:
>> > A polite ping :)
>> > 
>> > What else should I do now?
>> 
>> That's a good question.
>> 
>> Scott, are you still maintaining FSL bits, 
>
> Sort of... now that it's become very low volume, it's easy to forget when
> something does show up (or miss it if I'm not CCed).  It'd probably help if I
> were to just ack patches instead of thinking "I'll do a pull request for this
> later" when it's just one or two patches per cycle.

Yep, understand. Just sending acks is totally fine if you don't have
enough for a pull request.

cheers
