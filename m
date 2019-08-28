Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0454C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D964214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfH1FIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 01:08:42 -0400
Received: from baldur.buserror.net ([165.227.176.147]:49262 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfH1FIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:08:42 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1i2qCA-0007Ui-Om; Wed, 28 Aug 2019 00:08:35 -0500
Message-ID: <827cc152757906a0ebc04bbe56cdf44683721eb4.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        yebin10@huawei.com, thunder.leizhen@huawei.com,
        jingxiangfeng@huawei.com, fanchengyang@huawei.com,
        zhaohongjiang@huawei.com, Jason Yan <yanaijie@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        christophe.leroy@c-s.fr, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com
Date:   Wed, 28 Aug 2019 00:08:33 -0500
In-Reply-To: <878srf4cjk.fsf@concordia.ellerman.id.au>
References: <20190809100800.5426-1-yanaijie@huawei.com>
         <ed96199d-715c-3f1c-39db-10a569ba6601@huawei.com>
         <529fd908-42d6-f96f-daa2-9010f3035879@huawei.com>
         <878srf4cjk.fsf@concordia.ellerman.id.au>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: mpe@ellerman.id.au, linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com, yebin10@huawei.com, thunder.leizhen@huawei.com, jingxiangfeng@huawei.com, fanchengyang@huawei.com, zhaohongjiang@huawei.com, yanaijie@huawei.com, linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com, christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com, keescook@chromium.org, kernel-hardening@lists.openwall.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v6 00/12] implement KASLR for powerpc/fsl_booke/32
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-27 at 11:33 +1000, Michael Ellerman wrote:
> Jason Yan <yanaijie@huawei.com> writes:
> > A polite ping :)
> > 
> > What else should I do now?
> 
> That's a good question.
> 
> Scott, are you still maintaining FSL bits, 

Sort of... now that it's become very low volume, it's easy to forget when
something does show up (or miss it if I'm not CCed).  It'd probably help if I
were to just ack patches instead of thinking "I'll do a pull request for this
later" when it's just one or two patches per cycle.

-Scott


