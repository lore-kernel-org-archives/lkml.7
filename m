Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BB3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E702146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfCTKYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:24:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35177 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfCTKYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:24:23 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h6YOS-0000yA-Iy; Wed, 20 Mar 2019 11:24:20 +0100
Date:   Wed, 20 Mar 2019 11:24:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>, x86@kernel.org
Subject: Re: [PATCH 2/2] Revert "x86/hpet: Reduce HPET counter read
 contention"
In-Reply-To: <06512b71-c163-7851-1881-31a4c35fc495@redhat.com>
Message-ID: <alpine.DEB.2.21.1903201123510.1906@nanos.tec.linutronix.de>
References: <1552552932-21821-1-git-send-email-zhenzhong.duan@oracle.com> <1552552932-21821-2-git-send-email-zhenzhong.duan@oracle.com> <20190315092529.GU5996@hirez.programming.kicks-ass.net> <09d5ca8b-9cee-c013-01b4-bd2e78672b57@redhat.com>
 <ad2ab867-d39a-8d71-f76e-da820f9d2faa@oracle.com> <06512b71-c163-7851-1881-31a4c35fc495@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Waiman Long wrote:
> On 03/18/2019 04:44 AM, Zhenzhong Duan wrote:
> > https://lkml.org/lkml/2019/3/15/101
> >
> I think what Thomas was asking is to provide a REALISTIC use case where
> TSC is wrecked and HPET is somehow not used and we have to fall back to
> use PM timer. If such use case exists, I am sure Thomas will be happy to
> take it.

Exactly.

Thanks,

	tglx

