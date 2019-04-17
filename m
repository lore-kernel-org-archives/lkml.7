Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E088DC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55BA2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfDQJhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:37:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51661 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbfDQJhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:37:11 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hGgzx-0008Us-QF; Wed, 17 Apr 2019 11:36:58 +0200
Date:   Wed, 17 Apr 2019 11:36:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@lca.pw>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, luto@kernel.org,
        jpoimboe@redhat.com, sean.j.christopherson@intel.com,
        penberg@kernel.org, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: remove store_stackinfo()
In-Reply-To: <20190416142258.18694-1-cai@lca.pw>
Message-ID: <alpine.DEB.2.21.1904171136410.1845@nanos.tec.linutronix.de>
References: <20190416142258.18694-1-cai@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019, Qian Cai wrote:

> store_stackinfo() does not seem used in actual SLAB debugging.
> Potentially, it could be added to check_poison_obj() to provide more
> information, but this seems like an overkill due to the declining
> popularity of the SLAB, so just remove it instead.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
