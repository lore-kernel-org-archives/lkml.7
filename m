Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF2BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80092089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lFQeo0aM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393369AbfIJGQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:16:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfIJGQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ykZkUPCZEJJWvilRQ1BONPpE0r1rcbx/nKZazkyDSHw=; b=lFQeo0aM7GCKBBrlQycyYru89
        qrMJu2JN2IS87y3oAeYRTpulYPgeV46dW7Koefkme7/ongnLkvhjeoObWBkjL9p6XxlHmXX7DOoHr
        dSqbNH+cjQyEjac3OSm3bRojGFwTWHu1gOUXDu/DF6/F/CW8DwBlDQzKNjJpSYDFKcR2+GHd2vXAR
        Tizsz3b2nmGD/V5niDX7v/+o48HwXlWSvOz7GzqHDUbCxw1VwPYEDL1+k2YwjCVvh+NiP2L3tKyTC
        LBZO/XQXMf+Ag4WJSH6dALKrkQeehKQX6TiCHhBNA0R9P/Dn+6qYZwqTAB8GKtr/5QWU6wmE07J+8
        7woE9W+yw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7ZRS-0007Dx-H6; Tue, 10 Sep 2019 06:15:54 +0000
Date:   Mon, 9 Sep 2019 23:15:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexander Graf <graf@amazon.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v3] KVM: x86: Disable posted interrupts for odd IRQs
Message-ID: <20190910061554.GD10968@infradead.org>
References: <20190905125818.22395-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905125818.22395-1-graf@amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And what about even ones? :)

Sorry, just joking, but the "odd" qualifier here looks a little weird,
maybe something like "non-standard develiry modes" might make sense
here.
